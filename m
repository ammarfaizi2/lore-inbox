Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWCaOps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWCaOps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 09:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWCaOps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 09:45:48 -0500
Received: from mail.tmr.com ([64.65.253.246]:9127 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1750754AbWCaOpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 09:45:47 -0500
Message-ID: <442D41B1.1070005@tmr.com>
Date: Fri, 31 Mar 2006 09:50:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Ulrich Drepper <drepper@gmail.com>, linux-kernel@vger.kernel.org,
       jakub@redhat.com
Subject: Re: [PATCH] 2.6.16 - futex: small optimization (?)
References: <4428E7B7.8040408@bull.net> <a36005b50603280702n2979d8ddh97484615ea9d4f3a@mail.gmail.com> <4429BCAC.80208@tmr.com> <20060329152643.GA13194@elte.hu> <442C3F3F.5050107@tmr.com> <20060331060155.GA21975@elte.hu>
In-Reply-To: <20060331060155.GA21975@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>* Bill Davidsen <davidsen@tmr.com> wrote:
>
>  
>
>>>>>There are no such situations anymore in an optimal userlevel
>>>>>implementation.  The last problem (in pthread_cond_signal) was fixed
>>>>>by the addition of FUTEX_WAKE_OP.  The userlevel code you're looking
>>>>>at is simply not optimized for the modern kernels.
>>>>>          
>>>>>
>>>>What are you suggesting here, that the kernel can be inefficient as 
>>>>long as the user has a way to program around it?
>>>>        
>>>>
>>>What are you suggesting here, that FUTEX_WAKE_UP is a "user way to 
>>>program around" an inefficiency? If yes then please explain to me why 
>>>and what you would do differently.
>>>      
>>>
>>The point I'm making is that even if an application is "not optimized 
>>for modern kernels" or whatever, there's no reason to ignore 
>>inefficiencies. [...]
>>    
>>
>
>What are you suggesting here, that the implementation of FUTEX_WAKE_UP
>is "ignoring inefficiencies"? Please explain why and what you would do
>differently to solve that inefficiency.
>  
>
I am suggesting that "There are no such situations anymore in an optimal 
userlevel implementation" is not the right approach to the original 
post. What I would do differently is to evaluate the original suggestion 
to see if it would in fact be more efficient. Please read the original 
post and take it on merit, it's either an optimizationn or not, and 
obviously it's used even if not by some "optimal" user code.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

