Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbSLSUYT>; Thu, 19 Dec 2002 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266191AbSLSUYT>; Thu, 19 Dec 2002 15:24:19 -0500
Received: from [81.2.122.30] ([81.2.122.30]:1033 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266186AbSLSUYR>;
	Thu, 19 Dec 2002 15:24:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212192042.gBJKgsTl002677@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: davej@codemonkey.org.uk (Dave Jones)
Date: Thu, 19 Dec 2002 20:42:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, lm@bitmover.com,
       lm@work.bitmover.com, torvalds@transmeta.com, vonbrand@inf.utfsm.cl,
       akpm@digeo.com
In-Reply-To: <20021219201811.GA7715@suse.de> from "Dave Jones" at Dec 19, 2002 08:18:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > I also don't trust things like this where if something goes wrong,
>  > > we could lose the bug report.
>  > How?  I don't see as that is more likely than with Bugzilla.
> 
> user submits bug report
> robot rejects it

It's not coded to reject stuff.  Just parse it and point out obvious mistakes.

> user reads rejection, gets confused, gives up.

I do see what you mean, but that's not how I see it working:

user submits bug report
[it gets stored]
robot generates messages similar to compiler *warnings*.

>  > Anyway, loads of LKML posts get ignored, and nobody seems to worry about it :-).
> 
> Point to one important posting thats been ignored in recent times.

What about that data corruption bug that was pointed out around
2.4.18, and brought up again, when it was discovered that the patch
wasn't applied.  That is a case of a bug report getting lost.  Not
exactly what I meant, though, but it's relevant.

> More likely they weren't ignored, it was just deemed irrelevant,
> unimportant, or lacked information detailing how important the problem
> was.

Well, that's what the automated warnings would protect against - at
least the user would get a response, telling them how to submit a more
useful response.

> Besides, this is one area where bugzilla is helping.
> If I ignored/missed an agp related bug report on linux kernel,
> and the same user also filed it in bugzilla, I'll get pestered
> about it automatically later.

Agreed.

>  > I don't see any way of making Bugzilla do all the things I described
>  > originally, specifically the advanced tracking of versions tested.
> 
> I still think you're solving a non-problem. Of the 180 or so bugs so
> far, there has been _1_ vendor kernel report. 1 2.4 report. and
> 1 (maybe 2)  undecoded oopses (which were subsequently decoded less
> than 24hrs later.

Well, if we never get above that rate of bugs being entered in to the
database, then we might as well not have it, and go back to having
everything on LKML.

>  > That could help to find duplicates, which is a big problem when you
>  > have 1000+ bugs.
> 
> In an ideal world, we'd never have that many open bugs 8-)

Good point :-)

> Realistically, I check bugzilla a few times a day, I notice
> when something new has been added. Near the end of each week
> I[*] go through every remaining open bug looking to see if there's
> something additional that can be added / pinging old reporters /
> closing dead bugs. Dupes usually stand out doing this.
> How exactly do you plan to automate dupe detection ?
> You can't even do things like comparing oops dumps, as they
> may have been triggered in different ways,.

I mean make it easier for people to identify dupes.

I've got loads of ideas about how we could build a better bug database
- for example, we have categories at the moment in Bugzilla.  Why?  We
already have a MAINTAINERS file, so say somebody looks up the relevant
maintainer in that list, finds them, then goes to enter a bug in
Bugzilla.  Now they have to assign it to a category, and different
people may well assign the same bug to different categories -
immediately making duplicate detection more difficult.

If the number of bugs is always going to stay low, then my idea is
probably a waste of time, but I think that we are eventually going to
have loads of bug reports.  We _want_ more bug reports, especially in
the development tree.  Few enough people are testing it as it is!

John.
