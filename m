Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUJPUPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUJPUPK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 16:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268846AbUJPUPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 16:15:05 -0400
Received: from mx1.elte.hu ([157.181.1.137]:10697 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268831AbUJPUNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 16:13:51 -0400
Date: Sat, 16 Oct 2004 22:14:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041016201417.GA12371@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161426020.1223@gradall.private.brainfood.com> <20041016193626.GB10626@elte.hu> <Pine.LNX.4.58.0410161457410.1223@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410161457410.1223@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> > after bootup it makes sense to reset the maximum:
> >
> > 	echo 10 > /proc/sys/kernel/preempt_max_latency
> >
> > because during bootup there are a number of latencies that are one-time
> > only.
> 
> So, I did that, and immediately started getting more stack dumps.  Are
> these things that are interesting, or only informational?

they are informational, if you are evaluating latencies. Feel free to
post larger latencies. Right now the threshold for "large" depends - on
a fast box i'd say latencies above 200 usecs are worth reporting - but
any trace can be interesting. Latencies above 1000 usecs are definitely
worth seeing.

stability has the highest priority at the moment, and the other type of
non-latency stackdumps (scheduling while atomic, smp_processor_id()
warnings or outright kernel oopses) should always be reported if
possible.

	Ingo
