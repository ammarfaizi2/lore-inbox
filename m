Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSKNBaZ>; Wed, 13 Nov 2002 20:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSKNBaZ>; Wed, 13 Nov 2002 20:30:25 -0500
Received: from dp.samba.org ([66.70.73.150]:61317 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261302AbSKNBaY>;
	Wed, 13 Nov 2002 20:30:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] smp_init 'CPUS done' looks strange 
In-reply-to: Your message of "Wed, 13 Nov 2002 08:22:28 CDT."
             <Pine.LNX.4.44.0211130820410.24523-100000@montezuma.mastecende.com> 
Date: Thu, 14 Nov 2002 12:59:07 +1100
Message-Id: <20021114013718.0AE592C19D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211130820410.24523-100000@montezuma.mastecende.com> 
you write:
> On Wed, 13 Nov 2002, Rusty Russell wrote:
> 
> > In message <Pine.LNX.4.44.0211122246540.24523-100000@montezuma.mastecende.c
om> 
> > you write:
> > > Also, it would make sense in the future if smp_cpus_done actually gets a 
> > > value denoting how many cpus are online.
> > 
> > No.  Drop the prink by all means, but smp_cpus_done() can call
> > num_online_cpus() itself.  It can't know how many cpus the user
> > specified, however.
> 
> Doesn't that just encourage more (i = 0; i < NR_CPUS; i++) usage? If you 
> make max_cpus available to everyone, at least they'll have the correct cpu 
> count to check against. max_cpus is needed by more than bootup.

1) CPUs can be nonlinear.
2) They can bring CPUs up after boot.

AM has some cpu iterator patches for those who really care about
efficiently iterating over only online cpus, or only possible cpus.

Hope that helps,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
