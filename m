Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965132AbVIAOMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965132AbVIAOMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbVIAOMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:12:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:3473 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965132AbVIAOMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:12:31 -0400
Date: Thu, 1 Sep 2005 19:41:32 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       arjan@infradead.org, s0348365@sms.ed.ac.uk, tytso@mit.edu,
       cfriesen@nortel.com, rlrevell@joe-job.com, trenn@suse.de,
       george@mvista.com, johnstul@us.ibm.com, akpm@osdl.org
Subject: Re: Updated dynamic tick patches
Message-ID: <20050901141132.GB11355@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509011523.13994.kernel@kolivas.org> <20050901130721.GB10677@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050901130721.GB10677@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 04:07:22PM +0300, Tony Lindgren wrote:
> I tried this quickly on a loaner ThinkPad T30, and needed the following
> patch to compile. The patch does work with PIT, but with lapic the
> system does not wake to timer interrupts :(

Even I have found that enabling lapic breaks it on my T30! I think
that is a T30 issue, as I dont see any other reason why it should not 
work (note that I have it tested on some other SMP P4 servers where
it works well).

> I also hacked together a little timer test utility that should go trough
> on a completely idle system with no errors. Also posted it to:
> 
> http://www.muru.com/linux/dyntick/tools/dyntick-test.c
> 
> Srivatsa, could you try the dyntick-test.c on your system after booting
> to init=/bin/sh to make the system as idle as possible?

Thanks for this test. Will test and let you know how it goes on x86.
ATM I am trying to corner the lost-tick-calculation problem with ACPI 
PM timer.

> Unfortunately I cannot debug the APIC issue right now, but I seem to
> have an issue on ARM OMAP where the timer test occasionally fails on
> some longer values, for example 3 second sleep can take 4 seconds.
> 
> I don't know yet if this is the problem George Anzinger mentioned with
> next_timer_interrupt(), or if this is OMAP specific. But it only seems

Will let you know if I see it on x86 too.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
