Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316832AbSGLTDt>; Fri, 12 Jul 2002 15:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSGLTDt>; Fri, 12 Jul 2002 15:03:49 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:58775 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S316832AbSGLTDq>; Fri, 12 Jul 2002 15:03:46 -0400
Date: Fri, 12 Jul 2002 21:06:12 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Martin Dalecki <dalecki@evision-ventures.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <3D2F20DD.1030704@zytor.com>
Message-ID: <Pine.SOL.4.30.0207122051280.21379-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Jul 2002, H. Peter Anvin wrote:

> Linus Torvalds wrote:
> >
> > On Fri, 12 Jul 2002, Martin Dalecki wrote:
> >
> >>So Linus what's your opinnion please?
> >
> >
> > I will violently oppose anything that implies that the IDE layer uses the
> > SCSI layer normally.  No way, Jose. I'm all for scrapping, but the thing
> > that should be scrapped is ide-scsi.
> >
> > The higher layers already have much of what the SCSI layer does, and the
> > SCSI layer itself is slowly moving in that direction.
>
> Then *please* make a *compatible* interface available to user space.
> This certainly can be done; the parallel port IDE interface stuff had
> exactly such an interface (/dev/pg*) -- we could have a /dev/hg*
> interface presumably.  That is an acceptable solution.
>
> Note again that this discussion (and it's a discussion, not a voting
> session -- technical pros and cons is what applies) apply to ATAPI (SCSI
> over IDE) only.  Alan has already brought up the fact of non-hard disk

Please stop calling ATAPI as SCSI over IDE, it is not. It is Packet
Interface over ATA (IDE). Some ATAPI/SCSI devices are functionally
equivalent because they support the same command set (i.e. MMC).

> non-ATAPI devices, and IMO those devices are explicitly out of scope.
> Maturity of drivers is another, but right now we're suffering through
> having to deal with multiple drivers for the same hardware, or with user

Where multiple means two? ;-)

> space having to choose different interfaces depending on connection
> interface, and either which way that's pretty pathetic.

It is in fact. Generic higher level interface is a solution.

Greets
--
Bartlomiej

>
> 	-hpa


