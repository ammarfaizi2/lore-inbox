Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265920AbRFZGco>; Tue, 26 Jun 2001 02:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265921AbRFZGcd>; Tue, 26 Jun 2001 02:32:33 -0400
Received: from [32.97.182.101] ([32.97.182.101]:65176 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265920AbRFZGcN>;
	Tue, 26 Jun 2001 02:32:13 -0400
From: mdaljeet@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: linux-kernel@vger.kernel.org
Message-ID: <CA256A77.001B2342.00@d73mta01.au.ibm.com>
Date: Tue, 26 Jun 2001 10:19:04 +0530
Subject: interrupt problem....
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing a strange problem.
I am doing a continuous DMA for long hours using a card on my system. In my
code I enable interrupts and clear the interrupts in the interrupt handler
which is called on completion of every DMA cycle. Now, the program works
fine for say 16-20 hours but I think when the debug files'(where i put some
debug information for each DMA cycle + system log files etc) size becomes
too large, card stops generating interrupts.

1. There is a bit in card that tells that DMA is complete
2. There is a bit in card that tells card to generate interrupt when DMA is
complete
3. If we clear the above two bits, the interrupt handling is complete

Now, DMA is getting complete as the bits specified in the point 1 and 2 are
getting set. I have added a 'printk' in the interrupt handler to see
whether the card is generating interrupts or not. Card stops generating
interrupt. Even if I delete all the debug files and start my program again,
same thing happens. After I reboot the system and run my program, the card
starts working properly with same code.

I have noted following things:

a) If I delete all the system log files and restrict the size of my debug
file, the code runs fine for more than 48 hours. Basically I stop the
program after having a 48 hour run.
b) If the system log files has large size and I do not delete them before
starting my program, the card stops generating interrupts after 16-20 hours
of run.

Any pointers to the problem......????

Regards,
Daljeet.


