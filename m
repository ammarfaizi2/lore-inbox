Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSDUHkH>; Sun, 21 Apr 2002 03:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSDUHkG>; Sun, 21 Apr 2002 03:40:06 -0400
Received: from pc132.utati.net ([216.143.22.132]:52378 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S291401AbSDUHkF>; Sun, 21 Apr 2002 03:40:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Jeff Garzik <garzik@havoc.gtf.org>
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Date: Sat, 20 Apr 2002 21:41:29 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <20020420182003.A18057@havoc.gtf.org> <E16ygxR-0000cY-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020421080030.44E2647B@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 06:34 pm, Daniel Phillips wrote:

> I'm not arguing that BK is not a good way to do the grunt maintainance
> work. I think it is, and that's great.  Heck, I'm not arguing against
> Bitkeeper *at all*.  I'm arguing against building the bitkeeper
> documentation into the kernel tree, giving the impression that Bitkeeper is
> *required* for submitting patches.

I'm under the impression that Linus specifically asked for that 
documentation, because BK is a tool he used that he was getting flooded with 
questions about.

The question isn't really whether BitKeeper is required for kernel 
development, it's a question of whether submitting patches to LINUS is 
required for kernel development.

It seems like the BitKeeper documentation belongs together with the other 
submitting patches documentation, and should be moved to the directory 
"Documentation/Linus".

I.E. explicitly, the Kernel is only interested in documenting bitkeeper to 
the extent we're documenting how Linus works.  (And it IS how Linus works.)

If you're going to argue about Linus being a single point of failure (and 
quite possibly a closed and irreproducible system for which we have not seen 
source code), that's a can of worms I'm staying well away from this time 
'round, thanks. :)

It might be a good idea if there was a Documentation/SubmittingPatches 
directory that mentioned where the various active high visibility trees are 
and what they're for (Linus's 2.5 tree, Dave Jones's tree, Marcelo's 2.4 
tree, and Alan Cox's come to mind.)  But that sort of wanders off into 
Maintainers land (to get USB patches in, send them to Greg KH, who  has this 
email address and whose bitkeeper tree can be pulled from...)  With all the 
maintenance issues that implies...

> > > The next question you might ask is: are there more BK patches or
> > > more Non-BK, in total, on and off lkml?  I don't have statistics at
> > > hand but I'm willing to bet that there are more BK patches, because
> > > that is how the bulk of the grunt tree maintainance is getting
> > > done these days.
> > >
> > > My conclusion: though there are more BK patches being applied to
> > > Linus's tree than non-BK,
> >
> > So... your conclusion is based on a guess which is based on a guess.
>
> Check it if you think I'm wrong.

I think he's saying that the burden of proof about there BEING a problem 
rests on the one who is complaining about the problem.  Complaining and then 
expecting other people to prove there ISN'T a problem is kind of impolite...

> > Even if your conclusion is correct (it might be), how do you use
> > that to support the argument that, less discussion occurs due to BK?
>
> We haven't established that, we do see a strong correlation.  But think.
> It's obvious anyway, why discuss anything in public when you don't have
> to?  Just push it straight to Linus's tree, why bother with formalities?
> It's so easy.

And this differs from emailing him a patch without cc'ing linux-kernel in 
what way?

Either you trust Linus's judgement about what patches to accept, or you use 
somebody else's tree.  Did I miss where voting on linux-kernel ever got a 
patch in that Linus didn't want to merge, or kept one out that he did?

And AFTER the merge, you still get to flame all you want.  And produce a 
better patch to "clean up" the old one the way Martin "cleaned" Andre's name 
right out of the maintainers file...

I seem to remember Al Viro taking a clue-by-four to Richard Gooch's head over 
devfs on a fairly regular basis, and it was generally about the stuff that 
had already made it into the tree, not about pending unmerged stuff.

The ONLY reduction in access I can see to Linus's pending unmerged patch 
queue is due to the fact that completed patches don't hang around unmerged 
for months at a time anymore.  And since Bitkeeper seems to have 
significantly contributed to lubricating Linus's in-box, I consider it a net 
benefit.

Yes, it's a proprietary tool with "source under glass" licensing, but it's 
basically a groupware application.  Linus might as well be using proprietary 
email software: as long as the email he sends and receives is still ascii 
text, I can't say it makes a difference to me.

Think data, not applications.  The kernel tarballs produced are completely 
independent of bitkeeper.  Patches contributed to the kernel tarballs have 
been made without bitkeeper for a decade, and can still be made and 
contributed without use of bitkeeper.  The data being transmitted starts and 
ends in the same open format as always (C source code in a filesystem->C 
source code in a tarball), and the process in between is well understood and 
could be done by hand (even with paper and pencil) if necessary.  Bitkeeper 
just helps Linus to scale.

Proprietary software sucks when you derive work from it in an exclusive and 
dependent way.  Then they own your derived work.  (Like a microsoft word file 
you wrote, which microsoft can charge you to access because they own word and 
your file is useless without it.)  When it's something you can use but don't 
have to, it's basically a service.  Not owning a service is unsuprising.

In this case, none of the Linux kernel's end product is derived from 
bitkeeper.  It's just using bitkeeper as an optional tool in the process of 
producing that work.  It's analogous to using a proprietary bios to boot your 
Linux kernel: if it causes a problem, it can be replaced without changing the 
kernel being booted in any way.

> > As I mentioned, most merging with Linus occured in private anyway.
> > If you want to argue against that, go ahead.  But don't try to blame
> > BitKeeper for it.
>
> I sense that the discussion of patches on lkml is in decline and I do
> blame Bitkeeper.  Think I'm being paranoid?  Prove me wrong.

I sense that the chronic memory management problems of early 2.4 have finally 
calmed down a bit, that 2.5 has opened so people have an outlet for CODE 
rather than just plans for code, and that rather a lot of the intellectual 
bandwidth of the list is currently devoted to keeping up with all the changes 
in 2.5 that have already been made or are immediately pending, rather than 
speculating about a future that hasn't been coded yet.  And that the best 
flamewar we've managed to come up with recently (before this one) has been 
about the IDE subsystem (far too technical for most people to get really 
upset about) rather than something juicy like CML2's use of a version of 
Python that Red Hat doesn't ship yet. :)

I also sense that it's spring, the weather's nice and the flowers are 
blooming, and certain people might be spending some of their time away from a 
computer in a way that isn't as much of an option in the winter...

Rob
