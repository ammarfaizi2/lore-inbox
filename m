Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267562AbTBRCix>; Mon, 17 Feb 2003 21:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTBRCiw>; Mon, 17 Feb 2003 21:38:52 -0500
Received: from dp.samba.org ([66.70.73.150]:9963 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267562AbTBRCiv>;
	Mon, 17 Feb 2003 21:38:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Werner Almesberger <wa@almesberger.net>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       torvalds@tranmseta.com
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Mon, 17 Feb 2003 11:53:04 BST."
             <Pine.LNX.4.44.0302171112390.1336-100000@serv> 
Date: Tue, 18 Feb 2003 10:31:33 +1100
Message-Id: <20030218024852.9557D2C17F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302171112390.1336-100000@serv> you write:
> Maybe you could share a bit of your wisdom?
> 1. Doing the linking in userspace requires two steps, but I still don't 
> know what's so bad about it.
> 2. This still doesn't explain, why everything has to be moved into kernel, 
> why can't we move more into userspace?
> 3. You simply moved part of the query syscall functionality to 
> /proc/modules (which btw is still not enough to fix ksymoops).

I think you'd do far better to implement it yourself for half a dozen
architectures.  It's not my job to teach you things which can be
gained by reading the code and thinking a little.

We're going in a circle again.

> > The second change was the speed up one system of module locking in the
> > kernel which wasn't racy, and deprecate the other system which was
> > racy in 99% of its uses.  That is all.
> 
> Well, I'm not against optimizing the module locking (*), as we won't get 
> rid of it in the near feature, but it still has problems.
> 
> 1. It's adding complexity (however you implement it), I explained it in 
> detail and you still haven't told me, where I'm wrong.

No, it's exactly the same as before.  You can't see that, and I've
given up explaining it.

> 2. The module interface is incompatible with other kernel interfaces, I 
> tried to explain that in the mail from saturday, if you think I'm wrong, 
> your input is very welcome, but _please_ answer to that mail.

This problem is in your mind Roman.

Deal with it.

> > Did it solve all the races in the kernel?  Of course not.  But it's
> > simple to use, already well understood in the kernel, and avoids
> > massive changes.  It also allows connection tracking to be properly
> > modularized, which was my long-lost original purpose.
> 
> It's too much fun to quote Al here:

Quoting Al's rant isn't an argument.  It wasn't very coherent when he
wrote it, and it doesn't gain with repetition.

The code exists.  It's simple to use.

I give up.  You're killfiled again 8(
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
