Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbTBPLlt>; Sun, 16 Feb 2003 06:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbTBPLlt>; Sun, 16 Feb 2003 06:41:49 -0500
Received: from [81.2.122.30] ([81.2.122.30]:26116 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266535AbTBPLlq>;
	Sun, 16 Feb 2003 06:41:46 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302161150.h1GBok41000483@darkstar.example.net>
Subject: Re: openbkweb-0.0
To: dwmw2@infradead.org (David Woodhouse)
Date: Sun, 16 Feb 2003 11:50:46 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, lm@bitmover.com, arashi@yomerashi.yi.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1045394526.2068.52.camel@imladris.demon.co.uk> from "David Woodhouse" at Feb 16, 2003 11:22:06 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just wanted to confirm that bk-commit-head is actually:
> > 
> > 1. Complete
> 
> It should be complete -- but bear in mind that you may receive the mails
> in a different order to the order in which they were sent, so just
> applying them from a mail filter isn't necessarily sensible.

OK, fair enough, it does need to be more complicated than I originally
suggested, but each changeset is numbered, so presumably we could just
use that to ensure that we don't miss any.

> Also note that the dates on them are the date of the changeset itself,
> not the date of application to Linus' tree (or indeed the date of the
> cron job which creates the mail).

Well, that's OK as long as we are just trying to track Linus' tree, we
don't even need to know the patch's original date.

> > 2. Realtime
> 
> Almost -- it's run from an hourly cron job, which is more 'real time'
> than Linus actually pushing from his own box to master.kernel.org and
> quite enough of a demand on resources already.
> 
> It's not done with triggers on Linus' tree because I suspect that would
> actually make Linus _wait_ while the mail is generated for every
> changeset he's pushing to master.kernel.org. I do it with a cron job
> which pulls from Linus' tree to another, and I don't do it with triggers
> in my own tree because I suspect that would keep Linus' tree locked
> while it generated the mails too. I do need to investigate possible
> improvements to the way it's generated, though.

Can't Larry just do this from bkbits, though?  That's what I don't
understand.

Maybe not for Linus' tree due to the volume of patches, but for most
other trees, a mail sent out for each commit should be no problem.
There should be no issues with locking - the mailing list shouldn't
*care* whether anybody is actually receiving the mail, it just
broadcasts the changes for everybody to see. 

John.
