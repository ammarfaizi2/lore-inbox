Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVAAAB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVAAAB4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262166AbVAAAB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 19:01:56 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:57261 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262164AbVAAABw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 19:01:52 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
Date: Fri, 31 Dec 2004 19:01:50 -0500
User-Agent: KMail/1.7
Cc: Jim Nelson <james4765@cwazy.co.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       kernel-janitors@lists.osdl.org
References: <20041231014403.3309.58245.96163@localhost.localdomain> <20041231170139.B10216@flint.arm.linux.org.uk> <41D5CFCA.7000300@cwazy.co.uk>
In-Reply-To: <41D5CFCA.7000300@cwazy.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412311901.50638.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.52.185] at Fri, 31 Dec 2004 18:01:51 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 December 2004 17:16, Jim Nelson wrote:
>Russell King wrote:
>> On Fri, Dec 31, 2004 at 10:00:37AM +0000, Russell King wrote:
>>>On Fri, Dec 31, 2004 at 01:46:11AM -0800, Andrew Morton wrote:
>>>>James Nelson <james4765@verizon.net> wrote:
>>>>>This is an attempt to make the esp serial driver SMP-correct. 
>>>>> It also removes some cruft left over from the serial_write()
>>>>> conversion.
>>>>>
>>>>>>From a quick scan:
>>>>
>>>>- startup() does multiple sleeping allocations and request_irq()
>>>> under spin_lock_irqsave().  Maybe fixed by this:
>>>
>>>However, can you guarantee that two threads won't enter startup()
>>> at the same time?  (that's what ASYNC_INITIALIZED is protecting
>>> the function against, and the corresponding shutdown() as well.)
>>>
>>>It's probably better to port ESP to the serial_core structure
>>> where this type of thing is already taken care of.
>>
>> For the record, Verizon appear to have adopted silly policies.
>>
>>>>From now on, I will be removing the CC: line containing any
>>> verizon
>>
>> email address until further notice, or just plain ignoring mails
>> containing such addresses.  Why?  To prevent the inevitable bounce
>> caused by their misconfigured systems.  None of the servers I have
>> access to on several different ISPs can connect to Verizon's
>> incoming mail server.
>>
>> See:
>> 
>> http://www.broadbandreports.com/forum/remark,12116645~mode=flat~da
>>ys=9999
>>
>> particularly the last post by techie68, who claims to be a Verizon
>> tech support person.
>>
>> I encourage James Nelson to find another provider without silly
>> policies in the mean time.
>
>Another mail provider has been found.  Bloody Verizon.
>
This strikes me as being some damn petty politics on verizons part.  
I'm a customer because its the only game in town with affordable 
broadband, by at least 30 dollars a month.  So I'm stuck with it, or 
a friggin dialup that is also about 30 a month more expensive.

And it seems that everytime I use the "reply all" button on this list, 
I'll get at least 2 bounces because somebody elses server has 
blacklisted verizon for running an open relay 2 years ago, & never 
got around to lifting the ban when verizon rebuilt the systems last 
spring.

One should be carefull as that shoe can fit many feet. The CC: line of 
this message:

Jim Nelson <james4765@cwazy.co.uk>, Russell King 
<rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>, 
kernel-janitors@lists.osdl.org

I'm curious as to who I will get a bounce from.

>Documentation/serial/driver mentions a reference implementation -
> serial_amba.c. Couldn't find it in the 2.6.10 kernel sources - was
> it removed, and what would be a good refernce implementation in the
> current sources?
>
>Jim
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.31% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
