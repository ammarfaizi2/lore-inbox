Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbTBTXMO>; Thu, 20 Feb 2003 18:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265684AbTBTXMO>; Thu, 20 Feb 2003 18:12:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:14790 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264811AbTBTXMN>;
	Thu, 20 Feb 2003 18:12:13 -0500
Date: Fri, 21 Feb 2003 00:21:58 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302201428540.1159-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302210020490.6298-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Linus Torvalds wrote:

> > well, we can do the wait_task_inactive() in both cases - in
> > release_task(), and in __put_task_struct(). [in the release_task() path
> > that will just be a nop]. This further simplifies the patch.
> 
> I think the _real_ simplification is to just have the task switch do
> this in the tail:

if possible i'd avoid putting more overhead into the scheduler - it's
clearly more performance-sensitive than the task create/exit path.

	Ingo

