Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317263AbSILUdr>; Thu, 12 Sep 2002 16:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSILUdr>; Thu, 12 Sep 2002 16:33:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37264 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317263AbSILUdq>;
	Thu, 12 Sep 2002 16:33:46 -0400
Date: Thu, 12 Sep 2002 22:44:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Steven Cole <elenstev@mesatop.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>,
       Steven Cole <scole@lanl.gov>
Subject: Re: [PATCH] kernel BUG at sched.c:944! only with CONFIG_PREEMPT=y]
In-Reply-To: <1031862919.3770.103.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209122242300.21936-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12 Sep 2002, Robert Love wrote:

> While this sounds like a great debugging check, it is not useful in
> general since we surely have some bad code that calls schedule() with
> locks held.  Further, since the atomic accounting only includes locks if
> CONFIG_PREEMPT is set, you only see this with kernel preemption enabled.

it *is* a great debugging check, at zero added cost. Scheduling from an
atomic region *is* a critical bug that can and will cause problems in 99%
of the cases. Rather fix the asserts that got triggered instead of backing
out useful debugging checks ...

	Ingo

