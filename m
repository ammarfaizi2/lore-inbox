Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265206AbUEYVNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbUEYVNV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265235AbUEYVNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:13:21 -0400
Received: from mail.tmr.com ([216.238.38.203]:38664 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265206AbUEYVNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:13:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: Modifying kernel so that non-root users have some root capabilities
Date: Tue, 25 May 2004 17:15:56 -0400
Organization: TMR Associates, Inc
Message-ID: <40B3B78C.3050601@tmr.com>
References: <67B3A7DA6591BE439001F2736233351202B47EF0@xch-nw-28.nw.nos.boeing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1085519381 5636 192.168.12.100 (25 May 2004 21:09:41 GMT)
X-Complaints-To: abuse@tmr.com
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
To: "Laughlin, Joseph V" <Joseph.V.Laughlin@boeing.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <67B3A7DA6591BE439001F2736233351202B47EF0@xch-nw-28.nw.nos.boeing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laughlin, Joseph V wrote:
>>-----Original Message-----
>>From: Bill Davidsen [mailto:davidsen@tmr.com] 
>>Sent: Tuesday, May 25, 2004 11:14 AM
>>To: root@chaos.analogic.com
>>Cc: Laughlin, Joseph V; linux-kernel@vger.kernel.org
>>Subject: Re: Modifying kernel so that non-root users have 
>>some root capabilities
>>
>>
>>Richard B. Johnson wrote:
>>
>>>On Mon, 24 May 2004, Laughlin, Joseph V wrote:
>>>
>>>
>>>
>>>>(not sure if this is a duplicate or not.. Apologies in advance.)
>>>>
>>>>I've been tasked with modifying a 2.4 kernel so that a 
>>
>>non-root user 
>>
>>>>can do the following:
>>>>
>>>>Dynamically change the priorities of processes (up and down) Lock 
>>>>processes in memory Can change process cpu affinity
>>>>
>>>>Anyone got any ideas about how I could start doing this?  
>>
>>(I'm new to 
>>
>>>>kernel development, btw.)
>>>>
>>>>Thanks,
>>>
>>>
>>>You don't modify an operating system to do that!! You just make a 
>>>priviliged program (setuid) that does the things you want.
>>
>>Dick, it's called capabilities, and people have already modified the 
>>operating system to do that, it just doesn't work quite as 
>>intended in 
>>some cases. Setuid is the keys to the kingdom, you really 
>>don't want to 
>>use setuid root unless there's no other way.
>>
>>Remember when everything used to take the BKL? Then people 
>>saw a better 
>>way. Capabilities is the same kind of progression, save the 
>>big hammer 
>>for the big nail.
>>
> 
> 
> In what cases does changing the capabilities not have the intended
> effects?

Don't read that as "existing capabilities don't work," but as 
"capabilities don't exist for all the things people claim they need 
setuid root to do." The whole concept of capabilities was going to 
reduce the need and demand for setuid, and hopefully allow setuid to 
vanish in secure systems.

Either through lack of all the necessary bits, or lack of expertise 
using them the goal of reduction in demand and use for setuid seems not 
to have been met. I would argue that lack of need has been met, but 
careful thought seems needed to do some things without setuid.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
