Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266405AbUAVTnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266406AbUAVTnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:43:46 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:47072 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266405AbUAVTnn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:43:43 -0500
Subject: Re: 2.6.1 "clock preempt"?
From: john stultz <johnstul@us.ibm.com>
To: timothy parkinson <t@timothyparkinson.com>
Cc: hauan@cmu.edu, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
References: <1074630968.19174.49.camel@steinar.cheme.cmu.edu>
	 <1074633977.16374.67.camel@cog.beaverton.ibm.com>
	 <1074697593.5650.26.camel@steinar.cheme.cmu.edu>
	 <1074709166.16374.73.camel@cog.beaverton.ibm.com>
	 <20040122193704.GA552@h00a0cca1a6cf.ne.client2.attbi.com>
Content-Type: text/plain
Message-Id: <1074800554.21658.68.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 22 Jan 2004 11:42:35 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-01-22 at 11:37, timothy parkinson wrote:
> hi john,
> 
> i think this sounds like the same issue that i've been seeing with 2.5/2.6
> kernels for a while now.  smp kernel on a dual PIII machine without preempt.
> 
> after running for a while the "losing ticks" shows up in dmesg, and the system
> loses a lot of time.  load seems to make it worse, so that just might be the
> trigger.
> 
> i'll try that one-liner as well when i get a chance - you said that if the
> system still loses time, that narrows it down to hardware, yes?

Well, not necessarily hardware, but it narrows it down to something
blocking interrupts for way too long. IDE PIO for example seems to be a
likely culprit. Another possibility on SMP systems is your cpu TSCs not
being in sync.

thanks
-john

