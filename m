Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSLIGDu>; Mon, 9 Dec 2002 01:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLIGDu>; Mon, 9 Dec 2002 01:03:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:50356 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262887AbSLIGDs>; Mon, 9 Dec 2002 01:03:48 -0500
Date: Sun, 08 Dec 2002 22:11:19 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.50-mjb1 (scalability / NUMA patchset)
Message-ID: <134580000.1039414279@titus>
In-Reply-To: <19270000.1038270642@flay>
References: <19270000.1038270642@flay>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains mainly scalability and NUMA stuff, and
anything else that stops things from irritating me. It's meant
to be pretty stable, not so much a testing ground for new stuff.
I'd be very interested in feedback from other people running
large SMP or NUMA boxes.

http://www.aracnet.com/~fletch/linux/2.5.50/patch-2.5.50-mjb1.bz2

Since 2.5.47-mjb3:

merged by Linus:
- noearlyirq					Martin Bligh et al.

all screwed up at the moment:
- dcache_rcu					Dipankar Sarma

added:
merged up to 2.5.50 base
+ devclass_panic				Bill Irwin
+ shpte						Dave McCracken
+ subarch reorg					John Stultz
+ numaq_makefile				Martin Bligh
+ numaq_apic					James Cleverdon / Martin Bligh
+ numaq_mpparse1				James Cleverdon / Martin Bligh
+ config_page_offset				Dave Hansen / Andrea
+ vmalloc_stats					Dave Hansen
+ notsc						Martin Bligh

Pending:
Speed up page init on boot (Bill Irwin)
Move more of NUMA-Q to subarch (James C / Martin / John)
Full Summit support (James C / John)
RCU routecache (?)
Per-cpu interrupt stacks (bcrl / Dave)
4K Kernel stacks config option (Dave)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
The revenge of dcache_rcu (Dipankar)
/proc/meminfo.numa (Me and others).

kgdb						Various People
	The older version of kgdb, not the shiny new stuff in Andrew's tree.
	Yes, I'm boring and slow.

rcu_stats					Dipankar Sarma
	Gives rcu statistics

i386_topo					Matt Dobson
	Some i386 topology cleanups to make it cache the data.

use_generic_topo				Matt Dobson
	Something to do with tolopology that I forget.

numasched1					Erich Focht
	Numa scheduler general foundation work + pooling

numasched2					Michael Hohnbaum
	Numa scheduler lightweight initial load balancing.

local_pgdat					Bill Irwin
	Move the pgdat structure into the remapped space with lmem_map

early_printk					Dave Hansen et al.
	Allow printk before console_init

frameptr					Martin Bligh
	Disable -fomit_frame_pointer

confighz					Dave Hansen
	Make HZ a config option

devclass_panic					Bill Irwin
	Reorder sysfs init for topo to avoid panic

shpte						Dave McCracken
	Shared pagetables (as a config option)

subarch reorg					John Stultz
	Move the header files for subarch under include/asm-i386

numaq_makefile				Martin Bligh
	Create shell of NUMA-Q subarch support.

numaq_apic					James Cleverdon / Martin Bligh
	Break out some apic stuff for NUMA-Q into subarch

numaq_mpparse1					James Cleverdon / Martin Bligh
	Break out some mpparse stuff for NUMA-Q into subarch

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

mjb1						Martin Bligh
	Add a tag to the makefile

