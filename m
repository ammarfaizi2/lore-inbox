Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318322AbSGYAgF>; Wed, 24 Jul 2002 20:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318323AbSGYAgF>; Wed, 24 Jul 2002 20:36:05 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4540 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318322AbSGYAgE>;
	Wed, 24 Jul 2002 20:36:04 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org
Subject: Re: per-cpu data... 
In-reply-to: Your message of "Wed, 24 Jul 2002 13:31:29 +0100."
             <20020724133128.A7192@kushida.apsleyroad.org> 
Date: Thu, 25 Jul 2002 10:28:13 +1000
Message-Id: <20020725004020.7D20644FB@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020724133128.A7192@kushida.apsleyroad.org> you write:
> Rusty Russell wrote:
> > (From my reading, ## on "int x" and "__per_cpu" is well-defined).
> 
>   DECLARE_PER_CPU (int x[3]);
> 
> doesn't work, although you can always do
> 
>   typedef int three_ints_t[3];
>   DECLARE_PER_CPU (three_ints_t x);
> 
> I encountered the same thing while doing a user-space
> `MAKE_THREAD_SPECIFIC' macro.  The solution I went for looks like this:
> 
>   #define DECLARE_PER_CPU(type, name) \
>     __attribute__ ((__section (".percpu"))) __typeof__ (type) name##__per_cpu

Hmmm.... Yeah, might as well go the whole way.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
