Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263851AbRFLXe4>; Tue, 12 Jun 2001 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263859AbRFLXeo>; Tue, 12 Jun 2001 19:34:44 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:2858 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263851AbRFLXec>; Tue, 12 Jun 2001 19:34:32 -0400
Date: Wed, 13 Jun 2001 01:34:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.6pre2aa2 [was Re: 2.4.5aa1]
Message-ID: <20010613013419.A709@athlon.random>
In-Reply-To: <20010526193310.A1834@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010526193310.A1834@athlon.random>; from andrea@suse.de on Sat, May 26, 2001 at 07:33:10PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diff between 2.4.6pre2aa1 and 2.4.6pre2aa2:

-----------------------------------------------------------------------------
Only in 2.4.6pre2aa2/: 00_gcc-30-volatile-xtime-1

	Fixes a kernel bug noticed by gcc-3_0-branch from cvs of today.

Only in 2.4.6pre2aa2/: 00_sched-rt-fix-1

	Re-merged fix lost in pre6aa1.

--
Andrea
-----------------------------------------------------------------------------

Diff between 2.4.5aa3 and 2.4.6pre2aa1 (besides moving on top of
2.4.6pre2):

-----------------------------------------------------------------------------
Only in 2.4.5aa3: 00_alpha-compile-1
Only in 2.4.5aa3: 00_alpha-dp264-compile-1
Only in 2.4.5aa3: 00_alpha-rawhide-irq-1
Only in 2.4.5aa3: 00_bdev-inode-1
Only in 2.4.5aa3: 00_clear_inode-if-ext2-error-1
Only in 2.4.5aa3: 00_create_buffers-deadlock-1
Only in 2.4.5aa3: 00_eepro100-64bit-1
Only in 2.4.5aa3: 00_ioapic-2.4.5-1
Only in 2.4.5aa3: 00_fix-unusable-vm-on-alpha-1
Only in 2.4.5aa3: 00_gfp_buffer-alloc-pages-deadlock-1
Only in 2.4.5aa3: 00_local-apic-do_softirq-1

	Merged in 2.4.6pre2 mainline.

Only in 2.4.6pre2aa1: 00_alpha-compile-swapon-1

	Fixes a compile problem for the alpha. Jeff noticed it as well.

	(recommended)

Only in 2.4.6pre2aa1: 00_ide-oops-1

	Fixes an oops in the ide stats from Kurt.

	(recommended)

Only in 2.4.6pre2aa1: 00_irda-2.4.5ac13-1.bz2

	Irda updates in sync with 2.4.5ac13.

	(nice to have)

Only in 2.4.5aa3: 00_ksoftirqd-4
Only in 2.4.6pre2aa1: 00_ksoftirqd-5

	ksoftirqd updates to work with the softirq updates in 2.4.6pre2.  This
	fixes severe bugs like the fact do_softirq must not unconditionally
	re-enable interrupts before returning possibly generating an irq
	recursion that would overflow the stack. It also avoids to starve
	userspace and it lets the scheduler to balance the softirq flood.

	(recommended)

Only in 2.4.6pre2aa1: 00_numa-compile-1

	Fixes a numa compilation trouble introduced with the mm updates in
	2.4.6pre2.

	(recommended)

Only in 2.4.5aa3: 00_o_direct-7
Only in 2.4.6pre2aa1: 00_o_direct-8

	Updates the O_DIRECT defines for sparc and sparc64 (approved by DaveM).

	(recommended)

