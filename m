Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261969AbVASXVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbVASXVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVASXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:18:34 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:9693 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261968AbVASXRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:17:34 -0500
Date: Wed, 19 Jan 2005 15:17:03 -0800
From: Tony Lindgren <tony@atomide.com>
To: George Anzinger <george@mvista.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Con Kolivas <kernel@kolivas.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dynamic tick patch
Message-ID: <20050119231702.GJ14545@atomide.com>
References: <20050119000556.GB14749@atomide.com> <20050119094342.GB25623@elf.ucw.cz> <20050119171323.GB14545@atomide.com> <20050119174858.GB12647@dualathlon.random> <41EEE648.2010309@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EEE648.2010309@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* George Anzinger <george@mvista.com> [050119 15:00]:
>
> I don't think you will ever get good time if you EVER reprogramm the PIT.  
> That is why the VST patch on sourceforge does NOT touch the PIT, it only 
> turns off the interrupt by interrupting the interrupt path (not changing 
> the PIT).  This allows the PIT to be the "gold standard" in time that it is 
> designed to be.  The wake up interrupt, then needs to come from an 
> independent timer.  My patch requires a local APIC for this.  Patch is 
> available at http://sourceforge.net/projects/high-res-timers/

Well on my test systems I have pretty good accurate time. But I agree,
PIT is not the best option for interrupt. It should be possible to use
other interrupt sources as well.

It should not matter where the timer interrupt comes from, as long as 
it comes when programmed. Updating time should be separate from timer
interrupts. Currently we have a problem where time is tied to the
timer interrupt.

I'll take a look at your patch again, and check out the APIC part.

Regards,

Tony
