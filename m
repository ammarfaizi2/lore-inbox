Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314711AbSDVTtS>; Mon, 22 Apr 2002 15:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314712AbSDVTtR>; Mon, 22 Apr 2002 15:49:17 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:37391 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S314711AbSDVTtO>; Mon, 22 Apr 2002 15:49:14 -0400
Date: Mon, 22 Apr 2002 21:49:08 +0200 (CEST)
From: tomas szepe <kala@pinerecords.com>
To: linux-kernel@vger.kernel.org
Subject: PromiseULTRA100 TX2 ATA66 trouble
Message-ID: <Pine.LNX.4.44.0204222127100.2888-100000@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,


I've got an ATA66 compliant Western Digital drive attached to
a Promise Ultra100 TX2 IDE controller card using a good quality
80-wire cable.

Running on 2.4.19-pre7-ac2, I can't seem to get the kernel to
set ATA66 mode *unless* I pass the kernel the options 'ide2=ata66
ide2=autotune'. Although doing this spits out a warning during boot
time -- PDC20268: ATA-66/100 forced bit set (WARNING)!! -- everything
seems to work alright, as it should. I reckon the problem is only that
despite the fact the driver knows that both the disk and the controller
are capable of munching data in ATA66, it somehow doesn't trust that
things are going to work out and limits operation to ATA33 -- could
it be that it doesn't like the cable? I'm quite sure it's oook, and
the TX2 BIOS has no complains either.

2.4.19-pre7 as well as 2.4.19-pre7-ac2 w/o the aforementioned
kernel options passed set the device to operate as ATA33, effectively
restricting the transfer mode to the maximum of UDMA2. If, at this
stage, I try to set anything higher using hdparm, I get a "speed
warning" about UDMA 3/4/5 not functional.

Furthermore, applying Andre Hedrick's ide-2.4.19-p7.all.convert.6.patch
causes the kernel to not even recognize the controller. BUUUURN! <g>

The card is detected as:
Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d68 (rev 02)

Anyone has any suggestions for me?
thanks! -Tomas

pub 1024d/8e316a84 2002-01-29   tomas szepe <kala@pinerecords.com>
openpgp f/print 2955 2eea c4b8 b09e 7ae1  4d5d 68e3 d606 8e31 6a84

