Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbVHNRnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbVHNRnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 13:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVHNRnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 13:43:40 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:15562 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932571AbVHNRnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 13:43:39 -0400
Date: Sun, 14 Aug 2005 19:43:34 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
Message-Id: <20050814194334.26d8db29.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Doing a "hdparm -I /dev/hdc" (without a disk/with a ISO disk/[u]mounted/music CD):

Aug 14 19:14:33 sleipner kernel: hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
Aug 14 19:14:33 sleipner kernel: hdc: drive_cmd: error=0x04 { AbortedCommand }
Aug 14 19:14:33 sleipner kernel: ide: failed opcode was: 0xec

"hdparm -i /dev/hdc" does not interfere (hdparm v6.1) and normal access like copying,
burning, playing etc works without that message emerging. Though I have seen it once...
During a session of quick mount/umount/play video file of several disks, there it was.
I attributed it to bad media.

This is a VIA motherboard (AMD64 equipped) and I run without any desktop:

root:sleipner:~# cat /proc/pci 
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1106:0204 (VIA Technologies, Inc.) (rev 0).
      Master Capable.  Latency=8.  
      Prefetchable 32 bit memory at 0xd0000000 [0xdfffffff].
  Bus  0, device   0, function  1:
    Host bridge: PCI device 1106:1204 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device   0, function  2:
    Host bridge: PCI device 1106:2204 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device   0, function  3:
    Host bridge: VIA Technologies, Inc. K8M800 (rev 0).
  Bus  0, device   0, function  4:
    Host bridge: PCI device 1106:4204 (VIA Technologies, Inc.) (rev 0).
  Bus  0, device   0, function  7:
    Host bridge: VIA Technologies, Inc. K8M800 (rev 0).
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge [K8T800 South] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device  10, function  0:
    Ethernet controller: Linksys, A Division of Cisco Systems [AirConn] INPROCOMM IPN 2220 Wireless LAN Adapter (rev 01) (rev 0).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=32.
      I/O at 0x1c00 [0x1c1f].
      Non-prefetchable 32 bit memory at 0xc0006000 [0xc000601f].
      Non-prefetchable 32 bit memory at 0xc0005000 [0xc00057ff].
  Bus  0, device  11, function  0:
    CardBus bridge: Texas Instruments PCI7420 CardBus Controller (rev 0).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x88020000 [0x88020fff].
  Bus  0, device  11, function  1:
    CardBus bridge: Texas Instruments PCI7420 CardBus Controller (#2) (rev 0).
      IRQ 17.
      Master Capable.  Latency=64.  Min Gnt=192.Max Lat=3.
      Non-prefetchable 32 bit memory at 0x88021000 [0x88021fff].
  Bus  0, device  11, function  2:
    FireWire (IEEE 1394): Texas Instruments PCI7x20 1394a-2000 OHCI Two-Port PHY/Link-Layer Controller (rev 0).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xc0005800 [0xc0005fff].
      Non-prefetchable 32 bit memory at 0xc0000000 [0xc0003fff].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 16).
      IRQ 19.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 32 bit memory at 0xc0006400 [0xc00064ff].
  Bus  0, device  16, function  0:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 128).
      IRQ 18.
      Master Capable.  Latency=64.  
      I/O at 0x1c20 [0x1c3f].
  Bus  0, device  16, function  1:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2) (rev 128).
      IRQ 18.
      Master Capable.  Latency=64.  
      I/O at 0x1c40 [0x1c5f].
  Bus  0, device  16, function  2:
    USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3) (rev 128).
      IRQ 18.
      Master Capable.  Latency=64.  
      I/O at 0x1c60 [0x1c7f].
  Bus  0, device  16, function  3:
    USB Controller: VIA Technologies, Inc. USB 2.0 (rev 130).
      IRQ 18.
      Master Capable.  Latency=64.  
      Non-prefetchable 32 bit memory at 0xc0006800 [0xc00068ff].
  Bus  0, device  17, function  0:
    ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge (rev 0).
  Bus  0, device  17, function  1:
    IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 6).
      Master Capable.  Latency=64.  
      I/O at 0x1c80 [0x1c8f].
  Bus  0, device  17, function  5:
    Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 80).
      IRQ 19.
      I/O at 0x1400 [0x14ff].
  Bus  0, device  17, function  6:
    Communication controller: VIA Technologies, Inc. AC'97 Modem Controller (rev 128).
      IRQ 11.
      I/O at 0x1800 [0x18ff].
  Bus  0, device  24, function  0:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration (rev 0).
  Bus  0, device  24, function  1:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map (rev 0).
  Bus  0, device  24, function  2:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller (rev 0).
  Bus  0, device  24, function  3:
    Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control (rev 0).
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV36 [GeForce FX Go5700] (rev 161).
      IRQ 20.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xc1000000 [0xc1ffffff].
      Prefetchable 32 bit memory at 0xe0000000 [0xefffffff].

Mvh
Mats Johannesson
--
