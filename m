Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286508AbRL0T2B>; Thu, 27 Dec 2001 14:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286517AbRL0T1w>; Thu, 27 Dec 2001 14:27:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32009 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286508AbRL0T1l>; Thu, 27 Dec 2001 14:27:41 -0500
Date: Thu, 27 Dec 2001 11:25:13 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33.0112271928260.15706-100000@Appserv.suse.de>
Message-ID: <Pine.LNX.4.33.0112271105350.1052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Dec 2001, Dave Jones wrote:
> On Thu, 27 Dec 2001, Linus Torvalds wrote:
>
> > This is absolutely true - it's a _very_ powerful thing. Old patches
> > simply grow stale: keeping track of them is not necessarily at all
> > useful, and can add more work than anything else.
>
> *nod*, until they get scooped up into another tree -ac, -dj, -whatever
> and fed to you whenever you're in the mood for resyncing.

But that's nothing more than "somebody else maintains them".

I realize that quite often the author of the patch is not going to be its
maintainer, which is exactly why all the other trees are so useful.

Everybody should realize that "outside trees" are not a rogue thing. They
are _very_ important, for several reasons:

 - competition keeps people honest. If I was the only holder of the keys,
   nobody would even _know_ if I was corrupt. And nobody could choose with
   his feet.

   Look at politics: if you don't have choices, the one choice _will_ be
   corrupt even if it started out with all the best intentions. The old
   adage there is "Power corrupts. Absolute power corrupts absolutely".

 - Different taste. Let's face it, a lot of programming is about having
   taste. Sometimes I don't like the way things are done, and people prove
   me wrong by other means. See the whole thing about the VM stuff with
   Andrea's patches - one of the reasons I hadn't applied the much earlier
   patches by Andrea was that I didn't like the zone-balancing approach.

   Having external trees is _crucial_ for allowing different approaches to
   co-exist, in order to show their strengths and weaknesses. And I tend
   to be fairly open to admitting when I did something wrong, and somebody
   else had a better tree. At least I _try_.

 - Different goals. Many of the commercial vendors have vendor needs, and
   they (correctly) think that those needs are the most important thing,
   while I don't care about vendors and thus have different priorities.

   Again, multiple trees are absolutely required to make this work.

 - And imperfect patch retention. There's no question that I drop patches,
   some bad, but many good. And that's going to be true of _anybody_ who
   maintains anything, except somebody who just accepts anything without
   question (eg CVS).

I don't think I've ever spoken out against things like -ac, -dj and -aa: I
sometimes have to explain why I do not merge things whole-sale (which
would certainly be _technically_ the easiest solution much of the time),
and I often disagree with some part of the patch, but I'm actually
surprised how often I have to _defend_ having many trees.

Just a historical note: one of the things I hated most about Minix was
that while Andrew Tanenbaum allowed external patches to the system, nobody
else could make a whole distribution. Which meant that while there existed
many trees and maintainers that were "better" (notably Bruce Evans, who
was considered to be a God of Minix), they were really painful to use, in
that you had to always do it from patches.

I fully _expect_ that somebody better comes along. At some point, more
people will simply be using the -dj tree (or whatever), and that's fine.

> And when you're ready to resync what I've got so far (currently ~3mb),
> it's going to be another full time job splitting it into bits to feed
> you linus-bite-sized chunks. (ObSidenote: When this time comes btw,
> if maintainers of relevant parts want to feed Linus their relevant
> parts from my tree, that would be appreciated, and would keep _my_ load
> down :-)

This sounds absolutely wonderful..

Note that you will notice that it's a _huge_ undertaking, and one of the
things that Alan complained about was how the fact that _I_ avoid scaling
meant that he had to scale more. I think it's a very valid complaint, and
it may make a whole lot more sense (if it is possible) to have different
people caring about different parts.

Note that this may not be possible, due to lack of modularity. We've had
to actively change the tree layout of the kernel before just to make it
easier to maintain over several people. Which is painful, but not
certainly not impossible still..

> "Used to" ? cvs @ vger.samba.org was still being maintained before
> I went on xmas vacation. Did I miss something ?

Does he allow the wide and uncoordinated write access that he used to
allow? I thought he basically shut that down, and only allows a few people
now, exactly to avoid getting too horrible merge issues..

		Linus

