Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWDGWTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWDGWTI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWDGWTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 18:19:08 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:54414
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S964999AbWDGWTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 18:19:07 -0400
Date: Fri, 7 Apr 2006 15:18:50 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Bill Huey (hui)" <billh@gnuppy.monkey.org>
Subject: Re: RT task scheduling
Message-ID: <20060407221850.GA17303@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org> <20060407071125.GA2563@elte.hu> <20060407083931.GA11393@gnuppy.monkey.org> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <20060407105141.GA9972@elte.hu> <20060407111444.GA12458@gnuppy.monkey.org> <20060407112956.GA17277@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407112956.GA17277@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 01:29:56PM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> > First thing's first, SCHED_FIFO_GLOBAL for what you want in the main 
> > line is the same thing as SCHED_FIFO in -rt, right ?
> 
> yes.

Ok, good, we're getting some where. IMO, SCHED_FIFO_GLOBAL doesn't add
anything to existing Linux scheduling policies for it to be really
distinct than SCHED_FIFO. I'd much see that feature collapsed into a
into SCHED_FIFO intrinsically. In fact, that's the way it should be in
a solid RTOS. Creation of run categories that are so similar doesn't
really add to the "meaning" of the system, since SCHED_FIFO was kind
of hammered in the first place, just make SCHED_FIFO do that strict
priority stuff across all processors as a default property.

Whether this belongs in the main line or not is questionable. My guess
is probably not. But I definitely think it should go into -rt and it
would be much more warmly received by folks developing on that kernel
patch to know that SCHED_FIFO has this strict behavior. It's actually
needed in that patch IMO. Following ?

bill

