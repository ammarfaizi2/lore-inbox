Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWCUOcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWCUOcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWCUOcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:32:52 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:24221 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030408AbWCUOcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:32:51 -0500
Date: Tue, 21 Mar 2006 15:30:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Willy Tarreau <willy@w.ods.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321143042.GA32173@elte.hu>
References: <1142592375.7895.43.camel@homer> <200603220119.50331.kernel@kolivas.org> <20060321142504.GA31258@elte.hu> <200603220128.07550.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220128.07550.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> On Wednesday 22 March 2006 01:25, Ingo Molnar wrote:
> > * Con Kolivas <kernel@kolivas.org> wrote:
> > > What you're fixing with unfairness is worth pursuing. The 'ls' issue
> > > just blows my mind though for reasons I've just said. Where are the
> > > magic cycles going when nothing else is running that make it take ten
> > > times longer?
> >
> > i believe such artifacts are due to array switches not happening (due to
> > the workload getting queued back to rq->active, not rq->expired), and
> > 'ls' only gets a timeslice once in a while, every STARVATION_LIMIT
> > times. I.e. such workloads penalize the CPU-bound 'ls' process quite
> > heavily.
> 
> With nothing else running on the machine it should still get all the 
> cpu no matter which array it's on though.

yes. I thought you were asking why 'ls' pauses so long during the 
aforementioned workloads (of loadavg 7-8) - and i answered that. If you 
meant something else then please re-explain it to me.

	Ingo
