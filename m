Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVGFFXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVGFFXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVGFFVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:21:52 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:61884 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261724AbVGFDoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:44:24 -0400
Subject: Re: [PATCH] [24/48] Suspend2 2.1.9.8 for 2.6.12:
	601-kernel_power_power-header.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0507052141490.2149@montezuma.fsmlabs.com>
References: <11206164422542@foobar.com>
	 <Pine.LNX.4.61.0507052141490.2149@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120621550.4860.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 13:45:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 13:42, Zwane Mwaikambo wrote:
> On Wed, 6 Jul 2005, Nigel Cunningham wrote:
> 
> > diff -ruNp 602-smp.patch-old/kernel/power/suspend2_core/smp.c 602-smp.patch-new/kernel/power/suspend2_core/smp.c
> > --- 602-smp.patch-old/kernel/power/suspend2_core/smp.c	1970-01-01 10:00:00.000000000 +1000
> > +++ 602-smp.patch-new/kernel/power/suspend2_core/smp.c	2005-07-04 23:14:19.000000000 +1000
> > @@ -0,0 +1,12 @@
> > +#include <linux/sched.h>
> > +
> > +void ensure_on_processor_zero(void)
> > +{
> > +	set_cpus_allowed(current, cpumask_of_cpu(0));
> > +	BUG_ON(smp_processor_id() != 0);
> > +}
> > +
> > +void return_to_all_processors(void)
> > +{
> > +	set_cpus_allowed(current, CPU_MASK_ALL);
> > +}
> 
> Do we really need to wrap these?

Fair enough. If I remember rightly, it's just a result of the flux with
testing cpu hotplug, so I should certainly drop the wrappers.

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

