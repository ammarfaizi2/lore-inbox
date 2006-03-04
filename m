Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWCDEwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWCDEwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 23:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWCDEwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 23:52:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:19925 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750779AbWCDEwu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 23:52:50 -0500
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling
	patch 1 of 2
From: Mike Galbraith <efault@gmx.de>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu, kernel@kolivas.org,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4408D823.50407@bigpond.net.au>
References: <1140183903.14128.77.camel@homer>
	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>
	 <1140834190.7641.25.camel@homer> <1141382609.8768.57.camel@homer>
	 <4408D823.50407@bigpond.net.au>
Content-Type: text/plain
Date: Sat, 04 Mar 2006 05:54:35 +0100
Message-Id: <1141448075.7703.11.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-03-04 at 10:58 +1100, Peter Williams wrote:

> If you're going to manage the time slice in nanoseconds why not do it 
> properly?  I presume you've held back a bit in case you break something?
> 

Do you mean the < NS_TICK thing?  The spare change doesn't go away.

> If it helps, the smpnice balancing code's use of static_prio_timeslice()
> doesn't really care what units it's return value is in as long as 
> DEF_TIMESLICE is in the same units and contains the size of a time slice 
> allocated to a nice==0 non RT task.

Ok, thanks.  I wanted to make very certain I couldn't screw it up.
Still, it's simpler to just leave it in ticks.

	-Mike

