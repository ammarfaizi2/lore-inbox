Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266167AbUGESxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUGESxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 14:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUGESxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 14:53:10 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:43745 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266167AbUGESxA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 14:53:00 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Date: Mon, 5 Jul 2004 20:58:16 +0200
User-Agent: KMail/1.5.3
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
References: <Pine.LNX.4.21.0407051733310.14602-100000@mlf.linux.rulez.org>
In-Reply-To: <Pine.LNX.4.21.0407051733310.14602-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407052058.16478.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 of July 2004 20:09, Szakacsits Szabolcs wrote:
> On Mon, 5 Jul 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 05 of July 2004 14:14, Szakacsits Szabolcs wrote:
> > >     - nobody could point out any _technical_ benefit why the new
> > > HDIO_GETGEO code is better than the old one (the _way_ Andries wanted
> > > to
> >
> > Andries pointed it many times but you seem to completely ignore it
>
> Hmmm. I'm recovering people's partition tables in my spare time,
> voluntarily, free of charge when they got trashed due to Andries' and
> Andrew's bugs over the last two years (gpart, testdisk and parted's
> rescue mode don't always work),
>
>      http://mlf.linux.rulez.org/mlf/ezaz/ntfsresize.html#troubleshoot
>
> I reported them several bugs, hints, reasons, potential reasons, guesses,
> user feature request both privately and publicly.
>
> I do know very well Andries' arguments, I've learnt them the hard way.
> Actually I responded them several times, even in this thread.

OK

> > I also pointed out that IDE driver _doesn't_ need BIOS geometry et all.
>
> Thanks but I thought it was off-topic and think the same now, too. It was
> explained several times.

How can this be off-topic?  In case of IDE disks HDIO_GETGEO is handled by
ide-disk driver.  In 2.4 there was ide-geometry.c file (part of IDE driver)
which contained code for retrieving BIOS geometry (Andries removed it in 2.5),
Restoring 2.4 way of handling HDIO_GETGEO requires changes to the IDE driver.

> However none of you who responded seems to understand, still, what I want
> to say.
>
> You can't fix, for example, parted 1.6.11 and all earlier versions when
> one does a 2.4 -> 2.6 kernel upgrade. If a user uses an old enough tool on
> the new kernels then it can trash its partition table whatever the OS it
> is (not only the geometry but the layout in sectors, too).
>
> Also, sometimes [even very popular] distros ship one or two old tools, no
> need for kernel upgrade. Whenever a user use the shipped old tool on 2.6
> it can trash the partition table, being during install or later.

I understand this perfectly and I'm thinking about the best way to solve it.

> You, Bartlomiej Zolnierkiewicz, Andries Brouwer and Steffen Winterfeldt
> say don't care about those people. OK, at least now it's documented
> and this thread can be pointed out as a reference in the future.

Calm down because your false accusations are also documented now. ;-)

> Since there is nothing I could do more if maintainers aren't willing to
> fix their more destructive 2.6 kernel code, the case is closed from my
> part by this email.

Bartlomiej

