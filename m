Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268064AbTAIXcy>; Thu, 9 Jan 2003 18:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268067AbTAIXcy>; Thu, 9 Jan 2003 18:32:54 -0500
Received: from very.disjunkt.com ([195.167.192.238]:29893 "EHLO disjunkt.com")
	by vger.kernel.org with ESMTP id <S268064AbTAIXcp> convert rfc822-to-8bit;
	Thu, 9 Jan 2003 18:32:45 -0500
Date: Fri, 10 Jan 2003 00:37:36 +0100 (CET)
From: Jean-Daniel Pauget <jd@disjunkt.com>
X-X-Sender: jd@mint
To: Alan Cox <alan@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
In-Reply-To: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.51.0301100021050.5467@mint>
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    I had some strange bug using 2.4.21pre3-ac2 :
    at rebooting after a freeze (my machine freezes from time to time
    whatever the kernel is, I'm still diging that point)
    fsck.ext2 was not able to finish checking my /home (59Gb), it
    systematically got a signal 11 (I tried several times).

    rebooting using my previous kernel (2.4.20 with a minor patch for the
    i845G AGP mess-up) was enough so that the fsck worked fine at the first
    attempt with this kernel.

    this triggers two questions :
	o is the new piix-ide faulty ?
	o are 256 Mb of memory enough for fscking a 58Gb partition ?

    about signal 11, I tested my machine with several concurent kernel
    built with no signal 11 before (with 2.4.20 and prior)

    the machine is an ASUS P4PE motherboard, 2,4GHz PIV 256Mb
    and a nvidia Ge4-Ti4200. (at signal 11, the nvidia tainted module was
    not loaded yet :)

    thanks in advance for any enlightment...

    here-below, the lspci and /proc/pci...

--
Quand les plombs pêtent : « Ðïsjüñ£t.¢¤× »

--
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 02)
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub  (rev 02)
00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3)
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
02:05.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 02)

--
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 2).
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 2).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 2).
      IRQ 11.
      I/O at 0xd800 [0xd81f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 2).
      IRQ 5.
      I/O at 0xd400 [0xd41f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 2).
      IRQ 9.
      I/O at 0xd000 [0xd01f].
  Bus  0, device  29, function  7:
    USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 2).
      Non-prefetchable 32 bit memory at 0xe5800000 [0xe58003ff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 130).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 2).
      IRQ 9.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0xf000 [0xf00f].
      Non-prefetchable 32 bit memory at 0x10000000 [0x100003ff].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 2).
      IRQ 10.
      I/O at 0xa800 [0xa8ff].
      I/O at 0xa400 [0xa43f].
      Non-prefetchable 32 bit memory at 0xe4000000 [0xe40001ff].
      Non-prefetchable 32 bit memory at 0xe3800000 [0xe38000ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev 163).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
      Prefetchable 32 bit memory at 0xe7800000 [0xe787ffff].
  Bus  2, device   3, function  0:
    FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 128).
      IRQ 5.
      Master Capable.  Latency=32.  Max Lat=32.
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe50007ff].
      I/O at 0xb800 [0xb87f].
  Bus  2, device   5, function  0:
    Ethernet controller: Broadcom Corporation NetXtreme BCM5702X Gigabit Ethernet (rev 2).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=64.
      Non-prefetchable 64 bit memory at 0xe4800000 [0xe480ffff].

