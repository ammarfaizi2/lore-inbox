Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265653AbTFXEFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 00:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265654AbTFXEFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 00:05:48 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18448 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265653AbTFXEFq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 00:05:46 -0400
Date: Tue, 24 Jun 2003 00:13:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: John Bradford <john@grabjohn.com>
cc: felipe_alfaro@linuxmail.org, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
In-Reply-To: <200306232332.h5NNWxbs002721@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.3.96.1030624000256.2375F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jun 2003, John Bradford wrote:

Actually Bill Davidsen wrote, now 2nd level indent...

> Bill Davidsen suggested:
> > <bias report, I do stuff on servers a lot> It might be that the total
> > interactivity bonus should be set for a system, so that the admin trying
> > to use and editor on a config file wouldn't have an unresponsive cursor,
> > while a bunch of users doing similar things would get a smaller (perhaps
> > tiny) bonus and not impact the server main application.
> >
> > Question for the VM gods, faced with memory pressure should the VM as well
> > as the schedular be aware of interactivity and give a preference to those
> > processes when deciding what to page out? The supreme court says it's okay
> > to give preference as long as it's not a quota ;-)
> 
> Maybe we should give a quota.  When faced with 100% CPU usage,
> non-server apps, (however you define that), can't, in total, have more
> than 10% CPU, (but see * below).

I was thinking of total priority points... say for example on a server you
have max 50 interactivity points to share between and deserving processes.
So if I'm running vi and only vi it can get up to 100. I'm thinking of the
priority shown by ps, clearly one process will NOT get that much!

If I have X up and run vi in a window, or do web admin, I'd have more
processes and the max for any one would be lower.

In truth I think 50 sounds more like a desktop, maybe 10-20 for a server?
In any case I think that would be easier to track than CPU percentage, and
what I want to change is who gets the CPU next, not how much they get.
Typing in vi takes nada, but I see 1-5 sec delays in echoing the
character, even without X.

If this was to work, I would think that you would care more for xmms not
skipping than windows moving slowly, assuming that was the trade-off.
YMMV.

> *
> 
> Is there any reason why we can't set a 90%/10% server/non-server CPU
> limit, but make any application burstable to 100% for no longer than
> 10% of the time?  I.E. it would work analogously to a burstable
> network pipe.

Other than I think it's easier to just use the priorities already in place
and diddle them than to track CPU. On the other hand we have CPU and sleep
info. If Ingo or anyone qualified cares enough about this suggestion to
think about it we may get an answer from someone who really knows how this
works.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

