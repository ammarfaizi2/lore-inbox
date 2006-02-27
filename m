Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWB0RrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWB0RrT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWB0RrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:47:19 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:52133 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1751292AbWB0RrS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:47:18 -0500
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] Revert sky2 to 0.13a
Date: Mon, 27 Feb 2006 18:48:29 +0100
User-Agent: KMail/1.8
Cc: pomac@vapor.com,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4400FC28.1060705@gmx.net> <200602271738.38675.woho@woho.de> <20060227091837.3c214435@localhost.localdomain>
In-Reply-To: <20060227091837.3c214435@localhost.localdomain>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ttzAEQBFOw7recu"
Message-Id: <200602271848.29645.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ttzAEQBFOw7recu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 27 February 2006 18:18, Stephen Hemminger wrote:
> Okay, then what I need is lspci -v of all systems that have the problem,
> I'll make a blacklist (or update PCI quirks). I suspect that MSI doesn't
> work for any devices on these systems, or MSI changes the timing enough to
> expose existing races.

lspci -v attached

--Boundary-00=_ttzAEQBFOw7recu
Content-Type: text/plain;
  charset="iso-8859-1";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
        Subsystem: AOPEN Inc.: Unknown device 2580
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: da200000-da2fffff
        Prefetchable memory behind bridge: d0000000-d7ffffff
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [a0] #10 [0141]

0000:00:1b.0 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio Controller (rev 04)
        Subsystem: AOPEN Inc.: Unknown device 0560
        Flags: bus master, fast devsel, latency 0, IRQ 169
        Memory at da300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
        Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 2 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: da000000-da0fffff
        Prefetchable memory behind bridge: 0000000088000000-0000000088000000
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: da100000-da1fffff
        Prefetchable memory behind bridge: 0000000088100000-0000000088100000
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 4 (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 04) (prog-if 00 [UHCI])
        Subsystem: AOPEN Inc.: Unknown device 2658
        Flags: bus master, medium devsel, latency 0, IRQ 58
        I/O ports at e000 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 04) (prog-if 00 [UHCI])
        Subsystem: AOPEN Inc.: Unknown device 2659
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at e100 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 04) (prog-if 00 [UHCI])
        Subsystem: AOPEN Inc.: Unknown device 265a
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at e200 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 04) (prog-if 00 [UHCI])
        Subsystem: AOPEN Inc.: Unknown device 265b
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at e300 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 04) (prog-if 20 [EHCI])
        Subsystem: AOPEN Inc.: Unknown device 0553
        Flags: bus master, medium devsel, latency 0, IRQ 58
        Memory at da304000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d4) (prog-if 01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=06, subordinate=06, sec-latency=32
        Memory behind bridge: d8000000-d9ffffff
        Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 04)
        Subsystem: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: AOPEN Inc.: Unknown device 266f
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]

0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 04) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: AOPEN Inc.: Unknown device 052f
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 193
        I/O ports at e400 [size=8]
        I/O ports at e500 [size=4]
        I/O ports at e600 [size=8]
        I/O ports at e700 [size=4]
        I/O ports at e800 [size=16]
        Memory at da305000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 04)
        Subsystem: AOPEN Inc.: Unknown device 266a
        Flags: medium devsel, IRQ 11
        I/O ports at 5000 [size=32]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)] (prog-if 00 [VGA])
        Subsystem: PC Partner Limited: Unknown device 0450
        Flags: bus master, fast devsel, latency 0, IRQ 5
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at b000 [size=256]
        Memory at da230000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at da200000 [disabled] [size=128K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #10 [0001]
        Capabilities: [80] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:01:00.1 Display controller: ATI Technologies Inc RV370 [Radeon X300SE]
        Subsystem: PC Partner Limited: Unknown device 0451
        Flags: bus master, fast devsel, latency 0
        Memory at da220000 (32-bit, non-prefetchable) [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #10 [0001]

0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 19)
        Subsystem: AOPEN Inc. Marvell 88E8053 Gigabit Ethernet Controller (Aopen)
        Flags: bus master, fast devsel, latency 0, IRQ 177
        Memory at da020000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at c000 [size=256]
        Expansion ROM at 88000000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
        Capabilities: [e0] #10 [0011]

0000:04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 Gigabit Ethernet Controller (rev 19)
        Subsystem: AOPEN Inc. Marvell 88E8053 Gigabit Ethernet Controller (Aopen)
        Flags: bus master, fast devsel, latency 0, IRQ 185
        Memory at da120000 (64-bit, non-prefetchable) [size=16K]
        I/O ports at d000 [size=256]
        Expansion ROM at 88100000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
        Capabilities: [e0] #10 [0011]

0000:06:03.0 FireWire (IEEE 1394): Agere Systems FW323 (rev 61) (prog-if 10 [OHCI])
        Subsystem: AOPEN Inc.: Unknown device 030a
        Flags: bus master, medium devsel, latency 32, IRQ 66
        Memory at d9000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

0000:06:05.0 Multimedia audio controller: Xilinx Corporation RME Digi96/8 Pad (rev 04)
        Flags: slow devsel, IRQ 177
        Memory at d8000000 (32-bit, non-prefetchable) [size=16M]


--Boundary-00=_ttzAEQBFOw7recu--
