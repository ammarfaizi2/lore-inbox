Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUL2W4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUL2W4H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 17:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUL2W4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 17:56:06 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:26344 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261437AbUL2WzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 17:55:01 -0500
Message-ID: <41D33603.9060501@kolivas.org>
Date: Thu, 30 Dec 2004 09:56:03 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: Maciej Soltysiak <solt2@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org
Subject: Re: Trying out SCHED_BATCH
References: <m3mzw262cu.fsf@rajsekar.pc> <41CD51E6.1070105@kolivas.org>	 <04ef01c4ede2$ff4a7cc0$0e25fe0a@pysiak> <41D31373.1090801@kolivas.org> <4d8e3fd304122914466b42c632@mail.gmail.com>
In-Reply-To: <4d8e3fd304122914466b42c632@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Ciarrocchi wrote:
> On Thu, 30 Dec 2004 07:28:35 +1100, Con Kolivas <kernel@kolivas.org> wrote:
> 
>>Maciej Soltysiak wrote:
>>
>>>Hi
>>>
>>>Con wrote:
>>>
>>>
>>>>Only the staircase scheduler currently has an implementation of
>>>>sched_batch and you need 2 more patches on top of the staircase patch
>>>>for it to work.
>>>
>>>Hmm, Is it feasable to write a sched_batch policy for the current linux
>>>schedulers?
>>
>>Yes.
>>
>>The proper way to make a sched_batch implementation is more
>>comprehensive than what is made for staircase to prevent a deadlock
>>based on a batch task getting an important lock in the kernel and not
>>being able to release it due to a sched_normal task being higher
>>priority than it that is actually trying to get the lock. There is code
>>in the staircase version to prevent this from happening but probably not
>>complete enough in design to prevent everything. However it works and I
>>haven't had any reports of lockups since I implemented the extra checking.
>>
>>Would you like me to create a version like that? I don't have the time
>>to try and make a more comprehensive solution and follow the debugging
>>of such a beast.
>>
>>
>>>I mean, if there are people that want it bad, maybe it would be nice to
>>>be able
>>>to use a version of sched_batch that would work without the staircase
>>>scheduler.
>>>It is still experimental, right?
>>
>>No it's not experimental. It is very stable and used in production systems.
> 
> 
> Are you gointo  to push to Linus/Andrew ?

Staircase? I'm still in pain from the last time I tried to push it in a 
more palatable form via the plugsched architecture which took me a long 
time to do. I don't have the fortitude to go through that again in a hurry.

Cheers,
Con
