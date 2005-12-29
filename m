Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbVL2KDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbVL2KDE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbVL2KDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:03:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:12014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965149AbVL2KDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:03:03 -0500
Date: Thu, 29 Dec 2005 05:02:33 -0500
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051229100233.GA12056@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
	Hugh Dickins <hugh@veritas.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229082217.GA23052@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 09:22:17AM +0100, Ingo Molnar wrote:
 > 
 > * Lee Revell <rlrevell@joe-job.com> wrote:
 > 
 > > I'm not sure how much work it would be to break out 
 > > CONFIG_LATENCY_TRACE as a separate patch.
 > 
 > could you check out the 2.6.15-rc7 version of the latency tracer i 
 > uploaded to:
 > 
 > 	http://redhat.com/~mingo/latency-tracing-patches/
 > 
 > could test it by e.g. trying to reproduce the same VM latency as in the 
 > -rt tree. [the two zlib patches are needed if you are using 4K stacks, 
 > mcount increases stack footprint.]

kernel/latency.c: In function 'add_preempt_count_ti':
kernel/latency.c:1703: warning: implicit declaration of function 'preempt_count_ti'
kernel/latency.c:1703: error: invalid lvalue in assignment
kernel/latency.c: In function 'sub_preempt_count_ti':
kernel/latency.c:1764: error: invalid lvalue in assignment

interesting config options ...

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_BKL=y

CONFIG_WAKEUP_TIMING=y
CONFIG_WAKEUP_LATENCY_HIST=y
CONFIG_CRITICAL_IRQSOFF_TIMING=y
CONFIG_INTERRUPT_OFF_HIST=y
CONFIG_LATENCY_TRACE=y
CONFIG_USE_FRAME_POINTER=y
CONFIG_FRAME_POINTER=y

		Dave

