Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262419AbSI2IPQ>; Sun, 29 Sep 2002 04:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbSI2IPQ>; Sun, 29 Sep 2002 04:15:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27553 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262419AbSI2IPP>;
	Sun, 29 Sep 2002 04:15:15 -0400
Date: Sun, 29 Sep 2002 10:25:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Axel <Axel.Zeuner@gmx.de>
Cc: NPT library mailing list <phil-list@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.39: Signal delivery to thread groups: Bug or feature
In-Reply-To: <200209281638.g8SGcQi23877@mx1.redhat.com>
Message-ID: <Pine.LNX.4.44.0209291023500.12464-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 28 Sep 2002, Axel wrote:

> I played a little bit with the new clone flags and wrote a small test
> program using two threads: The first (initial) thread blocks all
> signals. The second thread is created with all signals blocked and
> inherits the signal mask of the initial thread. It unblocks SIGINT and
> calls sys_rt_sigtimedwait with the remaining signal mask. Therefore it
> waits for all signals with exception of SIGINT. In the kernel this
> yields to an empty signal mask for this thread during the sigwait. No
> signal handler is installed by the process. Now an external SIGINT is
> delivered to the whole process: The signal delivery code decides to send
> this signal directly to the initial thread because no user handler is
> installed and the signal mask for this thread blocks the signal. The
> second thread never receives the SIGINT.

could you send me the testcase? Thanks,

	Ingo


