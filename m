Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUGWGxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUGWGxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 02:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267533AbUGWGxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 02:53:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21179 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267520AbUGWGxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 02:53:38 -0400
Date: Fri, 23 Jul 2004 08:55:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040723065504.GA15118@elte.hu>
References: <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721154428.GA24374@elte.hu> <40FF48F9.1020004@yahoo.com.au> <20040722070743.GA7553@elte.hu> <40FF9CD1.7050705@yahoo.com.au> <20040722162357.GB23972@elte.hu> <41003BA3.70806@yahoo.com.au> <20040723054735.GA14108@elte.hu> <4100B403.6080402@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4100B403.6080402@yahoo.com.au>
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

> >look at my latest patches to see how it's done. We can preempt softirq
> >handlers via lock-break methods. The same method doesnt work in the idle
> 
> Are you referring to this patch?
> http://people.redhat.com/mingo/voluntary-preempt/defer-softirqs-2.6.8-rc2-A2

no, i'm referring to this one:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-I1

(disregard the debugging induced complexity.)

> Surely something similar could easily be done for irq context softirq
> processing with a patch like my earlier one? And it would prevent
> spilling to ksoftirq when a RT thread isn't waiting to run.

the softirq-defer patch is just the first step to enable lock-break of
softirqs - the lock-break is done in the -I1 patch.

(what patch do you refer to via 'my earlier one'? Did you mean your 'if
(rt_task())' suggestion?)

	Ingo
