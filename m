Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSJXRsx>; Thu, 24 Oct 2002 13:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265582AbSJXRsx>; Thu, 24 Oct 2002 13:48:53 -0400
Received: from mout1.freenet.de ([194.97.50.132]:42421 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S265581AbSJXRst>;
	Thu, 24 Oct 2002 13:48:49 -0400
From: Andreas Hartmann <andihartmann@freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Two fatal crashes with 2.4.20pre11
Date: Thu, 24 Oct 2002 19:59:10 +0200
Organization: privat
Message-ID: <ap9cde$1gj$1@ID-44327.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Trace: susi.maya.org 1035482350 1555 192.168.1.3 (24 Oct 2002 17:59:10 GMT)
X-Complaints-To: abuse@fu-berlin.de
User-Agent: KNode/0.7.1
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


I run the kernel mentioned in the subject on an IBM TP21 notebook for about 
two days. During this time, the notebook hanged up completely two times - 
always during scrolling in X. Hangup means: mouse is hanging, keyboard is 
death and no more pinging via ethernet.

This problem didn't appear in 2.4.19.

Unfortunately, there are no logentries in /var/log/messages or somewhere 
else.


lspci -v (2.4.19)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge 
(rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 
03) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: f0000000-f7ffffff

00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: IBM: Unknown device 0130
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 50000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=04, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)
        Subsystem: IBM: Unknown device 0130
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 50100000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=05, subordinate=07, sec-latency=176
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

00:03.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 
01)
        Subsystem: AMBIT Microsystem Corp. Lucent Win Modem
        Flags: medium devsel, IRQ 11
        Memory at e8101000 (32-bit, non-prefetchable) [size=256]
        I/O ports at 1c00 [size=8]
        I/O ports at 1800 [size=256]
        Capabilities: [f8] Power Management version 2

00:04.0 PCI bridge: Texas Instruments: Unknown device ac22 (prog-if 01 
[Subtractive decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=00, secondary=08, subordinate=0e, sec-latency=68
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [80] Power Management version 1

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM: Unknown device 0153
        Flags: slow devsel, IRQ 11
        Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1c10 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) 
(prog-if 00 [UHCI])
        Flags: medium devsel, IRQ 11
        I/O ports at 1c20 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Flags: medium devsel, IRQ 9

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13) 
(prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 017f
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
        Capabilities: [80] AGP version 1.0

08:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01) (prog-if 8f 
[Master SecP SecO PriP PriO])
        Subsystem: CMD Technology Inc PCI0648
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at 2020 [size=8]
        I/O ports at 2014 [size=4]
        I/O ports at 2018 [size=8]
        I/O ports at 2010 [size=4]
        I/O ports at 2000 [size=16]
        Capabilities: [60] Power Management version 1

08:02.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: IBM: Unknown device 0148
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 52000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=09, subordinate=0b, sec-latency=128
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

08:02.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: IBM: Unknown device 0148
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 53000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=0c, subordinate=0e, sec-latency=128
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001


Kind regards,
Andreas Hartmann
