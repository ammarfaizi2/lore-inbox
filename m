Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUHaRoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUHaRoZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHaRm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:42:56 -0400
Received: from amsfep18-int.chello.nl ([213.46.243.13]:50262 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S265805AbUHaRk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:40:59 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-Q5
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040830090608.GA25443@elte.hu>
References: <1093715573.8611.38.camel@krustophenia.net>
	 <20040828194449.GA25732@elte.hu> <200408282210.03568.pnambic@unu.nu>
	 <20040828203116.GA29686@elte.hu>
	 <1093727453.8611.71.camel@krustophenia.net>
	 <20040828211334.GA32009@elte.hu> <1093727817.860.1.camel@krustophenia.net>
	 <1093737080.1385.2.camel@krustophenia.net>
	 <1093746912.1312.4.camel@krustophenia.net> <20040829054339.GA16673@elte.hu>
	 <20040830090608.GA25443@elte.hu>
Content-Type: text/plain
Date: Tue, 31 Aug 2004 19:40:57 +0200
Message-Id: <1093974057.7484.5.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 11:06 +0200, Ingo Molnar wrote:
> i've uploaded -Q5 to:
> 
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk4-Q5
> 
> ontop of:
> 
>   http://redhat.com/~mingo/voluntary-preempt/diff-bk-040828-2.6.8.1.bz2
> 
> -Q5 should fix the PS2 problems and the early boot problems, and it
> might even fix the USB, ACPI and APIC problems some people were
> reporting.
> 
> There were a number of bugs that led to the PS2 problems:
> 
>  - a change to __cond_resched() in the -Q series caused the starvation
>    of the IRQ1 and IRQ12 threads during init - causing a silent timeout
>    and misdetection in the ps2 driver(s).
> 
>  - even with the starvation bug fixed, we must set system_state to
>    SCHEDULER_OK only once the init thread has started - otherwise the
>    idle thread might hang during bootup.
> 
>  - the redirected IRQ handling now matches that of non-redirected IRQs
>    better, the outer loop in generic_handle_IRQ has been flattened.
> 
> i also re-added the synchronize_irq() fix, it was not causing the PS2
> problems.
> 
> 	Ingo

Hi Ingo,

this one is great, it's been rock solid for over 24h now. No more SMP
problems for me. Thanks for all the hard work.

Kind regards.

-- 
Peter Zijlstra <a.p.zijlstra@chello.nl>

