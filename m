Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282090AbRKWJOO>; Fri, 23 Nov 2001 04:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282089AbRKWJOE>; Fri, 23 Nov 2001 04:14:04 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:40641 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S281823AbRKWJNt>; Fri, 23 Nov 2001 04:13:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: Charles Marslett <cmarslett9@cs.com>
Subject: Re: Swap vs No Swap.
Date: Fri, 23 Nov 2001 09:13:49 +0000
X-Mailer: KMail [version 1.3.1]
Cc: war <war@starband.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166wPI-0005yT-00@mauve.csi.cam.ac.uk> <3BFDECF2.CAE1ECC7@cs.com>
In-Reply-To: <3BFDECF2.CAE1ECC7@cs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E167CP4-00049I-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 November 2001 6:30 am, Charles Marslett wrote:
> James A Sutherland wrote:
> > On Thursday 22 November 2001 4:00 pm, war wrote:
> > > Incorrect, my point is I have enough ram where I am not going to run
> > > out for the things I do.
> >
> > There's more to it than "not run out". You have some fixed amount of RAM;
> > if the VM is working properly, adding swap will IMPROVE performance,
> > because that fixed amount of RAM is used more efficiently.
> >
> > Obviously, there are cases where removing swap breaks the system
> > entirely, but even in other cases, adding swap should *never* degrade
> > performance. (In theory, anyway; in practice, it still needs tuning...)
> >
> > > Using swap simply slows the system down!
> >
> > In which case, the VM isn't working properly; it SHOULD page out
> > infrequently used data to make more room for caching frequently used
> > files.
> >
> > James.
>
> I disagree.  It is true that a VM could be designed sufficiently complex
> that it would properly analyze every possible sequence of execution and
> have perfect prescience.  It would probably take a few hundred gigabytes of
> table structure to do that and that in itself will slow down the VM just
> scanning those tables, I dare say.

That wasn't quite what I had in mind :)

> In short, no VM is going to work perfectly -- it is extrapolating a model
> of behavior to a real world sequence of events and as such there will
> always be some real world set of programs and events that will make it
> worse than some other model of behavior (VM), including the one that never
> pages at all.  We just want that to happen rarely (whatever that means).

Yes, sometimes you'll get better behaviour in a specific case by "disabling" 
swap (i.e. forcing the kernel to page code instead), which in other cases 
causes nasty disk thrashing. In this case, though, I think the VM could do a 
much better job than it does presently; I've a feeling Rik's would perform 
better in this case, for example...

> A VM that is working properly is one that satisfies the beholder (sort of
> like beauty).  And in fact, if you look at the various similar discussions
> on Microsoft newsgroups (sorry ;-), you may notice they don't seem to be
> able to come up with a mechanism that handles large uniform access working
> sets and still works well with "normal" (highly peaked) working sets.  So I
> doubt it is an easy problem.

Nobody said VM coding was easy - or that Microsoft had got it right :)


James.
