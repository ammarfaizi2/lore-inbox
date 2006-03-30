Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWC3SoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWC3SoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 13:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbWC3SoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 13:44:16 -0500
Received: from corky.net ([212.150.53.130]:9892 "EHLO zebday.corky.net")
	by vger.kernel.org with ESMTP id S1750716AbWC3SoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 13:44:16 -0500
Message-ID: <442C34F9.8000602@corky.net>
Date: Thu, 30 Mar 2006 20:43:53 +0100
From: Just Marc <marc@corky.net>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crash soon after an alloc_skb failure in 2.6.16 and previous,
 swap disabled
References: <442C0BA3.1050603@corky.net> <Pine.LNX.4.61.0603301059420.738@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603301059420.738@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP on CorKy.NeT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
>> I'm running a few machines with swap turned off and am experiencing
>> crashes when the system is extremely low on kernel memory.   So far the
>> crashes observed are always inside the recv function of the Ethernet
>>     
> [SNIPPED...]
>
> Huh? If no buffers are available, received packets get thrown on the
> floor. I see the failure(s) happened in an interrupt. If so, the
> problem is in the network driver and your starved memory situation
> brought out a bug.
>
>   
The printout to the kernel log I attached to the previous email still 
does not mean the crash occurred there and then.
>> The benefits of running a system without swap are arguable, but in my
>> particular scenario I prefer to have connections dropped rather than
>> experience the overheads and latencies of a heavily swapping system.
>>     
>
> I read this as; "I want the advantages of swap, but I don't want
> to use swap." Or, "It doesn't work as I expected so therefore it's
> broken!" In any event, swap is used to handle the problems with a
> finite amount of memory. Normally sleeping tasks get swapped out,
> freeing their memory for your network stuff. If you don't have swap,
> that memory can't be freed. Tough! You did it, so you live with
> it -- but contact the maintainer of your network card. You may
> have forced a bug to come to the surface.
>
>   
In most cases you are right, in my case, there is almost no application 
used RAM and therefore nothing to be freed.   In my particular case I 
don't *really* need memory freed, I know a little odd.

But, as this is issue is occurring with at least e1000 and tg3 the bug 
might not be in these particular drivers.   As I do not have a crash 
dump or log of what happened when the system froze, I have no way of 
knowing.

As this problem is easily reproducible, I'll leave it to the kernel 
people involved to dig into it, that is of course, if they are interested.

Thanks
