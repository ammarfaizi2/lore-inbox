Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288029AbSABXve>; Wed, 2 Jan 2002 18:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287972AbSABXu3>; Wed, 2 Jan 2002 18:50:29 -0500
Received: from freeside.toyota.com ([63.87.74.7]:60684 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S288014AbSABXt7>; Wed, 2 Jan 2002 18:49:59 -0500
Message-ID: <3C339C98.8080207@lexus.com>
Date: Wed, 02 Jan 2002 15:49:44 -0800
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dieter =?ISO-8859-15?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>
Subject: Re: Linux 2.4.17 vs 2.2.19 vs rml new VM
In-Reply-To: <20020102231431Z287173-13997+212@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well it is possible that with the several patches
you mention that I might see results similar to
what I now see with the low-latency patch.

However -

The preempt patch does NOT play well with the
tux webserver, which I am using. So, preempt is
not an option for me until and unless it is cleaned
up to allow cooperation with tux.

tux and low-latency get along just fine.

cu

jjs

Dieter Nützel wrote:

>On Tuesday, 2. January 2002 20:50, Alan cox wrote:
>
>>>I find the low latency patch makes a noticeable
>>>difference in e.g. q3a and rtcw - OTOH I have
>>>not been able to discern any tangible difference
>>>from the stock kernel when using -preempt.
>>>
>>The measurements I've seen put lowlatency ahead of pre-empt in quality
>>of results. Since low latency fixes some of the locked latencies it might
>>be interesting for someone with time to benchmark
>>
>>       vanilla
>>       low latency
>>       pre-empt
>>       both together
>>
>
>Don't forget that you have to use preempt-kernel-rml + lock-break-rml to 
>achieve the same (more) than the latency patch.
>
>Taken from Robert's page and running it for some weeks, now.
>
>[-]
>Lock breaking for the Preemptible Kernel
>lock-break-rml-2.4.15-1
>lock-break-rml-2.4.16-3
>lock-break-rml-2.4.17-2
>lock-break-rml-2.4.18-pre1-1
>README
>ChangeLog
>With the preemptible kernel, the need for explicit scheduling points, like in 
>the low-latency patches, are no more. However, since we can not preempt while 
>locks are held, we can take a similar model as low-latency and "break" (drop 
>and immediately reacquire) locks to improve system response. The trick is 
>finding when and where we can safely break the locks (periods of quiescence) 
>and how to safely recover. The majority of the lock breaking is in the VM and 
>VFS code. This patch is for users with strong system response requirements 
>affected by the worst-case latencies caused by long-held locks.
>[-]
>
>Regards,
>	Dieter
>


