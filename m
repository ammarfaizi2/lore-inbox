Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSKIEJS>; Fri, 8 Nov 2002 23:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264730AbSKIEJF>; Fri, 8 Nov 2002 23:09:05 -0500
Received: from dp.samba.org ([66.70.73.150]:22497 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264727AbSKIEJA>;
	Fri, 8 Nov 2002 23:09:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module loader against 2.5.46: 9/9 
In-reply-to: Your message of "Fri, 08 Nov 2002 09:35:16 -0000."
             <20021108093516.A15440@flint.arm.linux.org.uk> 
Date: Sat, 09 Nov 2002 14:01:22 +1100
Message-Id: <20021109041543.D3F902C283@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021108093516.A15440@flint.arm.linux.org.uk> you write:
> On Thu, Nov 07, 2002 at 10:08:24PM +1100, Rusty Russell wrote:
> > That explains it: I didn't think you were insane 8).  Thanks, I'll
> > move it to some other name which just does the "add symbols to oops"
> > minimum.
> 
> I doubt that we need all of the kallsyms data in the kernel as well (unless
> you're using kdb.)

Yes.  From my IDE oops dumper experience, you can get the required
kernel symbols down to 70k w/o kdb (it's about 380k as stands).  I
haven't made this optimization yet though.

> One of the things on my todo list is to look into a kallsyms replacement
> that allows cross-compilation (and actually allows kallsyms to work at
> all on ARM.)
> 
> ARM requires the ELF architecture private flags to be set correctly to link
> two objects together.  So there's two problems with the current setup:

Hmm, depends on state of module loader code.   If it goes in, you'll
be getting a new one anyway which doesn't have this problem (I use $CC
to create kallsyms.o which gets linked in).  Otherwise, yes.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
