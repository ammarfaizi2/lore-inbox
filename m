Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318704AbSHLEfV>; Mon, 12 Aug 2002 00:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318705AbSHLEfV>; Mon, 12 Aug 2002 00:35:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29426 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318704AbSHLEfU>;
	Mon, 12 Aug 2002 00:35:20 -0400
Date: Mon, 12 Aug 2002 00:39:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Rob Landley <landley@trommello.org>, "H. Peter Anvin" <hpa@zytor.com>,
       "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: klibc development release
In-Reply-To: <Pine.LNX.4.44.0208112119540.25011-100000@waste.org>
Message-ID: <Pine.GSO.4.21.0208120001260.14833-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Aug 2002, Oliver Xymoron wrote:

> On Sun, 11 Aug 2002, Alexander Viro wrote:
> 
> > > What's wrong with LGPL?  I thought libraries were what it was originally
> >
> > klibc is static-only.  So for all practical purposes LGPL would be every bit
> > as viral as GPV itself.
> 
> You say that as if it were a bad thing.

I do.  I have no problems with people choosing whatever license they prefer
for their work and I have no problems with using GPL when I'm working on
projects that are already under it, but it's not the license I would choose
for my work in cases when I have a choice.

As for the "make the hardware work" code, there's nothing to stop people from
doing that _NOW_.  I'm not too fond of that, but as long as we are talking
about userland code it
	* will have to use normal system calls
	* will not have to link against any particular library, no matter
what we provide
	* will be up to those who write it and those who decide to use it.

We are talking about libc.  _Nothing_ in that code couldn't be reimplemented
by any half-competent programmer.  It's a textbook stuff.  Those who don't
like GPL would be trivially able to reimplement all these functions in their
own code anyway.  End of story.  Whatever license is chosen, it won't prevent
people from putting their code under any license they like.

There is a crucial difference from the situation with nVidia, Veritrash and
the rest of let's-bugger-the-kernel team.  _They_ want more than using
syscalls from user mode - they want an access to guts of the kernel and that's
a very different can of worms.  And _that_ I have problems with.  A lot.
Especially when they expect us to abstain from changes of kernel internals
that might break their junk and when they whine when such changes are done.

People do have a right to put their code under whatever license they like.
Now, _I_ won't use the stuff I don't have a source for unless I have
exceptionally good reason to believe that authors of that stuff are
among the few percents of programmers who *can* find their arse without
outside help.  But that has nothing to do with licensing or any moral
considerations and everything to the fact that I know what kind of crap
most of the software is.

