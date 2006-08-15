Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965351AbWHOKF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351AbWHOKF2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965354AbWHOKF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:05:28 -0400
Received: from mx03.stofanet.dk ([212.10.10.13]:3207 "EHLO mx03.stofanet.dk")
	by vger.kernel.org with ESMTP id S965351AbWHOKF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:05:27 -0400
Date: Tue, 15 Aug 2006 12:05:09 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@gogglemail.com>
X-X-Sender: simlo@frodo.shire
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Esben Nielsen <nielsen.esben@gogglemail.com>,
       Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Esben Nielsen <nielsen.esben@googlemail.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cleanup and remove some extra spinlocks from rtmutex
In-Reply-To: <20060815142605.GA232@oleg>
Message-ID: <Pine.LNX.4.64.0608151204400.10351@frodo.shire>
References: <1154439588.25445.31.camel@localhost.localdomain>
 <20060813190326.GA2276@oleg> <Pine.LNX.4.64.0608142217400.10597@frodo.shire>
 <20060815110353.GA111@oleg> <Pine.LNX.4.64.0608151152110.10351@frodo.shire>
 <20060815142605.GA232@oleg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Aug 2006, Oleg Nesterov wrote:

> On 08/15, Esben Nielsen wrote:
>>
>> On Tue, 15 Aug 2006, Oleg Nesterov wrote:
>>>
>>> task->pi_blocked_on != NULL, we hold task->pi_blocked_on->lock->wait_lock.
>>> Can it go away ?
>>
>> That is correct. But does it make the code more readable?
>
> Well, in my opinion - yes. But yes, it's only my personal feeling :)
>
>>                                                            When you read
>> the code you shouldn't need to go into that kind of complicated arguments
>> to see the correctness - unless the code can't be written otherwise.
>
> Sure, this needs a comment.

It is even better if you can read the code without a comment. Good code 
doesn't need comments.

Esben

>
> Thanks again,
>
> Oleg.
>
