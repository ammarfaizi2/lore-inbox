Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbVFRKpz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbVFRKpz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 06:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVFRKpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 06:45:54 -0400
Received: from pop.gmx.net ([213.165.64.20]:55502 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262101AbVFRKpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 06:45:16 -0400
X-Authenticated: #9962044
From: marvin24@gmx.de
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: forcedeth as a module only?
Date: Sat, 18 Jun 2005 12:44:59 +0200
User-Agent: KMail/1.8.1
References: <200506171804.j5HI4qoh027680@dbl.q-ag.de> <42B31749.90208@g-house.de> <42B336FC.9000400@colorfullife.com>
In-Reply-To: <42B336FC.9000400@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506181245.00670.marvin24@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Manfred,

I have an Asus K8N-E Deluxe (nForce3) and had problems with loosing network 
connection from time to time (every 30 minutes or so). The nic is NVENET_7 
(see lspci). Adding the DEV_NEED_LINKTIMER workaround solved the problem for 
me.
What is this workaround doing? Since I also heard of several people having 
such problems, why isn't this fix applied to all forcedeth devices?

Btw. Windows XP x86-64 has the same problem - but didn't found the source yet 
to patch ;-)

Best wishes 

Marc

# uname -a
Linux fb07-iapwap6 2.6.11 #4 Mon Jun 13 17:03:57 CEST 2005 x86_64 GNU/Linux
# lspci -v
0000:00:00.0 Host bridge: nVidia Corporation: Unknown device 00e1 (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: bus master, 66MHz, fast devsel, latency 0
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [44] #08 [01c0]
        Capabilities: [c0] AGP version 3.0

0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 00e0 (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: bus master, 66MHz, fast devsel, latency 0

0000:00:01.1 SMBus: nVidia Corporation: Unknown device 00e4 (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: 66MHz, fast devsel
        I/O ports at 5080 [size=32]
        I/O ports at 5000 [size=64]
        I/O ports at 5040 [size=64]
        Capabilities: [44] Power Management version 2

0000:00:02.0 USB Controller: nVidia Corporation: Unknown device 00e7 (rev a1) 
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
        Memory at ff6fd000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

0000:00:02.1 USB Controller: nVidia Corporation: Unknown device 00e7 (rev a1) 
(prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
        Memory at ff6fe000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

0000:00:02.2 USB Controller: nVidia Corporation: Unknown device 00e8 (rev a2) 
(prog-if 20 [EHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 20
        Memory at ff6ffc00 (32-bit, non-prefetchable) [size=256]
        Capabilities: [44] #0a [2098]
        Capabilities: [80] Power Management version 2

0000:00:05.0 Bridge: nVidia Corporation: Unknown device 00df (rev a2)
        Subsystem: Asustek Computer, Inc.: Unknown device 80a7
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 22
        Memory at ff6fc000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at ec00 [size=8]
        Capabilities: [44] Power Management version 2

0000:00:06.0 Multimedia audio controller: nVidia Corporation: Unknown device 
00ea (rev a1)
        Subsystem: Asustek Computer, Inc.: Unknown device 812a
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 21
        I/O ports at e800 [size=256]
        I/O ports at e400 [size=128]
        Memory at ff6fb000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

0000:00:08.0 IDE interface: nVidia Corporation: Unknown device 00e5 (rev a2) 
(prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 813f
        Flags: bus master, 66MHz, fast devsel, latency 0
        I/O ports at ffa0 [size=16]
        Capabilities: [44] Power Management version 2

0000:00:0b.0 PCI bridge: nVidia Corporation: Unknown device 00e2 (rev a2) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 16
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=10
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: ff400000-ff4fffff
        Prefetchable memory behind bridge: aeb00000-eeafffff

0000:00:0e.0 PCI bridge: nVidia Corporation: Unknown device 00ed (rev a2) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=128
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: ff500000-ff5fffff

0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel
        Capabilities: [80] #08 [2101]

0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
        Flags: fast devsel

0000:01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 
4153 (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 0200
        Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        I/O ports at c800 [size=256]
        Memory at ff4f0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at ff4c0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 3.0
        Capabilities: [50] Power Management version 2

0000:01:00.1 Display controller: ATI Technologies Inc: Unknown device 4173
        Subsystem: PC Partner Limited: Unknown device 0201
        Flags: bus master, 66MHz, medium devsel, latency 64
        Memory at c0000000 (32-bit, prefetchable) [size=256M]
        Memory at ff4e0000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 2

0000:02:0b.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80) (prog-if 10 [OHCI])
        Subsystem: Asustek Computer, Inc.: Unknown device 808a
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at ff5ff800 (32-bit, non-prefetchable) [size=2K]
        I/O ports at dc00 [size=128]
        Capabilities: [50] Power Management version 2


Am Freitag, 17. Juni 2005 22:47 schrieben Sie:
> Christian Kujau wrote:
> >are there any known issues with the forcedeth driver when statically
> >compiled in?
>
> No.
> But there are known issues with link detection: Some users report bad
> performance, and misconfigured links are one possible explanation.
>
> >eth0: forcedeth.c: subsystem: 01462:0250 bound to 0000:00:05.0
> >eth0: no link during initialization
>
> Very interesting.  The message itself is not fatal: It merely means that
> there was no link during ifup. This typically happens when the hardware
> initialization was not yet finished during ifup. Theoretically, an
> interrupt should happen when the hardware initialization is completed
> and that interrupt then sets up the link.
> Somehow it doesn't work for you.
>
> Could you try the attached patch? It polls for link changes instead of
> relying on the irq. Additionally, I have enabled some debug output.
>
> --
>     Manfred
