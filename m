Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSKLRRe>; Tue, 12 Nov 2002 12:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266631AbSKLRRe>; Tue, 12 Nov 2002 12:17:34 -0500
Received: from dp.samba.org ([66.70.73.150]:9696 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266622AbSKLRRd>;
	Tue, 12 Nov 2002 12:17:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: Re: Users locking memory using futexes 
In-reply-to: Your message of "Tue, 12 Nov 2002 03:46:48 -0000."
             <20021112034648.GA11766@bjl1.asuk.net> 
Date: Wed, 13 Nov 2002 04:17:47 +1100
Message-Id: <20021112172423.6E0322C27F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021112034648.GA11766@bjl1.asuk.net> you write:
> Perez-Gonzalez, Inaky wrote:
> > [...] each time you lock a futex you are pinning the containing page
> > into physical memory, that would cause that if you have, for
> > example, 4000 futexes locked in 4000 different pages, there is going
> > to be 4 MB of memory locked in [...]
> 
> Ouch!  It looks to me like userspace can use FUTEX_FD to lock many
> pages of memory, achieving the same as mlock() but without the
> resource checks.
> 
> Denial of service attack?

See "pipe".

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
