Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284738AbRLEVTG>; Wed, 5 Dec 2001 16:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284741AbRLEVSu>; Wed, 5 Dec 2001 16:18:50 -0500
Received: from trillium-hollow.org ([209.180.166.89]:19721 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S284738AbRLEVSI>; Wed, 5 Dec 2001 16:18:08 -0500
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Re: Loadable drivers [was SMP/cc Cluster description ] 
In-Reply-To: Your message of "Wed, 05 Dec 2001 21:28:44 +0100."
             <20011205212844.451f8781.skraw@ithnet.com> 
Date: Wed, 05 Dec 2001 13:17:47 -0800
From: erich@uruk.org
Message-Id: <E16BjQJ-0005EA-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephan von Krawczynski <skraw@ithnet.com> wrote:

...
> You can only be plain kidding with this statement. If you split the
> drivers from the rest of the kernel, you managed to get rid of this
> nice (yes, I really meant nice) monolithic design, where I only need
> a simple config file to _update_ to a new kernel revision (_up_, not
> _down_) and be happy (including all the drivers).

Hmm.  There is little fundamentally incompatible with having splits in
the core kernel and sets of drivers, and getting most of what you want
here.

However, the comment about being "happy (including all the drivers)"
seems a bit naive in my experience.  That makes the assumption that the
drivers in the new/old/whatever kernel you change to are necessarily of
the same caliber as the ones you came from, and that is not always true
by any means.

Also, in a world where one values stability, being able to rev
backward is quite important also.  The lack of software package tools
like rpm being able to "downgrade" software easily is a serious one in
my mind.  What do you do when you install something major and it
breaks, but it has interdependencies on multiple other things?

I don't object to producing well-tested full sets of driver source that
go with kernel versions, I just don't want them to be tied if I have
a need to pull something apart (a driver from one version and from
another are the only ones that run stably), which frankly happens too
often for my taste.  Even if it didn't I'd still want it as much as
possibly for the fall-back options it provides.


...
> working driver interoperability between NT/2K/XP whatever - with the
> idea that it is indeed possible to make major new kernel versions (which
> should be getting better btw) without _any_ changes in the driver
> framework that will break your nice and stable but _old_ drivers. What's
> the use of this? You are not talking about releasing driver-plugin-/
> framework-patches or the like just to load _old_ drivers into _new_
> kernel-environment?
> Is this what they do at MS? Well if, they have not come that far.

I didn't go far enough with my comment.  I should have said that the
lack of a common driver framework base that works between *all* (or nearly
all, some obsolescence is ok) their Windows versions is a problem.

In the consumer line (win3.1/95/98/me) where they were keeping very good
compatibility across some kinds of drivers (it had it's problems, to be
sure), they were trying the hardest because they recognized that the
most important thing was to just have things work in the first place.

NOTE:  I'm not endorsing their overall API convenience (driver or
Win16/Win32), stability, suitability, merchantability, whatever, I'm
just talking about drivers and their distribution model at the moment.


...
> Reading between your lines, I can well see that you are most probably
> talking about closed-source linux-drivers breaking with permanently
> released new kernel revisions. But, in fact, this is the closed-source
> phenomenon, and _not_ linux.

No, though I don't object to closed-source in general per se.  I hate it
for myself and businesses I've worked for because I like to be able to
fix/improve/whatever code, but I recognize that the majority of users
out there would never touch code.

My general feeling is that binary drivers are ok/should be supported well
across versions since that is the thing you load in at boot/bring-system-
up time.  Having separate (and usually many) step(s) to getting a driver
and having it load on your system is a major and I'm thinking artificial
pain.


In general my argument stems from the same basis that the kernel/user-level
interface does:  keeping interfaces stable and removing packaging/bundling
requirements across major boundaries almost always yield a win somewhere.

In the case of MS and drivers, the win they have in convenience to end-users
of all types, and the ability to mix and match drivers forward or backward
up to some limitations in API revisions.


...
> I tend to believe we could just wait another two MS cycles to have even
> the biggest MS-fans converted to kernel-hackers, only because of being
> real fed up with the brilliant, long term driver design.

Most people will never touch code or a compiler, and just want a simple
obvious formula or even to have the system automagically do the Right
Things for you.  Even many programmers have limitations of curiousity or
energy, and it isn't a bad thing to organize even core system things to
be easy.

MS may be stupid/annoying in other ways, but they know this and have
moved toward it, albeit sluggishly at times.


--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
