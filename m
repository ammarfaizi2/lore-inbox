Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbULGPlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbULGPlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULGPlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:41:07 -0500
Received: from mx1.elte.hu ([157.181.1.137]:43438 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261844AbULGPlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:41:00 -0500
Date: Tue, 7 Dec 2004 16:37:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Eran Mann <emann@mrv.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm2-V0.7.32-2
Message-ID: <20041207153720.GA20712@elte.hu>
References: <OFD07DEEA4.7C243C76-ON86256F5F.007976EC@raytheon.com> <20041204175636.GA3115@elte.hu> <41B5C038.1090501@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41B5C038.1090501@mrv.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Eran Mann <emann@mrv.com> wrote:

> On my machine, disabling CONFIG_LATENCY_TRACE causes the kernel to
> stop reporting preempt latencies. After
>
> # echo 1 > /proc/sys/kernel/preempt_max_latency
> 
> /proc/sys/kernel/preempt_max_latency always shows 1 no matter what
> load is on the machine. I´ve seen this behavior since the first time I
> tried to disable CONFIG_LATENCY_TRACE, around V0.7.31.something.

indeed - there was a thinko in trace_stop_sched_switched() that likely
caused this problem. Does the -32-8 patch (freshly uploaded) work better
for you?

	Ingo
