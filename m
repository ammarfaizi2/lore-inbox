Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154081AbQBLWlV>; Sat, 12 Feb 2000 17:41:21 -0500
Received: by vger.rutgers.edu id <S153996AbQBLWYV>; Sat, 12 Feb 2000 17:24:21 -0500
Received: from [207.181.251.162] ([207.181.251.162]:1633 "EHLO bitmover.com") by vger.rutgers.edu with ESMTP id <S154584AbQBLWGx>; Sat, 12 Feb 2000 17:06:53 -0500
Message-Id: <200002130207.SAA31705@work.bitmover.com>
To: Zachary Amsden <zamsden@cthulhu.engr.sgi.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Scheduled Transfer Protocol on Linux 
In-Reply-To: Your message of "Sat, 12 Feb 2000 16:42:53 PST." <200002130042.QAA22405@clock.engr.sgi.com> 
Date: Sat, 12 Feb 2000 18:07:26 -0800
From: Larry McVoy <lm@bitmover.com>
Sender: owner-linux-kernel@vger.rutgers.edu

: > OK, so tell me: how many locks does it take to scale up the following to
: > 16 CPUs:
: > 	local disks
: > 	local file system
: > 	remote file system
: > 	processes
: > 	networking interfaces and stack
: >
: > What do the locks cover?  At 16 CPUs, can you keep all the locks straight
: > in your head?  Nope.  So what happens when you go into the kernel and add
: > a feature?  You add a lock.  What does that do?  Increases the number of
: > locks.  What effect does that have?  Makes it more likely that you'll add
: > more locks, because now it is even less obvious what the lock protects.
: 
: Good design can avoid these problems.  If it isn't obvious what a lock 
: protects, you should rethink your locking structure.

I notice that you didn't actually answer any of the questions above, just
a nice hand wave that says "it need not be so".  Well, just to indulge
me, could you please either:

    a) answer the questions above, or
    b) show a shipping, production system which demonstrates your claims, or
    c) admit that you don't know the answer.

: I wasn't arguing that 16 way SMP is OK.  Everyone knows it isn't.

Geez, and this from the guy who said Linux needs to support "16-64 way SMP".

: Are you saying that clusters of small SMP machines are better?  

read these:
	http://www.bitmover.com/llnl/smp.pdf
	http://www.bitmover.com/llnl/labs.pdf

: So the locking 
: moves from the kernels to the application layer.  You still have the same 
: synchronization concerns, it's just a matter of what layer they are 
: implemented at.

Err, if you had actually done this, you'd find that your statements
are unsupportable in practice.  Please show me an application that has
anything, even with an order of magnitude, like the number of locks
taken/released per second in IRIX or Solaris.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
