Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVGaG3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVGaG3G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 02:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVGaG3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 02:29:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:29420 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261647AbVGaG3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 02:29:04 -0400
Date: Sun, 31 Jul 2005 08:29:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@vger.kernel.org>
Subject: Re: [sched, patch] better wake-balancing, #2
Message-ID: <20050731062927.GA472@elte.hu>
References: <200507301929_MC3-1-A601-D4C2@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507301929_MC3-1-A601-D4C2@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> On Fri, 29 Jul 2005 at 17:02:07 +0200, Ingo Molnar wrote:
> 
> > do wakeup-balancing only if the wakeup-CPU is idle.
> >
> > this prevents excessive wakeup-balancing while the system is highly
> > loaded, but helps spread out the workload on partly idle systems.
> 
> I tested this with Volanomark on dual-processor PII Xeon -- the 
> results were very bad:

which patch have you tested? The mail you replied to above is for patch
#2, while on SMT/HT boxes it's patch #3 that is the correct approach.

furthermore, which base kernel have you applied the patch to? Best would 
be to test the following kernels:

 2.6.13-rc4 + sched-rollup
 2.6.13-rc4 + sched-rollup + better-wake-balance-#3

the sched-rollup and the latest better-wake-balance patches can be found 
at:

  http://redhat.com/~mingo/scheduler-patches/

(sched-rollup is the current scheduler patch-queue in -mm. And if you 
have time, it would also be nice to have a 2.6.13-rc4 baseline for 
VolanoMark, and perhaps a 2.6.12 measurement too, so that we can see how 
things changed.)

	Ingo
