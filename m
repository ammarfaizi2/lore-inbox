Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285181AbRLFRty>; Thu, 6 Dec 2001 12:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285185AbRLFRto>; Thu, 6 Dec 2001 12:49:44 -0500
Received: from ip216-26-43-158.dsl.du.teleport.com ([216.26.43.158]:25843 "EHLO
	w-gerrit2") by vger.kernel.org with ESMTP id <S285181AbRLFRth>;
	Thu, 6 Dec 2001 12:49:37 -0500
To: Henning Schmiedehausen <hps@intermeta.de>
cc: mjbligh@linux.ibm.com, Larry McVoy <lm@bitmover.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gerrit@us.ibm.com>
From: Gerrit Huizenga <gerrit@us.ibm.com>
Subject: Re: SMP/cc Cluster description [was Linux/Pro] 
In-Reply-To: Your message of Thu, 06 Dec 2001 10:50:43 +0100.
             <1007632244.24677.1.camel@forge> 
Date: Thu, 06 Dec 2001 09:48:51 -0800
Message-Id: <E16C2dh-0000eb-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In message <1007632244.24677.1.camel@forge>, > : Henning Schmiedehausen writes:
> On Wed, 2001-12-05 at 22:14, Martin J. Bligh wrote:
> > > We don't agree on any of these points.  Scaling to a 16 way SMP pretty
> much
> > > ruins the source base, even when it is done by very careful people.
> >
> > I'd say that the normal current limit on SMP machines is 8 way.
> > But you're right, we don't agree.  Time will tell who was right.
> > When I say I'm interested in 16 way scalability, I'm not talking about
> > SMP, so perhaps we're talking at slightly cross purposes.
> 
> Well I do remember those Sequent Symmetry machines from university which
> scaled to 24 processors and more. If I remember correctly they ran 16x
> 386 and 8x 486 in a single box (under Dynix?)
> 
> Wasn't too much interested in that then. I was to busy toying with my
> Amiga. ;-)
> 
>      Regards
>           Henning

Actually, up to 30 cpus, mixing and matching pairs of 12 or 16 MHz 80386,
25 or 50 MHz 80486, or 60 MHz Pentiums on the same SMP bus (known as
the Symmetry 2000 series).  

NUMA-Q stuff went to 64 processors - with quad building blocks (4
identical processors) where you could mix and match Pentium Pro, Xeon,
Pentium III quads at various clock rates.

The internals of the OS looked a lot like any standard OS, with a few
pieces of secret sauce (e.g. the read-copy-update stuff - see
 sf.net/projects/lse, multiprocessor counters, etc.)  Code complexity
was not orders of magnitude higher to support these high end machines
with near linear scalability.  It had some areas that were more complex,
but you train your staff on the complexitities, and it becomes standard
practice.  Just like Linux is enormously more complex than the first DOS
OS's, DYNIX/ptx is somewhat more complex than Linux.  But is Linux already
so complex that no one can contribute?  I don't think so.  Could DOS
engineers contribute to Linux?  I think they have - with some updated
training and knowledge about the additional complexities.

I really don't think Larry's fears can only be solved by another new
OS rewrite.  In some cases, just awareness of how to use the next
level of complex technology is enough to evolve the programmer to the
next stage.  It is happening all the time.  Doesn't mean that a fresh
approach is bad, either.  But the premise that engineers will never be
smart enough to program for high count SMP is rediculous.  The level
of complexity just isn't that much higher than where we are today.

gerrit

