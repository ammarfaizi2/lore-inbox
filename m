Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267599AbTBEAKB>; Tue, 4 Feb 2003 19:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTBEAKB>; Tue, 4 Feb 2003 19:10:01 -0500
Received: from dp.samba.org ([66.70.73.150]:64981 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267599AbTBEAJ7>;
	Tue, 4 Feb 2003 19:09:59 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module alias and device table support. 
In-reply-to: Your message of "Tue, 04 Feb 2003 10:56:07 BST."
             <200302040956.h149u8IR021827@eeyore.valparaiso.cl> 
Date: Wed, 05 Feb 2003 11:00:01 +1100
Message-Id: <20030205001934.1C3BA2C6BA@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200302040956.h149u8IR021827@eeyore.valparaiso.cl> you write:
> Rusty Russell <rusty@rustcorp.com.au> said:
> > "insmod foo" will *always* get foo.  The only exception is when "foo"
> > doesn't exist, in which case modprobe looks for another module which
> > explicitly says it can serve in the place of foo.
> 
> OK.
> 
> > This allows smooth transition when a driver is superceded, *if* the
> > new author wants it.
> 
> I would't let this happen, ever. What if foo does exist and Aunt Tillie
> just didn't compile it?

Then they turned the config option off themselves.

> > Now, the netlink module *knows* it provides char-major-36: with
> > MODULE_ALIAS() it can say so.
> 
> The "provides" is the missing clue... You are taking about "provides" (and
> mixing it up with "alias", something I still can't agree on), I'm talking
> about "alias". Maybe they should be separate? In your examples netlink
> _provides_ char-major-36, xyz3000 _provides_ binfmt-754, eepro100 _aliases_
> to eth0 here. First use is clearly in-kernel, second one is (or should
> always be IMVHO) out-of-kernel. Sure, could use the same infrastructure for
> simplicity.

That's a different debate.

This is how it works today, and how it has worked since before 2.2.
If you want to argue that another mechanism should be used instead,
that's a completely different issue (and not neccessarily something I
would disagree with, especially since hotplug is now a first class
citizen).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
