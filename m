Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVLPFDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVLPFDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 00:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVLPFDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 00:03:45 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:53376 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751050AbVLPFDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 00:03:45 -0500
Message-ID: <43A24A6F.5090907@us.ibm.com>
Date: Thu, 15 Dec 2005 21:02:39 -0800
From: Sridhar Samudrala <sri@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Dobson <colpatch@us.ibm.com>
CC: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, andrea@suse.de,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
References: <439FCECA.3060909@us.ibm.com> <20051214100841.GA18381@elf.ucw.cz> <43A0406C.8020108@us.ibm.com> <20051215162601.GJ2904@elf.ucw.cz> <43A1E551.1090403@us.ibm.com>
In-Reply-To: <43A1E551.1090403@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Dobson wrote:

>Pavel Machek wrote:
>  
>
>>>>And as you noticed, it does not work for your original usage case,
>>>>because reserved memory pool would have to be "sum of all network
>>>>interface bandwidths * ammount of time expected to survive without
>>>>network" which is way too much.
>>>>        
>>>>
>>>Well, I never suggested it didn't work for my original usage case.  The
>>>discussion we had is that it would be incredibly difficult to 100%
>>>iron-clad guarantee that the pool would NEVER run out of pages.  But we can
>>>size the pool, especially given a decent workload approximation, so as to
>>>make failure far less likely.
>>>      
>>>
>>Perhaps you should add file in Documentation/ explaining it is not
>>reliable?
>>    
>>
>
>That's a good suggestion.  I will rework the patch's additions to
>Documentation/sysctl/vm.txt to be more clear about exactly what we're
>providing.
>
>
>  
>
>>>>If you want few emergency pages for some strange hack you are doing
>>>>(swapping over network?), just put swap into ramdisk and swapon() it
>>>>when you are in emergency, or use memory hotplug and plug few more
>>>>gigabytes into your machine. But don't go introducing infrastructure
>>>>that _can't_ be used right.
>>>>        
>>>>
>>>Well, that's basically the point of posting these patches as an RFC.  I'm
>>>not quite so delusional as to think they're going to get picked up right
>>>now.  I was, however, hoping for feedback to figure out how to design
>>>infrastructure that *can* be used right, as well as trying to find other
>>>potential users of such a feature.
>>>      
>>>
>>Well, we don't usually take infrastructure that has no in-kernel
>>users, and example user would indeed be nice.
>>							Pavel
>>    
>>
>
>Understood.  I certainly wouldn't expect otherwise.  I'll see if I can get
>Sridhar to post his networking changes that take advantage of this.
>  
>
I have posted these patches yesterday on lkml and netdev and here is a 
link to the thread.
    http://thread.gmane.org/gmane.linux.kernel/357835
  
Thanks
Sridhar

