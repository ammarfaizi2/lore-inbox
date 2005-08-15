Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVHOQOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVHOQOJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 12:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbVHOQOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 12:14:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:45186 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964816AbVHOQOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 12:14:08 -0400
Date: Mon, 15 Aug 2005 21:05:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, tony@atomide.com, tuukka.tikkanen@elektrobit.com,
       akpm@osdl.org, johnstul@us.ibm.com, linux-kernel@vger.kernel.org,
       ak@muc.de, george@mvista.com
Subject: Re: [ck] [PATCH] dynamic-tick patch modified for SMP
Message-ID: <20050815153541.GA4731@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050812201946.GA5327@in.ibm.com> <200508140053.21056.kernel@kolivas.org> <20050813164618.GA4659@in.ibm.com> <200508141018.29668.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508141018.29668.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 10:18:28AM +1000, Con Kolivas wrote:
> timers that made no progress until interrupts drove the timers on again. I 
> built in both PIT and APIC dyntick mode into the kernel and the default in 
> the way I modified the patch is for APIC mode to be used if it's built in. 
> After that I modified the values using the sysfs interface at
> /sys/devices/system/dyn_tick/dyn_tick0/. In APIC mode it seems to run close to 

Con,
	I am observing the reverse problem - my patch does not work in APIC
mode. I am thinking it has to do something with disabling PIT interrupts.

Have you enabled CONFIG_DYN_TICK_USE_APIC in my patch? What does
/sys/.../dyn_tick0/state show when my patch is working (in APIC mode for you)?
Can you disable CONFIG_DYN_TICK_USE_APIC with my patch and check if it
works? Also can you send me 'dmesg | grep APIC' (want to know if your
hardware has local APIC that is enabled by the kernel).



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
