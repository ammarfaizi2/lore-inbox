Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTLKIOy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264395AbTLKIOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:14:53 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:29369 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264387AbTLKIOu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:14:50 -0500
Message-ID: <3FD82775.3050303@cyberone.com.au>
Date: Thu, 11 Dec 2003 19:14:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rhino <rhino9@terra.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>,
       wli@holomorphy.com
Subject: Re: [CFT][RFC] HT scheduler
References: <3FD3FD52.7020001@cyberone.com.au>	<20031208155904.GF19412@krispykreme>	<3FD50456.3050003@cyberone.com.au>	<20031209001412.GG19412@krispykreme>	<3FD7F1B9.5080100@cyberone.com.au>	<3FD81BA4.8070602@cyberone.com.au> <20031211060120.4769a0e8.rhino9@terra.com.br>
In-Reply-To: <20031211060120.4769a0e8.rhino9@terra.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rhino wrote:

>On Thu, 11 Dec 2003 18:24:20 +1100
>Nick Piggin <piggin@cyberone.com.au> wrote:
>
>
>>
>>Nick Piggin wrote:
>>
>>
>>>http://www.kerneltrap.org/~npiggin/w26/
>>>Against 2.6.0-test11
>>>
>>
>>Oh, this patchset also (mostly) cures my pet hate for the
>>last few months: VolanoMark on the NUMA.
>>
>>http://www.kerneltrap.org/~npiggin/w26/vmark.html
>>
>>The "average" plot for w26 I think is a little misleading because
>>it got an unlucky result on the second last point making it look
>>like its has a downward curve. It is usually more linear with a
>>sharp downward spike at 150 rooms like the "maximum" plot.
>>
>>Don't ask me why it runs out of steam at 150 rooms. hackbench does
>>something similar. I think it might be due to some resource running
>>short, or a scalability problem somewhere else.
>>
>
>i didn't had the time to apply the patches (w26 and C1 from ingo ) 
>on a vanilla t11, but i merged them with the wli-2,btw this one has really put 
>my box on steroids ;) .
>

You won't be able to merge mine with Ingo's. Which one put the box on
steroids? :)

>
>none of them finished a hackbench 320 run, the OOM killed all of my
>agetty's logging me out. the box is a 1way p4(HT) 1gb of ram 
>and no swap heh.
>
>
>	hackbench:
>
>	sched-rollup-w26		sched-SMT-2.6.0-test11-C1
>		
>	 50	 4.839			 50	5.200
>	100	 9.415			100	10.090
>	150	14.469			150	14.764
>
>	
>
>	time tar -xvjpf linux-2.6.0-test11.tar.bz2:
>
>	sched-rollup-w26		sched-SMT-2.6.0-test11-C1
>	
>	real		43.396		real		23.136
>
                           ^^^^^^

>
>	user		27.608		user		20.700
>	sys		 4.039		sys		 4.344
>

Wonder whats going on here? Is this my patch vs Ingo's with nothing else 
applied?
How does plain 2.6.0-test11 go?

Thanks for testing.


