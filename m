Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSHYUaU>; Sun, 25 Aug 2002 16:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSHYUaU>; Sun, 25 Aug 2002 16:30:20 -0400
Received: from mail46-s.fg.online.no ([148.122.161.46]:50889 "EHLO
	mail46.fg.online.no") by vger.kernel.org with ESMTP
	id <S317508AbSHYUaT>; Sun, 25 Aug 2002 16:30:19 -0400
From: "Ulf-Andre Gramstad" <ulf-andre@gramstad.org>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: hpt374 / BUG();
Date: Sun, 25 Aug 2002 22:33:46 +0200
Message-ID: <IOELJIHGBNLBJNBMHABBKEAFCDAA.ulf-andre@gramstad.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.10.10208222009540.13077-100000@master.linux-ide.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just got a reply from HighPoint and they claim they do not have support
> for a 66MHz base PLL for hpt374/hpt372.
>
> So that make is more interesting.


The kernel works fine when all my HD's are connected to IDE1 and IDE2 on the
raid controller, but only one raid drive is enabled by hptraid.c.

Some of my info:

hde: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63,
UDMA(100)
hdf: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63,
UDMA(100)
hdg: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=155009/16/63,
UDMA(100)
hdh: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63,
UDMA(100)

hde/hdf = raid0 (240gb)
hdg/dhd = raid0 (160gb)

My /proc/partitions:

 114     0  156249984 ataraid/d0
 114     1  156248158 ataraid/d0p1
  34     0   78125000 hdg
  34    64   78150744 hdh
  33     0  120627360 hde
  33    64  120627360 hdf
   3     0   40209120 hda
   3     1     265072 hda1
   3     2   39937590 hda2

messages:

Aug 25 21:40:04 fantasy kernel:  ataraid/d0: ataraid/d0p1
Aug 25 21:40:04 fantasy kernel: Highpoint HPT370 Softwareraid driver for
linux version 0.01
Aug 25 21:40:04 fantasy kernel: Drive 0 is 76293 Mb
Aug 25 21:40:04 fantasy kernel: Drive 1 is 76319 Mb
Aug 25 21:40:04 fantasy kernel: Raid array consists of 2 drives.


Shouldn't hptraid.c also create ataraid/d1 and ataraid/d1p1?




Mvh
Ulf-Andre Gramstad

