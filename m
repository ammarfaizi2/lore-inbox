Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264916AbSJVSRw>; Tue, 22 Oct 2002 14:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264838AbSJVSCw>; Tue, 22 Oct 2002 14:02:52 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:27408 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S264813AbSJVSCX>;
	Tue, 22 Oct 2002 14:02:23 -0400
Message-ID: <3DB59431.2090807@mvista.com>
Date: Tue, 22 Oct 2002 13:08:49 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
References: <3DB4AABF.9020400@mvista.com>	<20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com>	<20021022025346.GC41678@compsoc.man.ac.uk>  <3DB54C53.9010603@mvista.com> <1035307430.1008.1476.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>On Tue, 2002-10-22 at 09:02, Corey Minyard wrote:
>
>  
>
>>I looked, and the rcu code relys on turning off interrupts to avoid 
>>preemption.  So it won't work.
>>    
>>
>
>At least on the variant of RCU that is in 2.5, the RCU code does the
>read side by disabling preemption.  Nothing else.
>
In 2.5.44, stock from kernel.org, rcu_process_callbacks() calls 
local_irq_disable().  Is that just preemption disabling, now?

>The write side is the same with or without preemption - wait until all
>readers are quiescent, change the copy, etc.
>
>But anyhow, disabling interrupts should not affect NMIs, no?
>
You are correct.  disabling preemption or interrupts has no effect on NMIs.

-Corey

