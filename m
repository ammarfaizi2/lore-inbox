Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264265AbUHSJJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUHSJJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUHSJJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:09:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:30926 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264265AbUHSJJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:09:13 -0400
Date: Thu, 19 Aug 2004 11:10:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
Message-ID: <20040819091018.GB8508@elte.hu>
References: <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu> <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu> <411DF776.6090102@superbug.demon.co.uk> <20040814115139.GB9705@elte.hu> <411E0361.9020407@superbug.demon.co.uk> <20040814123240.GA11034@elte.hu> <411E4343.1050302@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411E4343.1050302@superbug.demon.co.uk>
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


* James Courtier-Dutton <James@superbug.demon.co.uk> wrote:

> I have found a new problem though:
> 
> # cat latency_trace
> preemption latency trace v1.0
> -----------------------------
>  latency: 1883455195 us, entries: 1 (1)
>  process: ksoftirqd/1/5, uid: 0
>  nice: -10, policy: 0, rt_priority: 0
> =======>
>  0.000ms (+0.000ms): cond_resched_softirq (___do_softirq)
> 
> That looks bad to me. The user did not notice any latency, but 1883
> seconds seems like a high latency to me!

yeah, it doesnt look healthy. This could be some sort of tracing
underflow - what is the 'grep MHz /proc/cpuinfo' value of your box?

Also, could you try the -P4 patch, it has a more robust timestamping
mechanism.

	Ingo
