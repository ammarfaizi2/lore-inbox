Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTJ0XYh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263765AbTJ0XYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:24:37 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:62190 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263764AbTJ0XYf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:24:35 -0500
Message-ID: <3F9DA930.9010103@mvista.com>
Date: Mon, 27 Oct 2003 15:24:32 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: John stultz <johnstul@us.ibm.com>, Patrick Mochel <mochel@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix time after suspend-to-*
References: <20031022233306.GA6461@elf.ucw.cz> <1066866741.1114.71.camel@cog.beaverton.ibm.com> <20031023081750.GB854@openzaurus.ucw.cz> <3F9838B4.5010401@mvista.com> <1066942532.1119.98.camel@cog.beaverton.ibm.com> <3F985FB0.1070901@mvista.com> <1066955396.1122.133.camel@cog.beaverton.ibm.com> <3F988A0B.4010803@mvista.com> <20031024074811.GA1519@elf.ucw.cz>
In-Reply-To: <20031024074811.GA1519@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>The request can be on the wall clock or on clock_monotonic.  Still, we went 
>>round and round about how a tick on one should be a tick on the other.  My 
>>understanding is that the pm_timer was put in the ACPIC to handle this, but 
>>then I don't know how far down power is going, nor for how long.  I would 
>>think at some point the discontinuity would be large enough that one would 
>>want some user service to run and "fix" all the broken time assumptions.  
>>Some sort of a soft reboot that would kick the ntp code, cron and so on, 
>>much as is done at boot.
> 
> 
> Well, it is well possible that discontinuity is days (it usually is 8
> hours for me -- I suspend-to-disk before going to sleep), and nothing
> prevents you from suspending machine for half a year.
> 

Ok, but then is there some sort of house cleaning that happens to clean up the 
mess?  I am thinking something like the run level change where scripts might run 
to "fix" things.

Now it could be that my ignorance is showing here, possibly this is all being 
done already...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

