Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264765AbTBTWgZ>; Thu, 20 Feb 2003 17:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264754AbTBTWgY>; Thu, 20 Feb 2003 17:36:24 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4626 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265807AbTBTWet>; Thu, 20 Feb 2003 17:34:49 -0500
Date: Thu, 20 Feb 2003 14:40:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201428540.1159-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201438150.1671-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:
> 
> Suggested patch (against current BK, which has the finish_task_switch() 
> cleanups I mentioned earlier) appended. No special cases, nu subtlety with 
> __put_task_struct() caches, no nothing.

Yeah, don't bother to tell me it doesn't work. We need the task pointer to
include information on _both_ "I'm still using it" (the task itself) _and_
the "I'm waiting for it" case. So it's not just a matter of moving the
put_task() thing around, it needs to get the accounting right..

		Linus

