Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVFDCJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVFDCJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 22:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFDCJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 22:09:22 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:57466 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261221AbVFDCJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 22:09:17 -0400
Message-ID: <42A10D47.2030209@yahoo.com.au>
Date: Sat, 04 Jun 2005 12:09:11 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jack Steiner <steiner@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hang in sched_balance_self()
References: <20050603225544.GA8499@sgi.com>
In-Reply-To: <20050603225544.GA8499@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner wrote:
> Nick -
> 
> The latest 2.6.12-rc5-mm2 tree fails to boot on some of the 64p
> SGI systems. The system hangs immediately after printing:
> 
> 	...
> 	Inode-cache hash table entries: 8388608 (order: 12, 67108864 bytes)
> 	Mount-cache hash table entries: 1024
> 	Boot processor id 0x0/0x0
> 	Brought up 64 CPUs
> 	Total of 64 processors activated (118415.36 BogoMIPS).
> 
> 
> I have isolated the failure to cpu 0 hanging in sched_balance_self() during
> a fork (or clone).  The "while" loop at the end of function never 
> terminates, ie. sd is never NULL.
> 
> Is this a problem that you have seen before. If not, I'll do some
> more digging & isolate the problem.
> 

Hi Jack,
I have not seen this problem, however I don't think it has
had much testing with multilevel NUMA domains.

If you could do some more digging that would be great, however
I plan to get time on a 64-way IA64 next week and look at
some scheduler issues, so I'll keep this in mind if you haven't
made any progress.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
