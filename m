Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284931AbRLFCP7>; Wed, 5 Dec 2001 21:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284934AbRLFCPt>; Wed, 5 Dec 2001 21:15:49 -0500
Received: from [202.135.142.195] ([202.135.142.195]:49924 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S284931AbRLFCPf>;
	Wed, 5 Dec 2001 21:15:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] scalable timers implementation, 2.4.16, 2.5.0 
In-Reply-To: Your message of "Wed, 05 Dec 2001 14:13:17 -0800."
             <3C0E9BFD.BC189E17@zip.com.au> 
Date: Thu, 06 Dec 2001 13:15:42 +1100
Message-Id: <E16Bo4c-00031f-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3C0E9BFD.BC189E17@zip.com.au> you write:
> Rusty Russell wrote:
> > 
> > PS.  Also would be nice to #define del_timer del_timer_sync, and have a
> >      del_timer_async for those (very few) cases who really want this.
> 
> That could cause very subtle deadlocks.   I'd prefer to do:
> 
> #define del_timer_async	del_timer

I'd prefer to audit them all, create a patch, and remove del_timer.
Doing it slowly usually means things just get forgotten, then hacked
around when it finally gets ripped out.

The deadlock you're referring to is, I assume, del_timer_sync() called
inside the timer itself?  Can you think of any other dangerous cases?

Rusty.
--
  Anyone who quotes me is an idiot. -- Rusty Russell.
