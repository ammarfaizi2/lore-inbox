Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286925AbSAFCEH>; Sat, 5 Jan 2002 21:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286914AbSAFCDw>; Sat, 5 Jan 2002 21:03:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:9620 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286913AbSAFCDp>;
	Sat, 5 Jan 2002 21:03:45 -0500
Date: Sun, 6 Jan 2002 05:01:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201051753090.1607-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201060455560.4730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Davide Libenzi wrote:

> Ingo, you don't need that many queues, 32 are more than sufficent. If
> you look at the distribution you'll see that it matters ( for
> interactive feel ) only the very first ( top ) queues, while lower
> ones can very easily tollerate a FIFO pickup w/out bad feelings.

I have no problem with using 32 queues as long as we keep the code
flexible enough to increase the queue length if needed. I think we should
make it flexible and not restrict ourselves to something like word size.
(with this i'm not suggesting that you meant this, i'm just trying to make
sure.) I saw really good (behavioral, latency, not performance) effects of
the longer queue under high load, but this must be weighed against the
cache footprint of the queues.

	Ingo

