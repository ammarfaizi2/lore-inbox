Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbTCSQZl>; Wed, 19 Mar 2003 11:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263069AbTCSQZl>; Wed, 19 Mar 2003 11:25:41 -0500
Received: from mail-8.tiscali.it ([195.130.225.154]:4695 "EHLO mail.tiscali.it")
	by vger.kernel.org with ESMTP id <S263067AbTCSQZi>;
	Wed, 19 Mar 2003 11:25:38 -0500
Date: Wed, 19 Mar 2003 17:35:23 +0100
From: Mauro Chiarugi <maurochiarugi@tiscali.it>
To: linux-kernel@vger.kernel.org
Subject: problem with pcmcia, pci and hard disk
Message-Id: <20030319173523.745fb4a9.maurochiarugi@tiscali.it>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i've an hp Pavillon ze4288. I've compilied my kernel with pcmcia support
disabled (i use pcmcia-cs, but without kernel support because i've a
cisco aironet card 352, and it works only with this support disabled as
Cisco's release notes says) but, when i boot, my system freeze:"PCI:
Found IRQ 11 for device 00:0a.0 IRQ routing conflict for 00:0a.0, have
irq 5, want irq 11 O2 MICRO OZ6912 rev 00 PCI-to-Cardbus at slot 00:0a,
mem 0x80000000  host opts [0]: [pci/way] [pci irq 5]
   [lat 32/32] [bus 2/5]"
I've seen that with other kernel too, i receive always an error that is
"spurious 8259A interrupt: IRQ 7".

My bios version is phoenix ka.m1.34

I report my lspci below.. as you can see, audio device use irq 5

Thx all

sracatus

--------
lspci -v
--------
00:00.0 Host bridge: ATI Technologies Inc: Unknown device cab0 (rev 13)
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	Memory at d0500000 (32-bit, prefetchable) [size=4K]
	I/O ports at 8070 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: ATI Technologies Inc U1/A3 AGP Bridge [IGP 320M]
(rev 01) (prog-if 00 [Normal decode])	Flags: bus master, 66Mhz, medium devsel,
latency 99	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d0100000-d01fffff
	Prefetchable memory behind bridge: e0000000-efffffff

00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
(prog-if 10 [OHCI])	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at d0004000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [60] Power Management version 2

00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 02)	Subsystem: Hewlett-Packard Company:
Unknown device 0024	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 8400 [size=256]
	Memory at d0005000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
	Subsystem: ALi Corporation ALI M1533 Aladdin IV ISA Bridge
	Flags: bus master, medium devsel, latency 0
	Capabilities: [a0] Power Management version 1

00:08.0 Modem: ALi Corporation Intel 537 [M5457 AC-Link Modem] (prog-if
00 [Generic])	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: medium devsel, IRQ 3
	Memory at d0006000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 8800 [size=256]
	Capabilities: [40] Power Management version 2

00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 5
	Memory at 80000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
	Memory window 0: 81000000-81100000 (prefetchable)
	Memory window 1: 1c000000-1c3ff000
	I/O window 0: 00003000-0000307f
	I/O window 1: 00004000-000040ff
	16-bit legacy interface ports at 0001

00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])	Subsystem:
Hewlett-Packard Company: Unknown device 0024	Flags: medium devsel, IRQ 9
	Memory at d0007000 (32-bit, non-prefetchable) [size=2K]
	Memory at d0000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4) (prog-if b0)
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, medium devsel, latency 32
	I/O ports at 8060 [size=16]
	Capabilities: [60] Power Management version 2

00:11.0 Bridge: ALi Corporation M7101 PMU
	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: medium devsel

00:12.0 Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller	Subsystem: Hewlett-Packard Company: Unknown
device 0024	Flags: bus master, medium devsel, latency 90, IRQ 11
	I/O ports at 8c00 [size=256]
	Memory at d0008000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2

01:05.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
U1 (prog-if 00 [VGA])	Subsystem: Hewlett-Packard Company: Unknown device 0024
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel,
latency 66, IRQ 10	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	I/O ports at 9000 [size=256]
	Memory at d0100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

