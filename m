Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274543AbRIVJpY>; Sat, 22 Sep 2001 05:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274604AbRIVJpO>; Sat, 22 Sep 2001 05:45:14 -0400
Received: from cs6625186-50.austin.rr.com ([66.25.186.50]:19584 "EHLO
	hatchling.taral.net") by vger.kernel.org with ESMTP
	id <S274543AbRIVJpB>; Sat, 22 Sep 2001 05:45:01 -0400
Date: Sat, 22 Sep 2001 04:45:27 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: USB lockup on Thinkpad i1300
Message-ID: <20010922044527.A23908@taral.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My thinkpad happily locks up with both 2.4.9 and 2.4.10-pre14 when I
load usb-ohci. Tracing with kdb shows that the system locks up right
after executing this: (usb-ohci.c:2137)

        /* HC Reset requires max 10 ms delay */
        writel (OHCI_HCR,  &ohci->regs->cmdstatus);

Anyone have any idea? The processor apparently never gets to the next
instruction.

[Cc: me please, I'm not on this list.]

P.S. System chipset is ALi:

00:14.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
        Flags: bus master, medium devsel, latency 32, IRQ 10
        Memory at 82400000 (32-bit, non-prefetchable) [size=4K]

Shares IRQ with cardbus bridge and lcd controller.

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
