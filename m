Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266286AbUAVTvJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266417AbUAVTvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:51:09 -0500
Received: from h00a0cca1a6cf.ne.client2.attbi.com ([65.96.182.167]:27521 "EHLO
	h00a0cca1a6cf.ne.client2.attbi.com") by vger.kernel.org with ESMTP
	id S266286AbUAVTvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:51:03 -0500
Date: Thu, 22 Jan 2004 14:50:26 -0500
From: timothy parkinson <t@timothyparkinson.com>
To: john stultz <johnstul@us.ibm.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1 "clock preempt"?
Message-ID: <20040122195026.GA579@h00a0cca1a6cf.ne.client2.attbi.com>
Mail-Followup-To: john stultz <johnstul@us.ibm.com>, hauan@cmu.edu,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu> <1074633977.16374.67.camel@cog.beaverton.ibm.com> <1074697593.5650.26.camel@steinar.cheme.cmu.edu> <1074709166.16374.73.camel@cog.beaverton.ibm.com> <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com> <1074800554.21658.68.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074800554.21658.68.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


well, it does *say* the following:

  ..... host bus clock speed is 133.0266 MHz.
  checking TSC synchronization across 2 CPUs: passed.
  Starting migration thread for cpu 0

is there a good way to check IDE PIO?

timothy


On Thu, Jan 22, 2004 at 11:42:35AM -0800, john stultz wrote:
> On Thu, 2004-01-22 at 11:37, timothy parkinson wrote:
> > hi john,
> > 
> > i think this sounds like the same issue that i've been seeing with 2.5/2.6
> > kernels for a while now.  smp kernel on a dual PIII machine without preempt.
> > 
> > after running for a while the "losing ticks" shows up in dmesg, and the system
> > loses a lot of time.  load seems to make it worse, so that just might be the
> > trigger.
> > 
> > i'll try that one-liner as well when i get a chance - you said that if the
> > system still loses time, that narrows it down to hardware, yes?
> 
> Well, not necessarily hardware, but it narrows it down to something
> blocking interrupts for way too long. IDE PIO for example seems to be a
> likely culprit. Another possibility on SMP systems is your cpu TSCs not
> being in sync.
> 
> thanks
> -john
> 
> 
> 
