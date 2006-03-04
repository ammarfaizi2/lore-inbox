Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751544AbWCDVhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWCDVhw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 16:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751664AbWCDVhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 16:37:52 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:27752 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751543AbWCDVhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 16:37:52 -0500
Message-ID: <440A08AD.7050101@bigpond.net.au>
Date: Sun, 05 Mar 2006 08:37:49 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>, mingo@elte.hu, kernel@kolivas.org,
       nickpiggin@yahoo.com.au, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 2.6.16-rc5-mm2]  sched_cleanup-V17 - task throttling	patch
 1 of 2
References: <1140183903.14128.77.camel@homer>	 <1140812981.8713.35.camel@homer>  <20060224141505.41b1a627.akpm@osdl.org>	 <1140834190.7641.25.camel@homer> <1141382609.8768.57.camel@homer>	 <4408D823.50407@bigpond.net.au> <1141448075.7703.11.camel@homer>
In-Reply-To: <1141448075.7703.11.camel@homer>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Sat, 4 Mar 2006 21:37:50 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sat, 2006-03-04 at 10:58 +1100, Peter Williams wrote:
> 
> 
>>If you're going to manage the time slice in nanoseconds why not do it 
>>properly?  I presume you've held back a bit in case you break something?
>>
> 
> 
> Do you mean the < NS_TICK thing?  The spare change doesn't go away.

Not exactly.  I mean "Why calculate time slice in jiffies and convert to 
nanoseconds?  Why not just do the calculation in nanoseconds?"

> 
> 
>>If it helps, the smpnice balancing code's use of static_prio_timeslice()
>>doesn't really care what units it's return value is in as long as 
>>DEF_TIMESLICE is in the same units and contains the size of a time slice 
>>allocated to a nice==0 non RT task.
> 
> 
> Ok, thanks.  I wanted to make very certain I couldn't screw it up.
> Still, it's simpler to just leave it in ticks.
> 
> 	-Mike

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
