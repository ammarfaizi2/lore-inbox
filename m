Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270684AbTHEUpr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270686AbTHEUpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:45:47 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:938 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S270684AbTHEUpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:45:44 -0400
Date: Tue, 5 Aug 2003 22:45:12 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <Andries.Brouwer@cwi.nl>
cc: <B.Zolnierkiewicz@elka.pw.edu.pl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix error return get/set_native_max functions
In-Reply-To: <UTC200308052008.h75K8aD22137.aeb@smtp.cwi.nl>
Message-ID: <Pine.SOL.4.30.0308052231080.4251-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Aug 2003 Andries.Brouwer@cwi.nl wrote:

> > This change is okay, thanks.
> > However changing coding style is not...
>
> An interesting remark.
>
> I belong to the people who look at kernel source on a screen
> with 80 columns. Code that is wider and wraps is unreadable.

/me too

> Now of course you might react "buy a better monitor", but in fact
> this restriction leads to cleaner code. There is something wrong
> when code is indented too deeply, and almost always a cleanup is
> possible that splits some inner stuff out as a separate function.
>
> As a side effect of that you'll see in patches from me changes
> that bring the code within the 80-column limit.

I think that mixing such changes with real changes is a bad thing.

> > -static unsigned long idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
> > +static unsigned long
> > +idedisk_set_max_address(ide_drive_t *drive, unsigned long addr_req)
>
> It is a matter of taste precisely which transformation is best
> in order to bring the source within the 80-column limit,
> but having the type on the preceding line is very common
> in the kernel source (and elsewhere), so among the possible
> ways of splitting this line this is a very natural one.

It is not so common in drivers/ide/...

static unsigned long idedisk_set_max_address(ide_drive_t *drive,
					     unsigned long addr_req)

This format also clearly shows that actual function name suck and should
be shortened :-).

> I am not interested in a discussion about style, but will defend
> the 80-column limit.

Sure, 80-column is a must ;-).
--
Bartlomiej


