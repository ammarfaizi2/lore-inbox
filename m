Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261326AbSIWTyK>; Mon, 23 Sep 2002 15:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261391AbSIWTyJ>; Mon, 23 Sep 2002 15:54:09 -0400
Received: from smtpout.mac.com ([204.179.120.87]:29437 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261326AbSIWTyI>;
	Mon, 23 Sep 2002 15:54:08 -0400
Date: Mon, 23 Sep 2002 21:59:22 +0200
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
To: Larry McVoy <lm@bitmover.com>
From: Peter Waechtler <pwaechtler@mac.com>
In-Reply-To: <20020923083004.B14944@work.bitmover.com>
Message-Id: <F425930C-CF2E-11D6-8873-00039387C942@mac.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Am Montag den, 23. September 2002, um 17:30, schrieb Larry McVoy:

>>> Instead of taking the traditional "we've screwed up the normal system
>>> primitives so we'll event new lightweight ones" try this:
>>>
>>> We depend on the system primitives to not be broken or slow.
>>>
>>> If that's a true statement, and in Linux it tends to be far more true
>>> than other operating systems, then there is no reason to have M:N.
>>
>> No matter how fast you do context switch in and out of kernel and a 
>> sched
>> to see what runs next, it can't be done as fast as it can be avoided.
>
> You are arguing about how many angels can dance on the head of a pin.
> Sure, there are lotso benchmarks which show how fast user level threads
> can context switch amongst each other and it is always faster than going
> into the kernel.  So what?  What do you think causes a context switch in
> a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%
> of the time?  And doesn't that mean you already went into the kernel to
> see if the I/O was ready?  And doesn't that mean that in all the real
> world applications they are already doing all the work you are arguing
> to avoid?

Getting into kernel is not the same as a context switch.
Return EAGAIN or EWOULDBLOCK is definetly _not_ causing a context switch.

Is sys_getpid() causing a context switch? Unlikely
Do you know what blocking IO means?  M:N is about to avoid blocking IO!

