Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266652AbUAWUJY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266690AbUAWUIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:08:48 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:38065 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266696AbUAWUHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:07:50 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040123193635.GA492@h00a0cca1a6cf.ne.client2.attbi.com>
References: <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
	 <1074709166.16374.73.camel@cog.beaverton.ibm.com>
	 <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074800554.21658.68.camel@cog.beaverton.ibm.com>
	 <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074801242.21658.71.camel@cog.beaverton.ibm.com>
	 <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074806504.21658.76.camel@cog.beaverton.ibm.com>
	 <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com>
	 <1074885449.12446.27.camel@localhost>
	 <20040123193635.GA492@h00a0cca1a6cf.ne.client2.attbi.com>
Content-Type: text/plain
Message-Id: <1074888405.12447.41.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 23 Jan 2004 12:06:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-23 at 11:36, timothy parkinson wrote:
> On Fri, Jan 23, 2004 at 11:17:29AM -0800, john stultz wrote:
> > Well, lost ticks can be caused by many things, but your point is valid,
> > the message could be a bit more elightening. 
> 
> googling for this issue turns up quite a few questions about it - there's
> already one possible answer in the source, couldn't hurt to stick in a few
> more:
> 
> 
>       if (lost_count++ > 100) {
>               printk(KERN_WARNING "Losing too many ticks!\n");
>               printk(KERN_WARNING "TSC cannot be used as a timesource.\n"
>                     "Are you running with SpeedStep?\n"
> +                   "Perhaps you should enable DMA using \"hdparm\"?\n"
> +                   "etc..........)\n");
>               printk(KERN_WARNING "Falling back to a sane timesource.\n");
>               clock_fallback();
>       }
> 
> not that you have to actually listen to me or anything...  :-)

Looks good by me. Would you mind sending such a patch to Andrew?

thanks
-john


