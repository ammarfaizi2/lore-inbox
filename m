Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUIPGNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUIPGNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267563AbUIPGNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:13:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28874 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267561AbUIPGNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:13:13 -0400
Date: Thu, 16 Sep 2004 08:14:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040916061438.GA10314@elte.hu>
References: <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914145457.GA13113@elte.hu> <414776CE.5030302@yahoo.com.au> <20040915061922.GA11683@elte.hu> <4147FC14.2010205@yahoo.com.au> <20040915084355.GA29752@elte.hu> <4148E64A.9000206@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4148E64A.9000206@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> No, I mean putting cond_resched in might_sleep is ad hoc. But that
> doesn't mean it doesn't work - it obviously does ;)

ah, ok, i understand your point now. No, i'm not submitting the
CONFIG_PREEMPT_VOLUNTARY .config switch (and the kernel.h 2-liner) at
this point. All the latency breakers so far will mainly benefit
CONFIG_PREEMPT - which is also the primary preempt model used by
bleeding-edge testers.

	Ingo