Only in 2.4.5aa3: 00_raisesoftirq-setbit-1

	Dropped the set_bit in raisesoftirq, set_bit can only be run on an int.
	Noticed by DaveM. (ok on x86 it's harmless)

	(recommended)

Only in 2.4.5aa3: 00_sched-rt-fix-1

	Dropped by mistake sorry (I didn't catched the reject), will be
	reintroduced in a later version. Even if the bugfix was recommended
	this bug matters only in the rt corner case so it's not a showstopper.

Only in 2.4.5aa3: 00_softirq-SMP-fixes-3
Only in 2.4.6pre2aa1: 00_softirq-fixes-4

	Updated the memory barriers for clear_bit and friends to make the
	softirq code smp safe in architectures where the non conditional bitops
	and atomic operations are not also implicit memory barriers.

	(recommended)

Only in 2.4.6pre2aa1: 00_x86-entry.S-fix-1

	Showstopper x86 fix to avoid rescheduling and running signals when
	returning to kernel.

	(recommended)

Only in 2.4.6pre2aa1: 00_xircom-tulip-cb-2.4.5ac13-1
Only in 2.4.5aa3: 00_xircom-tulip-cb-arjanv-2.bz2

	Looks like mainline driver is been fixed, not merged the new driver
	anymore because the new driver hangs every few seconds, while the old
	one with this fix delivers the expected throughput.

	(nice to have)

Only in 2.4.6pre2aa1: 10_expand-stack-smp-1
Only in 2.4.5aa3: expand-stack-smp-1

	Renamed.

Only in 2.4.5aa3/30_tux: 30_atomic-lookup-1
Only in 2.4.6pre2aa1/30_tux: 30_atomic-lookup-2
Only in 2.4.5aa3/30_tux: 30_tux-vfs-1
Only in 2.4.6pre2aa1/30_tux: 30_tux-vfs-2

	Tux reject fixups.

--
Andrea
-----------------------------------------------------------------------------

Diff between 2.4.5aa1 and 2.4.5aa3:

-----------------------------------------------------------------------------
Only in 2.4.5aa3: 00_alpha-compile-1
Only in 2.4.5aa3: 00_alpha-dp264-compile-1

	Fixes CONFIG_ALPHA_GENERIC compile troubles and fix the right way the
	CONFIG_ALPHA_DP264 compile (included bootmem.h _after_ the
	__EXTERN_INLINE tricks.

	(recommended)

Only in 2.4.5aa3: 00_alpha-rawhide-irq-1

	Fix from Richard to cure bad networking performance on rawhide (disable
	irq right to avoid flood of reentrant nested irqs).

	(recommended)

Only in 2.4.5aa3: 00_bdev-inode-1

	Fix initrd issues (from 2.4.5ac).

	(recommended)

Only in 2.4.5aa3: 00_bootmem-header-1

	Comment change (from 2.4.5ac).

	(nice to have)

Only in 2.4.5aa3: 00_clear_inode-if-ext2-error-1

	Remember to clear_inode if the release of the inode in the superblock
	fails. (from 2.4.5ac)

	(nice to have)

Only in 2.4.5aa3: 00_cpudata-cachelinealigned-1

	Make the per-cpu cpu_data[] array a cacheline aligned thing.

	(nice to have)

Only in 2.4.5aa3: 00_fix-unusable-vm-on-alpha-1

	Avoid kswapd looping endlessly and allocating all the swap space even if
	there are hundred of gigabytes of ram free. This is not only a fix for
	alpha but for all the <16Mbytes x86 boxes and more in general for any
	hardware that happens to have at least one zone of memory empty because
	it misses ram in such physical address range for some reason. PDAs
	and most architectures with an iommu falls in that category as well.

	(*very* recommended)

Only in 2.4.5aa3: 00_free_shortage-bool-1

	Return boolean from free_shortage to avoid wasting CPU cycles.

	(nice to have)

Only in 2.4.5aa3: 00_ioapic-2.4.5-1

	Ingo's x86 ioapic updates.

	(recommended)

Only in 2.4.5aa1: 00_ipv6-null-oops-1

	Not needed any longer (thanks DaveM and Alan for the reminder).

Only in 2.4.5aa3: 00_irq-call-prediction-1

	Don't throw away the call prediction stack of the cpu while
	invoking irq handlers from the irq kernel entry point. (from
	2.4.5ac)

	(nice to have)

Only in 2.4.5aa3: 00_local-apic-do_softirq-1

	Don't forget to run the softirqs before returning from the
	local apic interrupt, even if the local apic irq will only
	do the per-process accounting without triggering a softirq
	itself, a nested irq could be running under the local apic
	irq while in_interrupt() was returning 1 (local apic
	does the irq_enter/irq_exit). Fix merged from Ingo's softirq patch, it
	is actually the only real fix included in his patch.

	(recommended)

Only in 2.4.5aa3: 00_mmap-addr-hint-1

	Allow mmap to give the hint on the mapping address.

Only in 2.4.5aa3: 00_nanosleep-4

	Provide nanosleep usec resolution so that a signal flood doesn't hang
	glibc folks that correctly trust the rem field to resume the nanosleep
	after a syscall interruption. (without the patch nanosleep resolution
	is instead 10msec on IA32 and around 1msec on alpha) Without the patch
	userspace risk to starve under signal flood.

	(recommended)

Only in 2.4.5aa3: 00_raisesoftirq-setbit-1

	While disabling irq and using non atomic operation is much nicer
	conceptually as it shows how much the softirqs are per-cpu, the
	atomic version is still actually faster than local cli/sti.
	Improvement merged from Ingo's softirq patch.

	(nice to have)

Only in 2.4.5aa3: 00_sched-rt-fix-1

	Reschedule tasks if they have higher goodness (not higher goodness + 1).
	Merged from 2.4.5ac.

	(recommended)

Only in 2.4.5aa3: 00_seg-reload-1

	Avoid spurious segment reloads (more expensive than branches). Improvement
	merged from 2.4.5ac.

	(nice to have)

Only in 2.4.5aa3: 00_silent-stack-overflow-5

	Avoid stack to silently overflow on the heap (make life easier to track
	down userspace issues). Perfect approach is not possible even using
	special LDT for the stack segment. The approach in the patch will work
	99% of the time and it enforces a GAP between heap and stack of 1 page
	as default (configurable via sysctl, if turned to zero the feature is
	disabled completely).

	(nice to have)

Only in 2.4.5aa3: 10_prefetch-1

	Prefetches next pointer in list_for_each, inode_lock in get_empty_inode()
	(around alloc_inode()), and the runqueue_lock (either per numa node or
	global depending on CONFIG_NUMA_SCHED) around the scheduler prologue.

Only in 2.4.5aa3: expand-stack-smp-1

	Do the checks inside the critical section to avoid races.
-----------------------------------------------------------------------------

On Sat, May 26, 2001 at 07:33:10PM +0200, Andrea Arcangeli wrote:
> I merged Rik's three liner fix to alloc_pages for GFP_BUFFER, plus my
> other fix in create_buffers wait_event and a bit bigger reserved pool of
> async bh. I'd suggest to test if this makes the highmem deadlock to go
> away.
> 
> Detailed description of 2.4.5aa1 follows.
> 
> ---------------------------------------------------------------------------
> 00_alpha-illegal-irq-1
> 
> 	Be verbose for MAX_ILLEGAL_IRQS times if an invalid irq number
> 	is getting run.
> 
> 	(debugging)
> 
> 00_boot-serial-console-1
> 
> 	Allows the serial console to work anytime during boot. It may have side
> 	effects but certainly nothing relevant and the current situation was
> 	annoying enough.
> 
> 	(nice to have)
> 
> 00_create_buffers-deadlock-1
> 
> 	Fix tasks possibly deadlocking in wait_event because the unused_list
> 	isn't refilled at I/O completion anymore with the 2.4
> 	pagecache(/swapcache) design.
> 
> 	(recommended)
> 
> 00_eepro100-64bit-1
> 
> 	Fixes a 64bit bug that was generating false positives and memory
> 	corruption.
> 
> 	(recommended)
> 
> 00_eepro100-alpha-1
> 
> 	Possibly fix the eepro100 transmitter hang on alpha by doing atomic PIO
> 	updates to avoid the clear_suspend to be lost.
> 	
> 	(recommended)
> 
> 00_gfp_buffer-alloc-pages-deadlock-1
> 
> 	Fix from Rik that avoids GFP_BUFFER to deadlock inside alloc_pages().
> 
> 	This is by no means a definitive fix for the VM deadlocks during oom,
> 	all other __GFP_IO allocations can still dealdock inside alloc_pages()
> 	like before. But it is a first step in the right direction I think.
> 
> 	Please try to beat 2.4.5aa1 hard and see if you can reproduce deadlocks
> 	with highmem.
> 
> 	(recommended)
> 
> 00_cachelinealigned-in-smp-1
> 
> 	Moves the pagecache_lock and the VM pagemap_lru_lock in two
> 	different L1 cachelines to avoid contention, mostly useful on
> 	the alpha where the spinlocks uses load locked store
> 	conditional loops (and we don't want to loop).
> 
> 	(nice to have)
> 
> 00_copy-user-lat-2
> 
> 	Put the rechedule points into copy-user calls, with lots of
> 	cache large read/writes could otherwise _never_ reschedule
> 	once until they returns to userspace.
> 
> 	(recommended)
> 
> 00_cpus_allowed-1
> 
> 	Fixes a bug in the cpu affinity in-kernel API, bug was fatal
> 	for ksoftirqd.
> 
> 	(recommended)
> 
> 00_double-buffer-pass-1
> 
> 	Avoids looping two times for no good reason into the lru lists
> 	of the buffer cache (the double loop was an unreliable hack
> 	from the prehistory that survided 'till today).
> 
> 	(nice to have)
> 
> 00_exception-table-1
> 
> 	Avoids a compilation warning when compiling without modules.
> 
> 	(very minor thing)
> 
> 00_highmem-deadlock-3
> 
> 	Fixes an highmem deadlock using a reserved pool for the bounce
> 	buffers.
> 
> 	(recommended)
> 
> 00_highmem-debug-1
> 
> 	Allows people with x86 machines with less than 1G of ram to
> 	test the highmem code.
> 
> 	(debugging)
> 
> 00_ia32-bootmem-corruption-1
> 
> 	Fixes the x86 boot stage to finish initializing all the
> 	reserved memory before starting allocating memory.
> 
> 	(recommended)
> 
> 00_ipv6-null-oops-1
> 
> 	Fixes null pointer oops.
> 
> 	(recommended)
> 
> 00_jens-loop-noop-nobounce-1
> 
> 	Skips the bounces with the null transfer function.
> 
> 	(nice to have)
> 
> 00_ksoftirqd-4
> 
> 	Avoids 1/HZ latency for the softirq if the softirq is marked
> 	again pending when do_softirq() finished and the machine is
> 	otherwise idle, it also fixes the case of a softirq re-marking
> 	itself runnable by delegating to the scheduler the balance of
> 	the softirq load like if it would be an normal task.
> 
> 	(nice to have)
> 
> 00_kupdate-large-interval-1
> 
> 	Allows to set large interval for the kupdate runs, this is
> 	useful on the laptops, instead of sigstopping ksoftirqd it's
> 	nicer to set a large interval for example of the order of one
> 	hour (do that at your own risk of course, doing that is not
> 	recommended unless you know what you're doing).
> 
> 	(nice to have)
> 
> 00_lvm-0.9.1_beta7-4
> 
> 	Updates to the lvmbeta7 with fixes for the lv hardsectsize
> 	estimantion based on the max hardsectsize of the underlying
> 	pv, plus it has some other tons of fixes and it is a must have
> 	for the 64bit archs as the IOP silenty changed for those
> 	platforms.
> 
> 	(recommended)
> 
> 00_max_readahead-1
> 
> 	Increases the max_readahead to allow the blkdev to read with
> 	512k scsi commands when possible.
> 
> 	(nice to have)
> 
> 00_msync-fb0-1
> 
> 	Fixes oopses while running msync on a region of virtual memory
> 	that maps to reserved memory.
> 
> 	(recommended)
> 
> 00_nfs-corruption-3
> 
> 	Production fix for the nfs map_shared fs data
> 	corruption. Other design solutions are discussed and the long
> 	term fix might be different but all the other approches are
> 	more invasive and risky, while this one is obviously right and 
> 	the most approriate for production.
> 
> 	(recommended)
> 
> 00_numa-sched-6
> 
> 	Implements a basic numa scheduler with a per node runqueue
> 	that boosts the perforormance on numa boxes. It also enables
> 	and somewhere fixes the last_idle heuristic in the smp
> 	scheduler.
> 
> 	The numa part doesn't impose any runtime overhead when
> 	CONFIG_NUMA_SCHED is not set.
> 
> 	(nice to have)
> 
> 00_o_direct-7
> 
> 	Implements O_DIRECT zerocopy direct I/O in a filesystem
> 	indipendent fascion, currently it's only available on ext2,
> 	but it will be easy to let the other of fs to take advantage
> 	of it too.
> 
> 	Defines KERNEL_HAS_O_DIRECT so filesystems out of the
> 	kernel can conditionally define the direct_IO callback to get the
> 	O_DIRECT support. Just a one line noop difference.
> 
> 	(nice to have)
> 
> 00_pagetable-fast-2
> 
> 	Enables the usage of the per-cpu quicklists for the pte/pgd to
> 	optimize the cache affinity and footprint.
> 
> 	(nice to have)
> 
> 00_peekurgdata-1
> 
> 	Allows MSG_PEEK to work on the urgent (aka out of band)
> 	receive queue as well, needed for tux.
> 
> 	(nice to have)
> 
> 00_rwsem-13
> 
> 	Alternate implementation for the rwsem, the x86 asm version is
> 	simpler in the slow path and it provides a faster up_write
> 	fast path, the C-spinlock version is much faster too.
> 
> 	ppc and alpha needs to be updated to use asm optimizations.
> 
> 	(nice to have)
> 
> 00_xircom-serial-1
> 
> 	Merged a fix posted on l-k that makes xircom integrated modem to work
> 	fine (without this artificial delay during initialization it really
> 	doesn't work).
> 
> 	(nice to have)
> 
> 00_sched-yield-1
> 
> 	Fixes a bug in sched_yield, where SCHED_YIELD needs to be
> 	cleared after a schedule() if no other task was runnable,
> 	otherwise the next schedule() would inherit the SCHED_YIELD
> 	behaviour even if a SCHED_YIELD wasn't requested anymore.
> 
> 	(nice to have)
> 
> 00_show_regs-1
> 
> 	Makes SYSRQ+P more verbose.
> 
> 	(debugging)
> 
> 00_slab-lists-1
> 
> 	Rewrites the slab cache handling for partial and completly
> 	free slab objects, always provides LIFO behaviour from all
> 	the lists to reduce the cache misses, while previously the
> 	completly free slab objects were reallocated with a less
> 	optimal FIFO policy. It also cleanups the code.
> 
> 	(nice to have)
> 
> 00_softirq-SMP-fixes-3
> 
> 	Fixes an SMP race in the softirq code on archs like the alpha
> 	where the atomic_t and bitop operations aren't memory barriers
> 	as well.
> 
> 	(recommended)
> 
> 00_sync-page-1
> 
> 	Avoids suprious unplug of the tq_disk task queue while waiting
> 	I/O completion.
> 
> 	(nice to have)
> 
> 00_timer_t-2
> 
> 	Defines the timer_t type in one single place.
> 
> 	(nice to have)
> 
> 00_waitqueue-2
> 
> 	Setups the not yet visible waitqueue flags outside the
> 	critical section.
> 
> 	(nice to have)
> 
> 00_x86-systable-1
> 
> 	Fills the end of the syscall table automatically, it is off by
> 	one without this patch.
> 
> 	(nice to have)
> 
> 00_xircom-tulip-cb-arjanv-2
> 
> 	No need of ifconfig eth0 promisc on the xircom card with this
> 	driver.
> 
> 	(nice to have)
> 
> 10_no-virtual-1
> 
> 	Avoids wasting tons of memory if highmem is not selected (like
> 	in all the 64bit ports).
> 
> 	(nice to have)
> 
> 10_parent-timeslice-7
> 
> 	Fixes a scheduler unfairness generated by the parent-timeslice
> 	logic.
> 
> 	(recommended)
> 
> 10_read_ahead-2
> 
> 	Setups readahead for lvm [global, hacking around read/write
> 	callbacks is broken] and drops sensless limits.
> 
> 	(recommended)
> 
> 20_share-timeslice-2
> 
> 	Reschedule the child first but share the timeslice with the
> 	parent (I never triggered a single userspace bug with this
> 	correct patch)
> 
> 	(nice to have)
> 
> The below patches aren't included by default but they can be applied incrementally
> if tux is needed. TUX patches are been developed by Ingo Molnar.
> 
> 30_atomic-alloc-1
> 
> 	Defines a PF_ATOMICALLOC that won't sleep watiting memory to
> 	become available.
> 
> 	(needed by tux)
> 
> 30_atomic-lookup-1
> 
> 	Implements an O_ATOMICLOOKUP flag to avoid entering the
> 	filesystem code that could wait for I/O in open, open will
> 	return -EWOULDBLOCKIO if the lookup wasn't doable in dcache.
> 
> 	(needed by tux for the asynchronous vfs lookups)
> 
> 30_net-exports-1
> 
> 	Exports some networking function so that tux can be compiled
> 	as module,  and splits the sock_map_file functionality away
> 	from sock_map_fd.
> 
> 	(needed by tux)
> 
> 30_pagecache-atomic-1
> 
> 	Defines a do_generic_file_read_atomic that implements
> 	nonblocking reads from cache, if information wasn't in cache
> 	the descriptor error flag is set to -EWOULDBLOCKIO.
> 
> 	(needed by tux to implement asynchronous read I/O)
> 
> 30_tux-2
> 
> 	tux core.
> 
> 	(nice to have)
> 
> 30_tux-data-1
> 
> 	Adds a tux_data private pointer to the sock structure.
> 
> 	(needed by tux)
> 
> 30_tux-dprintk-1
> 
> 	Defines tux_Dprintk.
> 
> 	(needed by tux)
> 
> 30_tux-exports-1
> 
> 	Exports to modules the in-kernel syscalls.
> 
> 	(needed by tux)
> 
> 30_tux-kstat-2
> 
> 	Defines additional kstats for tux.
> 
> 30_tux-process-1
> 
> 	Defines per-process callbacks for tux.
> 
> 30_tux-syscall-1
> 
> 	Implements the tux-syscall, it's the one executed by the
> 	userspace tux program to fire up, shutdown and control the tux
> 	kernel threads.
> 
> 	(needed by tux)
> 
> 30_tux-sysctl-2
> 
> 	Defines the symbolic names for the tux sysctl.
> 
> 	(needed by tux)
> 
> 30_tux-vfs-1
> 
> 	Adds a per-dentry tux private data.
> 
> 	(needed by tux)
> 
> 31_tux-logger-1
> 
> 	Aligns correctly the tux logentry for 8 byte cachelines too.
> 
> ---------------------------------------------------------------------------
> 
> The 2.4.5aa1 patch is here:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa1.bz2
> 
> As usual all the separate patches are in:
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.5aa1/
> 
> and they can be applyed in `ls` order to generate the 2.4.5aa1.bz2
> kernel.
> 
> Have fun.
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
