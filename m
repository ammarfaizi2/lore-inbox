Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131262AbRAJL03>; Wed, 10 Jan 2001 06:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132541AbRAJL0U>; Wed, 10 Jan 2001 06:26:20 -0500
Received: from chiara.elte.hu ([157.181.150.200]:59404 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131262AbRAJL0Q>;
	Wed, 10 Jan 2001 06:26:16 -0500
Date: Wed, 10 Jan 2001 12:25:52 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <3A5C2034.537B4C58@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0101101222540.833-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Jan 2001, Manfred Spraul wrote:

> That means sendmsg() changes the page tables? I measures
> smp_call_function on my Dual Pentium 350, and it took around 1950 cpu
> ticks.

well, this is a performance problem if you are using threads. For normal
processes there is no need for a SMP cross-call, there TLB flushes are
local only.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
