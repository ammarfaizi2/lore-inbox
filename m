Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261545AbTANH4Z>; Tue, 14 Jan 2003 02:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbTANH4Z>; Tue, 14 Jan 2003 02:56:25 -0500
Received: from franka.aracnet.com ([216.99.193.44]:33409 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261545AbTANH4X>; Tue, 14 Jan 2003 02:56:23 -0500
Date: Tue, 14 Jan 2003 00:05:06 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>, Robert Love <rml@tech9.net>
Subject: 2.5.58-mjb1 (scalability / NUMA patchset)
Message-ID: <437220000.1042531505@titus>
In-Reply-To: <922170000.1042183282@titus>
References: <19270000.1038270642@flay><134580000.1039414279@titus><32230000.1039502522@titus><568990000.1040112629@titus><21380000.1040717475@titus> <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains mainly scalability and NUMA stuff, and anything 
else that stops things from irritating me. It's meant to be pretty stable, 
not so much a testing ground for new stuff.

I'd be very interested in feedback from anyone willing to test on any platform, however large or small.

http://www.aracnet.com/~fletch/linux/2.5.58/patch-2.5.58-mjb1.bz2

Since 2.5.55-mjb1

Notes:
The interrupt distribution on Summit should be fixed now.
I put the new minimal NUMA scheduler in, no node-balance code yet (real soon).
The summit code will break the new bigsmp subarch for now.

- ksymsoff					Hugh Dickens
			(kind of part merged, and I don't have an updated ver)
- numasched1					Erich Focht
+ summit1					James Cleverdon / John Stultz
~ summit2					John Stultz
+ min_numasched					Martin J. Bligh
+ sched_tunables				Robert Love

Pending:
NUMA node rebalancer (Erich Focht)
Speed up page init on boot (Bill Irwin)
Notsc automatic enablement
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Lockless xtime structures (Andi)
P4 oprofile support (movement)

summit1						James Cleverdon / John Stultz
	Summit support part 1

summit2						James Cleverdon / John Stultz
	Summit support part 2

summit3						James Cleverdon / John Stultz
	Summit support part 3

summit4						James Cleverdon / John Stultz
	Summit support part 4

summit5						James Cleverdon / John Stultz
	Summit support part 5

dcache_rcu					Dipankar / Maneesh
	Use RCU type locking for the dentry cache.
 
early_printk					Dave Hansen et al.
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

min_numasched					Martin J. Bligh
	Minimal NUMA scheduler to make balancing node-local

numasched_ilb					Michael Hohnbaum
	Numa scheduler lightweight initial load balancing.

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler

local_pgdat					Bill Irwin
	Move the pgdat structure into the remapped space with lmem_map

thread_info_cleanup (4K stacks pt 1)		Dave Hansen / Ben LaHaise
	Prep work to reduce kernel stacks to 4K
	
interrupt_stacks    (4K stacks pt 2)		Dave Hansen / Ben LaHaise
	Create a per-cpu interrupt stack.

stack_usage_check   (4K stacks pt 3)		Dave Hansen / Ben LaHaise
	Check for kernel stack overflows.

4k_stack            (4K stacks pt 4)		Dave Hansen
	Config option to reduce kernel stacks to 4K

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

kgdb						Andrew Morton / Various People
	The older version of kgdb, synched with 2.5.54-mm1

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

-mjb						Martin Bligh
	Add a tag to the makefile

