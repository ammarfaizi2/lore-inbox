Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSFSWjU>; Wed, 19 Jun 2002 18:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318041AbSFSWjS>; Wed, 19 Jun 2002 18:39:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28800 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318040AbSFSWjR>;
	Wed, 19 Jun 2002 18:39:17 -0400
Date: Thu, 20 Jun 2002 00:37:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield() 
In-Reply-To: <Pine.LNX.3.96.1020619181429.3743B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0206200032000.21435-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Jun 2002, Bill Davidsen wrote:

> [...] I'd like to see threads of a single process be able to get, use,
> and share a timeslice before some cpu hog comes in and get his
> timeslice.

there is no such concept as 'threads of a single process' in Linux, and
this is not just a naming difference. In Linux threads are threads, and
whether they share the same set of pagetables or not is secondary to the
kernel. (there are lots of other resources they might or might not share
between each other.)

the OS where processes 'own' threads, where the process is a container,
where this concept is pretty much the only meaningful multiprogramming
concept, and where the kernel API is separated into per-thread and
per-process parts is not called Linux.

	Ingo

