Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289989AbSA3QyI>; Wed, 30 Jan 2002 11:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290153AbSA3Qwg>; Wed, 30 Jan 2002 11:52:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37832 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289989AbSA3Qv0>;
	Wed, 30 Jan 2002 11:51:26 -0500
Date: Wed, 30 Jan 2002 19:48:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Larry McVoy <lm@bitmover.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130084331.K23269@work.bitmover.com>
Message-ID: <Pine.LNX.4.33.0201301943050.11581-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Larry McVoy wrote:

> No.  What you described is diff/patch.  We have that already and if it
> really worked in all the cases there would be no need for BitKeeper to
> exist.  I'll be the first to admit that BK is too pedantic about
> change ordering and atomicity, but you need to see that there is a
> spectrum and if we slid BK over to what you described it would be a
> meaningless tool, it would basically be a lot of code implementing
> what people already do with diff/patch.

eg. i sent 8 different scheduler update patches 5 days ago:

 [patch] [sched] fork-fix 2.5.3-pre5
 [patch] [sched] yield-fixes 2.5.3-pre5
 [patch] [sched] SCHED_RR fix, 2.5.3-pre5
 [patch] [sched] set_cpus_allowed() fix, 2.5.3-pre5
 [patch] [sched] entry.S offset fix, 2.5.3-pre5.
 [patch] [sched] cpu_logical_map fixes, balancing, 2.5.3-pre5
 [patch] [sched] compiler warning fix, 2.5.3-pre3
 [patch] [sched] unlock_task_rq() cleanup, 2.5.3-pre3

these patches, while many of them are touching the same file (sched.c) are
functionally orthogonal, and can be applied in any order. Linus has
applied all of them, but he might have omitted any questionable one and
still apply the rest.

how would such changes be expressed via BK, and would it be possible for
Linus to reject/accept an arbitrary set of these patches?

	Ingo

