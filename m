Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269207AbUIHXVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269207AbUIHXVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 19:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbUIHXVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 19:21:55 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:21071 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269226AbUIHXVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 19:21:18 -0400
Message-ID: <413F901F.5020901@yahoo.com.au>
Date: Thu, 09 Sep 2004 09:05:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040810 Debian/1.7.2-2
X-Accept-Language: en
MIME-Version: 1.0
To: jmerkey@comcast.net
CC: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <090820041648.7817.413F37F600049F4800001E892200762302970A059D0A0306@comcast.net>
In-Reply-To: <090820041648.7817.413F37F600049F4800001E892200762302970A059D0A0306@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey@comcast.net wrote:
> On a system with 4GB of memory, and without 
> the user space patch that spilts user space
> just a stock kernel, I am seeing memory 
> allocation failures with X server and simple
> apps on a machine with a Pentium 4 
> processor and 500MB of memory.  
> 
> If you load large apps and do a lot of 
> skb traffic, the mempool abd slab 
> caches start gobbling up pages
> and don't seem to balance them 
> very well, resulting in memory 
> allocation failures over time if
> the system stays up for a week 
> or more.  
> 
> I am also seeing the same behavior 
> on another system which has been
> running for almost 30 days with 
> an skb based traffic regeneration 
> test calling and sending skb's
> in kernel between two interfaces.
> 
> The pages over time get stuck 
> in the slab allocator and user
> space apps start to fail on alloc
> requests.  
> 
> Rebooting the system clears
> the problem, which slowly over time
> comes back.  I am seeing this with
> stock kernels from kernel.org 
> and on kernels I have patched,
> so the problem seems to be
> in the base code.  I have spent
> the last two weeks observing 
> the problem to verify I can
> reproduce it and it keeps 
> happening.  
> 
> Jeff
> 

Hi Jeff,
Can you give us a few more details please? Post the allocation failure
messages in full, and post /proc/meminfo, etc. Thanks.
