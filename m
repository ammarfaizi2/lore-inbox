Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSKXWZ2>; Sun, 24 Nov 2002 17:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261733AbSKXWZY>; Sun, 24 Nov 2002 17:25:24 -0500
Received: from dp.samba.org ([66.70.73.150]:29867 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261742AbSKXWZU>;
	Sun, 24 Nov 2002 17:25:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       torvalds@transmeta.com
Subject: Re: calling schedule() from interupt context 
In-reply-to: Your message of "Fri, 22 Nov 2002 01:09:34 -0800."
             <20021122.010934.126934922.davem@redhat.com> 
Date: Mon, 25 Nov 2002 08:42:15 +1100
Message-Id: <20021124223234.7C5EB2C111@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021122.010934.126934922.davem@redhat.com> you write:
>    From: "dan carpenter" <error27@email.com>
>    Date: Fri, 22 Nov 2002 03:54:41 -0500
> 
>    module_put ==> put_cpu ==> preempt_schedule ==> schedule
> 
> Oh we can't kill module references from interrupts?

Err, no, that would be insane.  get_cpu() & put_cpu() should work
perfectly fine inside interrupts, no?

> Egads... that makes lots of the networking stuff
> nearly impossible as SKB's hold references to modules
> and thus skb freeing can thus put modules.

Relax: modular networking was one of my aims 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
