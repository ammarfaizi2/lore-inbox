Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965143AbVHPIft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965143AbVHPIft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 04:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbVHPIft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 04:35:49 -0400
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:32465 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S965143AbVHPIfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 04:35:48 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] pmtmr and PRINTK_TIME timings display
Date: Tue, 16 Aug 2005 10:35:30 +0200
User-Agent: KMail/1.7.2
Cc: Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>
References: <200508041459.43500.petkov@uni-muenster.de> <200508041723.25848.petkov@uni-muenster.de> <1124144326.8630.9.camel@cog.beaverton.ibm.com>
In-Reply-To: <1124144326.8630.9.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161035.31085.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 August 2005 00:18, john stultz wrote:
> On Thu, 2005-08-04 at 17:23 +0200, Borislav Petkov wrote:
> > I get it. Actually, I wasn't very sure whether this is the right solution
> > since my desktop machine uses tsc timer as default while the laptop the
> > pmtmr. I also remember that there was a patch a while ago on lkml which
> > enabled a modifiable behavior for PRINTK_TIME through a /proc interface
> > and kernel boot option but it somehow didn't get accepted. Ok, then,
> > since we keep the jiffies solution across arch's, how can I force the
> > kernel to use tsc for printk timings so that i can see the deltas between
> > the different printk's instead of the jiffies_64 ns value? The Pentium-M
> > Centrino on the laptop evidently supports rdtsc as a msr instruction.
>
> The issue is that there are a number of laptops that do not properly
> support cpufreq and additionally newer laptop chips halt their TSC's
> when they go into C3 mode. This keeps the TSC from working as a proper
> timesource on these systems, and causes the need for alternative
> timesources like the ACPI PM timer.

This _is_ actually my laptop I'm testing it on and sofar no problem. But as 
Steven pointed out earlier, one probably needs a different kind of timing 
information besides delta timings. Besides, <scripts/show_delta> can do all 
the formatting and delta computation already.

Thanks & regards,
Borislav Petkov.
