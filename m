Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbTG1MHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 08:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTG1MHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 08:07:48 -0400
Received: from hades.mk.cvut.cz ([147.32.96.3]:24530 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S263875AbTG1MHo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 08:07:44 -0400
Message-ID: <3F2515A2.8040008@kmlinux.fjfi.cvut.cz>
Date: Mon, 28 Jul 2003 14:22:58 +0200
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: via-rhine broken in 2.4.22-pre8 and 2.6.0-pre1&2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc:, I am not a subscriber]

Hello,

I recently tried 2.6.0-test1, 2.6.0-test2, 2.4.22-pre6 and 2.4.22-pre8, 
and via-rhine seems broken in all of them. Network connection doesn't 
work, and only the timeout messages appear:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, status 0003, PHY status 786d, resetting...
eth0: Setting full-duplex based on MII #1 link partner capability of 41e1.

2.4.21 still works fine.

lspci -v:

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Subsystem: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Flags: bus master, 66Mhz, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00 
[Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: e0000000-e1ffffff
	Prefetchable memory behind bridge: d8000000-dfffffff
	Capabilities: [80] Power Management version 2

00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at a000 [size=32]
	Capabilities: [dc] Power Management version 1

00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at a400 [size=8]
	Capabilities: [dc] Power Management version 1

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at e3001000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at e3000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2

00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 17
	I/O ports at a800 [size=8]
	I/O ports at ac00 [size=4]
	I/O ports at b000 [size=8]
	I/O ports at b400 [size=4]
	I/O ports at b800 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 17
	I/O ports at bc00 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at c400 [size=8]
	I/O ports at c800 [size=4]
	I/O ports at cc00 [size=256]
	Capabilities: [60] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
	Subsystem: Unknown device 1695:3005
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
	Subsystem: Unknown device 1695:3005
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
	Subsystem: Unknown device 1695:3005
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
	Subsystem: Unknown device 1695:3005
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at e3002000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Unknown device 1695:3005
	Flags: bus master, medium devsel, latency 32
	I/O ports at dc00 [size=16]
	Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
	Subsystem: Unknown device 1695:3005
	Flags: bus master, medium devsel, latency 32, IRQ 23
	I/O ports at e000 [size=256]
	Memory at e3003000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev b2) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
	Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
	Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

-- 
Jindrich Makovicka

