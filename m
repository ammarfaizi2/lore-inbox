Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280608AbRKJTXc>; Sat, 10 Nov 2001 14:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280612AbRKJTXX>; Sat, 10 Nov 2001 14:23:23 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:47627 "HELO holly.csn.ul.ie")
	by vger.kernel.org with SMTP id <S280608AbRKJTXI>;
	Sat, 10 Nov 2001 14:23:08 -0500
Date: Sat, 10 Nov 2001 19:23:01 +0000 (GMT)
From: Dave Airlie <airlied@csn.ul.ie>
X-X-Sender: <airlied@skynet>
To: <linux-kernel@vger.kernel.org>
Cc: <torvalds@transmeta.com>
Subject: 2.4.15-pre2 and broken /proc/pci
Message-ID: <Pine.LNX.4.32.0111101920030.10656-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.15-pre2 on my Dell Inspiron 3700, 2.4.10 worked fine, went straight to
pre2 ...

PCMCIA stopped working didn't see my cards, and I took a look in /proc/pci
and this what I saw..

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

with 2.4.10 I get:

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 3).
      Master Capable.  Latency=32.
      Prefetchable 32 bit memory at 0xf4000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 3).
      Master Capable.  Latency=32.  Min Gnt=140.
  Bus  0, device   3, function  0:
    CardBus bridge: Texas Instruments PCI1225 (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  Max Lat=6.
      Non-prefetchable 32 bit memory at 0x10000000 [0x10000fff].
  Bus  0, device   3, function  1:
    CardBus bridge: Texas Instruments PCI1225 (#2) (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=192.Max Lat=7.
      Non-prefetchable 32 bit memory at 0x10001000 [0x10001fff].
  Bus  0, device   7, function  0:
    Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 2).
  Bus  0, device   7, function  1:
    IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 1).
      Master Capable.  Latency=32.
      I/O at 0x860 [0x86f].
  Bus  0, device   7, function  2:
    USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.
      I/O at 0xdce0 [0xdcff].
  Bus  0, device   7, function  3:
    Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 3).
      IRQ 9.
  Bus  0, device   8, function  0:
    Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 16).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xd800 [0xd8ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage P/M Mobility AGP 2x (rev 100).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xfd000000 [0xfdffffff].
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xfcfff000 [0xfcffffff].
  Bus  2, device   0, function  0:
    Ethernet controller:  (rev 3).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=20.Max Lat=40.
  Bus  2, device   0, function  1:
    Serial controller:  (rev 3).
      IRQ 11.

Any ideas?

Regards,
	Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied@skynet.ie
pam_smb / Linux DecStation / Linux VAX / ILUG person


