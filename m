Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTBUGuV>; Fri, 21 Feb 2003 01:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267183AbTBUGuV>; Fri, 21 Feb 2003 01:50:21 -0500
Received: from mx1.elte.hu ([157.181.1.137]:40664 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S267180AbTBUGuU>;
	Fri, 21 Feb 2003 01:50:20 -0500
Date: Fri, 21 Feb 2003 08:00:15 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201536010.1304-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302210758290.1701-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:

> > if possible i'd avoid putting more overhead into the scheduler - it's
> > clearly more performance-sensitive than the task create/exit path.
> 
> This is a single non-serializing bit test, and if it means that the task
> counters are _right_, that's definitely the right thing to do.

ok. Plus the wait_task_inactive() stuff was always a bit volatile. Now we
could in fact remove it from release_task(), right?

	Ingo

