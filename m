Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263914AbTCVWWS>; Sat, 22 Mar 2003 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263915AbTCVWWR>; Sat, 22 Mar 2003 17:22:17 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33015 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S263914AbTCVWWR>; Sat, 22 Mar 2003 17:22:17 -0500
Date: Sat, 22 Mar 2003 23:33:06 +0100 (MET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dominik Brodowski <linux@brodo.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: 2.5.65-ac2 -- hda/ide trouble on ICH4
In-Reply-To: <1048375677.9219.42.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.SOL.4.30.0303222324390.29717-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 22 Mar 2003, Alan Cox wrote:

> On Sat, 2003-03-22 at 22:03, Bartlomiej Zolnierkiewicz wrote:
> > Previously callers called it with masked_irq=0 and disabling/enabling
> > hwif->irq code wasn't executed, now ide_do_request() is called with
> > masked_irq=IDE_NO_IRQ=-1 so this code is executed for sure.
>
> You are right - I botched the simplification of that. The logic is actually
> cleaner than I did with a bit more thought - IDE_NO_IRQ can go away and
> we should be using hwif->irq as the argument.

I think so.

--
Bartlomiej

