Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSJVLmw>; Tue, 22 Oct 2002 07:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJVLmw>; Tue, 22 Oct 2002 07:42:52 -0400
Received: from smtpcl2.fiducia.de ([195.200.32.60]:50364 "EHLO
	smtpcl2.fiducia.de") by vger.kernel.org with ESMTP
	id <S262450AbSJVLms>; Tue, 22 Oct 2002 07:42:48 -0400
Sensitivity: 
Subject: Re: PCI: Failed to allocate resource in 2.4.20pre10 and 11 - broken	IRQ-router?
To: "Alan Cox <alan" <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
From: "Andreas Hartmann" <andreas.hartmann@fiducia.de>
Date: Tue, 22 Oct 2002 13:48:45 +0100
Message-ID: <OFD7C667D3.0FFAD96B-ON41256C5A.0043BB37@fag.fiducia.de>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am 22.10.2002 11:10:03 schrieb Alan Cox :
> On Tue, 2002-10-22 at 07:28, Andreas Hartmann wrote:
> > Hello all,
> >
> > I'm using an IBM Thinkpad T21 with a dockingstation, which has an own
> additional
> > ide-controller. At this controller, one more ATA-IDE hd is connected
> (/dev/hde).
> > dmesg with kernel 2.4.19 looks like this (correct version):
>
> Please send me an lspci -v. Im curious about this one because the dock
> on my TP600 the IDE does work, although we dont yet support hot plugging
> IDE.

Hot plugging would be really nice - but you need a program to switch on or off
the locking of the docking station too.

> Also try 2.4.19 with the config you had in the working kernel - you
> have explicit CMD64x in one but not the other

CMD64x is switched off in *both* config-files of the kernel. I switched it on in
the 2.4.20pre10 kernel, but the result is the same.


lspci -v (2.4.19)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
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

00:03.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
        Subsystem: AMBIT Microsystem Corp. Lucent Win Modem
        Flags: medium devsel, IRQ 11
        Memory at e8101000 (32-bit, non-prefetchable) [size=256]
        I/O ports at 1c00 [size=8]
        I/O ports at 1800 [size=256]
        Capabilities: [f8] Power Management version 2

00:04.0 PCI bridge: Texas Instruments: Unknown device ac22 (prog-if 01 [Subtractive decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=00, secondary=08, subordinate=0e, sec-latency=68
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [80] Power Management version 1

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM: Unknown device 0153
        Flags: slow devsel, IRQ 11
        Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1c10 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: medium devsel, IRQ 11
        I/O ports at 1c20 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Flags: medium devsel, IRQ 9

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 017f
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
        Capabilities: [80] AGP version 1.0

08:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
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



lspci -v (2.4.20pre10)
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 03)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 03) (prog-if 00 [Normal decode])
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

00:03.0 Communication controller: Lucent Microelectronics WinModem 56k (rev 01)
        Subsystem: AMBIT Microsystem Corp. Lucent Win Modem
        Flags: medium devsel, IRQ 11
        Memory at e8101000 (32-bit, non-prefetchable) [size=256]
        I/O ports at 1c00 [size=8]
        I/O ports at 1800 [size=256]
        Capabilities: [f8] Power Management version 2

00:04.0 PCI bridge: Texas Instruments: Unknown device ac22 (prog-if 01 [Subtractive decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=00, secondary=08, subordinate=0e, sec-latency=68
        I/O behind bridge: 00000000-00000fff
        Memory behind bridge: 00000000-000fffff
        Prefetchable memory behind bridge: 00000000-000fffff
        Capabilities: [80] Power Management version 1

00:05.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator] (rev 01)
        Subsystem: IBM: Unknown device 0153
        Flags: slow devsel, IRQ 11
        Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Memory at e8000000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

00:07.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 1c10 [size=16]

00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: medium devsel, IRQ 11
        I/O ports at 1c20 [size=32]

00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 03)
        Flags: medium devsel, IRQ 9

01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/IX-MV (rev 13) (prog-if 00 [VGA])
        Subsystem: IBM: Unknown device 017f
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 11
        Memory at f0000000 (32-bit, non-prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
        Capabilities: [80] AGP version 1.0

08:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: CMD Technology Inc PCI0648
        Flags: bus master, medium devsel, latency 64, IRQ 11
        I/O ports at <ignored> [size=8]
        I/O ports at <ignored> [size=4]
        I/O ports at <ignored> [size=8]
        I/O ports at <ignored> [size=4]
        I/O ports at <ignored> [size=16]
        Capabilities: [60] Power Management version 1

08:02.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: IBM: Unknown device 0148
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at <ignored> (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=09, subordinate=0b, sec-latency=128
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001

08:02.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: IBM: Unknown device 0148
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at <ignored> (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=0c, subordinate=0e, sec-latency=128
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
        16-bit legacy interface ports at 0001


diff -u 2.4.19 2.4.20pre10
--- 2.4.19    Tue Oct 22 13:09:03 2002
+++ 2.4.20pre10        Tue Oct 22 13:07:41 2002
@@ -74,17 +74,17 @@
 08:01.0 IDE interface: CMD Technology Inc PCI0648 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: CMD Technology Inc PCI0648
        Flags: bus master, medium devsel, latency 64, IRQ 11
-       I/O ports at 2020 [size=8]
-       I/O ports at 2014 [size=4]
-       I/O ports at 2018 [size=8]
-       I/O ports at 2010 [size=4]
-       I/O ports at 2000 [size=16]
+       I/O ports at <ignored> [size=8]
+       I/O ports at <ignored> [size=4]
+       I/O ports at <ignored> [size=8]
+       I/O ports at <ignored> [size=4]
+       I/O ports at <ignored> [size=16]
        Capabilities: [60] Power Management version 1

 08:02.0 CardBus bridge: Texas Instruments PCI1420
        Subsystem: IBM: Unknown device 0148
        Flags: bus master, medium devsel, latency 64, IRQ 11
-       Memory at 52000000 (32-bit, non-prefetchable) [size=4K]
+       Memory at <ignored> (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=09, subordinate=0b, sec-latency=128
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003
@@ -93,7 +93,7 @@
 08:02.1 CardBus bridge: Texas Instruments PCI1420
        Subsystem: IBM: Unknown device 0148
        Flags: bus master, medium devsel, latency 64, IRQ 11
-       Memory at 53000000 (32-bit, non-prefetchable) [size=4K]
+       Memory at <ignored> (32-bit, non-prefetchable) [size=4K]
        Bus: primary=08, secondary=0c, subordinate=0e, sec-latency=128
        I/O window 0: 00000000-00000003
        I/O window 1: 00000000-00000003

Regards,
Andreas Hartmann


