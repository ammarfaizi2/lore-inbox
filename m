Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWCENNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCENNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 08:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWCENNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 08:13:45 -0500
Received: from smtp02.ya.com ([62.151.11.161]:61598 "EHLO smtpauth.ya.com")
	by vger.kernel.org with ESMTP id S1750705AbWCENNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 08:13:45 -0500
Message-ID: <440AE3F3.3090404@ya.com>
Date: Sun, 05 Mar 2006 14:13:23 +0100
From: =?ISO-8859-1?Q?Ra=FAl_Baena?= <raul_baena@ya.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: es-es, es
MIME-Version: 1.0
To: jonathan@jonmasters.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Doubt about scheduler
References: <4407584A.60301@ya.com> <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
In-Reply-To: <35fb2e590603032233i7302162do553ba61674cc8e50@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much Jon. But I think I haven´t explained very well.

I know that now the prio_array and runqueues structs aren´t accesible 
for modules, but in the 2.6.5 version they were. I would like to know 
the reason, why before they were accesible and now they don´t? If you 
could answer me, it would be great. I could to write the reason in my 
university job. (In Spain we have to make a final degree job, and mine 
is about modules in linux (I chose this), I would like to show 
information of the new scheduler, a scheduler monitor, and these fields 
are indispensable for me)
I thought in your solution (own kernel tree), but I would like to make a 
module that worked in standard distributions. I prefer to make a module 
that worked in 2.6.5 version instead to make one that worked in 2.6.12 
but with my own kernel tree. So I suposse that I will do that, but 
knowing the reason why could serve me to make a better investigation 
document.

Thank you again for your help, I will mention you in my final degree job 
acknowledge. Please, keep helping me!!! :)



Jon Masters escribió:

>On 3/2/06, Raúl Baena <raul_baena@ya.com> wrote:
>
>  
>
>>Hello!!!, I´m a student of computer science and I´m doing my final
>>degree job in linux. It is about "linux kernel modules" , I have to know
>>some things of the scheduler. The runqueue struct, and so on. The
>>problem is that in the last linux kernel version in the "sched.h" isn´t
>>defined these structs (prio_array, runqueue...), and I cann´t access to
>>runqueue or prio_array fields. I know that in the 2.6.5 kernel version
>>these fields were accessible and now don´t, could you tell me what is
>>the reason please?
>>    
>>
>
>Deliberately, these aren't available outside of the scheduler so that
>they can't be played with. Much as things like the symbol table aren't
>exported to modules, some things in the kernel aren't even available
>to other parts of the core kernel :-)
>
>  
>
>> I think that I´m going to do it (the module) in the 2.6.5 kernel
>>version and will try to explain why, and for this I need your help.
>>    
>>
>
>If you really need to play with this stuff, then why not just make
>your own kernel tree with this hacked up in the scheduler code itself?
>If it's just for you, then that'll work fine. If you would explain
>what it is that you need to do, then someone might be able to offer
>you advice on the general direction to take - see also
>http://www.kernelnewbies.org/
>
>Jon.
>
>
>
>  
>

