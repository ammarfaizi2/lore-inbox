Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbTETADa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTETADa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:03:30 -0400
Received: from dp.samba.org ([66.70.73.150]:3984 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262426AbTETAD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:03:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Mon, 19 May 2003 11:31:51 +0200."
             <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain> 
Date: Tue, 20 May 2003 10:04:31 +1000
Message-Id: <20030520001623.715822C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0305191103500.5653-100000@localhost.localdomain> you write:
> 
> the attached patch addresses a futex related SMP scalability problem of
> glibc. A number of regressions have been reported to the NTPL mailing list
> when going to many CPUs, for applications that use condition variables and
> the pthread_cond_broadcast() API call. Using this functionality, testcode
> shows a slowdown from 0.12 seconds runtime to over 237 seconds (!)  
> runtime, on 4-CPU systems.

I gave feedback on this before, but didn't get a response.

1) Overload the last futex arg (change from timeval * to void *),
   don't add YA arg at the end.

2) Use __alignof__(u32) not sizeof(u32).  Sure, they're the same, but
   you really mean __alignof__ here.

I'm glad you finally put your name at the top of the file...

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
