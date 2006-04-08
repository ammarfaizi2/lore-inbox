Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWDHHTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWDHHTk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWDHHTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:19:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:2184 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751372AbWDHHTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:19:40 -0400
Date: Sat, 8 Apr 2006 09:16:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060408071657.GA11660@elte.hu>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407210633.GA15971@gnuppy.monkey.org>
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

> On Fri, Apr 07, 2006 at 07:56:20AM -0700, Darren Hart wrote:
> > The rt-overload mechanism is distinct from load balancing.  RT overload 
> > attempts to make sure the NR_CPUS highest priority runnable tasks are running 
> > on each of the available CPUs.  This isn't load balancing, this is "system 
> > wide strict realtime priority scheduling" (SWSRPS).  This scheduling should 
> > take place even if there are 1000 non RT tasks on CPU 0 and none on all the 
> > others.  The load balancer would be responsible for distributing those 1000 
> > non rt tasks to all the CPUs.
> 
> I'm quite aware of what you're saying as well as a much of the 
> contents of the -rt patch. Please don't assume that I'm not aware of 
> this. The -rt patch doesn't do SWSRPS, [...]

to the contrary, the "RT overload" code in the -rt tree does strict, 
system-wide RT priority scheduling. That's the whole point of it.

	Ingo
