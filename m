Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUBFW7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265673AbUBFW7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:59:37 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:2769 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265663AbUBFW7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:59:30 -0500
Message-ID: <40241AFC.9030603@cyberone.com.au>
Date: Sat, 07 Feb 2004 09:53:48 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
References: <200402061815.i16IFhY07073@owlet.beaverton.ibm.com> <207100000.1076092771@flay> <40240F07.9060105@cyberone.com.au> <225230000.1076107348@flay>
In-Reply-To: <225230000.1076107348@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>>It's the classic fairness vs throughput thing we've argued about before.
>>>Most workloads don't have that static a number of processes, but it 
>>>probably does need to do it if the imbalance is persistent ... but much
>>>more reluctantly than normal balancing. See the patch I sent out a bit
>>>earlier to test it - that may be *too* extreme in the other direction,
>>>but it should confirm what's going on, at least.
>>>
>>Yep. I've argued for fairness here, and that is presently what
>>we get. Between nodes the threshold should probably be higher
>>though.
>>
>
>OK, but do you agree that the rate we rebalance things like 2 vs 1 should
>be slower than the rate we rebalance 3 vs 1 ? Fairness is only relevant
>over a long term imbalance anyway, so there should be a big damper on
>"fairness only" rebalances.
>
>

Well presently it happens at the same rate. This isn't bad though,
because you just use the more conservative rate. Its probably not
worth distinguishing the two cases.

If a CPU becomes idle, it will attempt to balance immediately.

>Moreover, as Rick pointed out, it's particularly futile over idle cpus ;-)
>
>

I don't follow...

