Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUEXK5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUEXK5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 06:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbUEXK5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 06:57:22 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:35255 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264246AbUEXK5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 06:57:17 -0400
Date: Mon, 24 May 2004 12:55:38 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Matt Domsch <Matt_Domsch@dell.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ata_piix: port disabled.  ignoring.
In-Reply-To: <Pine.GSO.4.58.0405241148400.18874@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0405241254001.24289@mion.elka.pw.edu.pl>
References: <Pine.GSO.4.58.0405141453020.27660@waterleaf.sonytel.be>
 <200405181520.54952.bzolnier@elka.pw.edu.pl> <Pine.GSO.4.58.0405190945500.23702@waterleaf.sonytel.be>
 <200405191510.39711.bzolnier@elka.pw.edu.pl> <Pine.GSO.4.58.0405241148400.18874@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 May 2004, Geert Uytterhoeven wrote:

> On Wed, 19 May 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Wednesday 19 of May 2004 09:48, Geert Uytterhoeven wrote:
> > > On Tue, 18 May 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > On Monday 17 of May 2004 16:19, Geert Uytterhoeven wrote:
> > > > > If I disable CONFIG_SCSI_SATA, IDE works, but very slow (no DMA).
> > > >
> > > > due to CONFIG_BLK_DEV_PIIX=n but ata_piix.c is prefferred for SATA
> > >
> > > No, I had
> > >
> > >     CONFIG_BLK_DEV_PIIX=y
> > >     CONFIG_BLK_DEV_IDEDMA_PCI=y
> > >
> > > but I get an error when trying to enable DMA using hdparm.
> >
> > I suppose that you're using chipset which ID is not in piix.c.
> > If not than this is a bug and I would like to know more about it.
>
> Upon closer look, piix.c doesn't recognize the ESB_3 yet. If I add it to

This is intended, new SATA chipsets belong to ata_piix.c.

> piix.[ch] and treat it the same as the ICH5-SATA, the SATA disk gets 57 MiB/s
> using the PATA piix driver.

OK, thanks.

Cheers,
Bartlomiej
