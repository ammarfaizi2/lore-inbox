Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVLUNCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVLUNCz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVLUNCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:02:54 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:1516 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932398AbVLUNCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:02:54 -0500
Date: Wed, 21 Dec 2005 08:02:27 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Ingo Molnar <mingo@elte.hu>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Christoph Lameter <christoph@lameter.com>,
       Alok N Kataria <alokk@calsoftinc.com>,
       Shobhit Dayal <shobhit@calsoftinc.com>,
       Shai Fultheim <shai@scalex86.org>, Matt Mackall <mpm@selenic.com>,
       Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 00/02] SLOB optimizations
In-Reply-To: <20051221065619.GC766@elte.hu>
Message-ID: <Pine.LNX.4.58.0512210752090.28477@gandalf.stny.rr.com>
References: <1134860251.13138.193.camel@localhost.localdomain>
 <20051220133230.GC24408@elte.hu> <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
 <20051220135725.GA29392@elte.hu> <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
 <1135093460.13138.302.camel@localhost.localdomain> <20051220181921.GF3356@waste.org>
 <1135106124.13138.339.camel@localhost.localdomain>
 <84144f020512201215j5767aab2nc0a4115c4501e066@mail.gmail.com>
 <1135114971.13138.396.camel@localhost.localdomain> <20051221065619.GC766@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Ingo Molnar wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > [...] Today's slab system is starting to become like the IDE where
> > nobody, but a select few sado-masochis, dare to venture in. (I've CC'd
> > them ;) [...]
>
> while it could possibly be cleaned up a bit, it's one of the
> best-optimized subsystems Linux has. Most of the "unnecessary
> complexity" in SLAB is related to a performance or a debugging feature.
> Many times i have looked at the SLAB code in a disassembler, right next
> to profile output from some hot workload, and have concluded: 'I couldnt
> do this any better even with hand-coded assembly'.

Exactly my point!  The complexity of SLAB keeps it at the "I could not do
it better myself" catagory.  This wasn't suppose to be a bash, it was
actually a complement.  But things in the "I could not do it better
myself" catagory are usually very hard to modify.  Because, unless you are
at the level of genius of those that wrote it, you may easily break it.
Or put it to a level of "Ha, I can do this better".

 >
> SLAB-bashing has become somewhat fashionable, but i really challenge
> everyone to improve the SLAB code first (to make it more modular, easier
> to read, etc.), before suggesting replacements.

I perfectly agree with this statement.  As I mentioned earlier, it may
have been different if I was a part of the changes that were made.  But I
wasn't, and that leaves me the task to figure out why things were done the
way they were done.  Before changes can be made, one must have a full
understanding of why things exist as it does.

Don't get me wrong, my comments are more of a frustration with myself that
I'm having trouble understanding all that's in SLAB.  I understand the
SLAB concept, but I'm having trouble with understanding the current
implementation.  That's _my_ problem.  But I will continue to work at it,
and maybe I will be able to produce some clean up patches once I do
understand.

>
> the SLOB is nice because it gives us a simple option at the other end of
> the complexity spectrum. The SLOB should remain there. (but it certainly
> makes sense to make it faster, within certain limits, so i'm not
> opposing your SLOB patches per se.)
>

I like the SLOB code, because it was simple enough for my mortal mind.  I
actually started to play with it to get a better understanding of the way
the SLAB works.  It has actually helped in that catagory.

-- Steve

