Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbTEHQrQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEHQrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:47:15 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39657 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261864AbTEHQrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:47:14 -0400
Date: Thu, 8 May 2003 18:59:25 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030508163441.GG20941@suse.de>
Message-ID: <Pine.SOL.4.30.0305081839190.24013-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 8 May 2003, Jens Axboe wrote:
> On Thu, May 08 2003, Linus Torvalds wrote:
> > On Thu, 8 May 2003, Jens Axboe wrote:
> > >
> > > Maybe a define or two would help here. When you see drive->addressing
> > > and hwif->addressing, you assume that they are used identically. That
> > > !hwif->addressing means 48-bit is ok, while !drive->addressing means
> > > it's not does not help at all.
> >
> > Why not just change the names? The current setup clearly is confusing, and
> > adding defines doesn't much help. Rename the structure member so that the
> > name says what it is, aka "address_mode", and when renaming it you'd go
> > through the source anyway and change "!addressing" to something more
> > readable like "address_mode == IDE_LBA48" or whatever.
>
> Might not be a bad idea, drive->address_mode is a heck of a lot more to
> the point. I'll do a swipe of this tomorrow, if no one beats me to it.

Good idea.

> > (Anyway, I'll just drop all the 48-bit patches for now, since you've
> > totally confused me about which ones are right and what the bugs are ;)

:-)

> I think we can all agree on the last one (attached again, it's short) is
> ok. The 'only use 48-bit when needed' can wait until Bart gets the
> taskfile infrastructure in place, until then I'll just have to eat the
> overhead :)

Okay for me.

btw. Jens, do you have any benchmarks of using 1MiB requests
     and/or removing 48-bit overhead?
--
Bartlomiej

