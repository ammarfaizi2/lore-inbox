Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282056AbRKWGdG>; Fri, 23 Nov 2001 01:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282074AbRKWGc4>; Fri, 23 Nov 2001 01:32:56 -0500
Received: from rly-ip01.mx.aol.com ([205.188.156.49]:63183 "EHLO
	rly-ip01.mx.aol.com") by vger.kernel.org with ESMTP
	id <S282056AbRKWGct>; Fri, 23 Nov 2001 01:32:49 -0500
Message-ID: <3BFDECF2.CAE1ECC7@cs.com>
Date: Thu, 22 Nov 2001 23:30:10 -0700
From: Charles Marslett <cmarslett9@cs.com>
X-Mailer: Mozilla 4.78 [en] (Windows NT 5.0; U)
X-Accept-Language: en,zh-TW,ja
MIME-Version: 1.0
To: James A Sutherland <jas88@cam.ac.uk>
CC: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap vs No Swap.
In-Reply-To: <3BFC5A9B.915B77DF@starband.net> <E166rbB-0005LC-00@mauve.csi.cam.ac.uk> <3BFD210F.58495F37@starband.net> <E166wPI-0005yT-00@mauve.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Apparently-From: Cmarslett9@cs.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James A Sutherland wrote:
> 
> On Thursday 22 November 2001 4:00 pm, war wrote:
> > Incorrect, my point is I have enough ram where I am not going to run out
> > for the things I do.
> 
> There's more to it than "not run out". You have some fixed amount of RAM; if
> the VM is working properly, adding swap will IMPROVE performance, because
> that fixed amount of RAM is used more efficiently.
> 
> Obviously, there are cases where removing swap breaks the system entirely,
> but even in other cases, adding swap should *never* degrade performance. (In
> theory, anyway; in practice, it still needs tuning...)
> 
> > Using swap simply slows the system down!
> 
> In which case, the VM isn't working properly; it SHOULD page out infrequently
> used data to make more room for caching frequently used files.
> 
> James.

I disagree.  It is true that a VM could be designed sufficiently complex that
it would properly analyze every possible sequence of execution and have perfect
prescience.  It would probably take a few hundred gigabytes of table structure
to do that and that in itself will slow down the VM just scanning those tables,
I dare say.

In short, no VM is going to work perfectly -- it is extrapolating a model of
behavior to a real world sequence of events and as such there will always be
some real world set of programs and events that will make it worse than some
other model of behavior (VM), including the one that never pages at all.  We
just want that to happen rarely (whatever that means).

A VM that is working properly is one that satisfies the beholder (sort of like
beauty).  And in fact, if you look at the various similar discussions on
Microsoft newsgroups (sorry ;-), you may notice they don't seem to be able
to come up with a mechanism that handles large uniform access working sets
and still works well with "normal" (highly peaked) working sets.  So I doubt
it is an easy problem.

--Charles
