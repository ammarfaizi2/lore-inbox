Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWCRMgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWCRMgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 07:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWCRMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 07:36:55 -0500
Received: from mail.tmr.com ([64.65.253.246]:7051 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S1751349AbWCRMgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 07:36:55 -0500
Message-ID: <441BFF38.9000300@tmr.com>
Date: Sat, 18 Mar 2006 07:38:16 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: can I bring Linux down by running "renice -20 cpu_intensive_process"?
References: <441180DD.3020206@wpkg.org>	<Pine.LNX.4.61.0603101540310.23690@yvahk01.tjqt.qr>	<yw1xbqwe2c2x.fsf@agrajag.inprovide.com>	<1142135077.25358.47.camel@mindpipe>	<yw1xk6azdgae.fsf@agrajag.inprovide.com> <4419D575.4080203@tmr.com> <yw1xbqw69f6j.fsf@agrajag.inprovide.com>
In-Reply-To: <yw1xbqw69f6j.fsf@agrajag.inprovide.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

>Bill Davidsen <davidsen@tmr.com> writes:
>
>  
>
>>Måns Rullgård wrote:
>>    
>>
>>>Lee Revell <rlrevell@joe-job.com> writes:
>>>
>>>      
>>>
>>>>On Fri, 2006-03-10 at 22:01 +0000, Måns Rullgård wrote:
>>>>        
>>>>
>>>>>Jan Engelhardt <jengelh@linux01.gwdg.de> writes:
>>>>>
>>>>>          
>>>>>
>>>>>>>Subject: can I bring Linux down by running "renice -20
>>>>>>>cpu_intensive_process"?
>>>>>>>
>>>>>>>              
>>>>>>>
>>>>>>Depends on what the cpu_intensive_process does. If it tries to
>>>>>>allocate lots of memory, maybe. If it's _just_ CPU (as in `perl
>>>>>>-e '1 while 1'`), you get a chance that you can input some
>>>>>>commands on a terminal to kill it.  SCHED_FIFO'ing or
>>>>>>SCHED_RR'ing such a process is sudden death of course.
>>>>>>            
>>>>>>
>>>>>Sysrq+n changes all realtime tasks to normal priority.
>>>>>
>>>>>          
>>>>>
>>>>A nice -20 SCHED_OTHER task is not realtime, only SCHED_FIFO and
>>>>SCHED_RR.
>>>>        
>>>>
>>>Maybe extending sysrq+n to lower the priority of -20 tasks would be a
>>>good idea.
>>>
>>>      
>>>
>>If it runs before the keyboard thread it doesn't matter...
>>    
>>
>
>Of course not, but that's not generally the case.
>
>  
>
>>But why should this hang anything, when there should be enough i/o
>>to get out of the user process. There's a good fix for this, don't
>>give this guy root any more ;-)
>>    
>>
>
>Ever heard of bugs?  Anyone developing a program can make a mistake.
>If the program runs with realtime scheduling a bug that makes it enter
>an infinite loop (or do something else that hogs the CPU) can be
>difficult to find since it rather efficiently locks you out.
>
>  
>
Please google "emoticons" and find out what those funny characters at 
the end of the of the paragraph you quoted really mean. Sheesh!

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

