Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTEKMgA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 08:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTEKMgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 08:36:00 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13738 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261308AbTEKMf7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 08:35:59 -0400
Date: Sun, 11 May 2003 14:48:24 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Gregoire Favre <greg@ulima.unil.ch>
cc: <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69 and ide-floppy errors
In-Reply-To: <20030511124233.GB10013@ulima.unil.ch>
Message-ID: <Pine.SOL.4.30.0305111445100.4788-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 May 2003, Gregoire Favre wrote:

> On Sun, May 11, 2003 at 02:35:48PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > Hi,
> >
> > Don't compile TCQ support in.
> > What do you have on hda and hdb?
>
> Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ICH4: IDE controller at PCI slot 00:1f.1
> ICH4: chipset revision 1
> ICH4: not 100% native mode: will probe irqs later
>     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
>     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
> hda: IC35L120AVVA07-0, ATA DISK drive
> hdb: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
> hda: tagged command queueing enabled, command queue depth 8
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> hdc: SONY DVD RW DRU-500A, ATAPI CD/DVD-ROM drive
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: host protected area => 1
> hda: 241254720 sectors (123522 MB) w/1863KiB Cache, CHS=239340/16/63, UDMA(100)
>  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 >
> hdc: ATAPI 16X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(33)
>
> I'll recompil without TCQ: thank you very much for the info!!!

Thanks for report.

Jens, can you comment on this issue. TCQ shouldn't be enabled
when there is other device on a channel?

--
Bartlomiej

> 	Grégoire
> ________________________________________________________________
> http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch

