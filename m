Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbTETR5i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTETR5h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:57:37 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:35834 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263748AbTETR5g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:57:36 -0400
Message-ID: <3ECA6F83.5090706@mvista.com>
Date: Tue, 20 May 2003 11:10:11 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Balazic <david.balazic@uni-mb.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: Wrong clock initialization
References: <3ECA673F.7B3FB388@uni-mb.si>
In-Reply-To: <3ECA673F.7B3FB388@uni-mb.si>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Balazic wrote:
> Hi!
> 
> When the kernel is booted ( ia32 version at least ) , it reads
> the time from from the hardware CMOS clock , _assumes_ it is in
> UTC and set the system time to it.
> 
> As almost nobody runs their clock in UTC, this means that the system
> is running on wrong time until some userspace tool corrects it.
> 
> This can lead to situtation when time goes backwards :
> 
> timezone is 2hours east of UTC.
> UTC time : 20:00
> local time : 22:00
> 
> System time between boot and userspace fix : 22:00UTC
> System time after fix : 20:00UTC
> 
> Comments ?

During shut down my system "says" it is setting the CMOS clock from 
the kernel clock.  I would expect this to correct the problem.  Is 
this a distro thing?

In any case, this would seem to make the problem go away after the 
first shutdown (if you don't dual boot with something other than Linux :).

> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

