Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270500AbRHNHqL>; Tue, 14 Aug 2001 03:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270498AbRHNHpv>; Tue, 14 Aug 2001 03:45:51 -0400
Received: from celebris.bdk.pl ([212.182.99.100]:58886 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S270494AbRHNHpn>;
	Tue, 14 Aug 2001 03:45:43 -0400
Date: Tue, 14 Aug 2001 09:49:01 +0200 (CEST)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Kevin P. Fleming" <kevin@labsysgrp.com>, linux-kernel@vger.kernel.org
Subject: Re: Lost interrupt with HPT370
In-Reply-To: <E15WG2Z-0007Di-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0108140929090.30634-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001, Alan Cox wrote:

> Date: Mon, 13 Aug 2001 12:37:51 +0100 (BST)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Kevin P. Fleming <kevin@labsysgrp.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
> Subject: Re: Lost interrupt with HPT370
> 
> > I have just tried an HPT-366 card with IC35L040VER07 drives (latest DeskStar
> > 41G ATA-100, although the card is only ATA-66) and could not get them to
> > even let me create a filesystem without hard locking the machine. This was
> > using 2.4.8-ac1 and 2.4.7-ac11. I wrote this off to motherboard/IDE card
> > compatibility (or lack thereof), but could it still be an IDE driver issue?
> 
> Some HPT cards have problems with certain drives. I believe its a fixed
> problem in newer boards or on those with updatable firmware if you update
> the firmware itself
> 
> Check your drive is in the bad_ata100_5 and bad_ata66_4 list. If not add
> it then rebuild and retry (drivers/ide/hpt366.c) - and let me know
> 
> Alan
> -
Alan,

What is the effect of putting or not a drive on bad_ata100_5 and
bad_ata66_4 ?

I am asking as I am using two 30GB IBM DTLA drives connected to HPT370
with kernel 2.2.19+Andre's ide patch, and I have noted that these drives
are present on bad_ata66_4 but not on bad_ata100_5 ?
Should I inderstand that IBM-DTLA-307030 would not be compatible with HPT
366, but *is* OK with HPT 370 running UDMA-100?


I have seen very good performance (15-30 MB/s of transfer with ide.patch,
without ide.patch performance is extremally poor at about 2-3 MB/s) and no
problems, except one serious problem, which made me feel rather bad;
I tried once to measure performance by running two dd command reading
from /dev/hde and /dev/hdg, respectively, concurrently; after dd command
finished reading HDD lamp stayed on until reboot, after which I lost
partition table on one of the disks; before the test I experimented with
hdparm which might have been not a good idea ...
I have not repeat this test later ..

HW: Abit MB with i440BX, FSB 133MHz, HPT 370 on-board,
ECC memory 133 MHz, Pentium-III 800MHz (133 MHz FSB)

