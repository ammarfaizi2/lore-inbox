Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbSKTHVS>; Wed, 20 Nov 2002 02:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267637AbSKTHUQ>; Wed, 20 Nov 2002 02:20:16 -0500
Received: from dp.samba.org ([66.70.73.150]:56531 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267638AbSKTHTt>;
	Wed, 20 Nov 2002 02:19:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matt Reppert <arashi@arashi.yi.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mii module broken under new scheme 
In-reply-to: Your message of "Tue, 19 Nov 2002 13:44:40 CDT."
             <3DDA8698.7050006@pobox.com> 
Date: Wed, 20 Nov 2002 09:07:53 +1100
Message-Id: <20021120072654.272252C082@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3DDA8698.7050006@pobox.com> you write:
> The promise of minimal driver breakage is rapidly fading away.

Perhaps: but this, at least, is being fixed by having a "finishing"
step for modules.  And it *did* catch three "modules" that weren't
really, so it's not completely useless.

Think back: who in their right mind would compile and test patches to
a rapidly-changing kernel, when those changes required userspace tool
changes and you didn't know if it was going to go in or not?  If you
care about modules in 2.5, you're probably a developer who needs
modules to do their job, so why rock the boat?

So I had to make a number of judgement calls without *any* input from
anyone else.  This was one: change the makefiles to add an extra step,
or require modules to say "I really am a module, not some random
object file".

On the one hand I've been trying to feed this to Linus slowly so that
*now* lkml can give feedback, on the other hand, fend of those who are
complaining that their needed feature isn't back in yet.

You've seen some of my decisions reversed already: noone wishes more
than me this had happened months ago 8(

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
