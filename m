Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268682AbUJPIRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268682AbUJPIRd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268683AbUJPIRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 04:17:33 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44457 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268682AbUJPIRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 04:17:31 -0400
Date: Sat, 16 Oct 2004 10:18:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016081856.GA942@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <Pine.LNX.4.58.0410152157030.1219@gradall.private.brainfood.com> <20041016075635.GA462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041016075635.GA462@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> a suggestion for future testing: please enable PREEMPT_TIMING for the
> next kernels you build, it will print such entries at the end of
> stacktraces:
> 
>  preempt count: 2
>  entry 1: cpu_idle+0x38/0x90 / (start_kernel+0x1ac/0x1f0)
>  entry 2: _spin_lock+0x22/0x80 / (timer_interrupt+0x1b/0x130)

correction: in -U3 you'll also need to enable LATENCY_TRACE for this to
work. I've fixed this in my tree and from -U4 onwards the preemption
trace will be maintained and printed if DEBUG_PREEMPT is enabled.

	Ingo
