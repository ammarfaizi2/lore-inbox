Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281210AbRKLXiI>; Mon, 12 Nov 2001 18:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281203AbRKLXh7>; Mon, 12 Nov 2001 18:37:59 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:3080 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S281189AbRKLXhu>;
	Mon, 12 Nov 2001 18:37:50 -0500
Date: Mon, 12 Nov 2001 23:37:42 +0000 (GMT)
From: Dave Airlie <airlied@skynet.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Subject: PCI again in 2.4.15-pre4
Message-ID: <Pine.LNX.4.32.0111122334280.4284-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I saw this first in 2.4.15-pre2 here it is again for pre4.

I've attached a cat /proc/pci which is bad, my Xircom doesn't show up,
further down I've attached an lspci -v -H 1 and it has my Xircom on it ..

Anyone care to comment... this worked in 2.4.10 I'll try to patch up to
2.4.14 and see where it stared..

Dave.

cat /proc/pci:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xf4000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=32.  Min Gnt=140.
  Bus  0, device   3, function  0:
    CardBus bridge: Texas Instruments PCI1225 (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=128.Max Lat=6.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   3, function  1:
    CardBus bridge: Texas Instruments PCI1225 (#2) (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.
      I/O at 0x860 [0x86f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.
      I/O at 0xdce0 [0xdcff].
  Bus  0, device   7, function  3:
    Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 3).
      IRQ 9.
  Bus  0, device   8, function  0:
    Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 16).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd800 [0xd8ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 100).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xfcfff000 [0xfcffffff].
  Bus  2, device   0, function  0:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  1:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  2:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  3:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  4:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  5:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  6:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.
  Bus  2, device   0, function  7:
    Class ffff:  (rev 255).
      Master Capable.  Latency=255.  Min Gnt=255.Max Lat=255.

lspci -v -H 1

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32
	Memory at f4000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fc000000-feffffff

00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10000000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at 10001000 (32-bit, non-prefetchable)
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 32
	I/O ports at 0860

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dce0

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, medium devsel, latency 32, IRQ 5
	I/O ports at d800
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 64) (prog-if 00 [VGA])
	Subsystem: Dell Computer Corporation: Unknown device 00ab
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable)
	I/O ports at ec00
	Memory at fcfff000 (32-bit, non-prefetchable)
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1

04:00.0 Ethernet controller: Xircom Cardbus Ethernet 10/100 (rev 03)
	Subsystem: Xircom Cardbus Ethernet 10/100
	Flags: medium devsel, IRQ 255
	I/O ports at <unassigned> [disabled]
	Capabilities: [dc] Power Management version 1

04:00.1 Serial controller: Xircom Cardbus Ethernet + 56k Modem (rev 03) (prog-if 02 [16550])
	Subsystem: Xircom CBEM56G-100 Ethernet + 56k Modem
	Flags: medium devsel, IRQ 255
	I/O ports at <unassigned> [disabled]
	Capabilities: [dc] Power Management version 1


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


