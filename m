Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbTKGWJh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTKGWIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:08:36 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:12991 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264429AbTKGPsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:48:14 -0500
Date: Fri, 07 Nov 2003 07:48:05 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test9-mjb2
Message-ID: <85450000.1068220085@[10.10.2.4]>
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

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.0-test9/patch-2.6.0-test9-mjb2.bz2

Since 2.6.0-test9-mjb1 (~ = changed, + = added, - = dropped)

Notes: 

Now in Linus' tree:

Dropped:

New:

+ kgdb						Various
	Stolen from akpm's 2.6.0-test9-mm2

~ schedstat					Rick Lindsley
	Provide lotsa scheduler statistics (new version)

~ kcg						Adam Litke
	Acylic call graphs from the kernel (new version)

~ qlogic driver					Qlogic
	The qlogic driver (new version)

+ emulex driver					Emulex
	Driver for emulex fiberchannel cards

Pending:
lotsa_sds
config_numasched
4/4 split
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
scheduler callers profiling (Anton or Bill Hartner)
Child runs first (akpm)
Kexec
e1000 fixes
Update the lost timer ticks code
pidmaps_nodepages (Dave Hansen)

Present in this patch:

kgdb						Various
	Stolen from akpm's 2.6.0-test9-mm2

early_printk					Dave Hansen / Keith Mannthey
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

numameminfo					Martin Bligh / Keith Mannthey
	Expose NUMA meminfo information under /proc/meminfo.numa

sched_tunables					Robert Love
	Provide tunable parameters for the scheduler (+ NUMA scheduler)

partial_objrmap					Dave McCracken
	Object based rmap for filebacked pages.

spinlock_inlining				Andrew Morton & Martin J. Bligh
	Inline spinlocks for profiling. Made into a ugly config option by me.

lockmeter					John Hawkes / Hanna Linder
	Locking stats.

sched_interactive				Ingo Molnar
	Bugfix for interactive scheduler

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

ppc64 pci fix					Anton Blanchard
	Fix some ppc64 pci thing or other.

per_node_idt					Zwane Mwaikambo
	Per node IDT so we can do silly numbers of IO-APICs on NUMA-Q

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

config_irqbal					Keith Mannthey
	Make irqbalance a config option

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

nolock						Dave McCracken
	Nah, we don't like locks.

mbind_part1					Matt Dobson
	Bind some memory for NUMA.

mbind_part2					Matt Dobson
	Bind some more memory for NUMA.

per_node_rss					Matt Dobson
	Track which nodes tasks mem is on, so sched can be sensible.

pfn_to_nid					Martin J. Bligh
	Dance around the twisted rats nest of crap in i386 include.

gfp_node_strict					Dave Hansen
	Add a node strict binding as a gfp mask option

page_lock					William Lee Irwin
	Conditionally convert mapping->page_lock back to an rwlock

irqbal_fast					Adam Litke
	Balance IRQs more readily

kcg						Adam Litke
	Acylic call graphs from the kernel. Wheeeeeeeeeeeee!

numa_mem_equals 				Dave Hansen
	mem= command line parameter NUMA awareness.

schedstat					Rick Lindsley
	Provide lotsa scheduler statistics

autoswap					Con Kolivas
	Auto-tune swapiness

ext2_fix					Andrew Morton
	Fix a race in ext2

emulex driver					Emulex
	Driver for emulex fiberchannel cards

qlogic driver					Qlogic
	The qlogic driver

-mjb						Martin J. Bligh
	Add a tag to the makefile


