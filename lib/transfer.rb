class Transfer

    attr_reader :sender, :receiver, :amount
    attr_accessor :status 
  
    def initialize(sender, receiver, amount) 
      @sender = sender 
      @receiver = receiver 
      @amount = amount
      @status = "pending"
    end 

    def valid? 
      sender.valid? && receiver.valid?
    end 

    def transaction_rejected
      @status = "rejected" 
      "Transaction rejected. Please check your account balance."
    end 

    def execute_transaction
      if sender.balance > amount && self.status == "pending" && valid?
        sender.balance -= amount
        receiver.balance += amount
        @status = "complete"
      else    
        transaction_rejected 
      end
    end

    def reverse_transfer 
      if receiver.balance > amount && self.status == "complete" && valid?
        receiver.balance -= amount
        sender.balance += amount
        @status = "reversed"
      else
        transaction_rejected
      end
    end
  
end
 