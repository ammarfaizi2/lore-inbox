Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263731AbUGIDFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUGIDFA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 23:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUGIDFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 23:05:00 -0400
Received: from gizmo01ps.bigpond.com ([144.140.71.11]:17829 "HELO
	gizmo01ps.bigpond.com") by vger.kernel.org with SMTP
	id S263731AbUGIDEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 23:04:53 -0400
Message-ID: <40EE0B51.3030606@bigpond.net.au>
Date: Fri, 09 Jul 2004 13:04:49 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Mike Galbraith'" <efault@gmx.de>, "'akpm@osdl.org'" <akpm@osdl.org>,
       "'rml@tech9.net'" <rml@tech9.net>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Con Kolivas'" <kernel@kolivas.org>, "'Elladan'" <elladan@eskimo.com>,
       "'Chris Siebenmann'" <cks@utcc.utoronto.ca>
Subject: Re: Maximum frequency of re-scheduling (minimum time quantum	) que
 stio n
References: <313680C9A886D511A06000204840E1CF08F42FE6@whq-msgusr-02.pit.comms.marconi.com> <40EDD980.4040608@bigpond.net.au> <40EDF8F5.2060808@yahoo.com.au>
In-Reply-To: <40EDF8F5.2060808@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Peter Williams wrote:
> 
>> Povolotsky, Alexander wrote:
>>
>>> Hi Peter,
>>>
>>>
>>>> By freeing "time slice"s from their involvement in active/expired 
>>>> priority array switching etc., the various single priority array 
>>>> schedulers (e.g. Con Kolivas's staircase scheduler and my SPA "pb" 
>>>> and "eb" schedulers) that are under development raise the 
>>>> possibility of allowing the time slice for SCHED_RR tasks to be 
>>>> different to that of ordinary tasks or even for it to be set 
>>>> separately for each SCHED_RR task.  Whether this is desirable or not 
>>>> is another question.
>>>
>>>
>>>
>>>
>>> IMHO (I am new in Linux),- if this functionality could be either 
>>> optionally
>>> configured at compile time or be optionally invokable at run time (or
>>> combination of both) - why not to have it ? - this addition enhances 
>>> choices
>>> of scheduling,
>>> which is good.
>>>
>>> Is there a chance such functionality will make into Linux 2.6 as a 
>>> patch (at
>>> some later time) ?
>>
>>
>>
>> Not until the current scheduler is replaced with a single priority 
>> array scheduler.  However, if there's enough interest, I could add 
>> this functionality to the CPU scheduler evaluation patch so that 
>> people could experiment with it (BUT it would be at the bottom of my 
>> to do list).
> 
> 
> You are mistaken. The current scheduler only uses a single array
> for realtime tasks. Functionality would be trivial to implement
> now.

OK.

> 
>>
>>>
>>> By the way - what is the "mechanism" of decision making process 
>>> (among Linux
>>> kernel developers) on such things ?
>>
>>
>>
>> I'll leave this question to someone more knowledgeable.
>>
> 
> I'd defer a final decision to others more knowlegeable of course
> (Ingo, Andrew, Linus?), however it would be almost out of the
> question to do a wholesale replacement in 2.6.
> 
> However well tested your scheduler might be, it needs several
> orders of magnitude more testing ;)

I agree (not to mention more experimenting to find good default values 
for some of the control parameters).  I was just passing on someone 
else's question.

> Maybe the best we can hope
> for is compile time selectable alternatives.

I'm hoping that a lot of the current configurable parameters in my 
schedulers can become constants.  For most of them, the reason that they 
are now configurable is to make trying out different values easier (i.e. 
no need to recompile and reboot).

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

