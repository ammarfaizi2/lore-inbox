Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbTFJPa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263245AbTFJP2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:28:23 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:34040 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263131AbTFJP1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:27:40 -0400
Message-ID: <3EE5FBE8.7020900@mvista.com>
Date: Tue, 10 Jun 2003 08:40:24 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Riley Williams <Riley@Williams.Name>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Eric Piel <Eric.Piel@Bull.Net>
Subject: Re: [PATCH] More time clean up stuff.
References: <BKEGKPICNAKILKJKMHCAEEEGEEAA.Riley@Williams.Name>
In-Reply-To: <BKEGKPICNAKILKJKMHCAEEEGEEAA.Riley@Williams.Name>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Riley Williams wrote:
> Hi George.
> 
> I'm ignoring the rest of this - it makes sense to me, but I'm
> no expert in it. However, your last point is one I can comment
> about as I've dealt with it professionally many times.
> 
>  > clock_nanosleep is changed to round up to the next jiffie to
>  > cover starting between jiffies.
> 
> Isn't this a case of replacing one error with another, where
> one of the two errors is unavoidable?
> 
>  1. In the old case, the sleep will on average be half a jiffie
>     LESS than the requested period.
> 
>  2. In the new case, the sleep will on average be half a jiffie
>     MORE than the requested period.
> 
> One or the other is unavoidable if a jiffie is the basic unit
> of time resolution of the system. However, the error is totally
> meaningless if we are asking to sleep for more than 15 jiffies.

I had a hard time justifiying this also.  I would really like to have 
better resolution.  As to which choice to make, the standard is VERY 
clear here:  No timer or sleep shall complete BEFORE its time.
> 
> Best wishes from Riley.
> ---
>  * Nothing as pretty as a smile, nothing as ugly as a frown.
> 
> ---
> Outgoing mail is certified Virus Free.
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.488 / Virus Database: 287 - Release Date: 5-Jun-2003
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

