Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268186AbTALAHX>; Sat, 11 Jan 2003 19:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268188AbTALAHX>; Sat, 11 Jan 2003 19:07:23 -0500
Received: from very.disjunkt.com ([195.167.192.238]:1233 "EHLO disjunkt.com")
	by vger.kernel.org with ESMTP id <S268186AbTALAHV> convert rfc822-to-8bit;
	Sat, 11 Jan 2003 19:07:21 -0500
Date: Sun, 12 Jan 2003 01:14:03 +0100 (CET)
From: Jean-Daniel Pauget <jd@disjunkt.com>
X-X-Sender: jd@mint
To: Jeff Garzik <jgarzik@pobox.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Another holiday, another set of tg3 releases.
Message-ID: <Pine.LNX.4.51.0301120101210.1290@mint>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


on 2002-12-30, Jeff Garzik <jgarzik@pobox.com> wrote :

> Another holiday, another set of tg3 releases.

    in my seek for unexpected freeze of my box (not yet figured which
    hardware is involved exactly) I updated to tg3-1.2a and applied
    both tg3-1.2a-00_irqsave and tg3-1.2a-01_mask_rewrite.
    as a result, after working a few seconds the network card freezes, and
    no ifupdown would permit any recovery.

    on the other hand, with only the first patch tg3-1.2a-00_irqsave, things
    seems ok and I'm waiting for my machine to freeze... ...or not. (the freeze
    frequency is ~10hours )...

    though, on your page you mention a fifth patch concerning mtu, as I'm
    running with an unusual mtu of 1452 because of internet over internet
    encapsulation on my DSL, maybe I'm concerned ?

    here-below my /proc/pci

--
Quand les plombs pêtent : « Ðïsjüñ£t.¢¤× »

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

