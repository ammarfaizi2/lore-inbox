Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315227AbSE2M45>; Wed, 29 May 2002 08:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315235AbSE2M45>; Wed, 29 May 2002 08:56:57 -0400
Received: from [212.176.239.134] ([212.176.239.134]:25782 "EHLO
	vzhik.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S315227AbSE2M4y>; Wed, 29 May 2002 08:56:54 -0400
Message-ID: <000901c20710$486c3f40$baefb0d4@nick>
Reply-To: "Nick Evgeniev" <nick@octet.spb.ru>
From: "Nick Evgeniev" <nick@octet.com>
To: "Neil Brown" <neilb@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c206f0$cfd42620$baefb0d4@nick> <15604.45243.291277.197140@notabene.cse.unsw.edu.au>
Subject: Re: 2.4.19-pre8-ac5 ide & raid0 bugs
Date: Wed, 29 May 2002 16:56:42 +0400
Organization: Octet Corp.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17D30N-0005Es-00*7nPkbYm.xtk* http://duncanthrax.net/exiscan/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes, I'm using lvm 1.1rc1 on top of raid0. Hardware details:
dual piii box on via Apollo pro133 chipset (via694)
two ATA-100 drives (FUJITSU MPG3204AH) attached to on-board  controller
(PROMISE 20265)
& one drive attached to VIA controller. RAID0 is made on top of first two
drives.

1. I don't have any problem with drive attached to via controller (in DMA33
mode)
2. The only problem that I have is with UDMA100 drives attached to promise
controller... Also I have to notice that log messages about ide errors are
related to drive that has no errors (according to smartctl -l, while another
drive has a few records in its log)
3. I had no problems with ide with 2.4.7 kernel for a months...

> > >-----------------------------
> > But now I've got even more bugs in log like:
> > >-----------------------------
> > May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert
block
> > across chunks or bigger than 16k 37713311 4
> > May 29 11:28:06 vzhik kernel: raid0_make_request bug: can't convert
block
> > across chunks or bigger than 16k 37713343 4
>
> This is a request for a 4K block that is not 4K aligned... this
> shouldn't happen.
> Are you using LVM or something to partition the raid0 array?
> ... though I seem to recall that LVM always partitions in multiples of
> 4K so that shouldn't be a problem.


