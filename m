Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUJ1OM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUJ1OM1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 10:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUJ1OM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 10:12:26 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:22306 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261273AbUJ1OKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 10:10:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ChhDUg+mA2Dt5ugFyoOv6kLMd0xIx8DPjn6qcsbwemXU09yri1EcIPDvoglzAO6NMi/QE4EcTFaFxeiDye5n9L2QWe7Ng7s7V08Ir8L44jcYZFwQoIxgkLrpJa6KEyVm9ocUwkMB02xivoV/3cpP6GC1hwQq100REzk1ZH+X0DE=
Message-ID: <1a56ea3904102807101147e561@mail.gmail.com>
Date: Thu, 28 Oct 2004 15:10:26 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5.2
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041028135706.GA25849@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041027135309.GA8090@elte.hu> <20041027205126.GA25091@elte.hu>
	 <20041027211957.GA28571@elte.hu>
	 <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>
	 <20041028063630.GD9781@elte.hu>
	 <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>
	 <20041028085656.GA21535@elte.hu>
	 <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>
	 <20041028093215.GA27694@elte.hu> <20041028135706.GA25849@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 15:57:06 +0200, Ingo Molnar <mingo@elte.hu> wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > (right now it's not possible to do wakeup-timing without
> > LATENCY_TRACE, i'll fix that.)
> 
> i've fixed this in -RT-V0.5.2. Also, the trace_enabled=4 method is
> deprecated now and the new mechanism is to use:
> 
>     /proc/sys/kernel/preempt_wakeup_timing
> 
> this flag is default-enabled. So starting at -RT-V0.5.2 to activate
> wakeup timing it's enough to enable PREEMPT_TIMING and reset the max
> after bootup:
> 
>     echo 0 > /proc/sys/kernel/preempt_max_latency
> 
> this will switch back to critical-section timing/tracing:
> 
>     echo 0 > /proc/sys/kernel/preempt_wakeup_timing

What kind of benchmarking tools about from the inkernel timing/tracing
do you use for testing REALTIME_PREEMPT?

> 
>         Ingo

-DaMouse

-- 
I know I broke SOMETHING but its their fault for not fixing it before me
