Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267158AbTBTVzJ>; Thu, 20 Feb 2003 16:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTBTVzJ>; Thu, 20 Feb 2003 16:55:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9663 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S267158AbTBTVzI>;
	Thu, 20 Feb 2003 16:55:08 -0500
Date: Thu, 20 Feb 2003 23:04:41 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <zwane@holomorphy.com>,
       <cw@f00f.org>, <linux-kernel@vger.kernel.org>, <mbligh@aracnet.com>,
       <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <20030220125021.03c6d39c.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302202303400.4661-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Andrew Morton wrote:

> Fixes two deadlocks in the scheduler exit path:
> 
> 1: We're calling mmdrop() under spin_lock_irq(&rq->lock).  But mmdrop
>    calls vfree(), which calls smp_call_function().  

this has been fixed in the -F3 scheduler patch.

	Ingo

