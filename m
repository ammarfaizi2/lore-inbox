Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266682AbSLJGe3>; Tue, 10 Dec 2002 01:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSLJGe2>; Tue, 10 Dec 2002 01:34:28 -0500
Received: from franka.aracnet.com ([216.99.193.44]:25746 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266682AbSLJGeY>; Tue, 10 Dec 2002 01:34:24 -0500
Date: Mon, 09 Dec 2002 22:42:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Zwane Mwaikambo <zwane@holomorphy.com>
Subject: 2.5.50-mjb2 (scalability / NUMA patchset)
Message-ID: <32230000.1039502522@titus>
In-Reply-To: <134580000.1039414279@titus>
References: <19270000.1038270642@flay> <134580000.1039414279@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, previous patch seemed to have some problems on non-NUMA boxen.
This one seems to work fine on a 4x machine at least ... next release
will have more substance ;-)

--------------------------

The patchset contains mainly scalability and NUMA stuff, and
anything else that stops things from irritating me. It's meant
to be pretty stable, not so much a testing ground for new stuff.
I'd be very interested in feedback from other people running
large SMP or NUMA boxes.

http://www.aracnet.com/~fletch/linux/2.5.50/patch-2.5.50-mjb2.bz2

Since 2.5.50-mjb1

Returned from the dead:
+ dcache_rcu					Dipankar Sarma

Gone to renegotiate with it's maker (seems to cause problems on standard 
SMP):
- numaq_makefile				Martin Bligh
- numaq_apic					James Cleverdon / Martin Bligh
- numaq_mpparse1				James Cleverdon / Martin Bligh

Pending:
Speed up page init on boot (Bill Irwin)
Notsc automatic enablement
Move more of NUMA-Q to subarch (James C / Martin / John)
Full Summit support (James C / John)
RCU routecache (?)
Per-cpu interrupt stacks (bcrl / Dave)
4K Kernel stacks config option (Dave)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
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

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

notsc						Martin Bligh
	Enable notsc option for NUMA-Q (new version for new config system)

dcache_rcu
	Use RCU type locking for the dentry cache.

mjb2						Martin Bligh
	Add a tag to the makefile

