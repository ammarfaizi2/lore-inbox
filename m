Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUHEBeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUHEBeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 21:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUHEBeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 21:34:05 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:48287 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267536AbUHEBeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 21:34:02 -0400
Message-ID: <41118D0C.9090103@yahoo.com.au>
Date: Thu, 05 Aug 2004 11:27:40 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Williams <pwil3058@bigpond.net.au>
CC: Albert Cahalan <albert@users.sf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kernel@kolivas.org, Andrew Morton OSDL <akpm@osdl.org>
Subject: Re: SCHED_BATCH and SCHED_BATCH numbering
References: <1091638227.1232.1750.camel@cube> <41118AAE.7090107@bigpond.net.au>
In-Reply-To: <41118AAE.7090107@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:

> Albert Cahalan wrote:
>
>> Are these going to be numbered consecutively, or might
>> they better be done like the task state? SCHED_FIFO is
>> in fact already treated this way in one place. One might
>> want to test values this way:
>>
>> if(foo & (SCHED_ISO|SCHED_RR|SCHED_FIFO))  ...
>>
>> (leaving aside SCHED_OTHER==0, or just translate
>> that single value for the ABI)
>>
>> I'd like to see these get permenant allocations
>> soon, even if the code doesn't go into the kernel.
>> This is because user-space needs to know the values.
>
>
> Excellent idea.  The definition of rt_task() could become:
>
> #define rt_task(p) ((p)->policy & (SCHED_RR|SCHED_FIFO))
>
> instead of the highly dodgy:
>
> #define rt_task(p) ((p)->prio < MAX_RT_PRIO)
>

Nothing wrong with that, is there?

