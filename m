Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267395AbUHRSFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267395AbUHRSFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267396AbUHRSFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:05:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:33922 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267395AbUHRSF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:05:28 -0400
Date: Wed, 18 Aug 2004 14:05:23 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: PCI-Bus
Message-ID: <Pine.LNX.4.53.0408181403120.16592@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello PCI gurus...

We have been using a high-speed fiber-optic data-link
built around a PLX(tm) chip and a HotLink(tm) chip.
It has been running at about the on-board clock-limit
of 133 megabytes per second, DMA from one box to another
box.

The chassis used "SuperO" X5DL8-GG motherboards. They
worked fine with Linux 2.4.26.

Some zit decided to change the working system and
ordered a bunch of CELESTICA A8 440 machines. Their
PCI/Bus perfoamance sucks. Instead of 133 megabytes
per second, I get 40 megabytes per second with the
exact same boards and Linux version. These systems
use AMD processors and even a faster front-side bus.
One could assume that they might even be faster.

The vendor says something like "Linux doesn't initialize
the PCI bus properly.....". They claim that the machine
is only "qualified" with W$, etc.

In the BIOS, there is a setup for win-95 through win-xp,
plus "unknown OS". I have tried them all.

Here is the output of `lspci -v`.......


00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 115
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=101
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: ec000000-edffffff
	Capabilities: [c0] #08 [0086]
	Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
	Flags: bus master, 66Mhz, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: medium devsel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:1a.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:1a.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:1a.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:1a.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:1b.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:1b.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:1b.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

00:1b.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Flags: fast devsel

01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 64, IRQ 19
	Memory at ec000000 (32-bit, non-prefetchable) [size=4K]

01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 64, IRQ 19
	Memory at ec001000 (32-bit, non-prefetchable) [size=4K]

01:01.0 Ethernet controller: Advanced Micro Devices [AMD] AMD-8111 Ethernet (rev 03)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 198, IRQ 16
	Memory at ec002000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage XL
	Flags: bus master, stepping, medium devsel, latency 64, IRQ 16
	Memory at ed000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at 2000 [size=256]
	Memory at ec003000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [5c] Power Management version 2

08:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=08, secondary=09, subordinate=0d, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: f1000000-f12fffff
	Capabilities: [a0] PCI-X non-bridge device.
	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [0041]

08:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 0
	Memory at ee200000 (64-bit, non-prefetchable) [size=4K]

08:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Bus: primary=08, secondary=0e, subordinate=12, sec-latency=128
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: f1300000-f13fffff
	Capabilities: [a0] PCI-X non-bridge device.
	Capabilities: [b8] #08 [8000]

08:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 0
	Memory at ee201000 (64-bit, non-prefetchable) [size=4K]

08:03.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Memory at ee202000 (64-bit, non-prefetchable) [size=4K]
	Bus: primary=08, secondary=13, subordinate=1a, sec-latency=64
	I/O behind bridge: 00005000-00005fff
	Memory behind bridge: ef000000-efffffff
	Prefetchable memory behind bridge: 00000000f4000000-00000000f7f00000
	Capabilities: [a0] PCI-X non-bridge device.
	Capabilities: [b8] #08 [8000]
	Capabilities: [90] #0c [0009]
	Capabilities: [98] Power Management version 2
	Capabilities: [c0] #08 [0043]

08:03.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 0
	Memory at ee203000 (64-bit, non-prefetchable) [size=4K]

08:04.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 64
	Memory at ee204000 (64-bit, non-prefetchable) [size=4K]
	Bus: primary=08, secondary=1b, subordinate=22, sec-latency=64
	I/O behind bridge: 00006000-00006fff
	Memory behind bridge: f0000000-f0ffffff
	Prefetchable memory behind bridge: 00000000f8000000-00000000fbf00000
	Capabilities: [a0] PCI-X non-bridge device.
	Capabilities: [b8] #08 [8000]
	Capabilities: [90] #0c [0009]
	Capabilities: [98] Power Management version 2

08:04.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, medium devsel, latency 0
	Memory at ee205000 (64-bit, non-prefetchable) [size=4K]

09:01.0 Serial controller: Analogic Corp DLB 0-62501 High-speed data link (prog-if 00 [8250])
	Subsystem: Analogic Corp DLB 0-62501 High-speed data link
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 25
	Memory at f1200000 (32-bit, non-prefetchable) [size=512]
	I/O ports at 3400 [disabled] [size=256]
	Memory at f1000000 (32-bit, non-prefetchable) [size=1M]
	I/O ports at 3000 [disabled] [size=256]
	Capabilities: [40] Power Management version 0
	Capabilities: [48] #00 [0000]

09:02.0 Serial controller: Analogic Corp DLB 0-62501 High-speed data link (prog-if 00 [8250])
	Subsystem: Analogic Corp DLB 0-62501 High-speed data link
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 26
	Memory at f1200400 (32-bit, non-prefetchable) [size=512]
	I/O ports at 3c00 [disabled] [size=256]
	Memory at f1100000 (32-bit, non-prefetchable) [size=1M]
	I/O ports at 3800 [disabled] [size=256]
	Capabilities: [40] Power Management version 0
	Capabilities: [48] #00 [0000]

0e:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, 66Mhz, medium devsel, latency 136, IRQ 29
	I/O ports at 4000 [size=256]
	Memory at f1310000 (64-bit, non-prefetchable) [size=64K]
	Memory at f1300000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [68] PCI-X non-bridge device.

0e:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, 66Mhz, medium devsel, latency 136, IRQ 30
	I/O ports at 4400 [size=256]
	Memory at f1330000 (64-bit, non-prefetchable) [size=64K]
	Memory at f1320000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=1M]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [68] PCI-X non-bridge device.

0e:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 31
	Memory at f1350000 (64-bit, non-prefetchable) [size=64K]
	Memory at f1340000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

0e:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
	Subsystem: Advanced Micro Devices [AMD]: Unknown device 2b80
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 28
	Memory at f1370000 (64-bit, non-prefetchable) [size=64K]
	Memory at f1360000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

The Analogic entries of:
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 25
don't look much different than the Ethernet controllers, above. Of
course they are built into the motherboard and claim 64-bits.

Does anybody have a clue what "Linux should have set up...", but
didn't? Or is this just a bunch of garbage from the vendor of
a defective product?


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


