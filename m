Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264728AbUEOAb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbUEOAb0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUEOAYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:24:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5599 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265315AbUEOAXV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:23:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Marc Singer <elf@buici.com>
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Date: Sat, 15 May 2004 02:25:28 +0200
User-Agent: KMail/1.5.3
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405150126.33153.bzolnier@elka.pw.edu.pl> <20040515001028.GA9500@buici.com>
In-Reply-To: <20040515001028.GA9500@buici.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405150225.28051.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 of May 2004 02:10, Marc Singer wrote:
> On Sat, May 15, 2004 at 01:26:33AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Saturday 15 of May 2004 00:49, Marc Singer wrote:
> > > On Sat, May 15, 2004 at 12:19:46AM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > > > > > > - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which
> > > > > > > > is used in many places in generic IDE code - anybody wanting
> > > > > > > > to understand interactions with your code + generic code will
> > > > > > > > have serious problems (especially if knows _nothing_ about
> > > > > > > > lpd7a40x)
> > > > > > >
> > > > > > > I don't know what you mean.  I grep for that constant and found
> > > > > > > it nowhere except for ide-io.c and in my code.  It doesn't take
> > > > > > > much to find the references.
> > > > > >
> > > > > > I'm talking about ide_init_hwif_ports() function.
> > > > >
> > > > > Most of the ARM arch's use it.  Perhaps all of them need a good
> > > > > once over.
> > > >
> > > > Since some time I have a patch killing <asm/arch-*/ide.h>. :)
> > >
> > > OK.  That raises an interesting question.  If a) you as the IDE
> > > maintainer want to make a policy change, and b) you have a concrete
> > > action to take, then how do you go about it so that the right thing
> > > (tm) happens?
> >
> > I posted patch to linux-arm-kernel (rmk, I can't find it in l-a-k
> > archives and I also can't find any mail about it being rejected?) and
> > linux-ide. [ and to affected arch maintainers of course ]
>
> There is a web page for posting kernel patches.  It is most likely to
> receive attention than posting to the mailing list.
>
>   <http://www.arm.linux.org.uk/developer/patches/>

It is for -rmk tree.

> > > One tack would be to post to the ARM list stating that there is
> > > such-and-such, a new policy, and this requires a change to the
> > > way-things-work (tm).  Then effect a patch that breaks the bad stuff
> > > so that the users of such bad stuff must cope.
> >
> > It is stable kernel series so I paid 'stable kernel' price
> > and made sure that it shouldn't break anything.
>
> Fair enough.  We'll start with lh and see if we can get others to
> follow.

lh is non-buildable in the mainline so I shouldn't care about it
(from kill ide_init_hwif_ports() patch standpoint).

We will change mainline and others will follow. 8)

