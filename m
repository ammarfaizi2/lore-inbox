Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbSKRTDH>; Mon, 18 Nov 2002 14:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264723AbSKRTDH>; Mon, 18 Nov 2002 14:03:07 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:63620 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S264716AbSKRTDG>;
	Mon, 18 Nov 2002 14:03:06 -0500
Message-ID: <3DD93B06.5050602@colorfullife.com>
Date: Mon, 18 Nov 2002 20:09:58 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.48
References: <Pine.LNX.4.44.0211181056170.1018-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>On Mon, 18 Nov 2002, Manfred Spraul wrote:
>  
>
>>I think this patch should keep the interrupts disabled until after
>>smp_commenced is set. It's partially tested: bochs boots until all cpus
>>are up and then crashes.
>>    
>>
>
>This patch certainly cannot work: calibrate_delay() needs interrupts.
>  
>
Not really. calibrate_delay needs interrupts on one cpu.
The boot cpu is still around, and spinning with enabled interrupts in 
do_boot_cpu().

I haven't checked the irq routing, the timer must be fixed to the boot 
cpu, otherwise my patch is unreliable/incomplete.

--
    Manfred


