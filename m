Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266663AbUJPTgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266663AbUJPTgs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 15:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268800AbUJPTgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 15:36:45 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37295 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266663AbUJPTfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 15:35:07 -0400
Date: Sat, 16 Oct 2004 21:36:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041016193626.GB10626@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <Pine.LNX.4.58.0410161426020.1223@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410161426020.1223@gradall.private.brainfood.com>
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

> > i have released the -U4 PREEMPT_REALTIME patch:
> >
> >    http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U4
> >
> > this is a fixes-only release, and it is still experimental code.
> 
> Few stack dumps now.

these are normal, they are the PREEMPT_TIMING traces which get printed
every time the kernel measures a new latency maximum. The stack dumps
are done to make it easier to identify which place too that long of a
delay and why. (if LATENCY_TRACE is enabled too then the last latency
and its trace can also be found in /proc/latency_trace.)

after bootup it makes sense to reset the maximum:

	echo 10 > /proc/sys/kernel/preempt_max_latency

because during bootup there are a number of latencies that are one-time
only.

	Ingo
