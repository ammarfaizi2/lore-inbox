Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267195AbSKSX56>; Tue, 19 Nov 2002 18:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267614AbSKSX55>; Tue, 19 Nov 2002 18:57:57 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:30475 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S267195AbSKSX54>; Tue, 19 Nov 2002 18:57:56 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1951@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError }
Date: Tue, 19 Nov 2002 16:04:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, CSB5/CSB6 does not have this problem. I have been using this with the
GC-LE chipset. 

However, there was something that I noticed when I was experimenting with
the FreeBSD kernel for producing these corruptions. I could not reproduce
these corruptions with FreeBSD 4.6 and at UDMA 2. I also noticed that the
PCI config space settings for the IDE controller were different in FreeBSD
and Linux 2.4.17.

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Tuesday, November 19, 2002 4:29 PM
To: Manish Lachwani
Cc: 'Steven Timm'; Linux Kernel Mailing List
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError }


On Tue, 2002-11-19 at 21:59, Manish Lachwani wrote:
> ALso, we had been using TYAN S2518 with OSB4 in UDMA 2. However, it causes
> data corruption when there is IO with even one drive. We used two drives
in
> master-master and master-slave mode and it did not solve the problem. EVen
> at UDMA 0, we experienced the same issue of data corruption. Once does not
> need to have 0x40 errors to see this corruption. If you want to see this
> corruption, use the dt utility and then run:

Known. The newer kernels will panic in this case to avoid corrupting,
and the 2.4.20-ac/2.5.4x kernels will not use UDMA for disks on OSB4.
The newer serverworks (CSB5/CSB6) doesn't have this problem btw
