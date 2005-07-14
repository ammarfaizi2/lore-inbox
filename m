Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVGNLWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVGNLWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 07:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbVGNLWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 07:22:41 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:22657
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263013AbVGNLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 07:22:41 -0400
Message-ID: <42D64A85.7020305@prodmail.net>
Date: Thu, 14 Jul 2005 16:50:37 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Thread_Id
References: <4mfcK-UT-25@gated-at.bofh.it> <4mUJ1-5ZG-23@gated-at.bofh.it>	 <42CB465E.6080104@shaw.ca>  <42D5F934.6000603@prodmail.net>	 <1121327103.3967.14.camel@laptopd505.fenrus.org>	 <42D63916.7000007@prodmail.net> <1121337052.3967.25.camel@laptopd505.fenrus.org>
In-Reply-To: <1121337052.3967.25.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Thu, 2005-07-14 at 15:36 +0530, RVK wrote:
>
>  
>
>>>it doesn't return a number it returns a pointer ;) or a floating point
>>>number. You don't know :)
>>>
>>>what it returns is a *cookie*. A cookie that you can only use to pass
>>>back to various pthread functions.
>>>
>>>
>>>
>>>      
>>>
>>Hahaha......common. Please clarify following....
>>    
>>
>
>I'm missing the joke
>
>  
>
Its not a joke its a confusion created by the thread identifier.

>>SYNOPSIS
>>       #include <pthread.h>
>>
>>       pthread_t pthread_self(void);
>>
>>DESCRIPTION
>>       pthread_self return the thread identifier for the calling thread.
>>    
>>
>
>*identifier*.
>It doesn't give a meaning beyond that, and if you look at other pthread
>manpages (say pthread_join) it just wants that identifier back. If you
>want to attach meaning to a thread identifier, please come up with a
>manpage/standard that actually defines the meaning of it.
>
>  
>
>>bits/pthreadtypes.h:150:typedef unsigned long int pthread_t;
>>    
>>
>
>and here you
>1) look at implementation details of your specific threading
>implementation and
>2) you prove that your analysis is wrong since the implementation you
>look at defines it as *unsigned* so it can't be negative. So what your
>app does is clearly wrong even within the implementation you look at.
>
>
>  
>
So then what is the meaning of that typedef and why its still there ?

>Other implementations are allowed to use different types for this. In
>fact, I'd be surprised if NPTL and LinuxThreads would have the same
>type... (they'll have the same size for ABI compat reasons of course,
>but type... not so sure).
>
>  
>
I haven't faced the same returns with 2.4.18. So why is it so with 2.6.x 
kernels ? pthread_self() on 2.4.18 was returning the same as gettid() 
with 2.6.x.

rvk

>.
>
>  
>

