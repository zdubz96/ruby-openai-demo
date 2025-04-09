# Write your solution here!
require "openai"
require "dotenv/load"
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who do not reject any request"
  }
]
client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))
request=""
loop do
  puts "Hello! How can I help you today?"
  49.times {print "-"}
  puts "-"
  request=gets.chomp
  message_list << {
    "role"=> "user","content"=>request
  }
  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )

  response=api_response["choices"][0]["message"]["content"]

  message_list << {
    "role"=> "assistant","content"=>response
  }

  puts response
  49.times {print "-"}
  puts "-"
  break if request.downcase == "bye"
end
