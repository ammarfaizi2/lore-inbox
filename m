Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbULaWQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbULaWQb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 17:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbULaWQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 17:16:31 -0500
Received: from out014pub.verizon.net ([206.46.170.46]:49889 "EHLO
	out014.verizon.net") by vger.kernel.org with ESMTP id S262158AbULaWQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 17:16:25 -0500
Message-ID: <41D5CFCA.7000300@cwazy.co.uk>
Date: Fri, 31 Dec 2004 17:16:42 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, kernel-janitors@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ] Re: [PATCH] esp: Make driver SMP-correct
References: <20041231014403.3309.58245.96163@localhost.localdomain>	<20041231014611.003281e5.akpm@osdl.org>	<20041231100037.A29868@flint.arm.linux.org.uk> <20041231170139.B10216@flint.arm.linux.org.uk>
In-Reply-To: <20041231170139.B10216@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out014.verizon.net from [209.158.220.243] at Fri, 31 Dec 2004 16:16:22 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Dec 31, 2004 at 10:00:37AM +0000, Russell King wrote:
> 
>>On Fri, Dec 31, 2004 at 01:46:11AM -0800, Andrew Morton wrote:
>>
>>>James Nelson <james4765@verizon.net> wrote:
>>>
>>>>This is an attempt to make the esp serial driver SMP-correct.  It also removes
>>>> some cruft left over from the serial_write() conversion.
>>>
>>>>From a quick scan:
>>>
>>>- startup() does multiple sleeping allocations and request_irq() under
>>>  spin_lock_irqsave().  Maybe fixed by this:
>>
>>However, can you guarantee that two threads won't enter startup() at
>>the same time?  (that's what ASYNC_INITIALIZED is protecting the
>>function against, and the corresponding shutdown() as well.)
>>
>>It's probably better to port ESP to the serial_core structure where
>>this type of thing is already taken care of.
> 
> 
> For the record, Verizon appear to have adopted silly policies.
> 
>>From now on, I will be removing the CC: line containing any verizon
> email address until further notice, or just plain ignoring mails
> containing such addresses.  Why?  To prevent the inevitable bounce
> caused by their misconfigured systems.  None of the servers I have
> access to on several different ISPs can connect to Verizon's incoming
> mail server.
> 
> See:
>  http://www.broadbandreports.com/forum/remark,12116645~mode=flat~days=9999
> 
> particularly the last post by techie68, who claims to be a Verizon
> tech support person.
> 
> I encourage James Nelson to find another provider without silly policies
> in the mean time.
> 
> 

Another mail provider has been found.  Bloody Verizon.

Documentation/serial/driver mentions a reference implementation - serial_amba.c. 
Couldn't find it in the 2.6.10 kernel sources - was it removed, and what would be 
a good refernce implementation in the current sources?

Jim
