Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422778AbWHYT0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422778AbWHYT0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 15:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHYT0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 15:26:53 -0400
Received: from mga07.intel.com ([143.182.124.22]:28014 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1422778AbWHYT0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 15:26:52 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,169,1154934000"; 
   d="scan'208"; a="107690935:sNHT33980891"
Message-ID: <44EF4EED.2040904@linux.intel.com>
Date: Fri, 25 Aug 2006 21:26:37 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: linux-kernel@vger.kernel.org, len.brown@intel.com, mingo@elte.hu,
       akpm@osdl.org, jbarnes@virtuousgeek.org, nickpiggin@yahoo.com.au
Subject: Re: [RFC] maximum latency tracking infrastructure (version 2)
References: <1156504939.3032.26.camel@laptopd505.fenrus.org> <1156520608.10471.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
In-Reply-To: <1156520608.10471.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Fri, 2006-08-25 at 13:22 +0200, Arjan van de Ven wrote:
> 
>> +void set_acceptable_latency(char *identifier, int usecs);
>> +void modify_acceptable_latency(char *identifier, int usecs);
>> +void remove_acceptable_latency(char *identifier);
>> +void synchronize_acceptable_latency(void);
>> +int system_latency_constraint(void);
>> +
>> +int register_latency_notifier(struct notifier_block * nb);
>> +int unregister_latency_notifier(struct notifier_block * nb);
> 
> 
> The name space here is bugging me a little. Maybe prefix them with
> "pm_latency" so you'd have "pm_latency_set_acceptable()" ,
> "pm_latency_modify_acceptable()" , something like that. Likewise with
> the file names , "include/linux/pm_latency.h"
> 

there is no reason why this should JUST be about power management....
