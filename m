Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261731AbTCZQCS>; Wed, 26 Mar 2003 11:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261745AbTCZQCS>; Wed, 26 Mar 2003 11:02:18 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54771 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261731AbTCZQCR>;
	Wed, 26 Mar 2003 11:02:17 -0500
Message-ID: <3E81D183.6040708@mvista.com>
Date: Wed, 26 Mar 2003 08:12:51 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Fionn Behrens <fionn@unix-ag.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: System time warping around real time problem - please help
References: <1048609931.1601.49.camel@rtfm>	 <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>	 <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm>	 <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>	 <3E811055.5040202@mvista.com> <1048689492.31839.13.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1048689492.31839.13.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Wed, 2003-03-26 at 02:28, george anzinger wrote:
> 
>>Stands for Time Stamp Counter.  It is a special cpu register that 
>>basically counts cpu cycles.  Some times (incorrectly me thinks) it is 
>>affected by power management code which slows the cpu by changing the 
>>cpu frequency.
> 
> 
> Not incorrectly. It counts cpu clocks, its designed for profiling and
> the like. There is no guarantee in any Intel MP standard that the clocks
> are synched up.


> 
I seem to recall a different notion of correctness from Andy Grover... 
  but memory may deceive :(


As for sync, I would think it is a mother board issue.

But as you say, Intel should put in a usable counter.  The HPET seems 
like it has the capabilities, however, I suspect that it is a slow 
read.  Any idea how many cycles it takes to do a memory mapped I/O access?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

