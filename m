Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWITUR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWITUR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWITUR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:17:27 -0400
Received: from vms048pub.verizon.net ([206.46.252.48]:6586 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S1750724AbWITUR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:17:26 -0400
Date: Wed, 20 Sep 2006 16:17:24 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.18-rt1
In-reply-to: <1158777240.29177.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
To: linux-kernel@vger.kernel.org
Cc: Daniel Walker <dwalker@mvista.com>, paulmck@us.ibm.com,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Message-id: <200609201617.24961.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060920141907.GA30765@elte.hu> <20060920182553.GC1292@us.ibm.com>
 <1158777240.29177.16.camel@c-67-180-230-165.hsd1.ca.comcast.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 September 2006 14:34, Daniel Walker wrote:
>On Wed, 2006-09-20 at 11:25 -0700, Paul E. McKenney wrote:
>> OK, using that instead.
>>
>> I get the following at startup, which probably means that I need to use
>> some machine other than a NUMA-Q.  Trying a different machine...
>>
>>       Thanx, Paul
>>
>> BUG: unable to handle kernel NULL pointer dereference at virtual
>> address 00000000 printing eip:
>> c01151ff
>> *pde = 34d21001
>> *pte = 00000000
>> stopped custom tracer.
>> Oops: 0000 [#1]
>> PREEMPT SMP
>> Modules linked in:
>> CPU:    2
>> EIP:    0060:[<c01151ff>]    Not tainted VLI
>> EFLAGS: 00010246   (2.6.18-rt2-autokern1 #1)
>> EIP is at __wake_up_common+0x10/0x55
>
>I get this too, it happens when HRT is off.. If you turn HRT on it will
>boot .. I haven't found a fix for it, but I imagine Thomas will find it
>soon.
>
>Daniel

I'm re-building with HRT on now, but I just noticed another side effect of 
2.6.18.  I have an led sniffer plugged into the pl2302 usb<->serial 
adaptor laying where I can see it, and all leds are red, as if the 
interface has not been inited properly.  And I don't see it being 
initialized in the dmesg.  I thought the default was to build it.  Yup, 
pl2303.ko is present in the /lib/modules trees all across the board.

Any ideas on this one folks?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
