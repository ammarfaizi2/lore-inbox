Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWA0WI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWA0WI7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422645AbWA0WI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:08:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44184 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422644AbWA0WI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:08:58 -0500
Message-ID: <43DA99EB.6020909@sgi.com>
Date: Fri, 27 Jan 2006 17:08:43 -0500
From: Prarit Bhargava <prarit@sgi.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@redhat.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: boot-time slowdown for measure_migration_cost
References: <B8E391BBE9FE384DAA4C5C003888BE6F058CC7A6@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F058CC7A6@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
>>The boot-time migration cost auto-tuning stuff seems to have
>>been merged to Linus' tree since 2.6.15.  On little one- or
>>two-processor systems, the time required to measure the
>>migration costs isn't very noticeable, but by the time we
>>get to even a four-processor ia64 box, it adds about
>>30 seconds to the boot time, which seems like a lot.
> 
> 
> I only see about 16 seconds for a 4-way tiger (not that 16 seconds
> is good ... but it not as bad as 30).  This was with a build
> from tiger_defconfig that sets CONFIG_NR_CPUS=4 ... so I wonder
> what's causing the factor of two.  I measured with a printk
> each side of build_sched_domains() and booted with the "time"
> command line arg to get:

I've noticed the delay on a 16p and 64p.  At first I thought it was a 
system hang but have since learned to live with the delay.

  What happens on a 512 cpu
> Altix (if it's quadratic, they may be still waiting for the
> boot to finish :-)


Not quadratic.  This is a 64p Altix ...

[    9.942253] Brought up 64 CPUs
[    9.942904] Total of 64 processors activated (143654.91 BogoMIPS).
[    9.943995] build_sched_domains: start
[   32.108439] migration_cost=0,32232,39021
[   37.894391] build_sched_domains: end

P.

> 
> -Tony
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

