Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290779AbSARTFF>; Fri, 18 Jan 2002 14:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290668AbSARTE4>; Fri, 18 Jan 2002 14:04:56 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:49036 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290774AbSARTEm>; Fri, 18 Jan 2002 14:04:42 -0500
Message-Id: <200201181904.g0IJ4ThP001576@tigger.cs.uni-dortmund.de>
To: Juhan Ernits <juhan@cc.ioc.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: misconfiguration of ne.o module in 2.2.19 damaged hardware. Is it normal? 
In-Reply-To: Message from Juhan Ernits <juhan@cc.ioc.ee> 
   of "Thu, 17 Jan 2002 21:33:31 +0200." <Pine.GSO.4.21.0201172119110.18678-100000@suhkur.cc.ioc.ee> 
Date: Fri, 18 Jan 2002 20:04:29 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juhan Ernits <juhan@cc.ioc.ee> said:

[...]

> I installed linux on this box (Debian 2.2r4, kernel version 2.2.19).
> Then when configuring the network the module ne.o was chosen. 
> I was sure about the io address but not so sure about the irq. So I
> configured the module with only io address parameter.

This is enough, IRQ can be found from that datum. I assume this is an ISA
NIC? If PCI, no such parameters are needed. BTW, NE clones are (in)famous
for their bizarre assortment of bugs, you might have hit one that doesn't
work with Linux.

> At this point no problems occurred.
> 
> Then I configured the network address but the device eth0 did not appear
> to be available (naturally, due to misconfiguration). Since it was part of
> automated install I decided to reboot after this.

What does lsmod(8) tell you? If you do an "modprobe ne io=..." what does it
say?

If your guess at IO is wrong, nothing happens. If the NIC is _not_ an NE,
strange things could very well happen. It might be broken, not installed
correctly, jumpers set wrong, ...
-- 
Horst von Brand			     http://counter.li.org # 22616
