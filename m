Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286605AbRL0URf>; Thu, 27 Dec 2001 15:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286603AbRL0URQ>; Thu, 27 Dec 2001 15:17:16 -0500
Received: from ns.suse.de ([213.95.15.193]:25612 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S286605AbRL0URA>;
	Thu, 27 Dec 2001 15:17:00 -0500
Date: Thu, 27 Dec 2001 21:16:59 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33.0112271105350.1052-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0112272038060.15706-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Linus Torvalds wrote:

> > > This is absolutely true - it's a _very_ powerful thing. Old patches
> > > simply grow stale: keeping track of them is not necessarily at all
> > > useful, and can add more work than anything else.
> > *nod*, until they get scooped up into another tree -ac, -dj, -whatever
> > and fed to you whenever you're in the mood for resyncing.
> But that's nothing more than "somebody else maintains them".

Absolutely. Reading every patch sent to Linux-Kernel is a big task.
(And this is without the patches sent to you that don't make it to l-k)
After spending post-xmas reading through old postings catching up, and
picking up some obvious small fixes still not merged, I'm already starting
to fall behind. It's little wonder that some bits fall through the cracks
sometimes.

CCing someone like Alan or myself or anyone else maintaining a jumbo
sized' tree stands more likelyhood of something hitting Linus when it gets
around to mergetime, but remember that I'm only human too, and I too have
scaling issues.

> I realize that quite often the author of the patch is not going to be its
> maintainer, which is exactly why all the other trees are so useful.

You take the words right out of my mouth.

>    Look at politics: if you don't have choices, the one choice _will_ be
>    corrupt even if it started out with all the best intentions. The old
>    adage there is "Power corrupts. Absolute power corrupts absolutely".

Totally. Though things will no doubt get interesting if Rik & Andrea
both come up with patches to acheive the same goal differently.
Sometimes choice is good. The -ac vs -linus VM scuffle was certainly an
interesting thing to watch, but I'm glad that at the time I wasn't
maintaining a 'fork'. (Alan had the benefit of neither of those involved
worked for Red Hat).  If Rik VM-nextgeneration becomes "vm of choice" for
2.6, and I choose to stick with Andrea-vm I've no doubt at all I'll hear
complaints. But to reiterate: competition is good, and I'll not let
politics spoil that.

>  - Different taste. Let's face it, a lot of programming is about having
>    taste. Sometimes I don't like the way things are done, and people prove
>    me wrong by other means. See the whole thing about the VM stuff with
>    Andrea's patches - one of the reasons I hadn't applied the much earlier
>    patches by Andrea was that I didn't like the zone-balancing approach.

*nod*, I've no doubt you'll have issues with some bits I've got lined
up already, that's fine. If we need a better solution for something in 2.5
than a "carried forward from 2.4" fix, I've no problem with that.
Some of the bits I'll be merging in a few releases time, I've also
no intention of feeding you, at least unless the maintainer of
said code asks it to be pushed your way at some point.

>    Having external trees is _crucial_ for allowing different approaches to
>    co-exist, in order to show their strengths and weaknesses. And I tend
>    to be fairly open to admitting when I did something wrong, and somebody
>    else had a better tree. At least I _try_.

*nod*. The only situation that bothers me is the situation that could
arise where we have a dozen different 'trees' none of which will apply
against each other. I'm trying to have this not happen by merging anything
that looks sensible. I'll not do things like Alan did, merging new archs,
new filesystems (or other major feature, 2.5 after all is the devel tree,
not -dj).

I'm already 3mb away from your tree, I've figured I've already crossed the
threshold, now it's time to jump the chasm.  Resync time may take a while,
but for as long as I've got my tree in sync, this isn't a problem.
(Insert dave run over by bus analogy here).  And I'll happily maintain
-dj for at least as long as I find it a fun and interesting challenge.
(Even if this means overspill to 2.6-dj patches to feed Marcelo/whoever)

> I don't think I've ever spoken out against things like -ac, -dj and -aa: I
> sometimes have to explain why I do not merge things whole-sale (which
> would certainly be _technically_ the easiest solution much of the time),
> and I often disagree with some part of the patch, but I'm actually
> surprised how often I have to _defend_ having many trees.

Half a dozen or so trees with different goals isn't such a bad thing.
If for eg someone else started doing what I've been doing the last few
weeks, anyone wanting to experiment with 2.5 now has to dig through
patches & changelogs trying to figure out which one to use/hack on.
Nightmare if $developer wants a feature from -dj and one from -whoever.
But then again, you learn quite a bit from trying to merge competing trees 8)

> I fully _expect_ that somebody better comes along. At some point, more
> people will simply be using the -dj tree (or whatever), and that's fine.

If people want to do that whilst you rip apart a subsystem making it
unusable for the majority, I'll continue to merge the non-broken bits.

The one thing I want to make _absolutely clear_ however, is that I will
not do a maintainers job for them wrt pushing changes to you.
Sure I'll push the overspill of smaller changes to you (with maintainer
cc'd where necessary), but I won't do Greg's job for eg, when it comes to
USB merging.

> Note that you will notice that it's a _huge_ undertaking, and one of the
> things that Alan complained about was how the fact that _I_ avoid scaling
> meant that he had to scale more. I think it's a very valid complaint, and
> it may make a whole lot more sense (if it is possible) to have different
> people caring about different parts.

I had anticipated this. If other projects I work on have to suffer, so be it.
To reiterate.. for as long as I find it a fun thing to do.

> > "Used to" ? cvs @ vger.samba.org was still being maintained before
> > I went on xmas vacation. Did I miss something ?
> Does he allow the wide and uncoordinated write access that he used to
> allow? I thought he basically shut that down, and only allows a few people
> now, exactly to avoid getting too horrible merge issues..

Sounds accurate. But for the net layer & Sparc arch, it's certainly
proved invaluable. Not only for anyone wanting inside-info on whats
in Davem's queue, but also probably for Davem himself.

Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

