Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTAENHX>; Sun, 5 Jan 2003 08:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTAENHX>; Sun, 5 Jan 2003 08:07:23 -0500
Received: from web14008.mail.yahoo.com ([216.136.175.124]:29349 "HELO
	web14008.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264716AbTAENHV>; Sun, 5 Jan 2003 08:07:21 -0500
Message-ID: <20030105131555.46223.qmail@web14008.mail.yahoo.com>
Date: Sun, 5 Jan 2003 05:15:55 -0800 (PST)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: RE: updated CDROMREADAUDIO DMA patch
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I tried the patch on 2.4.21pre2. In the short time that it has been on,
it seems
to be working. To test, I did this before the patch:
cdda2wav -D /dev/cdrom -e -N, then fired up Quake3, 
the game was very stuttery. CD music played fine. After patching, 
the game played smooth, game sounds were smooth 
as well as the CD music.

I will bat it around more and report any problems.

Thanks!

Tony

lspci - INTEL 845PESVL motherboard:
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host
Bridge (rev 02)
	Subsystem: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
	Flags: bus master, fast devsel, latency 0
	Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] #09 [6105]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP
Bridge (rev 02) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, fast devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: fc500000-fe5fffff
	Prefetchable memory behind bridge: cc100000-dc2fffff

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5356
	Flags: bus master, medium devsel, latency 0, IRQ 16
	I/O ports at e800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5356
	Flags: bus master, medium devsel, latency 0, IRQ 19
	I/O ports at e880 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 02)
(prog-if 00 [UHCI])
	Subsystem: Intel Corp.: Unknown device 5356
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at ec00 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev
02) (prog-if 20 [EHCI])
	Subsystem: Intel Corp.: Unknown device 5356
	Flags: bus master, medium devsel, latency 0, IRQ 23
	Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] #0a [2080]

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
(prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: fe600000-feafffff
	Prefetchable memory behind bridge: dc300000-dc3fffff

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
	Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02) (prog-if
8a [Master SecP PriP])
	Subsystem: Intel Corp.: Unknown device 5356
	Flags: bus master, medium devsel, latency 0, IRQ 18
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at <unassigned> [size=8]
	I/O ports at <unassigned> [size=4]
	I/O ports at ffa0 [size=16]
	Memory at 40000000 (32-bit, non-prefetchable) [disabled] [size=1K]

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 02)
	Subsystem: Intel Corp.: Unknown device 5356
	Flags: medium devsel, IRQ 17
	I/O ports at e480 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4
Ti4600] (rev a2) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Memory at dc280000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at fe5e0000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:01.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
(rev 01)
	Subsystem: Adaptec AHA-3960D U160/m
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 22
	BIST result: 00
	I/O ports at d400 [disabled] [size=256]
	Memory at feafe000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feaa0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

02:01.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m
(rev 01)
	Subsystem: Adaptec AHA-3960D U160/m
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 21
	BIST result: 00
	I/O ports at d800 [disabled] [size=256]
	Memory at feaff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at feac0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2

02:03.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24]
(rev 02)
	Subsystem: IC Ensemble Inc: Unknown device d634
	Flags: bus master, medium devsel, latency 32, IRQ 19
	I/O ports at dc00 [size=32]
	I/O ports at d080 [size=16]
	I/O ports at d000 [size=16]
	I/O ports at df00 [size=64]
	Capabilities: [80] Power Management version 1

02:05.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
	Subsystem: IBM 10/100 EtherJet Management Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 18
	Memory at feafd000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at de80 [size=64]
	Memory at fe900000 (32-bit, non-prefetchable) [size=1M]
	Expansion ROM at fe800000 [disabled] [size=1M]
	Capabilities: [dc] Power Management version 2

02:08.0 Ethernet controller: Intel Corp. 82801BD PRO/100 VE (LOM)
Ethernet Controller (rev 82)
	Subsystem: Intel Corp.: Unknown device 3015
	Flags: bus master, medium devsel, latency 32, IRQ 20
	Memory at feafc000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at de00 [size=64]
	Capabilities: [dc] Power Management version 2

