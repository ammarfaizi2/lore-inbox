Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319168AbSIMHI0>; Fri, 13 Sep 2002 03:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319196AbSIMHI0>; Fri, 13 Sep 2002 03:08:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:60617 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319168AbSIMHIZ>;
	Fri, 13 Sep 2002 03:08:25 -0400
Date: Fri, 13 Sep 2002 09:19:20 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Steven Cole <elenstev@mesatop.com>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Steven Cole <scole@lanl.gov>
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
In-Reply-To: <1031863543.3837.110.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209130914190.28568-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Sep 2002, Robert Love wrote:

> > it *is* a great debugging check, at zero added cost. Scheduling from an
> > atomic region *is* a critical bug that can and will cause problems in 99%
> > of the cases. Rather fix the asserts that got triggered instead of backing
> > out useful debugging checks ...
> 
> There are a lot of shitty drivers that this is going to catch. [...]

of course. And your point in making it in_interrupt() had what purpose -
hiding that tons of code breaks preemption? [and tons of code breaks on
SMP.] Your patch was removing precisely the tool that can be used to
improve SMP quality on UP boxes as well.

> [...] Yes, that is great... but we cannot BUG().  There really are a LOT
> of them. In the least, we need to show_trace().

yes. And we also need kallsyms and kksymoops in the kernel, so that people
can send in meaningful traces.

	Ingo

