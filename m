Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268548AbTGMOY2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 10:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268843AbTGMOY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 10:24:28 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5841 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S268548AbTGMOY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 10:24:26 -0400
Date: Sun, 13 Jul 2003 16:38:54 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jean-Luc <jean-luc.coulon@wanadoo.fr>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.75 : cannot set dma mode on ide disks
In-Reply-To: <20030713073329.GA5595@tangerine>
Message-ID: <Pine.SOL.4.30.0307131638140.8063-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You've forgot to compile in driver for your IDE chipset.

--
Bartlomiej

On Sun, 13 Jul 2003, Jean-Luc wrote:

> Hi,
>
> This is part of dmesg :
> ...
> Journalled Block Device driver loaded
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
> hda: QUANTUM FIREBALLP LM30, ATA DISK drive
> hdb: WDC WD400BB-00DEA0, ATA DISK drive
> hdc: GoldStar CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
> hdd: CREATIVECD3621E, ATAPI CD/DVD-ROM drive
> anticipatory scheduling elevator
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: max request size: 128KiB
> hda: host protected area => 1
> hda: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=58168/16/63
>   hda: hda1 hda2 hda3 hda4
> hdb: max request size: 128KiB
> hdb: host protected area => 1
> hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
>   hdb: hdb1
> ...
>
> When I try to set dma on on either of the disks, I get the following:
> [root@debian-f5ibh] ~ # hdparm -d1  /dev/hda
>
> /dev/hda:
>   setting using_dma to 1 (on)
>   HDIO_SET_DMA failed: Operation not permitted
>   using_dma    =  0 (off)
>
>
> [I'm not on the list, please cc to me]
>
> ---
> Regards
> 	Jean-Luc

