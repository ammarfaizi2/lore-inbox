Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTATTw1>; Mon, 20 Jan 2003 14:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267237AbTATTvo>; Mon, 20 Jan 2003 14:51:44 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:21989 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267206AbTATTvF>; Mon, 20 Jan 2003 14:51:05 -0500
Date: Mon, 20 Jan 2003 11:52:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Theurer <habanero@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
cc: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, Robert Love <rml@tech9.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Anton Blanchard <anton@samba.org>
Subject: Re: [patch] sched-2.5.59-A2
Message-ID: <264880000.1043092340@flay>
In-Reply-To: <200301201352.55534.habanero@us.ibm.com>
References: <Pine.LNX.4.44.0301201817220.12564-100000@localhost.localdomain> <200301201313.39621.habanero@us.ibm.com> <262510000.1043091224@flay> <200301201352.55534.habanero@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I have included a very rough patch to do ht-numa topology.  I requires to
>> > manually define CONFIG_NUMA and CONFIG_NUMA_SCHED.  It also uses
>> > num_cpunodes instead of numnodes and defines MAX_NUM_NODES to 8 if
>> > CONFIG_NUMA is defined.
>> 
>> Whilst it's fine for benchmarking, I think this kind of overlap is a
>> very bad idea long-term - the confusion introduced is just asking for
>> trouble. And think what's going to happen when you mix HT and NUMA.
>> If we're going to use this for HT, it needs abstracting out.
> 
> I have no issues with using HT specific bits instead of NUMA.  Design wise it 
> would be nice if it could all be happy together, but if not, then so be it.  

That's not what I meant - we can share the code, we just need to abstract
it out so you don't have to turn on CONFIG_NUMA. That was the point of
the pooling patch I posted at the weekend. Anyway, let's decide on the
best approach first, we can clean up the code for merging later.

M.

