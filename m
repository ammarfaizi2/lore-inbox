Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264771AbUEOAOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264771AbUEOAOk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264722AbUEOAMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:12:00 -0400
Received: from florence.buici.com ([206.124.142.26]:51593 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264700AbUEOAKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 20:10:31 -0400
Date: Fri, 14 May 2004 17:10:28 -0700
From: Marc Singer <elf@buici.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: rmk@arm.linux.org.uk, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: arm-lh7a40x IDE support in 2.6.6
Message-ID: <20040515001028.GA9500@buici.com>
References: <200405141840.04401.bzolnier@elka.pw.edu.pl> <200405150019.46504.bzolnier@elka.pw.edu.pl> <20040514224932.GA8061@buici.com> <200405150126.33153.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405150126.33153.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2004 at 01:26:33AM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Saturday 15 of May 2004 00:49, Marc Singer wrote:
> > On Sat, May 15, 2004 at 12:19:46AM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > > > > > > - you are setting IDE_NO_IRQ in ide_init_hwif_ports() which is
> > > > > > > used in many places in generic IDE code - anybody wanting to
> > > > > > > understand interactions with your code + generic code will have
> > > > > > > serious problems (especially if knows _nothing_ about lpd7a40x)
> > > > > >
> > > > > > I don't know what you mean.  I grep for that constant and found it
> > > > > > nowhere except for ide-io.c and in my code.  It doesn't take much
> > > > > > to find the references.
> > > > >
> > > > > I'm talking about ide_init_hwif_ports() function.
> > > >
> > > > Most of the ARM arch's use it.  Perhaps all of them need a good once
> > > > over.
> > >
> > > Since some time I have a patch killing <asm/arch-*/ide.h>. :)
> >
> > OK.  That raises an interesting question.  If a) you as the IDE
> > maintainer want to make a policy change, and b) you have a concrete
> > action to take, then how do you go about it so that the right thing
> > (tm) happens?
> 
> I posted patch to linux-arm-kernel (rmk, I can't find it in l-a-k archives
> and I also can't find any mail about it being rejected?) and linux-ide.
> [ and to affected arch maintainers of course ]

There is a web page for posting kernel patches.  It is most likely to
receive attention than posting to the mailing list.

  <http://www.arm.linux.org.uk/developer/patches/>

> > One tack would be to post to the ARM list stating that there is
> > such-and-such, a new policy, and this requires a change to the
> > way-things-work (tm).  Then effect a patch that breaks the bad stuff
> > so that the users of such bad stuff must cope.
> 
> It is stable kernel series so I paid 'stable kernel' price
> and made sure that it shouldn't break anything.

Fair enough.  We'll start with lh and see if we can get others to
follow.
