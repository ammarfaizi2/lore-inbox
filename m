Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269706AbRHIGuq>; Thu, 9 Aug 2001 02:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269707AbRHIGuf>; Thu, 9 Aug 2001 02:50:35 -0400
Received: from web20106.mail.yahoo.com ([216.136.226.43]:11531 "HELO
	web20106.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269706AbRHIGuX>; Thu, 9 Aug 2001 02:50:23 -0400
Message-ID: <20010809065034.82696.qmail@web20106.mail.yahoo.com>
Date: Wed, 8 Aug 2001 23:50:34 -0700 (PDT)
From: Venu Gopal Krishna Vemula <vvgkrishna_78@yahoo.com>
Subject: Problem on Interrupt Handling
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
         I am developing  a linux device driver for a 
serial communication adapter which is based on
interrrupt driven IO, top half handles registering the
Immediate task queue, bottom half performs the actual
task

     But after some time 'RxFull' interrupts are not
comming. This is happening after I got an interrupt
which tells "CPU not responding,  RFIFO is FULL". 
		ALl other types  interrupts(includes TxEmpty and
Modem interrupts) are Ok... The above problem is
solving when  ISR0 (interrupt status register which
contains  RXtype interrupts) and enable ISR0, RxFull
interrupt is again comming .

     In my UART(Serial communication Controller,) 
RxFull has high priority and then TxEmpty.Both RxFull
and TxEmpty share same IRQ line. No other device is
sharing the IRQ line. 

I would appreciate if you can help solving this
problem.

regards,
Vvgkrishna_78@yahoo.com


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
