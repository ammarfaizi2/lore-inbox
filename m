Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWCaHRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWCaHRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWCaHRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:17:13 -0500
Received: from corky.net ([212.150.53.130]:19895 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S1751240AbWCaHRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:17:12 -0500
Message-ID: <442CE572.3060408@corky.net>
Date: Fri, 31 Mar 2006 09:16:50 +0100
From: Just Marc <marc@corky.net>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crash soon after an alloc_skb failure in 2.6.16 and previous,
 swap disabled
References: <442C0BA3.1050603@corky.net> <20060330145422.6c7e2517.akpm@osdl.org>
In-Reply-To: <20060330145422.6c7e2517.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,
> Just Marc <marc@corky.net> wrote:
>   
>> I'm running a few machines with swap turned off and am experiencing 
>> crashes when the system is extremely low on kernel memory.   So far the 
>> crashes observed are always inside the recv function of the Ethernet 
>> module, below is the trace for the tg3 module but a similar result is 
>> also seen with the e1000 module.   Th crash is not necessarily related 
>> to the Ethernet modules but may happen at a later stage deeper in the 
>> networking code.
>>
>> I don't have console access to the machine so I can't know what the 
>> final oops/crash message is (if any) but this can be reproduced on any 
>> machine quite easily by consuming all of the available memory,  I guess 
>> that if done at userspace the OOM killer will prevent this from 
>> happening but a simple LKM can allocate all this memory and this issue 
>> should surface quickly.
>>     
>
> We'd really need to see that final oops trace, please.
>
>   
I will get that for you once I have physical access to the machines.   
I'm hoping there would be one rather than a hard lockup.
> It's not unusual for a hard-working gigabit NIC to exhaust the page
> allocator reserves and perhaps we're a bit too noisy in the logs when it
> happens.  But it's sufficiently rare and sufficiently associated with other
> problems (like this one) that nobody has yet gone and stuck the
> __GFP_NOWARN into the relevant drivers to suppress the messages.
>
> If we really have broken something in there then someone else will hit this
> soon enough.  But nobody has, as far as I know.
>
> A digital photo of the screen would suit.
>
> Or perhaps netconsole.  If the crash is really associated with the NIC
> running out of txbufs then netconsole might not be useful.  But perhaps the
> crash is something else altogether.
>
>   
I suspect netconsole is going to have a hard time transmitting anything 
at that moment.   I'll try it anyway.

But still, this problem is highly reproducible, in my setup anyway, it 
happens to the machine once every few days.

I'll get back to you with more details as they become available.

Thanks
