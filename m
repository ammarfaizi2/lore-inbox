Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVBSKTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVBSKTx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 05:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVBSKTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 05:19:53 -0500
Received: from simmts8.bellnexxia.net ([206.47.199.166]:41634 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261687AbVBSKTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 05:19:45 -0500
Message-ID: <3720.10.10.10.24.1108808241.squirrel@linux1>
In-Reply-To: <200502190410.31960.pmcfarland@downeast.net>
References: <20050214020802.GA3047@bitmover.com>
    <845b6e8705021803533ba8cc34@mail.gmail.com>
    <20050218125057.GE2071@opteron.random>
    <200502190410.31960.pmcfarland@downeast.net>
Date: Sat, 19 Feb 2005 05:17:21 -0500 (EST)
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
From: "Sean" <seanlkml@sympatico.ca>
To: "Patrick McFarland" <pmcfarland@downeast.net>
Cc: linux-kernel@veger.kernel.org, "Andrea Arcangeli" <andrea@suse.de>,
       Erik =?iso-8859-1?Q?B=E5gfors?= <zindar@gmail.com>,
       "Tupshin Harper" <tupshin@tupshin.com>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-7
X-Mailer: SquirrelMail/1.4.3a-7
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, February 19, 2005 4:10 am, Patrick McFarland said:
> On Friday 18 February 2005 07:50 am, Andrea Arcangeli wrote:
>> On Fri, Feb 18, 2005 at 12:53:09PM +0100, Erik Bågfors wrote:
>> > RCS/SCCS format doesn't make much sence for a changeset oriented SCM.
>>
>> The advantage it will provide is that it'll be compact and a backup will
>> compress at best too. Small compressed tarballs compress very badly
>> instead, it wouldn't be even comparable. Once the thing is very compact
>> it has a better chance to fit in cache, and if it fits in cache
>> extracting diffs from each file will be very fast. Once it'll be compact
>> the cost of a changeset will be diminished allowing it to scale better
>> too.
>
> In the case of darcs, RCS/SCCS works exactly opposite of how darcs does.
> By
> using it's super magical method, it represents how code is written and how
> it
> changes (patch theory at its best). You can clearly see the direction code
> is
> going, where it came from, and how it relates to other patches.
>
> Sure, you can do this with RCS/SCCS style versioning, but whats the point?
> It
> is inefficient, and backwards.
>
>> Now it's true new disks are bigger, but they're not much faster, so if
>> the size of the repository is much larger, it'll be much slower to
>> checkout if it doesn't fit in cache. And if it's smaller it has better
>> chances of fitting in cache too.
>
> Thats all up to how the versioning system is written. Darcs developers are
> working in a checkpoint system to allow you to just grab the newest stuff,
> and automatically grab anything else you need, instead of just grabbing
> everything. In the case of the darcs linux repo, no one wants to download
> 600
> megs or so of changes.
>
>> The thing is, RCS seems a space efficient format for storing patches,
>> and it's efficient at extracting them too (plus it's textual so it's not
>> going to get lost info even if something goes wrong).
>
> It may not even be space efficient. Code ultimately is just code, and
> changes
> ultimately are changes. RCS isn't magical, and its far from it. Infact,
> the
> format darcs uses probably stores more code in less space, but don't quote
> me
> on that.
>
>> The whole linux-2.5 CVS is 500M uncompressed and 75M tar.bz2 compressed.
>
> The darcs repo which has the entire history since at least the start of
> 2.4
> (iirc anyways) to *now* is around 600 to 700.
>
>> My suggestion is to convert _all_ dozen thousand changesets to arch or
>> SVN and then compare the size with CVS (also the compressed size is
>> interesting for backups IMHO). Unfortunately I know nothing about darcs
>> yet (except it eats quite some memory ;)
>
> My suggestion is to convert _all_ dozen thousand changesets to darcs, and
> then
> compare the size with CVS. And no, darcs doesn't eat that much memory for
> the
> amount of work its doing. (And yes, they are working on that).
>
> The only thing you haven't brought up is the whole "omgwtfbbq! BK sucks,
> lets
> switch to SVN or Arch!" thing everyone else in the known universe is
> doing.
> BK isn't clearly inferior or superior to SVN or Arch or Darcs (and the
> same
> goes for SVN vs Arch vs Darcs).
>
> (Start Generic BK Thread On LKML Rant)
>
> Dear Everyone,
>
> I think if Linus is happy with BK, he should stick with it. His opinion
> ultimately trumps all of ours because he does all the hard maintainership
> work, and we don't. The only guy that gets to bitch about how much a
> versioning system sucks is the maintainer of a project (unless its CVS,
> then
> all bets are off).
>
> Linus has so far indicated that he likes BK, so the kernel hacking
> community
> will be stuck using that for awhile. However, that doesn't stop the
> license
> kiddies from coming out of the woodwork and mindlessly quoting the bad
> parts
> of the BK license (which, yes, its non-free, but at this point, who gives
> a
> shit).
>
> IMO, yes, a non-free versioning system for the crown jewel of the FLOSS
> community is a little... odd, but it was LInus's choice, and we now have
> to
> respect it/deal with it.
>
> Now, I did say above (in this thread) that darcs would be really awesome
> for
> kernel hacking, especially since it's inherent support for multiple
> branches[1] and the ability to send changes from each other around easily
> would come in handy; however, darcs was not mature at the time of Linus's
> decision (and many say it is still not mature enough), so if Linus had
> actually chosen darcs, I (and other people here) would be now flaming him
> for
> choosing a versioning system that wasn't mature.
>
> Similarly, if he had chosen arch, everyone would have flamed him for
> choosing
> a hard to use tool. With svn, he would have met flamage by the hands of it
> being too much like cvs and not supporting arch/darcs style branch
> syncing.
> And if he stayed with cvs, he would have been roasted over an open fire
> for
> sticking with an out of date, useless, insane tool.
>
> And if he chose anything else that I didn't previously mention, everyone
> would
> have donned flame retardant suits and went into the fray over the fact
> that
> no one has heard of that versioning system.
>
> No matter what choice Linus would have made, he would have had some part
> of
> the community pissed at him, so it is ultimately his choice on what to use
> because hes the only one going to be happy with it.
>
> [1] The Linux Kernel is looks like a forest instead of just a few
> branches.
>
> (End Rant)
>
> So, in summary, anti-BK posts on the lkml are retarded. Oh, and I
> apologize if I've put any words in your mouth, Linus.
>

Hey Patrick,

Good post.  One nit though is that the current thread has no anti-BK
aspect to it at all.   It's just a request that other tools be usable too
and that the BK zealotry be kept to a minimum.

Darcs sounds really interesting; will make sure to learn more about it soon.

Thanks,
Sean





