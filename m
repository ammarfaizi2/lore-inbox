Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUIOJzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUIOJzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 05:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUIOJzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 05:55:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24520 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263962AbUIOJzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 05:55:01 -0400
Date: Wed, 15 Sep 2004 11:56:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@novell.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040915095614.GB1629@elte.hu>
References: <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au> <20040914150316.GN4180@dualathlon.random> <1095210126.2406.70.camel@krustophenia.net> <20040915013925.GF9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915013925.GF9106@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* William Lee Irwin III <wli@holomorphy.com> wrote:

> > With Ingo's patches the worst case latency on the same machine as my XP
> > example is about 150 usecs.  So, it seems to me that Ingo's patches can
> > achieve results as good or better than OSX even without the one or two
> > "dangerous" changes, like the removal of lock_kernel around
> > do_tty_write.
> 
> The code we're most worried is buggy, not just nonperformant.

what code do you mean? The one i know about and which Lee is referring
to above is the 6-lines tty unlocking change - the one which Alan
objected to rightfully. I've zapped it from my tree.

(nobody objected to the original thread on lkml weeks ago where the tty
unlocking change was proposed, implemented, alpha-tested and beta-tested
in -mm for several releases - that's why it showed up in my 20+
latency-reduction patches.)

No latency changes to the tty layer until someone fixes its locking. End
of story.

	Ingo
