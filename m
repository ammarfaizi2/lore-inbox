Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUACAnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 19:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265783AbUACAnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 19:43:18 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:55938 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S265780AbUACAnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 19:43:03 -0500
Date: Fri, 02 Jan 2004 16:42:26 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.1-rc1-mjb1
Message-ID: <4690000.1073090546@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset contains ... oh hell, anything I feel like putting in it.  
It's meant to be pretty stable - performance should be better than mainline,
particularly on larger machines.

I'd be very interested in feedback from anyone willing to test on any 
platform, however large or small.

ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/2.6.1-rc1/patch-2.6.1-rc1-mjb1.bz2

Since 2.6.0-mjb2 (~ = changed, + = added, - = dropped)

Notes:  

Now includes kexec and the new kgdb-over-ethernet code ... please test!
Sound under xmms, and other code that uses OSS emulation interfaces to
ALSA drivers should sound a whole load better than mainline with this release.

-----------------------------------------------------------------------

Now in Linus' tree:

- vm86_sysenter_fix				Brian Gerst
	Re-enable sysenter after task switch

- readahead_fixes				Ram Pai
	Fix performance bugs in readahead

- readahead_simplfiy				Ram Pai
	Simplify the readahead code

- slab_reclaim_accounting			Manfred Spraul
	Fix slab reclaim accounting

Dropped:

New:

+ smp_boot_id					Martin J. Bligh
	Fix panic if boot cpu's phys apicid doesn't match expected.

+ sysfs_backing_store1				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

+ sysfs_backing_store2				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

+ sysfs_backing_store3				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

+ sysfs_backing_store4				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

+ sysfs_backing_store5				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

+ gcov warning fix				Martin J. Bligh
	remove "export-objs" from gcov.

Pending:
config_numasched
list_of_lists
Hyperthreaded scheduler (Ingo Molnar)
Child runs first (akpm)
pidmaps_nodepages (Dave Hansen)
Netdump
Netconsole

Present in this patch:

netdrvr_2.6.1_rc1_exp1				Jeff Garzik
	Net driver kit, including the netpoll infrastructure.

kgdb						Various
	Stolen from akpm's 2.6.0-mm1, includes fixes

kgdboe_netpoll					Matt Mackall et al.
	Kgdb over ethernet support that works with the netpoll infrastructure

ppc64_bar_0_fix					Anton Blanchard
	PPC 64 fixups

ppc64_reloc_hide				Anton Blanchard / Paul Mackerras
	PPC 64 fixups

ppc64_sched_clock_fix				Anton Blanchard / Paul Mackerras
	PPC 64 fixups

ppc64_use_statfs64				Anton Blanchard
	PPC 64 fixups

ppc64_compat_clock				Olaf Hering
	PPC 64 fixups

ppc64_numa_sign_extn				Anton Blanchard
	PPC 64 fixups

ppc64_IRQ_INPROGRESS_fix			Anton Blanchard
	PPC 64 fixups

spinlock_inlining				Andrew Morton & Martin J. Bligh
	Inline spinlocks for profiling. Made into a ugly config option by me.

lockmeter					John Hawkes / Hanna Linder
	Locking stats.


oops_dump_preceding_code			Andrew Morton
	dump opcodes preceding and after the offending EIP.

4g4g						Ingo Molnar
	Provide a 4G/4G user/kernel split for 32 bit memory lushes.

lotsa_sds					Badari
	Enable lots of scsi disks

x86-64						Andi Kleen et al.
	x86_64 patch kit, 2.6.0-1

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

local_balance_exec				Martin J. Bligh
	Modify balance_exec to use node-local queues when idle

tcp_speedup					Martin J. Bligh
	Speedup TCP (avoid double copy) as suggested by Linus

disable preempt					Martin J. Bligh
	I broke preempt somehow, temporarily disable it to stop accidents

aiofix2						Mingming Cao
	fixed a bug in ioctx_alloc()

config_irqbal					Keith Mannthey
	Make irqbalance a config option

percpu_real_loadavg				Dave Hansen / Martin J. Bligh
	Tell me what the real load average is, and tell me per cpu.

per_node_rss					Matt Dobson
	Track which nodes tasks mem is on, so sched can be sensible.

pfn_to_nid					Martin J. Bligh
	Dance around the twisted rats nest of crap in i386 include.

gfp_node_strict					Dave Hansen
	Add a node strict binding as a gfp mask option

irqbal_fast					Adam Litke
	Balance IRQs more readily

kcg						Adam Litke
	Acylic call graphs from the kernel. Wheeeeeeeeeeeee!

numa_mem_equals 				Dave Hansen
	mem= command line parameter NUMA awareness.

schedstat					Rick Lindsley
	Provide lotsa scheduler statistics

schedstat_arches				Rick Lindsley
	Make schedstats support PPC, PPC64, x86_64 as well as ia32

autoswap					Con Kolivas
	Auto-tune swapiness

mbind_part1					Matt Dobson
	Bind some memory for NUMA.

mbind_part2					Matt Dobson
	Bind some more memory for NUMA.

emulex driver					Emulex
	Driver for emulex fiberchannel cards

qlogic						Qlogic / Mike Anderson
	Now qla2xxx-8.00.00b8-1

protocol254					Paul Mackerras / Omkhar 
	Allow protocol 254

slabtune					Dave McCracken
	Take slab in bigger bites on larger machines

less_bouncy					Martin J. Bligh
	Stop bouncing warm tasks cross node

topdown						Bill Irwin
	Turn userspace upside down for fun & profit

sysfs_vs_dcache					Maneesh Soni
	Fix race.

pci_topology					Matt Dobson
	Expose PCI NUMA topology to userspace

stacktrace					Adam Litke
	Stack backtracing via frame pointers

implicit_huge_pages 				Adam Litke / wli / Brian T.
	Implicit huge pages for mmap and shmem

user_text_replication				Dave Hansen
        Replicate read-only user text.

fasync_lock_rcu					Manfred Spraul
	Use RCU for fasync_lock

lockmeter_ia64					Ray Bryant
	Add a config option for lockmeter on ia64

4g4g_sep_fix					Ingo Molnar
	Fix SEP on 4g/4g split

4g4g_sysenter_test_fix				Arjan
	Fix sysenter detection

4g4g_locked_copy				Dave McCracken
	Locked copy to userspace

kexec						Eric Biederman et al.
	Exec a kernel for breakfast today.

alsa_100rc2					ALSA project
	New code drop of sound infrastructure - fixes various bugs.

force_wholefrag					Martin J. Bligh et al.
	OSS emulation sounds like crap without wholefrag. Revert that change.

lockmeter_notsc					Martin J. Bligh
	Lockmeter does not require CONFIG_X86_TSC.

smp_boot_id					Martin J. Bligh
	Fix panic if boot cpu's phys apicid doesn't match expected.

sysfs_backing_store1				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store2				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store3				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store4				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

sysfs_backing_store5				Maneesh Soni
	Provide a backing store for sysfs out of permanent KVA space.

-mjb						Martin J. Bligh
	Add a tag to the makefile



