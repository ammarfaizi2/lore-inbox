Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267118AbSKMHJk>; Wed, 13 Nov 2002 02:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbSKMHJk>; Wed, 13 Nov 2002 02:09:40 -0500
Received: from dp.samba.org ([66.70.73.150]:57735 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267118AbSKMHJi>;
	Wed, 13 Nov 2002 02:09:38 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Users locking memory using futexes 
In-reply-to: Your message of "12 Nov 2002 18:06:24 -0000."
             <1037124384.8321.70.camel@irongate.swansea.linux.org.uk> 
Date: Wed, 13 Nov 2002 05:13:35 +1100
Message-Id: <20021113071630.376412C118@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1037124384.8321.70.camel@irongate.swansea.linux.org.uk> you write:
> On Tue, 2002-11-12 at 17:17, Rusty Russell wrote:
> > > Ouch!  It looks to me like userspace can use FUTEX_FD to lock many
> > > pages of memory, achieving the same as mlock() but without the
> > > resource checks.
> > > 
> > > Denial of service attack?
> > 
> > See "pipe".
> 
> Thats not an excuse. If the futex stuff allows arbitary memory locking
> and it isnt properly accounted then its a bug, with the added problem
> that its easier to havie nasty accidents with than pipes.

It's bounded by one page per fd.  If you want better than that, then
yes we'll need to thihk harder.

Frobbing futexes on COW and page-in/out is a possible solution, but
requires careful thought.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
