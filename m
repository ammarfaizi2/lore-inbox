Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbTDKWXd (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTDKWXc (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:23:32 -0400
Received: from fw-az.mvista.com ([65.200.49.158]:55545 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261876AbTDKWXb (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 18:23:31 -0400
Message-ID: <3E974348.7080104@mvista.com>
Date: Fri, 11 Apr 2003 15:35:52 -0700
From: Steven Dake <sdake@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411173018$2695@gated-at.bofh.it> <20030411175011$3d7e@gated-at.bofh.it> <20030411182022$7f7a@gated-at.bofh.it> <20030411184016$1180@gated-at.bofh.it> <20030411204006$0496@gated-at.bofh.it> <20030411205018$7440@gated-at.bofh.it> <200304112111.h3BLBWgu025834@post.webmailer.de>
In-Reply-To: <200304112111.h3BLBWgu025834@post.webmailer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Arnd Bergmann wrote:

>Greg KH wrote:
>
>  
>
>>On Fri, Apr 11, 2003 at 01:29:57PM -0700, Steven Dake wrote:
>>    
>>
>>>It gets even worse, because performance of hotswap events on disk adds 
>>>is critical and spawning processes is incredibly slow compared to the 
>>>performance required by some telecom applications...
>>>      
>>>
>>It's critical that we quick name this disk within X milliseconds after
>>it has been added to the system?  What spec declares this?
>>    
>>
>
>While the problem might not really be the per-device latency, what should 
>be handled correctly is the following scenario:
>
>- Someone accidentally removes the cable that connects a few hundred 
>  (mounted) disks
>- The cable is replaced, but - oops - to the wrong socket
>- The person notices the error and now places the cable into the right
>  socket.
>
>At this time we have four concurrent hotplug events for every single
>disks that we want to be finished in order and we want every disk
>to end up with its original minor number in the end. If this is not
>possible, the system still needs to be in a sensible state after this.
>  
>
Yes, and in the rest of my email, I stated this would be solved by 
replacing /sbin/hotplug with a mechanism to communicate events to a user 
space daemon which would process requests in order as submitted by the 
kernel. (All except the same minor/major, which may or may not happen).  
If the kernel is evil and doesn't submit events in order, thats another 
problem to solve, but it should for disk events, atleast.

>        Arnd <><
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>
>  
>

