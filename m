Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUARMwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 07:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUARMwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 07:52:23 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:32917 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261188AbUARMwV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 07:52:21 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Subject: Re: [PATCH] fix/improve modular IDE (Re: [PATCH] modular IDE for 2.6.1 ugly but working fix)
Date: Sun, 18 Jan 2004 13:56:14 +0100
User-Agent: KMail/1.5.3
Cc: Sam Ravnborg <sam@ravnborg.org>, Witold Krecicki <adasi@kernel.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200401171313.52545.adasi@kernel.pl> <200401171702.35705.bzolnier@elka.pw.edu.pl> <200401181252.49861.arekm@pld-linux.org>
In-Reply-To: <200401181252.49861.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401181356.14767.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 of January 2004 12:52, Arkadiusz Miskiewicz wrote:
> Dnia sob 17. stycznia 2004 17:02, Bartlomiej Zolnierkiewicz napisa³:
> > On Saturday 17 of January 2004 16:38, Sam Ravnborg wrote:
> > > > +ide-core-objs += ide.o ide-default.o ide-io.o ide-iops.o ide-lib.o \
> > > > +	ide-probe.o ide-taskfile.o
> > >
> > > It would be more consistent to use "ide-core-y" since this is
> > > what the following lines are expanded to.
> > >
> > > > +
> > > > +ide-core-$(CONFIG_BLK_DEV_CMD640)	+= pci/cmd640.o
> > >
> > > Like this line.
> >
> > Yep, thanks!
>
> Could you send updated patch so we could test it?
>
> Also would be nice if ide-detect name was used instead of ide-generic so it
> will be consistent with 2.4 naming.

ide-detect != ide-generic

In 2.4 you have to load ide-detect after loading chipset module.
In 2.6+patch you don't have to load anything after loading chipset module.

ide-detect is used for all chipset modules to probe for drives.
ide-generic is generic/default host driver - you use it only if you don't have
specific modules for your IDE chipsets.

> ps. patch by Witold Krecicki works for other drivers - I've seen it working
> - but it's hacky anyway.

Sure, it works for other *PCI* drivers, but not ie. PPC ones (easy to fix).

--bart

