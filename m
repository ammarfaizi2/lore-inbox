Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVBSJTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVBSJTK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVBSJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:17:06 -0500
Received: from downeast.net ([204.176.212.2]:61378 "EHLO downeast.net")
	by vger.kernel.org with ESMTP id S261696AbVBSJML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:12:11 -0500
From: Patrick McFarland <pmcfarland@downeast.net>
To: linux-kernel@veger.kernel.org
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
Date: Sat, 19 Feb 2005 04:10:18 -0500
User-Agent: KMail/1.7.2
Cc: Andrea Arcangeli <andrea@suse.de>,
       Erik =?iso-8859-1?q?B=E5gfors?= <zindar@gmail.com>,
       Tupshin Harper <tupshin@tupshin.com>, darcs-users@darcs.net,
       lm@bitmover.com, linux-kernel@vger.kernel.org
References: <20050214020802.GA3047@bitmover.com> <845b6e8705021803533ba8cc34@mail.gmail.com> <20050218125057.GE2071@opteron.random>
In-Reply-To: <20050218125057.GE2071@opteron.random>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5234265.f5DTMvsft1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502190410.31960.pmcfarland@downeast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart5234265.f5DTMvsft1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 18 February 2005 07:50 am, Andrea Arcangeli wrote:
> On Fri, Feb 18, 2005 at 12:53:09PM +0100, Erik B=E5gfors wrote:
> > RCS/SCCS format doesn't make much sence for a changeset oriented SCM.
>
> The advantage it will provide is that it'll be compact and a backup will
> compress at best too. Small compressed tarballs compress very badly
> instead, it wouldn't be even comparable. Once the thing is very compact
> it has a better chance to fit in cache, and if it fits in cache
> extracting diffs from each file will be very fast. Once it'll be compact
> the cost of a changeset will be diminished allowing it to scale better
> too.

In the case of darcs, RCS/SCCS works exactly opposite of how darcs does. By=
=20
using it's super magical method, it represents how code is written and how =
it=20
changes (patch theory at its best). You can clearly see the direction code =
is=20
going, where it came from, and how it relates to other patches.

Sure, you can do this with RCS/SCCS style versioning, but whats the point? =
It=20
is inefficient, and backwards.

> Now it's true new disks are bigger, but they're not much faster, so if
> the size of the repository is much larger, it'll be much slower to
> checkout if it doesn't fit in cache. And if it's smaller it has better
> chances of fitting in cache too.

Thats all up to how the versioning system is written. Darcs developers are=
=20
working in a checkpoint system to allow you to just grab the newest stuff,=
=20
and automatically grab anything else you need, instead of just grabbing=20
everything. In the case of the darcs linux repo, no one wants to download 6=
00=20
megs or so of changes.

> The thing is, RCS seems a space efficient format for storing patches,
> and it's efficient at extracting them too (plus it's textual so it's not
> going to get lost info even if something goes wrong).

It may not even be space efficient. Code ultimately is just code, and chang=
es=20
ultimately are changes. RCS isn't magical, and its far from it. Infact, the=
=20
format darcs uses probably stores more code in less space, but don't quote =
me=20
on that.

> The whole linux-2.5 CVS is 500M uncompressed and 75M tar.bz2 compressed.

The darcs repo which has the entire history since at least the start of 2.4=
=20
(iirc anyways) to *now* is around 600 to 700.=20

> My suggestion is to convert _all_ dozen thousand changesets to arch or
> SVN and then compare the size with CVS (also the compressed size is
> interesting for backups IMHO). Unfortunately I know nothing about darcs
> yet (except it eats quite some memory ;)

My suggestion is to convert _all_ dozen thousand changesets to darcs, and t=
hen=20
compare the size with CVS. And no, darcs doesn't eat that much memory for t=
he=20
amount of work its doing. (And yes, they are working on that).

The only thing you haven't brought up is the whole "omgwtfbbq! BK sucks, le=
ts=20
switch to SVN or Arch!" thing everyone else in the known universe is doing.=
=20
BK isn't clearly inferior or superior to SVN or Arch or Darcs (and the same=
=20
goes for SVN vs Arch vs Darcs).

(Start Generic BK Thread On LKML Rant)

Dear Everyone,

I think if Linus is happy with BK, he should stick with it. His opinion=20
ultimately trumps all of ours because he does all the hard maintainership=20
work, and we don't. The only guy that gets to bitch about how much a=20
versioning system sucks is the maintainer of a project (unless its CVS, the=
n=20
all bets are off).

Linus has so far indicated that he likes BK, so the kernel hacking communit=
y=20
will be stuck using that for awhile. However, that doesn't stop the license=
=20
kiddies from coming out of the woodwork and mindlessly quoting the bad part=
s=20
of the BK license (which, yes, its non-free, but at this point, who gives a=
=20
shit).=20

IMO, yes, a non-free versioning system for the crown jewel of the FLOSS=20
community is a little... odd, but it was LInus's choice, and we now have to=
=20
respect it/deal with it.

Now, I did say above (in this thread) that darcs would be really awesome fo=
r=20
kernel hacking, especially since it's inherent support for multiple=20
branches[1] and the ability to send changes from each other around easily=20
would come in handy; however, darcs was not mature at the time of Linus's=20
decision (and many say it is still not mature enough), so if Linus had=20
actually chosen darcs, I (and other people here) would be now flaming him f=
or=20
choosing a versioning system that wasn't mature.

Similarly, if he had chosen arch, everyone would have flamed him for choosi=
ng=20
a hard to use tool. With svn, he would have met flamage by the hands of it=
=20
being too much like cvs and not supporting arch/darcs style branch syncing.
And if he stayed with cvs, he would have been roasted over an open fire for=
=20
sticking with an out of date, useless, insane tool.

And if he chose anything else that I didn't previously mention, everyone wo=
uld=20
have donned flame retardant suits and went into the fray over the fact that=
=20
no one has heard of that versioning system.

No matter what choice Linus would have made, he would have had some part of=
=20
the community pissed at him, so it is ultimately his choice on what to use=
=20
because hes the only one going to be happy with it.

[1] The Linux Kernel is looks like a forest instead of just a few branches.

(End Rant)

So, in summary, anti-BK posts on the lkml are retarded. Oh, and I apologize=
 if=20
I've put any words in your mouth, Linus.

=2D-=20
Patrick "Diablo-D3" McFarland || pmcfarland@downeast.net
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, w=
e'd=20
all be running around in darkened rooms, munching magic pills and listening=
 to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989

--nextPart5234265.f5DTMvsft1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCFwKH8Gvouk7G1cURAkbhAKDBoJxc1z0qIPPuhcbbGrwj3C2zVgCghYzA
E02gNYEmj8PjXw97gYW05fM=
=eRdY
-----END PGP SIGNATURE-----

--nextPart5234265.f5DTMvsft1--
