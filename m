Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270641AbTHOSCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270659AbTHOSCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:02:25 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:46095 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S270641AbTHOSCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:02:24 -0400
Message-ID: <3F3D23BD.6050608@techsource.com>
Date: Fri, 15 Aug 2003 14:17:33 -0400
From: Timothy Miller <tim@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: Timothy Miller <miller@techsource.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O12.2int for interactivity
References: <20030804195058.GA8267@cray.fish.zetnet.co.uk> <200308141659.33447.kernel@kolivas.org> <3F3BE9BD.20304@techsource.com> <200308160235.05105.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

>On Fri, 15 Aug 2003 05:57, Timothy Miller wrote:
>  
>
>>>Actually the timeslice handed out is purely dependent on the static
>>>priority, not the priority it is elevated or demoted to by the
>>>interactivity estimator. However lower priority tasks (cpu bound ones if
>>>the estimator has worked correctly) will always be preempted by higher
>>>priority tasks (interactive ones) whenever they wake up.
>>>      
>>>
>>Ok, so tasks at priority, say, 5 are all run before any tasks at
>>priority 6, but when a priority 6 task runs, it gets a longer timeslice?
>>    
>>
>
>All "nice" 0 tasks get the same size timeslice. If their dynamic priority is 
>different (the PRI column in top) they still get the same timeslice.
>  
>

Why isn't dynamic priority just an extension of static priority?  Why do 
you modify only the ordering while leaving the timeslice alone?


So, tell me if I infer this correctly:  If you have a nice 5 and a nice 
7, but the nice 5 is a cpu hog, while the nice 7 is interactive, then 
the interactivity scheduler can modify their dynamic priorities so that 
the nice 7 is being run before the nice 5.  However, despite that, the 
nice 7 still gets a shorter timeslice than tha nice 5.

Have you tried altering this?


