Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266249AbUIOCMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUIOCMM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 22:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUIOCMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 22:12:12 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51633 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266627AbUIOCLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 22:11:25 -0400
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
From: Lee Revell <rlrevell@joe-job.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040915013925.GF9106@holomorphy.com>
References: <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu>
	 <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au>
	 <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au>
	 <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
	 <20040914150316.GN4180@dualathlon.random>
	 <1095210126.2406.70.camel@krustophenia.net>
	 <20040915013925.GF9106@holomorphy.com>
Content-Type: text/plain
Message-Id: <1095214289.2406.101.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 14 Sep 2004 22:11:29 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-14 at 21:39, William Lee Irwin III wrote:
> > With Ingo's patches the worst case latency on the same machine as my XP
> > example is about 150 usecs.  So, it seems to me that Ingo's patches can
> > achieve results as good or better than OSX even without the one or two
> > "dangerous" changes, like the removal of lock_kernel around
> > do_tty_write.
> 
> The code we're most worried is buggy, not just nonperformant.
> 

Understood.  The only dangerous change I know of in the VP patches is
the one Alan took issue with, the aforementioned removal of lock_kernel
in the tty code.  IIRC this only produced a latency of about 300 usecs,
and only when switching VT's from a console to X and back.  My point was
that it's quite possible that we can get OSX-like results without the
more dangerous changes.

Ingo, if you want to send me a patch set without the more controversial
changes, I can compare the performance.  A diff against the latest VP
patch would be OK.

Lee



