Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUG2VKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUG2VKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUG2VKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:10:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:22965 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265264AbUG2VJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:09:07 -0400
Date: Thu, 29 Jul 2004 23:07:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Pavel Machek <pavel@ucw.cz>
Cc: Scott Wood <scott@timesys.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729210701.GA32708@elte.hu>
References: <20040721082218.GA19013@elte.hu> <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040729202629.GC468@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729202629.GC468@openzaurus.ucw.cz>
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


* Pavel Machek <pavel@ucw.cz> wrote:

> ...
> > [the only remaining source of 'latency uncertainty' is the small
> > asynchronous hardirq stub that would still remain. This has an effect
> > that can be compared to e.g. cache effects and it cannot become unbound
> > unless the CPU is bombarded with a very high number of interrupts.]
> 
> Well, I do not follow you I guess.
> 
> With large-enough number of hardirqs you do no progress at all.
> 
> Even if only "sane" number of irqs, if they all decide to hit within
> one getpid(), this getpid is going to take quite long....

yes, all of this assumes some _minimal_ sanity of the hardware
environment. We do detect interrupt storms and turn those IRQ sources
off, but there's no (sane) way to avoid interrupt storms from
driver-handled IRQ sources.

	Ingo
