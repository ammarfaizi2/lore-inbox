Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265786AbTATNPE>; Mon, 20 Jan 2003 08:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTATNPD>; Mon, 20 Jan 2003 08:15:03 -0500
Received: from cibs9.sns.it ([192.167.206.29]:47365 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S265786AbTATNO7>;
	Mon, 20 Jan 2003 08:14:59 -0500
Date: Mon, 20 Jan 2003 14:23:58 +0100 (CET)
From: venom@sns.it
To: linux-kernel@vger.kernel.org
Subject: ReiserFS corruption with kernel 2.5.59
Message-ID: <Pine.LNX.4.43.0301201418180.1075-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI,
I was using reiserFS for the root FS on a desktop, just to test kernel 2.5.59,
and I started to get those messages:

PAP-14030: direct2indirect: pasted or inserted byte exists in the tree [5094
5096 0x1001 IND]. Use fsck to repair.

Of course I repaired the FS.

System was under a really light I/O load, and stared to have those problems
after a couple of days of uptime.

System is:
Pentium III 933 Mhz, 256 KB L2 cache
512 MB RAM
i810 MB chipset

kernel is 2.5.59 compiled with gcc 3.2.1 and binutils 2.13.90.0.16

Disk is a Maxtor 32049H2, connected to an ATA66 intel 82801AA controller.


/proc/pci is:
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and Memory Controller
Hub (rev 2).
      Prefetchable 32 bit memory at 0x44000000 [0x47ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82815 815 Chipset AGP Bridge (rev 2).
      Master Capable.  Latency=64.  Min Gnt=12.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801AA PCI Bridge (rev 2).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801AA ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801AA IDE (rev 2).
      I/O at 0x2460 [0x246f].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82801AA USB (rev 2).
      IRQ 19.
      I/O at 0x2440 [0x245f].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801AA AC'97 Audio (rev 2).
      IRQ 17.
      I/O at 0x2000 [0x20ff].
      I/O at 0x2400 [0x243f].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 4).
      IRQ 18.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0x42000000 [0x43ffffff].
      Non-prefetchable 32 bit memory at 0x40300000 [0x40303fff].
      Non-prefetchable 32 bit memory at 0x40800000 [0x40ffffff].
  Bus  2, device   8, function  0:
    Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 120).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=10.Max Lat=10.
      I/O at 0x1000 [0x107f].
      Non-prefetchable 32 bit memory at 0x40000000 [0x4000007f].

Hope this helps

Luigi




