Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270970AbUJVDq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270970AbUJVDq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270965AbUJVDqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:46:14 -0400
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:16245 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270970AbUJVDiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:38:51 -0400
Message-ID: <417880C3.4000807@yahoo.com.au>
Date: Fri, 22 Oct 2004 13:38:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
References: <20041021011714.GQ24619@dualathlon.random> <20041022011057.GC14325@dualathlon.random> <20041021182651.082e7f68.akpm@osdl.org> <200410212155.52264.jbarnes@sgi.com>
In-Reply-To: <200410212155.52264.jbarnes@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes wrote:
> On Thursday, October 21, 2004 8:26 pm, Andrew Morton wrote:
> 
>>I'd be OK with wapping over to the watermark version, as long as we have
>>runtime-settable levels.
>>
>>But I'd be worried about making the default values anything other than zero
>>because nobody seems to be hitting the problems.
> 
> 
> Yes, please keep the default at 0 regardless of the algorithm.  On the NUMA 
> systems I'm aware of, an incremental min just doesn't make any sense.
> 

That problem shouldn't exist any more, so your one zone per node (?)
NUMA systems, incremental min won't have any effect at all.

That said, it isn't something that we should just turn on and see
who yells.

