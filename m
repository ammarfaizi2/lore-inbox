Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266897AbSKOXky>; Fri, 15 Nov 2002 18:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266928AbSKOXky>; Fri, 15 Nov 2002 18:40:54 -0500
Received: from are.twiddle.net ([64.81.246.98]:10630 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266897AbSKOXkw>;
	Fri, 15 Nov 2002 18:40:52 -0500
Date: Fri, 15 Nov 2002 15:47:47 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: in-kernel linking issues
Message-ID: <20021115154747.B25789@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org
References: <20021115142226.B25624@twiddle.net> <20021115230536.6C9982C10F@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021115230536.6C9982C10F@lists.samba.org>; from rusty@rustcorp.com.au on Sat, Nov 16, 2002 at 09:45:21AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 09:45:21AM +1100, Rusty Russell wrote:
> > Actually, I've yet to come across one that is adversely affected.
> > Note that we're putting code _not_ compiled with -fpic into this
> > shared object.
> 
> Hmm, OK, I'm officially confused: I always connected the two.

I encorage this view.  Normally bad things happen when this rule is
not followed in userland.  But the kernel can bend the rules a bit.

> Of course.  And ia64's module.c is about 500 lines (vs 130 for x86).
> It's probably the worst case unless Alpha proves to be a complete pig
> (note: ia64 might be missing some other stuff, but the linker is
> tested).

The ia64 code you have isn't going to be reliable until the
other points I mentioned wrt section and common symbol sorting
are done.  What you have will work until there's a large 
variable (32k for alpha/mips, 1MB for ia64) in the data area.

> Hmm, OK, I guess this is where I say "patch welcome"?

I guess this is where I say "patch for what"?  Do I have some
amount of buy-in for the shared library approach, or do I start
adding lots of code to your .o linker?

I guess I could work up a proof-of-concept patch for the former
and see what people think...


r~
