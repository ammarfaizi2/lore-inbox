Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268184AbTCFQyo>; Thu, 6 Mar 2003 11:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268190AbTCFQyn>; Thu, 6 Mar 2003 11:54:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27652 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268184AbTCFQym>; Thu, 6 Mar 2003 11:54:42 -0500
Date: Thu, 6 Mar 2003 09:03:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@digeo.com>, <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <Pine.LNX.4.44.0303061752010.13348-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303060858120.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Mar 2003, Ingo Molnar wrote:
> 
> the whole compilation (gcc tasks) will be rated 'interactive' as well,
> because an 'interactive' make process and/or shell process is waiting on
> it.

No. The make that is waiting for it will be woken up _once_ - when the 
thing dies. Marking it interactive at that point is absolutely fine.

> I tried something like this before, and it didnt work.

You can't have tried it very hard.

In fact, you haven't apparently tried it hard enough to even bother giving
my patch a look, much less apply it and try it out.

> the xine has been analyzed quite well (which is analogous to the XMMS
> problem), it's not X that makes XMMS skip, it's the other CPU-bound tasks
> on the desktops that cause it to skip occasionally. Increasing the
> priority of xine to just -1 or -2 solves the skipping problem.

Are you _crazy_?

Normal users can't "just increase the priority". You have to be root to do 
so. And I already told you why it's only hiding the problem.

In short, you're taking a very NT'ish approach - make certain programs run 
in the "foreground", and give them a static boost because they are 
magically more important. And you're ignoring the fact that the heuristics 
we have now are clearly fundamentally broken in certain circumstances.

I've pointed out the circumstances, I've told you why it happens and when 
it happens, and you've not actually even answered that part. You've only 
gone "it's not a problem, you can fix it up by renicing every time you 
find a problem".

Get your head out of the sand, and stop this "nice" blathering.

			Linus

