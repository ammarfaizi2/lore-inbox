Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318923AbSIJBee>; Mon, 9 Sep 2002 21:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSIJBea>; Mon, 9 Sep 2002 21:34:30 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47020 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318923AbSIJBe3>;
	Mon, 9 Sep 2002 21:34:29 -0400
Date: Mon, 9 Sep 2002 21:39:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Daniel Phillips <phillips@arcor.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Question about pseudo filesystems
In-Reply-To: <20020909235654.A5875@kushida.apsleyroad.org>
Message-ID: <Pine.GSO.4.21.0209092136190.4087-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Sep 2002, Jamie Lokier wrote:

> Daniel Phillips wrote:
> > > The expected behaviour is as it has always been: rmmod fails if anyone
> > > is using the module, and succeeds if nobody is using the module.  The
> > > garbage collection of modules is done using "rmmod -a" periodically, as
> > > it always has been.
> > 
> > When you say 'rmmod modulename' the module is supposed to be removed, if
> > it can be.  That is the user's expectation, and qualifies as 'obviously
> > correct'.
> > 
> > Garbage collecting should *not* be the primary mechanism for removing
> > modules, that is what rmmod is for.  Neither should a filesystem module
> > magically disappear from the system just because the last mount went
> > away, unless the module writer very specifically desires that.  This is
> > where the obfuscating opinion is coming from: Al has come up with an
> > application where he wants the magic disappearing behavior and wants
> > to impose it on the rest of the world, regardless of whether it makes
> > sense.

Huh?
 
> I think you've misunderstood.  The module does _not_ disappear when the
> last file reference is closed.  It's reference count is decremented,
> that is all.  Just the same as if you managed the reference count
> yourself.  You still need rmmod to actually remove the module.

Never let the facts to stand in a way of a rant.  Or presume that ability to
write implies ability to read, for that matter...

