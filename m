Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290323AbSAPKfA>; Wed, 16 Jan 2002 05:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290393AbSAPKev>; Wed, 16 Jan 2002 05:34:51 -0500
Received: from oflmta01bw.bigpond.com ([139.134.6.21]:20204 "EHLO
	oflmta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S290323AbSAPKec>; Wed, 16 Jan 2002 05:34:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] I3 sched tweaks... 
In-Reply-To: Your message of "Wed, 16 Jan 2002 04:15:47 CDT."
             <Pine.LNX.4.33.0201160412180.24929-100000@devserv.devel.redhat.com> 
Date: Wed, 16 Jan 2002 21:34:39 +1100
Message-Id: <E16QnOx-0003vt-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.33.0201160412180.24929-100000@devserv.devel.redhat.com> 
you write:
> > 4) scheduler_tick needs no args (p is always equal to current).
> 
> i have not taken this part. We have 'current' calculated in
> update_process_times(), so why not pass it along to the scheduler_tick()
> function?

Because it's redundant.  It's *always* p == current (and the code
assumes this!), but I had to grep the callers to find out.

Moreover, the function doesn't make *sense* if p != current...

> > 3) lock_task_rq returns the rq, rather than assigning it, for clarity.
>
> i've made it an inline function instead of a macro.

I thought of that, but assumed you had a good reason for making it a
macro in the first place...

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
