Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbVHOWSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbVHOWSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVHOWSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:18:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:38326 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965015AbVHOWSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:18:50 -0400
Subject: Re: [PATCH] pmtmr and PRINTK_TIME timings display
From: john stultz <johnstul@us.ibm.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200508041723.25848.petkov@uni-muenster.de>
References: <200508041459.43500.petkov@uni-muenster.de>
	 <1123161545.12009.6.camel@localhost.localdomain>
	 <200508041723.25848.petkov@uni-muenster.de>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 15:18:46 -0700
Message-Id: <1124144326.8630.9.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-04 at 17:23 +0200, Borislav Petkov wrote:
> I get it. Actually, I wasn't very sure whether this is the right solution 
> since my desktop machine uses tsc timer as default while the laptop the 
> pmtmr. I also remember that there was a patch a while ago on lkml which 
> enabled a modifiable behavior for PRINTK_TIME through a /proc interface and 
> kernel boot option but it somehow didn't get accepted. Ok, then, since we 
> keep the jiffies solution across arch's, how can I force the kernel to use 
> tsc for printk timings so that i can see the deltas between the different 
> printk's instead of the jiffies_64 ns value? The Pentium-M Centrino on the 
> laptop evidently supports rdtsc as a msr instruction.

The issue is that there are a number of laptops that do not properly
support cpufreq and additionally newer laptop chips halt their TSC's
when they go into C3 mode. This keeps the TSC from working as a proper
timesource on these systems, and causes the need for alternative
timesources like the ACPI PM timer. 

thanks
-john


