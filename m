Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267274AbTAPVF3>; Thu, 16 Jan 2003 16:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbTAPVF3>; Thu, 16 Jan 2003 16:05:29 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:43208 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S267274AbTAPVF0> convert rfc822-to-8bit; Thu, 16 Jan 2003 16:05:26 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: linux-kernel@vger.kernel.org
Subject: [ACPI] 2.5.58 hangs at boot 
Date: Thu, 16 Jan 2003 22:15:35 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301162215.35903.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

2.5.58 hangs during booting, at this place:

......
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030109

2.5.56 was working OK, except the usual usb problems.

Thank you,
Michael




karpfen:/home/dreher # lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: VIA Technologies, Inc. VT8367 [KT266]
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 
[Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: e8000000-e80fffff
        Prefetchable memory behind bridge: e4000000-e7ffffff
        Capabilities: [80] Power Management version 2

00:06.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2

00:06.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 50) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2

00:06.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev 
51) (prog-if 20)
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 7
        Memory at e8111000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 2

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 
(rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d800 [size=256]
        Memory at e8110000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc.: Unknown device 3147
        Subsystem: VIA Technologies, Inc.: Unknown device 3147
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at dc00 [size=16]
        Capabilities: [c0] Power Management version 2

00:11.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 7
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

00:11.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 23) (prog-if 
00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 32, IRQ 7
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 40)
        Subsystem: AOPEN Inc.: Unknown device 01ae
        Flags: medium devsel, IRQ 5
        I/O ports at e800 [size=256]
        Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro TF 
(prog-if 00 [VGA])
        Subsystem: Unknown device 1787:0100
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, 
IRQ 11
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        I/O ports at c000 [size=256]
        Memory at e8020000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [50] AGP version 2.0
        Capabilities: [5c] Power Management version 2

karpfen:/home/dreher #
