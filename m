Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266924AbSKOW6m>; Fri, 15 Nov 2002 17:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSKOW6m>; Fri, 15 Nov 2002 17:58:42 -0500
Received: from dp.samba.org ([66.70.73.150]:42404 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266924AbSKOW6j>;
	Fri, 15 Nov 2002 17:58:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues 
In-reply-to: Your message of "Fri, 15 Nov 2002 14:22:26 -0800."
             <20021115142226.B25624@twiddle.net> 
Date: Sat, 16 Nov 2002 09:45:21 +1100
Message-Id: <20021115230536.6C9982C10F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021115142226.B25624@twiddle.net> you write:
> On Sat, Nov 16, 2002 at 08:21:32AM +1100, Rusty Russell wrote:
> > AFAICT, that would hurt some archs.  Of course, you could say "modules
> > are meant to be slow" but I don't think that would win you any
> > friends 8)
> 
> Actually, I've yet to come across one that is adversely affected.
> Note that we're putting code _not_ compiled with -fpic into this
> shared object.

Hmm, OK, I'm officially confused: I always connected the two.

> > Note: "extreme reduction" is probably overstating.  There are only
> > about 300 lines of linker code in the kernel (x86).
> 
> Note that x86 is the easiest possible case.

Of course.  And ia64's module.c is about 500 lines (vs 130 for x86).
It's probably the worst case unless Alpha proves to be a complete pig
(note: ia64 might be missing some other stuff, but the linker is
tested).

> You've only got two relocation types, you don't need to worry about
> .got, .plt, .opd allocation, nor sorting sections into a required
> order, nor sorting COMMON symbols.

Hmm, OK, I guess this is where I say "patch welcome"?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
