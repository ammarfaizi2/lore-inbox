Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264556AbTCZCSD>; Tue, 25 Mar 2003 21:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264557AbTCZCSD>; Tue, 25 Mar 2003 21:18:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:47351 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264556AbTCZCSB>;
	Tue, 25 Mar 2003 21:18:01 -0500
Message-ID: <3E811055.5040202@mvista.com>
Date: Tue, 25 Mar 2003 18:28:37 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Fionn Behrens <fionn@unix-ag.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System time warping around real time problem - please help
References: <1048609931.1601.49.camel@rtfm>	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm> <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Tue, 2003-03-25 at 22:55, Fionn Behrens wrote:
> 
>>>This all sounds very much like the TSCs are drifting WRT each other. 
>>>Is it possible that you have some power management code (or hardware) 
>>>that is slowing one cpu and not the other?
>>
>>Well, I still don't really know what TSCs actually are (or what TSC
>>stands for).

Stands for Time Stamp Counter.  It is a special cpu register that 
basically counts cpu cycles.  Some times (incorrectly me thinks) it is 
affected by power management code which slows the cpu by changing the 
cpu frequency.
>>
>>The only suspect in that case would be the amd76x_pm.o kernel module
>>which I am admittedly using. It saves about 90Watts of power when the
>>machine is idle...
> 
> 
> If you are using amd76x_pm boot with "notsc", ditto for that matter
> on dual athlons with APM or ACPI in some cases. In fact I wish people
> would stop using the tsc for clock timing altogether. It simply doesn't
> work on a lot of modern systems
> 
I agree, however, what is really needed is not available in x86 
machines, i.e. a cpu register that has a fixed and stable count rate. 
  An I/O register is second best because of the long time it takes to 
read it.
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

