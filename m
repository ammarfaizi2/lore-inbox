Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275851AbRI1GBe>; Fri, 28 Sep 2001 02:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275850AbRI1GBX>; Fri, 28 Sep 2001 02:01:23 -0400
Received: from sirppi.helsinki.fi ([128.214.205.27]:60690 "EHLO
	sirppi.helsinki.fi") by vger.kernel.org with ESMTP
	id <S275851AbRI1GBN>; Fri, 28 Sep 2001 02:01:13 -0400
From: Atro Tossavainen <atossava@cc.helsinki.fi>
Message-Id: <200109280601.f8S61c931645@sirppi.helsinki.fi>
Subject: [2.2.19] clock timer configuration lost - probably a VIA686a motherboard
To: linux-kernel@vger.kernel.org
Date: Fri, 28 Sep 2001 09:01:38 +0300 (EET DST)
Reply-To: Atro.Tossavainen@helsinki.fi
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting this message every couple of minutes on a new machine with
the 2.2.19 kernel.

The motherboard is a new ASUS and does not have a VIA chipset.

It is presently not possible for me to upgrade to a 2.4 kernel as AFS
support is still rather flakey there.

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Acer Labs Unknown device (rev 4).
      Vendor id=10b9. Device id=1647.
      Medium devsel.  Master Capable.  No bursts.  
      Prefetchable 32 bit memory at 0xf0000000 [0xf0000008].
  Bus  0, device   1, function  0:
    PCI bridge: Acer Labs Unknown device (rev 0).
      Vendor id=10b9. Device id=5247.
      Slow devsel.  Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   2, function  0:
    USB Controller: Acer Labs M5237 USB (rev 3).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Laten
cy=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xec000000 [0xec000000].
  Bus  0, device   6, function  0:
    USB Controller: Acer Labs M5237 USB (rev 3).
      Medium devsel.  Fast back-to-back capable.  IRQ 9.  Master Capable.  Laten
cy=32.  Max Lat=80.
      Non-prefetchable 32 bit memory at 0xeb000000 [0xeb000000].
  Bus  0, device   4, function  0:
    IDE interface: Acer Labs M5229 TXpro (rev 196).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
Min Gnt=2.Max Lat=4.
      I/O at 0xd400 [0xd401].
  Bus  0, device   7, function  0:
    ISA bridge: Acer Labs M1533 Aladdin IV (rev 0).
      Medium devsel.  Master Capable.  No bursts.  
  Bus  0, device  10, function  0:
    Multimedia audio controller: Unknown vendor Unknown device (rev 8).
      Vendor id=1102. Device id=2.
      Medium devsel.  Fast back-to-back capable.  IRQ 5.  Master Capable.  Laten
cy=32.  Min Gnt=2.Max Lat=20.
      I/O at 0xb400 [0xb401].
  Bus  0, device  10, function  1:
    Input device controller: Unknown vendor Unknown device (rev 8).
      Vendor id=1102. Device id=7002.
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  
      I/O at 0xb000 [0xb001].
  Bus  0, device  11, function  0:
    Ethernet controller: Intel 82557 (rev 12).
      Medium devsel.  Fast back-to-back capable.  IRQ 10.  Master Capable.  Late
ncy=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xea000000 [0xea000000].
      I/O at 0xa800 [0xa801].
      Non-prefetchable 32 bit memory at 0xe9800000 [0xe9800000].
  Bus  0, device  17, function  0:
    Bridge: Acer Labs M7101 PMU (rev 0).
      Medium devsel.  
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Unknown device (rev 130).
      Vendor id=102b. Device id=525.
      Medium devsel.  Fast back-to-back capable.  IRQ 11.  Master Capable.  Late
ncy=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xee000000 [0xee000008].
      Non-prefetchable 32 bit memory at 0xed000000 [0xed000000].
      Non-prefetchable 32 bit memory at 0xec800000 [0xec800000].

Or, in a more readable format,

# lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi]: Unknown device 1647 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5247
00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:04.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c4)
00:06.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV]
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 08)
00:0a.1 Input device controller: Creative Labs SB Live! (rev 08)
00:0b.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 0c)
00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

-- 
Atro Tossavainen (Mr.)               / The Institute of Biotechnology at
Systems Analyst, Techno-Amish &     / the University of Helsinki, Finland,
+358-9-19158939  UNIX Dinosaur     / employs me, but my opinions are my own.
< URL : http : / / www . iki . fi / atro . tossavainen / >
