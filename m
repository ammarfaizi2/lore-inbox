Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbTC1Ayl>; Thu, 27 Mar 2003 19:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261833AbTC1Ayk>; Thu, 27 Mar 2003 19:54:40 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:17835 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S261829AbTC1Ayi>; Thu, 27 Mar 2003 19:54:38 -0500
Date: Fri, 28 Mar 2003 02:05:32 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Suparna Bhattacharya <suparna@in.ibm.com>,
       Andre Hedrick <andre@linux-ide.org>, Jens Axboe <axboe@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 2.5.66-masked_irq-fix-A0
In-Reply-To: <1048810944.3953.8.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0303280201250.27389-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Mar 2003, Alan Cox wrote:

> On Thu, 2003-03-27 at 23:54, Bartlomiej Zolnierkiewicz wrote:
> > # Revert previous masked_irq handling for ide_do_request().
> > # Fixes "hda: lost interrupt" bug.
>
> Rejected. Breaks hardware where someone put IDE on IRQ0, the

Yep.

> logic is sound enough and I will fix it properly using the NO_IRQ
> stuff

Something like that?
	if (masked_irq != IDE_NO_IRQ && masked_irq != hwif->irq)

