Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbSJHTrG>; Tue, 8 Oct 2002 15:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJHTpz>; Tue, 8 Oct 2002 15:45:55 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:18143 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261504AbSJHToZ>; Tue, 8 Oct 2002 15:44:25 -0400
Date: Tue, 08 Oct 2002 12:44:26 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>, Michael Hohnbaum <hohnbaum@us.ibm.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Message-ID: <578740000.1034106266@flay>
In-Reply-To: <200210081933.06677.efocht@ess.nec.de>
References: <200210072209.41880.efocht@ess.nec.de> <1420721189.1034032091@[10.10.2.3]> <200210081933.06677.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aaargh, you got the wrong second patch :-( Sorry for that...

No problem
 
> Thanks for the hints, I cleaned up the first patch, too. No
> CONFIG_NUMA_SCHED any more, switched to MAX_NUMNODES, including
> asm/numa.h from asm/topology.h, so no need for you to see it.

Cool. Well it compiles now, but:

CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
CP4 4ivi e e UPr: 0000
ing
igrU:i   4
eaIP:    p060:[<c0114231>]    Not tainted
EFLAGS: 00010046
EIP is at calc_pool_load+0x109/0x120
eax: 00000000   ebx: 00000001   ecx: c034f380   edx: 00000000
esi: c028efa0   edi: 00000020   ebp: c3a37efc   esp: c3a37ed4
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=c3a36000 task=f01bf060)
Stack: c028f948 c028efa0 f01bf060 00002928 00002944 00002944 ffffffff ffffffff 
       c028efa0 ffffffff c3a37f78 c01142d5 c028f948 00000004 00000001 00000001 
       c3a36000 c028efa0 f01bf060 00000010 00000008 00000000 00000001 00002a13 
Call Trace:
 [<c01142d5>] load_balance+0x8d/0x5c4
 [<c0118a8d>] call_console_drivers+0xdd/0xe4
 [<c0118cc2>] release_console_sem+0x42/0xa4
 [<c0114c21>] schedule+0xd5/0x3ac
 [<c0105300>] default_idle+0x0/0x34
 [<c01053bf>] cpu_idle+0x43/0x48
 [<c0118cc2>] release_console_sem+0x42/0xa4
 [<c0118c1d>] printk+0x125/0x140

Code: f7 3c 99 8b 55 08 89 84 9a 80 00 00 00 8b 45 f4 5b 5e 5f 89 

