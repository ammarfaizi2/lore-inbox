Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270261AbTGMQDL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270260AbTGMQDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:03:11 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:16794 "EHLO
	mwinf0301.wanadoo.fr") by vger.kernel.org with ESMTP
	id S270245AbTGMQCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:02:00 -0400
Date: Sun, 13 Jul 2003 18:15:28 +0200
From: Jean-Luc <jean-luc.coulon@wanadoo.fr>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: =?iso-8859-1?B?UmWg?=
	=?iso-8859-1?Q?=3A?= 2.5.75 : cannot set dma mode on ide disks
Message-ID: <20030713161528.GE1362@tangerine>
References: <Pine.SOL.4.30.0307131638140.8063-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.SOL.4.30.0307131638140.8063-100000@mion.elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on dim, jui 13, 2003 at 16:38:54 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej,

Ok, thank you. I had just some difficulties to figure out were was 
hidden the chipset choice during the configuration process...

---
Regards
	Jean-Luc

On 13.07.2003 16:38, Bartlomiej Zolnierkiewicz wrote:
> 
> 
> You've forgot to compile in driver for your IDE chipset.
> 
> --
> Bartlomiej
> 
> On Sun, 13 Jul 2003, Jean-Luc wrote:
> 
> > Hi,
> >
> > This is part of dmesg :
> > ...
> > Journalled Block Device driver loaded
> > Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> > ide: Assuming 33MHz system bus speed for PIO modes; override with
> > idebus=xx
> > hda: QUANTUM FIREBALLP LM30, ATA DISK drive
> > hdb: WDC WD400BB-00DEA0, ATA DISK drive
> > hdc: GoldStar CD-RW CED-8083B, ATAPI CD/DVD-ROM drive
> > hdd: CREATIVECD3621E, ATAPI CD/DVD-ROM drive
> > anticipatory scheduling elevator
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> > ide1 at 0x170-0x177,0x376 on irq 15
> > hda: max request size: 128KiB
> > hda: host protected area => 1
> > hda: 58633344 sectors (30020 MB) w/1900KiB Cache, CHS=58168/16/63
> >   hda: hda1 hda2 hda3 hda4
> > hdb: max request size: 128KiB
> > hdb: host protected area => 1
> > hdb: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
> >   hdb: hdb1
> > ...
> >
> > When I try to set dma on on either of the disks, I get the
> following:
> > [root@debian-f5ibh] ~ # hdparm -d1  /dev/hda
> >
> > /dev/hda:
> >   setting using_dma to 1 (on)
> >   HDIO_SET_DMA failed: Operation not permitted
> >   using_dma    =  0 (off)
> >
> >
> > [I'm not on the list, please cc to me]
> >
> > ---
> > Regards
> > 	Jean-Luc
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
