Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288955AbSAIT0x>; Wed, 9 Jan 2002 14:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSAIT0n>; Wed, 9 Jan 2002 14:26:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30649 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288955AbSAIT0h>;
	Wed, 9 Jan 2002 14:26:37 -0500
Date: Wed, 9 Jan 2002 22:24:00 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Mike Kravetz <kravetz@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
In-Reply-To: <Pine.LNX.4.40.0201090940490.1595-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201092218450.7442-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Jan 2002, Davide Libenzi wrote:

> the niced -20 vmstat has not been run for the whole test time and the
[...]

> Ingo for the duration of the test the `nice -n 20 vmstat -n 1` never
> run for about the 20 seconds. With the swap_cnt correction it ran for
> 5-6 times.

no wonder, it should be 'nice -n -20 vmstat -n 1'. And you should also do
a 'renice -20 $$ $PPID' before running vmstat. (if you are about to run
comparisons, i'd suggest the -G1 patch so you'll have all the recent
fixes.)

	Ingo

