Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbUCPNDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 08:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUCPNDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 08:03:22 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:40111 "EHLO
	kartuli.timesys") by vger.kernel.org with ESMTP id S261407AbUCPNDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:03:20 -0500
Message-ID: <4056FAF8.9000907@timesys.com>
Date: Tue, 16 Mar 2004 08:02:48 -0500
From: "La Monte H.P. Yarroll" <piggy@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en, de-de
MIME-Version: 1.0
To: "Amit S. Kale" <amitkale@emsyssoft.com>
CC: George Anzinger <george@mvista.com>, Tom Rini <trini@kernel.crashing.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [Kgdb-bugreport] [PATCH][2/3] Update CVS KGDB's have kgdb_{schedule,process}_breakpoint
References: <20040225213626.GF1052@smtp.west.cox.net> <200403151650.34115.amitkale@emsyssoft.com> <40560962.9050804@mvista.com> <200403161000.02223.amitkale@emsyssoft.com>
In-Reply-To: <200403161000.02223.amitkale@emsyssoft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Amit S. Kale wrote:

>On Tuesday 16 Mar 2004 1:22 am, George Anzinger wrote:
>  
>
>>Amit S. Kale wrote:
>>    
>>
>>>On Friday 12 Mar 2004 1:33 pm, George Anzinger wrote:
>>>      
>>>
>>>>Amit S. Kale wrote:
>>>>        
>>>>
>>>>>On Friday 12 Mar 2004 2:58 am, George Anzinger wrote:
>>>>>          
>>>>>
>>>>>>Amit S. Kale wrote:
>>>>>>~
>>>>>>
>>>>>>            
>>>>>>
>>>>>>>>context any
>>>>>>>>
>>>>>>>>p fun()
>>>>>>>>                
>>>>>>>>
>>>>>>>p fun() will push arguments on stack over the place where irq occured,
>>>>>>>which is exactly how it'll run.
>>>>>>>              
>>>>>>>
>>>>>>Is this capability in kgdb lite?  It was one of the last things I added
>>>>>>to -mm version.
>>>>>>            
>>>>>>
>>>>>No! It's not present in kgdb heavy also. All you can do is set $pc,
>>>>>continue.
>>>>>          
>>>>>
>>>>Possibly I can help here.  I did it for the mm version.  It does require
>>>>a couple of asm bits and it sort of messes up the set/fetch memory, but
>>>>it does do the job.
>>>>        
>>>>
>>>I have seen that. It's too messy!
>>>      
>>>
>>You have a better solution?
>>    
>>
>
>Nope.
>
>I think this feature is very likely to be abused by programmers. They do 
>deserve suffering if they choose to shoot at their own feet.
>
>Kernel programmers have to be aware of implementation of this feature if they 
>choose to call arbitrary functions. This includes knowing whether interrupts 
>are disabled, handling of exceptions in gdb called functions, whether other 
>processors run, that breakpoints are  disabled. Given that kgdb is used for 
>learning the kernel, such features are best kept aside.
>
>-Amit
>
Pardon my question.  I've lost track of the thread and the available context
doesn't really help me.

Is this the ability to step into an arbitrary function from the gdb command
line or something else?

-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell's sig

