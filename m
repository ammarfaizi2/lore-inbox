Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWDGKyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWDGKyS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWDGKyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:54:18 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:31670 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932426AbWDGKyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:54:17 -0400
Date: Fri, 7 Apr 2006 12:51:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060407105141.GA9972@elte.hu>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org> <20060407071125.GA2563@elte.hu> <20060407083931.GA11393@gnuppy.monkey.org> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407103926.GC11706@gnuppy.monkey.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bill Huey <billh@gnuppy.monkey.org> wrote:

> On Fri, Apr 07, 2006 at 11:19:46AM +0200, Ingo Molnar wrote:
> > -ENOPARSE. CPU binding brings with itself obvious disadvantages that 
> > some applications are not ready to pay. CPU binding restricts the 
> > scheduler from achieving best resource utilization. That may be fine for 
> > some applications, but is not good enough for a good number of 
> > applications. So in no way can any 'CPU binding mechanism' (which 
> > already exists in multiple forms) replace the need and desire for a 
> > globally scheduled class of RT tasks.
> 
> You're discussing a different problem than what I'm talking about. 
> [...]

no, i'm discussing precisely the point you raised:

>>> You should consider for a moment to allow for the binding of a 
>>> thread to a CPU to determine the behavior of a SCHED_FIFO class task 
>>> instead of creating a new run category. [...]

with the observation that 1) binding is already possible [so your 
suggestion is apparently knocking on open doors] 2) binding is a 
separate mechanism (not adequate for all workloads) and it is thus 
orthogonal to what i'm trying to achieve with the "RT overload" stuff.  
Really simple and straightforward observations i think.

	Ingo
