Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264002AbSIQJqX>; Tue, 17 Sep 2002 05:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264004AbSIQJqW>; Tue, 17 Sep 2002 05:46:22 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29079 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264002AbSIQJqV>;
	Tue, 17 Sep 2002 05:46:21 -0400
Date: Tue, 17 Sep 2002 11:57:45 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG(): sched.c: Line 944
In-Reply-To: <1032253191.4592.15.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0209171153050.7096-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 17 Sep 2002, Robert Love wrote:

[...]
> Now, remind me why this is all worth it...

having preemption support that 1) is correct 2) works?

We *must* use the schedule() check to debug preemption bugs, or we wont
have usable preemption in 2.6, i dont really understand why your are not
happy that we have such a great tool. In fact we should also add other
debugging bits, like 'check for !0 preemption count in smp_processor_id()'
, and the underflow checks that caught the IDE bug. These are all bits
that help the elimination of preemption bugs which are also often SMP
bugs, on plain UP boxes.

	Ingo

