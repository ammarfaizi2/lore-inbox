Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRI3JEb>; Sun, 30 Sep 2001 05:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273233AbRI3JEX>; Sun, 30 Sep 2001 05:04:23 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:50963 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S273176AbRI3JEK>; Sun, 30 Sep 2001 05:04:10 -0400
Date: Sun, 30 Sep 2001 11:04:06 +0200
From: Marc SCHAEFER <schaefer@alphanet.ch>
Message-Id: <200109300904.f8U946H11487@vulcan.alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon motherboards
Newsgroups: alphanet.ml.linux.kernel
In-Reply-To: <20010930091838.A761@localhost.localdomain>
Organization: ALPHANET NF -- Not for profit telecom research
X-Newsreader: TIN [UNIX 1.3 unoff BETA 970705; i586 Linux 2.0.38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010930091838.A761@localhost.localdomain> you wrote:
> Is anyone creating list of Athlon motherboards working without any errors (when

2.4.9 + LVM patch + ext3 patch + bttv patch
Compiled for:

   CONFIG_MK7=y

is a Duron 700, 640 MB of memory at 133, using three of the 4 IDE buses
(also the ATA100).

This machine is used for heavy data computations (CPU with dnetc, I/O
and memory for a search engine, see http://search.alphanet.ch/, also
has linux-kernel).

I never had any data integrity problem with it, nor crashes (ok, well,
I just switched to ext3 and LVM recently). Previously it ran 2.4.0, 2.4.3
and 2.4.4, and before 2.2.18pre21 (this is a Debian 2.2r3, except it has
XFree 4.0.2, 2.4 modules and stuff, PostgreSQL7). It also has an AGP
videocard, a PCTV video card, sound, two network cards, etc. It's not
only used as a server but also as a video editing station.

I have used the SCSI card with some SuSE driver and a SDT-10000 tape drive,
with --compare (and gzip -t). I however have systematic crash with
a Plextor 12x writer that I need to investigate: apparently the Plextor
does a reconnect unlinked to any previous nexus, and the SuSE driver
hates this.

A friend has a slightly different motherboard (different revisions on chips),
and had the PC100 vs PC133 bug, then upgraded to 2.4.9 and doesn't have it
anymore.

schaefer@search:/data/home/schaefer$ uname -a
Linux search 2.4.9 #1 Wed Sep 12 21:30:55 CEST 2001 i686 unknown

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
      Prefetchable 32 bit memory at 0xe4000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=8.
  Bus  0, device   4, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 34).
  Bus  0, device   4, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
      Master Capable.  Latency=32.  
      I/O at 0xb800 [0xb80f].
  Bus  0, device   4, function  2:
    USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xb400 [0xb41f].
  Bus  0, device   4, function  3:
    USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
      IRQ 9.
      Master Capable.  Latency=32.  
      I/O at 0xb000 [0xb01f].
  Bus  0, device   4, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 48).
      IRQ 9.
  Bus  0, device   9, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 (rev 17).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xe3000000 [0xe3000fff].
  Bus  0, device   9, function  1:
    Multimedia controller: Brooktree Corporation Bt878 (rev 17).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xe2800000 [0xe2800fff].
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0x9400 [0x94ff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe00000ff].
  Bus  0, device  11, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0x9000 [0x903f].
  Bus  0, device  12, function  0:
    SCSI storage controller: Tekram Technology Co.,Ltd. TRM-S1040 (rev 1).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0x8800 [0x88ff].
      Non-prefetchable 32 bit memory at 0xdf800000 [0xdf800fff].
  Bus  0, device  13, function  0:
    Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex] (rev 0).
      IRQ 9.
      Master Capable.  Latency=248.  Min Gnt=3.Max Lat=8.
      I/O at 0x8400 [0x841f].
  Bus  0, device  17, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 10.
      Master Capable.  Latency=32.  
      I/O at 0x8000 [0x8007].
      I/O at 0x7800 [0x7803].
      I/O at 0x7400 [0x7407].
      I/O at 0x7000 [0x7003].
      I/O at 0x6800 [0x683f].
      Non-prefetchable 32 bit memory at 0xdf000000 [0xdf01ffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 101).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1ffffff].
      I/O at 0xd800 [0xd8ff].
      Non-prefetchable 32 bit memory at 0xe0800000 [0xe0800fff].

