Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268165AbTCFQol>; Thu, 6 Mar 2003 11:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268168AbTCFQol>; Thu, 6 Mar 2003 11:44:41 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37808 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S268165AbTCFQoj>;
	Thu, 6 Mar 2003 11:44:39 -0500
Date: Thu, 6 Mar 2003 17:54:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303060704580.7206-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0303061752010.13348-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Linus Torvalds wrote:

> We should notice automatically that X is "interactive", thanks to the
> fact that interactive tasks wait for it. That's the whole point of my
> very simple patch..

the whole compilation (gcc tasks) will be rated 'interactive' as well,
because an 'interactive' make process and/or shell process is waiting on
it. I tried something like this before, and it didnt work.

> So don't argue about things that are obviously broken. Renicing X is not
> the answer, and in fact there have been multiple reports that it makes
> XMMS skip sound because it just _hides_ the problem and moves it
> elsewhere.

the xine has been analyzed quite well (which is analogous to the XMMS
problem), it's not X that makes XMMS skip, it's the other CPU-bound tasks
on the desktops that cause it to skip occasionally. Increasing the
priority of xine to just -1 or -2 solves the skipping problem.

	Ingo

