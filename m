Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132775AbRDDI2l>; Wed, 4 Apr 2001 04:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132774AbRDDI2c>; Wed, 4 Apr 2001 04:28:32 -0400
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:60167 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S132772AbRDDI2Q>; Wed, 4 Apr 2001 04:28:16 -0400
Date: Wed, 4 Apr 2001 10:27:29 +0200 (CEST)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.3 irq routing conflict (VIA chipset)
In-Reply-To: <Pine.LNX.4.30.0104031414510.11170-100000@diego.linuxninja.org>
Message-ID: <Pine.LNX.4.33.0104041017560.1203-100000@7812-grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Apr 2001, Tim Pepper wrote:

> I know there was a thread on this previously and I was thinking it had been
> resolved (or was that only for a specific mobo mfg?).  When I finally got my
> VIA chipset machine up to date with a 2.4.3 kernel I noticed the following on
> boot up:

I get a like error (apparently plugged in the same slot)

> 	PCI: Found IRQ 11 for device 00:0a.0
> 	IRQ routing conflict in pirq table for device 00:0a.0

Mar 30 10:32:07 wiibroe kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb120, last bus=1
Mar 30 10:32:07 wiibroe kernel: PCI: Using configuration type 1
Mar 30 10:32:07 wiibroe kernel: PCI: Probing PCI hardware
Mar 30 10:32:07 wiibroe kernel: PCI: Disabled enhanced CPU to PCI
posting #2
Mar 30 10:32:07 wiibroe kernel: PCI: Using IRQ router VIA [1106/0586] at
00:07.0Mar 30 10:32:07 wiibroe kernel: Activating ISA DMA hang
workarounds.
[...]
Mar 30 10:32:10 wiibroe kernel: 8139too Fast Ethernet driver 0.9.15c
loaded
Mar 30 10:32:10 wiibroe kernel: PCI: Found IRQ 11 for device 00:0a.0
Mar 30 10:32:10 wiibroe kernel: IRQ routing conflict in pirq table for
device 00:0a.0

> The only device on irq 11 is an agp voodoo3 card.  I don't seem to see any
> negative effects (unless what I believe is an unrelated scsi error is tied to
> this somehow).

The box has two NIC's (a via rhine at IRQ 10 and the RTL8139). The
strange things is that the RTL8139 card is detected at IRQ 11 but runs
at IRQ 12 (11 is used by an ATI AGP card):

  Bus  0, device   9, function  0:
    Ethernet controller: VIA Technologies, Inc. VT86C100A [Rhine 10/100]
(rev 6).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=118.Max Lat=152.
      I/O at 0xe800 [0xe87f].
      Non-prefetchable 32 bit memory at 0xe8000000 [0xe800007f].
  Bus  0, device  10, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
16).
      IRQ 12.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xec00 [0xecff].
      Non-prefetchable 32 bit memory at 0xe8001000 [0xe80010ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: ATI Technologies Inc 3D Rage IIC AGP (rev
58).
      IRQ 11.
      Master Capable.  Latency=64.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xe6000000 [0xe6ffffff].
      I/O at 0xd000 [0xd0ff].
      Non-prefetchable 32 bit memory at 0xe5000000 [0xe5000fff].

Rasmus

-- 
-- [ Rasmus 'Møffe' Bøg Hansen ] --------------------------------------
There are three kinds of lies:
lies, politics and statistics.
--------------------------------- [ moffe at amagerkollegiet dot dk ] -


