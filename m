Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUG2VCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUG2VCk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUG2VBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:01:48 -0400
Received: from gprs214-254.eurotel.cz ([160.218.214.254]:17025 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265287AbUG2VAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:00:42 -0400
Date: Thu, 29 Jul 2004 23:00:19 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-audio-dev@music.columbia.edu, arjanv@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040729210019.GA18623@elf.ucw.cz>
References: <20040721085246.GA19393@elte.hu> <40FE545E.3050300@yahoo.com.au> <20040721183415.GC2206@yoda.timesys> <20040721184650.GA27375@elte.hu> <20040721195650.GA2186@yoda.timesys> <20040721214534.GA31892@elte.hu> <20040722022810.GA3298@yoda.timesys> <20040722074034.GC7553@elte.hu> <20040729202629.GC468@openzaurus.ucw.cz> <20040729205750.GA28735@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729205750.GA28735@yoda.timesys>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, I do not follow you I guess.
> > 
> > With large-enough number of hardirqs you do no progress at all.
> > 
> > Even if only "sane" number of irqs, if they all decide to hit within one
> > getpid(), this getpid is going to take quite long....
> > 				Pavel
> 
> Ordinarily, yes.  However, if it's a high-priority RT task that does
> the getpid(), whose priority is higher than that of the RT tasks,
> you'll get at most one hardirq stub per active IRQ number; after
> that, the IRQs will be masked until their threads get a chance to be
> scheduled.

But will not even num_IRQs*time_per_stub be so high that any analysis
is impractical?

...

...

Hmm, that high-priority hask only has to eat num_IRQs*time_per_stub
once, so perhaps its okay.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
