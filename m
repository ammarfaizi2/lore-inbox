Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319438AbSILFRf>; Thu, 12 Sep 2002 01:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319439AbSILFRf>; Thu, 12 Sep 2002 01:17:35 -0400
Received: from dsl-213-023-043-193.arcor-ip.net ([213.23.43.193]:65411 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319438AbSILFRe>;
	Thu, 12 Sep 2002 01:17:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [RFC] Raceless module interface
Date: Thu, 12 Sep 2002 06:11:55 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Oliver Neukum <oliver@neukum.name>,
       Roman Zippel <zippel@linux-m68k.org>, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
References: <Pine.GSO.4.21.0209112351210.11628-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0209112351210.11628-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pLKe-0007ds-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 September 2002 05:53, Alexander Viro wrote:
> On Thu, 12 Sep 2002, Daniel Phillips wrote:
> 
> > On Thursday 12 September 2002 05:13, Rusty Russell wrote:
> > > B) We do not handle the "half init problem" where a module fails to load, eg.
> > > 	a = register_xxx();
> > > 	b = register_yyy();
> > > 	if (!b) {
> > > 		unregister_xxx(a);
> > > 		return -EBARF;
> > > 	}
> > >   Someone can start using "a", and we are in trouble when we remove
> > >   the failed module.
> > 
> > No we are not.  The module remains in the 'stopped' state
> > throughout the entire initialization process, as it should and
> > does, in my model.
> 
> Bzzzert.

Rusty, writing "Bzzzert" on lkml is juvenile, as is refering to your
peers as "shallow thinkers".  Ok, let's see if there is some content
in your post.

> At the very least, for block devices we need to be able to open
> disks during module initialization.

Huh?  Would you please back up and try to make a coherent point?
I'd love to point out why you're wrong, but you didn't actually
say anything.

> Al, fully expecting a stack of mind-boggling (and broken) kludges to be
> posted...

As I recall, you are the one who proposed eliminating the ability
to unload modules entirely, because you were not able to solve the
unload races.  It's a good thing that people with more sense
shouted you down.

Now, let's be civilized about this.  If you have points, make them,
we do not need them decorated with sound effects.

-- 
Daniel
