Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266558AbUFWTjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266558AbUFWTjk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFWTjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:39:40 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:10757 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266558AbUFWTjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:39:37 -0400
Message-ID: <40D9E0F0.8050005@techsource.com>
Date: Wed, 23 Jun 2004 15:58:40 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
CC: Marcus Hartig <m.f.h@web.de>, linux-kernel@vger.kernel.org
Subject: Re: status of Preemptible Kernel 2.6.7
References: <40D9B20A.4070409@web.de>  <40D9C48C.4060004@techsource.com>	 <1088017171.14159.2.camel@betsy>  <40D9DA4A.3070700@techsource.com> <1088018611.14161.5.camel@betsy>
In-Reply-To: <1088018611.14161.5.camel@betsy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert Love wrote:
> On Wed, 2004-06-23 at 15:30 -0400, Timothy Miller wrote:
> 
> 
>>I wasn't talking about locks.  I was talking about kernel functions 
>>taking long periods of time, cases where preempt has been useful to 
>>reduce kernel latency.
>>
>>Holding locks for extended periods is something else entirely.
> 
> 
> I know what you were talking about.  I was replying that it seems better
> overall to me if we work to eliminate long lock hold times (which then
> eliminates long non-preemption times) than litter the kernel with
> explicit rescheduling statements.

Yes, getting rid of locks does seem to be a more immediately productive 
thing to do.

Are there any cases where we claim locks on data, rather than metadata? 
  That is to say, one would prefer to lock, claim a pointer or reference 
or such, and then unlock, rather than to lock, manipulate data, and then 
unlock, right?

There might be situations where the data structures involved are larger 
(more pointers, flags, etc.), but we can get control of data without 
having to hold a lock on it.

Am I making sense?  :)

