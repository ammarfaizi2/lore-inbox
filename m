Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbSLHUMs>; Sun, 8 Dec 2002 15:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSLHUMs>; Sun, 8 Dec 2002 15:12:48 -0500
Received: from m1.cs.man.ac.uk ([130.88.192.2]:47884 "EHLO m1.cs.man.ac.uk")
	by vger.kernel.org with ESMTP id <S261600AbSLHUMq>;
	Sun, 8 Dec 2002 15:12:46 -0500
Date: Sun, 8 Dec 2002 20:20:18 +0000 (GMT)
From: Simon Ward <simon.ward@cs.man.ac.uk>
X-X-Sender: wards0@tl008.cs.man.ac.uk
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
Subject: Re: PROBLEM: Oops.. NULL pointer reference in 2.4.20-ac1 (fixed)
In-Reply-To: <87hedo8i84.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.44.0212082012430.23903-100000@tl008.cs.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2002, OGAWA Hirofumi wrote:

> Probably his M5229 has 0xff on INTERRUPT_LINE after boot immediately.
> 
> Simon, could you send the outputs of `lspci -vx'? And the following
> patch fixs this problem?

The patch works fine. Thank you. The output of 'lspci -vx' follows:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
	Flags: bus master, slow devsel, latency 64
	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
00: b9 10 41 15 06 00 10 24 04 00 00 06 00 40 00 00
10: 00 00 00 e0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 41 15
30: 00 00 00 00 b0 00 00 00 00 00 00 00 00 00 00 00

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M1541 PCI to AGP Controller (rev 04) (prog-if 00 [Normal decode])
	Flags: bus master, slow devsel, latency 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: de000000-dfffffff
	Prefetchable memory behind bridge: e5f00000-e7ffffff
00: b9 10 43 52 07 00 00 04 04 00 04 06 00 40 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 40 d0 d0 00 20
20: 00 de f0 df f0 e5 f0 e7 00 00 00 00 00 00 00 00
30: 00 00 00 00 e0 00 00 00 00 00 00 00 00 00 08 00

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
	Flags: medium devsel
00: b9 10 01 71 01 00 80 02 00 00 80 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b9 10 01 71
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
	Flags: bus master, medium devsel, latency 0
00: b9 10 33 15 0f 00 00 32 c3 00 01 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00: 14 4a 00 50 03 00 00 02 00 00 00 02 00 00 00 00
10: 01 b8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 14 4a 00 50
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 01 00 00

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at b400 [size=16]
00: b9 10 29 52 05 00 80 02 c1 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 02 04

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01) (prog-if 00 [VGA])
	Subsystem: 3Dfx Interactive, Inc. Voodoo3 AGP
	Flags: 66Mhz, fast devsel, IRQ 11
	Memory at de000000 (32-bit, non-prefetchable) [size=32M]
	Memory at e6000000 (32-bit, prefetchable) [size=32M]
	I/O ports at d800 [size=256]
	Expansion ROM at e5ff0000 [disabled] [size=64K]

00:0a.0 Ethernet controller: NetVin NV5000SC
	Subsystem: NetVin RT8029-Based Ethernet Adapter
	Flags: medium devsel, IRQ 10
	I/O ports at b800 [size=32]
	Capabilities: [54] AGP version 1.0
	Capabilities: [60] Power Management version 1
00: 1a 12 05 00 03 00 b0 80 01 00 00 03 00 00 00 00
10: 00 00 00 de 08 00 00 e6 01 d8 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 1a 12 30 00
30: 00 00 ff e5 54 00 00 00 00 00 00 00 0b 01 00 00


Regards
Simon Ward
-- 
Email: simon.ward@cs.man.ac.uk -- ICQ UIN: 63202593
Too many people are thinking of security instead of opportunity.  They seem
more afraid of life than death.
		-- James F. Byrnes

