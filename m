Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316874AbSE1SIk>; Tue, 28 May 2002 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316875AbSE1SIj>; Tue, 28 May 2002 14:08:39 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:21757 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316874AbSE1SIi>; Tue, 28 May 2002 14:08:38 -0400
Subject: Re: O(1) count_active_tasks()
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, torvalds@transmeta.com
In-Reply-To: <1022599985.20316.32.camel@sinai>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 11:08:35 -0700
Message-Id: <1022609318.20317.65.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 08:33, Robert Love wrote:

> If I get a chance, I'll run some tests on my dual 2.5 machine and see if
> they match.  But I would not let that stop anything ... this is mergable
> in 2.5 imo.

Well, I did some tests.  I changed count_active_tasks to calculate using
both methods and whine if they did not match.  I then put the machine
under extreme load with a lot of I/O.  Finally, I ran `uptime(1)' in a
tight loop and watched the console.

Over a long period of constant count_active_tasks calls via `uptime(1)',
I had only a couple messages.  This is most likely <=1% of the calls and
in each case we were one to high with the new method (140 vs 141, for
example).

Not sure why, or if it is even us or nr_running() or even the old method
that is off ... but who cares.  It is a statistic.

	Robert Love

