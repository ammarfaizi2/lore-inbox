Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266635AbUAWUil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 15:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266676AbUAWUil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 15:38:41 -0500
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.182.167]:25472 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S266635AbUAWUii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 15:38:38 -0500
Date: Fri, 23 Jan 2004 15:38:35 -0500
From: timothy parkinson <t@timothyparkinson.com>
To: john stultz <johnstul@us.ibm.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 "clock preempt"?
Message-ID: <20040123203835.GA518@h00a0cca1a6cf.ne.client2.attbi.com>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>, hauan@cmu.edu,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com> <1074800554.21658.68.camel@cog.beaverton.ibm.com> <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com> <1074801242.21658.71.camel@cog.beaverton.ibm.com> <20040122200044.GA593@h00a0cca1a6cf.ne.client2.attbi.com> <1074806504.21658.76.camel@cog.beaverton.ibm.com> <20040123190205.GA477@h00a0cca1a6cf.ne.client2.attbi.com> <1074885449.12446.27.camel@localhost> <20040123193635.GA492@h00a0cca1a6cf.ne.client2.attbi.com> <1074888405.12447.41.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074888405.12447.41.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jan 23, 2004 at 12:06:45PM -0800, john stultz wrote:
> On Fri, 2004-01-23 at 11:36, timothy parkinson wrote:
> > On Fri, Jan 23, 2004 at 11:17:29AM -0800, john stultz wrote:
> > > Well, lost ticks can be caused by many things, but your point is valid,
> > > the message could be a bit more elightening. 
> > 
> > googling for this issue turns up quite a few questions about it - there's
> > already one possible answer in the source, couldn't hurt to stick in a few
> > more:
> > 
> > 
> >       if (lost_count++ > 100) {
> >               printk(KERN_WARNING "Losing too many ticks!\n");
> >               printk(KERN_WARNING "TSC cannot be used as a timesource.\n"
> >                     "Are you running with SpeedStep?\n"
> > +                   "Perhaps you should enable DMA using \"hdparm\"?\n"
> > +                   "etc..........)\n");
> >               printk(KERN_WARNING "Falling back to a sane timesource.\n");
> >               clock_fallback();
> >       }
> > 
> > not that you have to actually listen to me or anything...  :-)
> 
> Looks good by me. Would you mind sending such a patch to Andrew?
> 
> thanks
> -john
> 

no problem, i'll take it from here.

* Running with SpeedStep (this is a cpu thing i assume?) could cause this.
* Not having DMA enabled on your hard disk(s) could cause this.  See the hdparm
  utility to enable it.
* Incorrect TSC synchronization on SMP systems could cause this.
* Anything else?

thanks,

timothy

