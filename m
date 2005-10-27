Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVJ0IA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVJ0IA7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbVJ0IA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:00:59 -0400
Received: from smtpa1.netcabo.pt ([212.113.174.16]:18662 "EHLO
	exch01smtp03.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S964985AbVJ0IA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:00:59 -0400
Message-ID: <43608972.6070501@rncbc.org>
Date: Thu, 27 Oct 2005 09:01:54 +0100
From: Rui Nuno Capela <rncbc@rncbc.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: William Weston <weston@lysdexia.org>, george@mvista.com,
       Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
References: <1129852531.5227.4.camel@cmn3.stanford.edu>	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>	 <20051022035851.GC12751@elte.hu>	 <1130182121.4983.7.camel@cmn3.stanford.edu>	 <1130182717.4637.2.camel@cmn3.stanford.edu>	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>	 <20051025154440.GA12149@elte.hu>	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>	 <435E91AA.7080900@mvista.com> <20051026082800.GB28660@elte.hu>	 <435FA8BD.4050105@mvista.com> <435FBA34.5040000@mvista.com>	 <435FEAE7.8090104@rncbc.org>	 <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org> <1130371042.21118.76.camel@localhost.localdomain>
In-Reply-To: <1130371042.21118.76.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2005 08:00:51.0264 (UTC) FILETIME=[8C574400:01C5DACC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> 
>>On Wed, 26 Oct 2005, Rui Nuno Capela wrote:
>>
>>
>>>Just noticed a couple or more of this on dmesg. Maybe its old news and 
>>>being discussed already. Otherwise my P4@2.53Ghz/UP laptop boots and 
>>>runs without hicups on 2.6.14-rc5-rt7 (config.gz attached).
>>>
>>>... time warped from 13551912584 to 13551905960.
>>>... system time:     13488892865 .. 13488892865.
>>>udevstart/1579[CPU#0]: BUG in get_monotonic_clock_ts at 
>>>kernel/time/timeofday.c:
>>>262
>>>  [<c0116fcb>] __WARN_ON+0x4f/0x6c (8)
>>>  [<c012f8b0>] get_monotonic_clock_ts+0x27a/0x2f0 (40)
>>>  [<c0141c9d>] kmem_cache_alloc+0x51/0xac (76)
>>>  [<c0114826>] copy_process+0x2ff/0xeed (44)
>>>  [<c0139444>] unlock_page+0x17/0x4a (12)
>>>  [<c0147a8a>] do_wp_page+0x245/0x372 (20)
>>>  [<c01154f5>] do_fork+0x69/0x1b5 (56)
>>>  [<c02c120b>] do_page_fault+0x432/0x543 (32)
>>>  [<c01017aa>] sys_clone+0x32/0x36 (72)
>>>  [<c0102a9b>] sysenter_past_esp+0x54/0x75 (16)
>>
 >>[...]
> 
> Also, Rui, do they show up at different times or clustered together?
> (William, I see your output is clustered) The reason I asked, is that
> the test may produce more than one warning message for the same time
> warp. Since the time used to check for the time warp is not updated if
> time goes backwards, so if you call the this routine more than once
> before the time warp catches back up, it will warn again.
> 

Don't really know if its consistent, but it does occur on several times, 
on only on boot.

Sorry for the delay.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


