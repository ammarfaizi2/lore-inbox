Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280589AbRKBHdP>; Fri, 2 Nov 2001 02:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRKBHdE>; Fri, 2 Nov 2001 02:33:04 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:34725 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S280589AbRKBHcv>; Fri, 2 Nov 2001 02:32:51 -0500
Date: Fri, 2 Nov 2001 09:44:35 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <linux-kernel@vger.kernel.org>
Subject: Forcing 8259A for one irq.
Message-ID: <Pine.LNX.4.33.0111020925560.32189-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a strange scenario whereupon i have a box with IO-APIC enabled
(SMP box) and a driver which seems not to be SMP safe and only works if i
boot the kernel with noapic. My question is, which is the cleanest way of
making a specific IRQ use the 8259 instead of IOAPIC? (kind of like the
timer on some boxes).

I've looked at the enable_8259A_irq function, but my method looks terribly
incorrect (and untested too). Would this method work? And is there
anything i should look out for?

irq_num = IRQ below 15 (specified as parameter to module)
add entry to IO-APIC routing table? (local-apic to CPU#0)
enable_8259A_irq(irq_num)

This is only a temporary measure until i get the driver completely SMP
safe and i want to avoid running noapic.

Thanks in advance,
	Zwane Mwaikambo

--
Anyone for a LUG in Swaziland?

