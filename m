Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265708AbUBFWnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbUBFWnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:43:24 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:40422 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266890AbUBFWmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:42:50 -0500
Date: Fri, 06 Feb 2004 14:42:28 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nick Piggin <piggin@cyberone.com.au>
cc: Rick Lindsley <ricklind@us.ibm.com>, Anton Blanchard <anton@samba.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, dvhltc@us.ibm.com
Subject: Re: [PATCH] Load balancing problem in 2.6.2-mm1
Message-ID: <225230000.1076107348@flay>
In-Reply-To: <40240F07.9060105@cyberone.com.au>
References: <200402061815.i16IFhY07073@owlet.beaverton.ibm.com> <207100000.1076092771@flay> <40240F07.9060105@cyberone.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It's the classic fairness vs throughput thing we've argued about before.
>> Most workloads don't have that static a number of processes, but it 
>> probably does need to do it if the imbalance is persistent ... but much
>> more reluctantly than normal balancing. See the patch I sent out a bit
>> earlier to test it - that may be *too* extreme in the other direction,
>> but it should confirm what's going on, at least.
> 
> Yep. I've argued for fairness here, and that is presently what
> we get. Between nodes the threshold should probably be higher
> though.

OK, but do you agree that the rate we rebalance things like 2 vs 1 should
be slower than the rate we rebalance 3 vs 1 ? Fairness is only relevant
over a long term imbalance anyway, so there should be a big damper on
"fairness only" rebalances.

Moreover, as Rick pointed out, it's particularly futile over idle cpus ;-)

m.

