Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262933AbSJOO7D>; Tue, 15 Oct 2002 10:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262937AbSJOO7D>; Tue, 15 Oct 2002 10:59:03 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32487 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262933AbSJOO7C>;
	Tue, 15 Oct 2002 10:59:02 -0400
Date: Tue, 15 Oct 2002 17:15:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: Use of yield() in the kernel
In-Reply-To: <200210151536.39029.baldrick@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0210151712520.13919-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 15 Oct 2002, Duncan Sands wrote:

> Maybe it is worth auditing the kernel source files using yield()?

most definitely.

> Here is the list of files using yield(), excluding non-i386 arch
> specific files:
> 
[...]
> mm/oom_kill.c

this one i think is OK.

> kernel/sched.c (in migration_call)

this is okay as well.

> kernel/softirq.c

these are okay too - both are nonperformance bits.

> arch/i386/mm/fault.c

okay as well, it's a last-ditch effort to not kill init, so yielding is
the right thing to do here.

the others i think should be fixed. (but there might be exceptions.)

	Ingo

