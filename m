Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVASJoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVASJoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 04:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVASJoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 04:44:19 -0500
Received: from gprs215-241.eurotel.cz ([160.218.215.241]:35256 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261420AbVASJoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 04:44:13 -0500
Date: Wed, 19 Jan 2005 10:43:42 +0100
From: Pavel Machek <pavel@suse.cz>
To: Tony Lindgren <tony@atomide.com>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119094342.GB25623@elf.ucw.cz>
References: <20050119000556.GB14749@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050119000556.GB14749@atomide.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Attached is the dynamic tick patch for x86 to play with
> as I promised in few threads earlier on this list.[1][2]
> 
> The dynamic tick patch does following:
> 
> - Separates timer interrupts from updating system time
> 
> - Allows updating time from other interrupts in addition
>   to timer interrupt
> 
> - Makes timer tick dynamic
> 
> - Allows power management modules to take advantage of the
>   idle time inbetween skipped ticks
> 
> - Might help with the whistling caps?
> 
> The patch should be non-intrusive where possible. The system
> boots with the regular timers, and then later on switches on
> the dynamic tick if the selected driver implements get_hw_time()
> function.
> 
> Currently supported timers are TSC and ACPI PM timer. Other
> timers should be easy to add. Both TSC and ACPI PM timer
> rely on the PIT timer for interrupts, so the maximum skip
> inbetween ticks is only few seconds at most.
> 
> Please note that this patch alone does not help much with
> power savings. More work is needed in that area to make the
> system take advantage of the idle time inbetween the skipped
> ticks.

Well, having HZ=100 instead of HZ=1000 has measurable benefits on
power consumption. This should be at least as good, no?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
