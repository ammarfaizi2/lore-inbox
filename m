Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264492AbSIVTVT>; Sun, 22 Sep 2002 15:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264495AbSIVTVS>; Sun, 22 Sep 2002 15:21:18 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32128 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264492AbSIVTVS>; Sun, 22 Sep 2002 15:21:18 -0400
Date: Sun, 22 Sep 2002 12:24:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Message-ID: <86171478.1032697481@[10.10.2.3]>
In-Reply-To: <73440311.1032684750@[10.10.2.3]>
References: <73440311.1032684750@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> +	int this_pool = CPU_TO_NODE(this_cpu);
>> +	int this_pool=CPU_TO_NODE(this_cpu), weight, maxweight=0;
> 
> Howcome you can use the CPU_TO_NODE abstraction here ...
> 
>> +	/* build translation table for CPU_TO_NODE macro */
>> +	for (i = 0; i < NR_CPUS; i++)
>> +		if (cpu_online(i))
>> +			lnode_number[i] = pnode_to_lnode[SAPICID_TO_PNODE(cpu_physical_id(i))];
> 
> But not here?

Doh! Because you're building the list to use for CPU_TO_NODE,
obviously ;-) Sorry.

Should still get buried back down into the arch code though. 

M.



