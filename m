Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311180AbSDSGfB>; Fri, 19 Apr 2002 02:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSDSGfA>; Fri, 19 Apr 2002 02:35:00 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25575 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S311180AbSDSGfA>;
	Fri, 19 Apr 2002 02:35:00 -0400
Date: Fri, 19 Apr 2002 06:31:15 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] migration thread fix
In-Reply-To: <Pine.LNX.4.44.0204182043110.2453-100000@beast.local>
Message-ID: <Pine.LNX.4.44.0204190629360.3799-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 18 Apr 2002, Erich Focht wrote:

> The patch below applies to the 2.5.8 kernel. It does two things:
> 
> 1: Fixes a BUG in the migration threads: the interrupts MUST be disabled
> before the double runqueue lock is aquired, otherwise this thing will
> deadlock sometimes.
> 
> 2: Streamlines the initialization of migration threads. Instead of
> fiddling around with cache_deccay_ticks, waiting for migration_mask bits
> and relying on the scheduler to distribute the tasks uniformly among
> processors, it starts the migration thread on the boot cpu and uses it
> to reliably distribute the other threads to their target cpus.
> 
> Please consider applying it!

looks perfectly good to me. Even with wli's patch i saw some migration
thread initialization weirdnesses.

	Ingo

