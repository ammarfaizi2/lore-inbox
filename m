Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281128AbRKKWXN>; Sun, 11 Nov 2001 17:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281132AbRKKWXE>; Sun, 11 Nov 2001 17:23:04 -0500
Received: from [208.129.208.52] ([208.129.208.52]:53508 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281128AbRKKWWv>;
	Sun, 11 Nov 2001 17:22:51 -0500
Date: Sun, 11 Nov 2001 14:31:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Ingo Molnar <mingo@elte.hu>
cc: Mike Fedyk <mfedyk@matchmail.com>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <Pine.LNX.4.40.0111111308250.7269-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.40.0111111429360.7269-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2001, Davide Libenzi wrote:

> Ingo, i'm giving the timer_ticks patch a try in my proposed scheduler coz
> i like the idea of skipping the if inside goodness(), and i can do this
> safely because inside the proposed scheduler i don't have any cross CPU
> goodnesses ( no "if (p->processor != this_cpu) weight -= p->timer_ticks;" ).
> I made a change to it anyway, that is adding a water-mark in the decay
> behavior ( timer.c ).
> When counter is above this watermark ( currently 20 ) the counter decay as
> usual while if counter <= watermark, ticks accumulates in timer_ticks.
> This solution keeps the same good behavior for CPU bound tasks while it
> gives a "human"/current decay to tasks that has got a lot of counter
> accumulation inside the recalc loop ( I/O bound ).

The watermark is 10 ( DEF_COUNTER ) not 20.




- Davide


