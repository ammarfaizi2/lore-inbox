Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269637AbUIRVWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269637AbUIRVWa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 17:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbUIRVWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 17:22:30 -0400
Received: from dennis.enea.se ([192.36.1.67]:20902 "EHLO dennis.enea.se")
	by vger.kernel.org with ESMTP id S269637AbUIRVW1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 17:22:27 -0400
From: =?iso-8859-1?Q?M=E5rten_Berggren?= <berg@enea.se>
To: <linux-kernel@vger.kernel.org>
Subject: IDE: pdc202xx_new on Asus A7V333?
Date: Sat, 18 Sep 2004 23:22:17 +0200
Organization: Enea Open Systems
Message-ID: <000401c49dc5$93e4f3b0$810113ac@enea.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been trying to get pdc202xx_new working (in 2.4.27) on my
Asus A7V333 motherboard (with VIA KT333 and a PDC20276). Loading
it as a module with modprobe gives me the following entires in the
syslog:

Sep 18 12:27:25 r2d2 kernel: PDC20276: IDE controller at PCI slot
00:06.0 
Sep 18 12:27:25 r2d2 kernel: PCI: Found IRQ 5 for device 00:06.0 
Sep 18 12:27:25 r2d2 kernel: PCI: Sharing IRQ 5 with 00:09.0 
Sep 18 12:27:25 r2d2 kernel: PCI: Sharing IRQ 5 with 00:10.0 
Sep 18 12:27:25 r2d2 kernel: PDC20276: chipset revision 1 
Sep 18 12:27:25 r2d2 kernel: PDC20276: not 100%% native mode: will probe
irqs later
Sep 18 12:27:25 r2d2 kernel:     ide2: BM-DMA at 0xb000-0xb007, BIOS
settings: hde:pio, hdf:pio
Sep 18 12:27:25 r2d2 kernel:     ide3: BM-DMA at 0xb008-0xb00f, BIOS
settings: hdg:pio, hdh:pio

which gives me the impression that the module has loaded ok, but there
is no matching entries in /proc/ide and pdcraid does not find it.
So is there any way to tell if it is working or not? (Should there
be an entry in /proc/ide?)

If it is not working, can it be because it shares IRQ 5 with my USB
and network card?

(Part of) /proc/pci:

  Bus  0, device   6, function  0:
    RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 1).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=18.
      I/O at 0xd400 [0xd407].
      I/O at 0xd000 [0xd003].
      I/O at 0xb800 [0xb807].
      I/O at 0xb400 [0xb403].
      I/O at 0xb000 [0xb00f].
      Non-prefetchable 32 bit memory at 0xd5800000 [0xd5803fff].
...
  Bus  0, device   9, function  0:
    USB Controller: VIA Technologies, Inc. USB (rev 80).
      IRQ 5.
      Master Capable.  Latency=32.
      I/O at 0xa800 [0xa81f].
...
  Bus  0, device  16, function  0:
    Ethernet controller: National Semiconductor Corporation DP83815
(MacPhyter) Ethernet Controller (rev 0).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=11.Max Lat=52.
      I/O at 0xa000 [0xa0ff].
      Non-prefetchable 32 bit memory at 0xd3800000 [0xd3800fff].

(Part of) /proc/interrupts:
  5:       2175          XT-PIC  usb-uhci, eth0

Please help; I have spent quite some time on this. I'm not afraid
of printk debugging, but I have no idea how the system should work.

Regards

Mårten Berggren

