Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932705AbWF3OUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932705AbWF3OUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 10:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932716AbWF3OUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 10:20:54 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:9920 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S932705AbWF3OUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 10:20:53 -0400
Date: Fri, 30 Jun 2006 07:12:48 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630141248.GC22381@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <p73bqsax0iu.fsf@verdi.suse.de> <20060630132901.GB22381@frankl.hpl.hp.com> <200606301541.22928.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606301541.22928.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Fri, Jun 30, 2006 at 03:41:22PM +0200, Andi Kleen wrote:
> 
> > So why do we need care about context switch in cpu-wide mode?
> > It is because we support a mode where the idle thread is excluded
> > from cpu-wide monitoring. This is very useful to distinguish 
> > 'useful kernel work' from 'idle'. 
> 

The exclude-idle feature is an option you select when you create
your cpu-wide session. By default, it is off.

> I don't quite see the point because on x86 the PMU doesn't run
> during C states anyways. So you get idle excluded automatically.
> 
Yes, but that may not necessarily be troe of all architectures.
At least with the option, the interfaces provides some guarantee.

> And on the other hand a lot of people especially want idle
> accounting too and boot with idle=poll. Your explicit 
> code would likely defeat that.
> 
> > As you realize, that means 
> > that we need to turn off when the idle thread is context switched
> > in and turn it back on when it is switched off.
> 
> Also x86-64 has idle notifiers for this if you really wanted
> to do it properly.
> 
That looks like a useful feature I could leverage but why is it just
on x86-64 at the moment?

-- 
-Stephane
