Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031736AbWLATVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031736AbWLATVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031739AbWLATVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:21:33 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:28327 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1031736AbWLATVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:21:32 -0500
In-Reply-To: <000001c71510$4bec8400$8f8c030a@amr.corp.intel.com>
References: <000001c71510$4bec8400$8f8c030a@amr.corp.intel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6629E963-BF86-4344-9FB4-331C12684A86@oracle.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Chris Mason" <chris.mason@oracle.com>
Content-Transfer-Encoding: 7bit
From: Zach Brown <zach.brown@oracle.com>
Subject: Re: [rfc patch] optimize o_direct on block device
Date: Fri, 1 Dec 2006 11:21:31 -0800
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 30, 2006, at 10:16 PM, Chen, Kenneth W wrote:

> Zach Brown wrote on Thursday, November 30, 2006 1:45 PM
>>> At that time, a patch was written for raw device to demonstrate that
>>> large performance head room is achievable (at ~20% speedup for  
>>> micro-
>>> benchmark and ~2% for db transaction processing benchmark) with a
>>> tight I/O submission processing loop.
>>
>> Where exactly does the benefit come from?  icache misses?  "atomic"
>> ops leading to pipeline flushes?
>
> It benefit from shorter path length. It takes much shorter time to  
> process
> one I/O request, both in the submit and completion path.  I always  
> think in
> terms of how many instructions, or clock ticks does it take to  
> convert user
> request into bio, submit it and in the return path, to process the  
> bio call
> back function and do the appropriate io completion (sync or async).

Sure.

What I'm hoping for is an understanding of what exactly the path is  
doing with those cycles.  Do we have any more detailed measurements  
than, say, get_cycles() before and after the call?

Maybe it's time for me to have a good sit down with systemtap :)

- z
