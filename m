Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSLXIDN>; Tue, 24 Dec 2002 03:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267065AbSLXIDN>; Tue, 24 Dec 2002 03:03:13 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58320 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267059AbSLXIDL>; Tue, 24 Dec 2002 03:03:11 -0500
Date: Tue, 24 Dec 2002 00:11:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.53-mjb1 (scalability / NUMA patchset)
Message-ID: <21380000.1040717475@titus>
In-Reply-To: <568990000.1040112629@titus>
References: <19270000.1038270642@flay>
 <134580000.1039414279@titus><32230000.1039502522@titus>
 <568990000.1040112629@titus>
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

http://www.aracnet.com/~fletch/linux/2.5.53/patch-2.5.53-mjb1.bz2

Since 2.5.52-mjb1
- config_hz					Dave Hansen
+ config_hz (new version) 			Andrew Morton / Dave Hansen
- i386_topo					Matt Dobson
+ i386_topo (new version)			Matt Dobson

Merged:
- numaq_makefile                                Martin Bligh
- numaq_apic                                    James Cleverdon / Martin 
Bligh
- numaq_mpparse1                                James Cleverdon / Martin 
Bligh
- numaq_mpparse2                                James Cleverdon / Martin 
Bligh

Pending:
Speed up page init on boot (Bill Irwin)
Notsc automatic enablement
Final bits of NUMA-Q / clustered_apic_mode to subarch (Martin)
Full Summit support (James C / John)
scheduler callers profiling (Anton)
PPC64 NUMA patches (Anton)
Scheduler tunables (rml)
Lockless xtime structures (Andi)

kgdb						Various People
	The older version of kgdb, not the shiny new stuff in Andrew's tree.
	Yes, I'm boring and slow.

noframeptr					Martin Bligh
	Disable -fomit_frame_pointer

use_generic_topo				Matt Dobson
	Make non-NUMA PPC64 use generic topology functions

i386_topo					Matt Dobson
	Some i386 topology cleanups to make it cache the data.

numasched1					Erich Focht
	Numa scheduler general foundation work + pooling

numasched2					Michael Hohnbaum
	Numa scheduler lightweight initial load balancing.

local_pgdat					Bill Irwin
	Move the pgdat structure into the remapped space with lmem_map

early_printk					Dave Hansen et al.
	Allow printk before console_init

confighz					Andrew Morton / Dave Hansen
	Make HZ a config option of 100 Hz or 1000 Hz

config_page_offset				Dave Hansen / Andrea
	Make PAGE_OFFSET a config option

vmalloc_stats					Dave Hansen
	Expose useful vmalloc statistics

shpte						Dave McCracken
	Shared pagetables (as a config option)

more_numaq1					James Cleverdon / Martin Bligh
	yet more Numa-Q subarch splitup

dcache_rcu					Dipankar / Maneesh
	Use RCU type locking for the dentry cache.

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

mjb1						Martin Bligh
	Add a tag to the makefile

