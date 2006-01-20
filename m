Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWATVbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWATVbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWATVbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:31:03 -0500
Received: from gw02.applegatebroadband.net ([207.55.227.2]:57584 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S1750781AbWATVbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:31:02 -0500
Message-ID: <43D1564D.2000303@wildturkeyranch.net>
Date: Fri, 20 Jan 2006 13:29:49 -0800
From: George Anzinger <george@wildturkeyranch.net>
Reply-To: george@wildturkeyranch.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: john stultz <johnstul@us.ibm.com>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: BUG in check_monotonic_clock()
References: <1137779515.3202.3.camel@localhost.localdomain>	 <1137782296.27699.253.camel@cog.beaverton.ibm.com>	 <1137782896.3202.9.camel@localhost.localdomain>	 <1137783149.27699.256.camel@cog.beaverton.ibm.com>	 <1137783751.3202.11.camel@localhost.localdomain>	 <1137784177.27699.260.camel@cog.beaverton.ibm.com> <1137784987.3202.14.camel@localhost.localdomain>
In-Reply-To: <1137784987.3202.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> On Fri, 2006-01-20 at 11:09 -0800, john stultz wrote:
> 
> 
>>That's what I was guessing. So there aren't any TSC inconsistency
>>messages in the dmesg? Odd.
> 
> 
> I didn't see any ..
> 
> 
>>>Isn't there a handy proc entry for this? 
>>
>>Yep, there's a sysfs entry:
>>
>>	/sys/devices/system/clocksource/clocksource0/current_clocksource 
> 
> 
> Great! The patch that George sent me fixed it .. Thanks George !

By the way, this means you are using a 64-bit ktime and not the dual 32-bit 
ktime.  This _may_ not be what you want on a 32-bit kernel.  There is a 
config option to change this....

-- 
George Anzinger   george@wildturkeyranch.net
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
