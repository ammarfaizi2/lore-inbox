Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTJQWsx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 18:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbTJQWsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 18:48:53 -0400
Received: from dyn-ctb-210-9-245-184.webone.com.au ([210.9.245.184]:20484 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S261159AbTJQWsv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 18:48:51 -0400
Message-ID: <3F9071C3.5070909@cyberone.com.au>
Date: Sat, 18 Oct 2003 08:48:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: decaying average for %CPU
References: <1066358155.15931.145.camel@cube>	 <3F8F5A53.50209@cyberone.com.au> <1066359629.15920.161.camel@cube>	 <3F8F6020.2040206@cyberone.com.au> <1066364241.15931.180.camel@cube>
In-Reply-To: <1066364241.15931.180.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Albert Cahalan wrote:

>On Thu, 2003-10-16 at 23:21, Nick Piggin wrote:
>  
>
>>Albert Cahalan wrote:
>>    
>>
>>>On Thu, 2003-10-16 at 22:56, Nick Piggin wrote:
>>>      
>>>
>>>>Albert Cahalan wrote:
>>>>
>>>>        
>>>>
>>>>>The UNIX standard requires that Linux provide
>>>>>some measure of a process's "recent" CPU usage.
>>>>>Right now, it isn't provided. You might run a
>>>>>CPU hog for a year, stop it ("kill -STOP 42")
>>>>>for a few hours, and see that "ps" is still
>>>>>reporting 99.9% CPU usage. This is because the
>>>>>kernel does not provide a decaying average.
>>>>>
>>>>>          
>>>>>
>>>>I think the kernel provides enough info for userspace to do
>>>>the job, doesn't it?
>>>>
>>>>        
>>>>
>>>I'm pretty sure not. Linux provides:
>>>
>>>per-process start time
>>>current time
>>>per-process total (lifetime) CPU usage
>>>units of time measurement (awkwardly)
>>>boot time
>>>      
>>>
>>But your userspace program can calculate deltas in the total
>>CPU statistics. Yep, its in /proc/stat.
>>    
>>
>
>Huh?
>
>This isn't about "top", which displays % of CPU
>time used over the refresh interval by reading
>all the process data multiple times.
>
>This is about programs like "ps", which read
>everything and then spit out the output.
>
>I hope you're not suggesting to read things
>twice with a huge sleep(5) in the middle, or
>to run some kind of daemon that polls /proc
>once a second. That's far beyond horrid.
>  
>

Yeah I spose it is.


