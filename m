Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319097AbSIKPcR>; Wed, 11 Sep 2002 11:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319113AbSIKPcR>; Wed, 11 Sep 2002 11:32:17 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56585 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S319097AbSIKPcQ>; Wed, 11 Sep 2002 11:32:16 -0400
Date: Wed, 11 Sep 2002 11:28:52 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
In-Reply-To: <E17oUnq-0006tg-00@starship>
Message-ID: <Pine.LNX.3.96.1020911111334.12605B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Sep 2002, Daniel Phillips wrote:

> > The expected behaviour is as it has always been: rmmod fails if anyone
> > is using the module, and succeeds if nobody is using the module.  The
> > garbage collection of modules is done using "rmmod -a" periodically, as
> > it always has been.

I can't disagree with any of that, but the idea of releasing resources
when they are not in use and preventing new use of the resource from the
time of the release request is hardly new to UNIX. It's exactly the way
filespace is treated when a file is unlinked while open.
 
> Al's analysis is all focussed on the filesystem case, where you can
> prove assertions about whether the subsystem defined by the module is
> active or not.  This doesn't cover the whole range of module applications.

Which if true doesn't preclude solving the problems it does address.

> There is a significant class of module types that must rely on sheduling
> techniques to prove inactivity.  My suggestion covers both, Al has his
> blinders on.

Clearly there are people who don't agree, and you don't help by insulting
them. I'd like a single solution, but it looks as if Al's idea will work
for filesystems, and it's relatively simple.
 
> Designs are not always correct just because they work.

Solutions which work are most certainly correct, and no degree of elegance
will make a non-working solution correct for any definition of correct I
use. I think you mean "optimal" here, and clearly an optimal solution is
simple, reliable, efficient, general, and easy to code and understand.
Anything less is subject to improvement, and that certainly applies to
module removal ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

