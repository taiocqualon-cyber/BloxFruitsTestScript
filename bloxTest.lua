-- Blox Fruits Test Script (Local / Hợp pháp)
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

humanoid.WalkSpeed = 100
humanoid.JumpPower = 100

local flying = false
local userInputService = game:GetService("UserInputService")
userInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.E then
        flying = not flying
        print("Chế độ bay:", flying)
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        rootPart.CFrame = rootPart.CFrame + Vector3.new(0,1,0)
    end
end)

local function getNearestMonster(range)
    local nearest = nil
    local distance = range
    if workspace:FindFirstChild("Monsters") then
        for _, npc in pairs(workspace.Monsters:GetChildren()) do
            if npc:FindFirstChild("HumanoidRootPart") and npc:FindFirstChild("Humanoid") then
                local d = (npc.HumanoidRootPart.Position - rootPart.Position).magnitude
                if d < distance then
                    nearest = npc
                    distance = d
                end
            end
        end
    end
    return nearest
end

game:GetService("RunService").RenderStepped:Connect(function()
    local monster = getNearestMonster(50)
    if monster then
        rootPart.CFrame = CFrame.new(monster.HumanoidRootPart.Position + Vector3.new(0,0,3))
        if monster:FindFirstChild("Humanoid") then
            monster.Humanoid:TakeDamage(10)
        end
    end
end)
