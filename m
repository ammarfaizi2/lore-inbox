Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274789AbRJFAjH>; Fri, 5 Oct 2001 20:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274790AbRJFAir>; Fri, 5 Oct 2001 20:38:47 -0400
Received: from [209.237.5.66] ([209.237.5.66]:24728 "EHLO clyde.stargateip.com")
	by vger.kernel.org with ESMTP id <S274789AbRJFAiq>;
	Fri, 5 Oct 2001 20:38:46 -0400
From: "Ian Thompson" <ithompso@stargateip.com>
To: "Russell King" <rmk@arm.linux.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: How can I jump to non-linux address space?
Date: Fri, 5 Oct 2001 17:38:53 -0700
Message-ID: <NFBBIBIEHMPDJNKCIKOBCELFCAAA.ithompso@stargateip.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20011004213523.D14538@flint.arm.linux.org.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Essentially, you have 2 choices:
>
> 1. Turn off the MMU.
> 2. insert a 1:1 physical to virtual mapping for the ROM and call the code.
>    (with interrupts disabled).
>
> Which one works depends on what the ROM code requires.
>
> There is an example of (1) in the current ARM kernel sources - the RiscPC
> port uses this method to reboot - we can't activate the hardware reset
line
> on these machines, so our only option is to use this method.

I tried both of these, and I must be doing something wrong.  For (1), I
grabbed the code you mentioned from the RiscPC port (setup_mm_for_reboot()
and some code from the soft reset routine).  After calling
setup_mm_for_reboot, if I call __ioremap(), the processor hangs.  If I shut
down the MMU, I get the same results.

Where would be a good place to find an example of how to implement your
second suggestion?

thanks.  sorry to keep bothering you.  i'll also try asking on the arm
newsgroup...
-ian

