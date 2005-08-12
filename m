Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVHLHGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVHLHGt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 03:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVHLHGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 03:06:49 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29407 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S1751151AbVHLHGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 03:06:49 -0400
Date: Fri, 12 Aug 2005 09:07:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Message-ID: <20050812070726.GB13938@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1123816044.4453.7.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123816044.4453.7.camel@mindpipe>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Thu, 2005-08-11 at 13:00 +0200, Ingo Molnar wrote:
> > i have released the -53-01 Real-Time Preemption patch, which can be 
> > downloaded from:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > there are two new features in this release, which justified the jump 
> > from .52 to .53:
> > 
> >  - the inclusion of the High Resolution Timers patch, written by
> >    George Anzinger, and ported/improved/cleaned-up by Thomas Gleixner.
> > 
> 
> George,
> 
> Very nice to see this going in (via) the RT patch.
> 
> Can we get a real help text here:
> 
> Clock & Timer Selection
> > 1. Legacy Timer Support (LEGACY_TIMER) (NEW)
>   2. HPET Timer Support (HPET_TIMER)
>   3. High Resolution Timer Support (HIGH_RES_TIMERS) (NEW)
> choice[1-3?]: ?
> 
> You may have either HPET, High Resolution, or Legacy timer support.
> 
> This would be a great place to put some of your extensive docs about the
> various timer sources and issues on x86.  I have always thought the HRT
> docs were the best source on the net for this info, and I refer people
> to it whenever someone has a question about timers on the linux audio
> lists.
> 
> The docs for "High Resolution Timer clock source" are great.
> 
> Can we get more docs here:
> 
> HRT Softirg dynamic priority adjustment (HIGH_RES_TIMERS_DYN_PRIO) 
>         ^^^ typo
> [N/y/?] (NEW) ?
> 
> This option enables the dynamic priority adjustment of the
> high resolution timer soft interrupt
> 
> No point documenting this one if it's expected to go away though.

this feature is from Thomas - and most of the PREEMPT_RT integration 
work too (and hence all the bugs are purely his fault too! ;-).

In the -53-03 patch i've made HIGH_RES_TIMERS_DYN_PRIO always-on for 
PREEMPT_RT, but for other preemption models it's still selectable 
individually, so some more docs would indeed be useful.

	Ingo
