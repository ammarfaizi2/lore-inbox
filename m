Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUIOBje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUIOBje (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 21:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266595AbUIOBje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 21:39:34 -0400
Received: from holomorphy.com ([207.189.100.168]:5528 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266566AbUIOBjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 21:39:32 -0400
Date: Tue, 14 Sep 2004 18:39:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915013925.GF9106@holomorphy.com>
References: <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095210126.2406.70.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095210126.2406.70.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 09:02:07PM -0400, Lee Revell wrote:
> For a generic desktop I don't think any of this makes much of a
> difference; AFAIK none of the VP testers have reported a perceptible
> difference in system responsiveness.  A good point of comparison here is
> what Microsoft OS'es can do.  My Windows XP setup works pretty well with
> a latency of 2.66ms or 128 frames at 48KHZ, and is rock solid at 256
> frames or 5.33ms.
> However for low latency audio Mac OS X is our real competition.  OS X
> can deliver audio latencies of probably 0.5ms.  There is not much point
> in going much lower than this because the difference becomes
> imperceptible and the more frequent cache thrashing becomes an issue;
> this is close enough to the limits of what sound hardware is capable of
> anyway.
> With Ingo's patches the worst case latency on the same machine as my XP
> example is about 150 usecs.  So, it seems to me that Ingo's patches can
> achieve results as good or better than OSX even without the one or two
> "dangerous" changes, like the removal of lock_kernel around
> do_tty_write.

The code we're most worried is buggy, not just nonperformant.


-- wli
