Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSFBVgZ>; Sun, 2 Jun 2002 17:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSFBVgY>; Sun, 2 Jun 2002 17:36:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:52647 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S314458AbSFBVgW>; Sun, 2 Jun 2002 17:36:22 -0400
Date: Sun, 2 Jun 2002 23:36:08 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.19 IDE 78
In-Reply-To: <3CFA733F.4070907@evision-ventures.com>
Message-ID: <Pine.SOL.4.30.0206022333220.8028-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 2 Jun 2002, Martin Dalecki wrote:

> Paul Mackerras wrote:
> > Martin,
> >
> > I think you have a typo here:
> >
> >
> >>diff -urN linux-2.5.19/drivers/ide/ide-pmac.c linux/drivers/ide/ide-pmac.c
> >>--- linux-2.5.19/drivers/ide/ide-pmac.c	2002-06-01 18:53:06.000000000 +0200
> >>+++ linux/drivers/ide/ide-pmac.c	2002-06-01 18:17:36.000000000 +0200
> >>@@ -434,7 +434,7 @@
> >> 		goto out;
> >> 	}
> >> 	udelay(10);
> >>-	OUT_BYTE(drive->ctl | 2, IDE_CONTROL_REG);
> >>+	ata_irq_enale(drive, 0);
>

I think Paul was talking about ata_irq_enale() ;)

> For sure not. The nIEN bit is *negated* on the part of the
> device - please look at the ata_irq_enable() functions definition.
> I have explained it there.
>
> > ata_irq_enable surely?
>
> The toggle is the second parameter becouse I didn't wan't to
> provide two functions. - 0 measn disable it 1 means enable it.>

--
Bartlomiej

