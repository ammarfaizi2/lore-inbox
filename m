Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293243AbSCADJy>; Thu, 28 Feb 2002 22:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310238AbSCADGA>; Thu, 28 Feb 2002 22:06:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2579 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S310334AbSCADEH>; Thu, 28 Feb 2002 22:04:07 -0500
Date: Thu, 28 Feb 2002 22:02:27 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-preX: What we really need: -AA patches finally in the tree
In-Reply-To: <Pine.LNX.4.33L.0202282002260.2801-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1020228215025.3310A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Rik van Riel wrote:

> On Thu, 28 Feb 2002, Bill Davidsen wrote:
> > On Tue, 26 Feb 2002, Christoph Hellwig wrote:
> >
> > > They shouldn't,  But many old drivers do (and _had to_):
> > >
> > > 	current->policy = SCHED_YIELD;
> > > 	schedule();
> > >
> > > which isn't possible with the new scheduler.
> >
> > Let's see, the choices are to (a) keep the old scheduler which has many
> > performance issues, or (b) put in the new scheduler and let people who
> > need the old drivers either fix them or stop upgrading.
> 
> or (c) have proponents of the inclusion of the O(1) scheduler
> fix all drivers before having the O(1) scheduler considered
> for inclusion.
> 
> Adding a yield() function to 2.4's scheduler and fixing all
> the drivers to use it isn't that hard. Now all that's needed
> are some O(1) fans willing to do the grunt work.

That sounds very nice, but in practice it means it would never happen, and
you know it. First you have to patch the existing scheduler. Aside from
the work on something which we are about to discard, the patch would have
to go through the maintainer, and the the submitter, and the pope, and
god, and finally Linus, and then (only then) could the patch go in the old
scheduler. Then you start the process with each of the drivers. They are
old grotty drivers, I would bet that no one "maintains" some of them (I'll
actually count when I login to a better machine). 

This process could take six months to a year, after which we can start the
process with the scheduler. Alternatively we can put in the new scheduler,
let the drivers have compile errors, and let them be fixed when (if) they
are still in use.

If we could get a dispensation from Linus to submit one patch combining
the scheduler and all the drivers, it could be done (almost mechanically).
But with the maintainers, submitters, etc, process for each bit, it could
take a year. And dammit the patch is so night and day better that it
shouldn't take a year.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

