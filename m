Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTDITQ1 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTDITQ1 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:16:27 -0400
Received: from palrel13.hp.com ([156.153.255.238]:13730 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S263667AbTDITQS (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 15:16:18 -0400
Date: Wed, 9 Apr 2003 12:27:50 -0700
From: David Mosberger <davidm@napali.hpl.hp.com>
Message-Id: <200304091927.h39JRob0010157@napali.hpl.hp.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: bk pull
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please do a

	bk pull http://lia64.bkbits.net/to-linus-2.5

This will update the files shown below.

Thanks!

	--david

 arch/ia64/sn/tools/make_textsym    |  171 ----
 Documentation/io_ordering.txt      |   47 +
 arch/ia64/Kconfig                  |    9 
 arch/ia64/Makefile                 |   10 
 arch/ia64/boot/Makefile            |    1 
 arch/ia64/hp/common/sba_iommu.c    |    2 
 arch/ia64/ia32/ia32_entry.S        |    4 
 arch/ia64/ia32/ia32_signal.c       |    9 
 arch/ia64/ia32/sys_ia32.c          |  125 ---
 arch/ia64/kernel/Makefile          |   23 
 arch/ia64/kernel/acpi-ext.c        |   71 ++
 arch/ia64/kernel/acpi.c            |   72 +-
 arch/ia64/kernel/entry.S           |   17 
 arch/ia64/kernel/fsys.S            |   18 
 arch/ia64/kernel/head.S            |   70 --
 arch/ia64/kernel/ia64_ksyms.c      |   18 
 arch/ia64/kernel/mca.c             |  284 +++++++-
 arch/ia64/kernel/module.c          | 1281 +++++++++++++++++++++++++++++++------
 arch/ia64/kernel/palinfo.c         |   10 
 arch/ia64/kernel/perfmon.c         |   11 
 arch/ia64/kernel/process.c         |   30 
 arch/ia64/kernel/signal.c          |    4 
 arch/ia64/kernel/smpboot.c         |   13 
 arch/ia64/kernel/time.c            |   21 
 arch/ia64/kernel/traps.c           |    4 
 arch/ia64/kernel/unwind.c          |   12 
 arch/ia64/lib/io.c                 |   33 
 arch/ia64/lib/swiotlb.c            |    7 
 arch/ia64/mm/fault.c               |    1 
 arch/ia64/module.lds               |   13 
 arch/ia64/pci/pci.c                |  118 ++-
 arch/ia64/scripts/check-gas        |    3 
 arch/ia64/sn/Makefile              |   14 
 arch/ia64/sn/fakeprom/Makefile     |   29 
 arch/ia64/sn/fakeprom/README       |   32 
 arch/ia64/sn/fakeprom/fpmem.c      |   30 
 arch/ia64/sn/fakeprom/fprom.lds    |   31 
 arch/ia64/sn/fakeprom/make_textsym |  171 ++++
 arch/ia64/sn/io/Makefile           |    8 
 arch/ia64/sn/io/sn2/Makefile       |    7 
 arch/ia64/sn/io/sn2/l1_command.c   |    4 
 arch/ia64/sn/io/sn2/pcibr/Makefile |    2 
 arch/ia64/sn/kernel/Makefile       |   44 -
 arch/ia64/sn/kernel/setup.c        |    7 
 arch/ia64/sn/kernel/sn2/Makefile   |   38 -
 arch/ia64/sn/kernel/sn2/io.c       |   98 ++
 arch/ia64/sn/kernel/sn2/iomv.c     |   11 
 include/asm-ia64/acpi-ext.h        |   32 
 include/asm-ia64/acpi.h            |    2 
 include/asm-ia64/atomic.h          |   15 
 include/asm-ia64/bitops.h          |    2 
 include/asm-ia64/compat.h          |   49 +
 include/asm-ia64/fcntl.h           |    5 
 include/asm-ia64/fpu.h             |    5 
 include/asm-ia64/ia32.h            |   11 
 include/asm-ia64/intrinsics.h      |    4 
 include/asm-ia64/io.h              |   36 -
 include/asm-ia64/machvec.h         |   45 -
 include/asm-ia64/machvec_hpzx1.h   |    2 
 include/asm-ia64/machvec_init.h    |    1 
 include/asm-ia64/machvec_sn1.h     |    4 
 include/asm-ia64/machvec_sn2.h     |   39 -
 include/asm-ia64/mca.h             |    2 
 include/asm-ia64/module.h          |   54 +
 include/asm-ia64/pci.h             |   15 
 include/asm-ia64/pgtable.h         |   31 
 include/asm-ia64/processor.h       |    6 
 include/asm-ia64/sal.h             |   31 
 include/asm-ia64/smp.h             |    4 
 include/asm-ia64/sn/io.h           |    7 
 include/asm-ia64/sn/sn2/io.h       |  206 +++++
 include/asm-ia64/spinlock.h        |   64 -
 include/asm-ia64/system.h          |    3 
 include/asm-ia64/unaligned.h       |  131 +--
 74 files changed, 2801 insertions(+), 1043 deletions(-)

through these ChangeSets:

<davidm@tiger.hpl.hp.com> (03/04/09 1.1048)
   ia64: Initial sync with 2.5.67.

<mort@wildopensource.com> (03/04/09 1.1047)
   [PATCH] ia64: Fix up "extern inline"
   
   Here is a trivial patch to processor.h to change "extern" to "static".

<sfr@canb.auug.org.au> (03/04/08 1.1046)
   [PATCH] ia64: compat_uptr_t and compat_ptr
   
   Here is the ia64 part of the patch.  It depends on my previous COMPAT
   patches.  This is safe to apply even before Linus applies the generic
   part.

<sfr@canb.auug.org.au> (03/04/08 1.1045)
   [PATCH] ia64: compat_sys_fcntl{,64}
   
   Here is the ia64 part of the patch.  Pleas apply after Linus has applied
   the generic part.

<davidm@tiger.hpl.hp.com> (03/04/08 1.889.308.55)
   ia64: Sync sys32_ipc() with x86 counter-part.

<davidm@wailua.hpl.hp.com> (03/04/07 1.889.308.54)
   ia64: Fix inconsistency in sys32_execve().  Reported by
   	Chandra Kapate).

<alex_williamson@hp.com> (03/04/03 1.889.308.53)
   [PATCH] ia64: update PCI segment support
   
   Update to the PCI segment support that Bjorn posted around 2.5.19ish.

<davidm@tiger.hpl.hp.com> (03/04/03 1.889.308.52)
   ia64: Trivial stack-size correction in mca.c.  Patch by Keith Owens.

<alex_williamson@hp.com> (03/04/03 1.889.308.51)
   [PATCH] ia64: remove platform_pci_dma_addres
   
   This removes platform_pci_dma_address.  Since the scatterlist
   in 2.5 has a dma_address, seems like we can expect a certain usage
   of it.  SGI folks may want to verify this doesn't break their DMA
   engines.

<alex_williamson@hp.com> (03/04/03 1.889.308.50)
   [PATCH] ia64: generic build fix
   
   trivial build fix for the generic kernel target

<davidm@tiger.hpl.hp.com> (03/04/03 1.889.308.49)
   ia64: Checkin support files for vendor-specific ACPI extensions.
         Fix spelling of Hewlett-Packard.

<Xavier.Bru@bull.net> (03/04/03 1.889.308.48)
   [PATCH] ia64: fix missing symbol exports
   
   3) with CONFIG_NUMA set, there are undefined symbols building modules:
   
   scripts/modpost vmlinux drivers/md/dm-mod.o drivers/net/e1000/e1000.o drivers/net/eepro100.o drivers/md/md.o drivers/net/mii.o fs/xfs/xfs.o
   *** Warning: cpu_info__per_cpu [fs/xfs/xfs.ko] undefined!
   *** Warning: cpu_info__per_cpu [drivers/md/md.ko] undefined!
   *** Warning: cpu_to_node_map [drivers/md/md.ko] undefined!
   
   exporting them in ia64_ksyms.c fixes the problem.

<davidm@tiger.hpl.hp.com> (03/03/31 1.889.308.47)
   ia64: Fix IA64_FETCHADD() macro.

<mort@wildopensource.com> (03/03/31 1.889.308.46)
   [PATCH] ia64: replace cpu_is_online with cpu_online
   
   Consolidate the uses of
   cpu_is_online() to use the (relatively) new
   cpu_online() macro.

<jbarnes@sgi.com> (03/03/31 1.889.308.45)
   [PATCH] ia64: machine vectors for readX routines
   
   We need readX() to be machine vectors since some platforms don't provide
   DMA coherence via PIO reads (PCI drivers and the spec imply that this is
   a good idea).  Writes are ok though for all existing ia64 platforms (and
   hopefully it'll stay that way).

<davidm@wailua.hpl.hp.com> (03/03/27 1.889.308.44)
   ia64: Change struct ia64_fpreg so it will get 16-byte alignment with all
   	ia64 compilers, not just GCC.

<davidm@tiger.hpl.hp.com> (03/03/27 1.889.308.43)
   ia64: Patch by Andreas Schwab to fix sys32_ptrace().

<schwab@suse.de> (03/03/27 1.889.308.42)
   [PATCH] ia64: Fix request_module from ia32 process
   
   When an ia32 process triggers request_module the kernel cannot execute
   modprobe because the kernel thread still has the ia32 address limits in
   force.  I think a kernel thread should always have the ia64 address
   limits, similar to what sys32_execve is doing.

<jes@wildopensource.com> (03/03/27 1.889.308.41)
   [PATCH] ia64: don't try to synchronize ITCs on ITC_DRIFT platforms
   
   A small patch for 2.4 that stops the kernel from trying to syncrhonize
   ITC clocks between CPUs if we know that the ITC isn't synchronized
   across the backplane.

<kochi@hpc.bs1.fc.nec.co.jp> (03/03/27 1.889.308.40)
   [PATCH] ia64: update email address
   
   My e-mail address changed and I'd like to update it in arch/ia64/kernel/acpi.c.

<davidm@tiger.hpl.hp.com> (03/03/27 1.889.308.39)
   ia64: Two small MCA fixes.

<schwab@suse.de> (03/03/26 1.889.308.38)
   [PATCH] ia64: fix unwinder bug in unw_access_gr()
   
   I've found this by inspecting the code: pt_regs_off returns an offset into
   struct pt_regs.  Relative to latest bk, 2.5 has the same bug.

<Eric.Piel@Bull.Net> (03/03/26 1.889.308.37)
   [PATCH] ia64: fix settimeofday() not synchronised with gettimeofday()
   
   Eric Piel wrote:
   > However, now, it still gives negative difference:
   > # ./a.out
   > requested:      1047572128s 2564ns
   > new:            1047572128s 1588ns
   > diff is -0.000976000sec
   > 
   > That's better but there is still something...
   > Can anyone reproduce this bug? Any idea about what may cause this
   > shifted results?
   > 
   > I don't understand what does the line in settimeofday():
   >         nsec -= (jiffies - wall_jiffies ) * (1000000000 / HZ);
   
   Finally I read the code to do the same thing for i386 (get and
   settimeofday()). This explains the meaning of this line, in the i386
   it's associated with the equivalent line in do_gettimeofday()! On ia64
   everything is done inside of gettimeoffset(). Therefore I'm now
   confident that suppressing this line is a Good Thing ;-) The patch doing
   it wrt the bk tree is attached.
   
   The test case confirms that it works:
   requested:      1048681051s 194873ns
   new:            1048681051s 194874ns
   diff is  0.000001000sec
   
   That's the same result than on a 2.4.19 . 
   This also solved an error on the high resolution timers test suite.

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.36)
   ia64: More module-loader fixing.

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.35)
   ia64: Fix module loader by setting sh_type of place-holder sesctions to SHT_NOBITS.

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.34)
   ia64: Minor fixes.

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.33)
   ia64: Add module.lds.

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.32)
   ia64: Fix typo in sys_clone().

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.31)
   ia64: Add ia64-specific LDFLAGS_MODULE and export unwind API to modules.

<davidm@tiger.hpl.hp.com> (03/03/26 1.889.308.30)
   ia64: Rewrite the relocator in the kernel module loader.  Fix some bugs and simplify
   	the handling of loader-created sections.

<wolfgang@top.mynetix.de> (03/03/24 1.889.308.29)
   [PATCH] ia64: Cross-compile fix
   
   the attached patch (against bk-current) fixes a cross 
   compilation problem by using the target specific objdump 
   tool instead of the host specific one.

<davidm@tiger.hpl.hp.com> (03/03/24 1.889.308.28)
   ia64: Manual merge of Keith Owen's patch to avoid deadlock on
   	ia64_sal_mc_rendez().  Also prefix local-variables in
   	SAL macros to avoid name collisions.

<kaos@sgi.com> (03/03/24 1.889.308.27)
   [PATCH] ia64: mca rendezvous fix
   
   We are not setting the 'always rendezvous for mca' flag.  kdb needs it
   set to get decent mca debugging on all cpus but I do not want kdb to
   change sal behaviour.  Since we do not recover from mca without a
   debugger, I see no reason why this flag should not be on for all
   kernels.
   
   The rendezvous timeout was set to 100 * HZ, but SAL expects the timeout
   to be in milliseconds, HZ may not be 1 millisecond.  The patch makes
   the timeout an explicit 20 seconds, semi-arbitrary value.

<davidm@tiger.hpl.hp.com> (03/03/22 1.889.308.26)
   First draft at making modules work again (loosely based on Rusty's original and
   thoroughly broken ia64 patch).  Not all relocs are supported yet and the reloc
   code needs to be cleaned up, but simply stuff like loading the palinfo module
   works.  Also, linkage-stubs are optimized with brl for McKinley or better.

<davidm@tiger.hpl.hp.com> (03/03/22 1.889.308.25)
   ia64: Minor Makefile cleanup.

<sv@sw.com.sg> (03/03/21 1.889.308.24)
   [PATCH] ia64: improve show_trace_task() portability
   
   Trying to port some patches from i386 to ia64 I've found that
   show_trace_task is the only portable way to show tasks' call
   traces(perhaps because it is called from ./kernel/sched.c:)).
   But its ia64 implementation can't work with running task.
   
   Attached patch fixes this issue.
   
   As I understand show_trace and show_stack are platform
   dependent or have different sense/args.

<alex_williamson@hp.com> (03/03/19 1.889.308.23)
   [PATCH] ia64: Use PAL_HALT_LIGHT in cpu_idle
   
   Here's patches for 2.4 & 2.5 to use PAL_HALT_LIGHT in cpu_idle.
   This helps to reduce CPU temp a little on boxes with firmware that
   takes advantage of this lower power state.  I've tried this on a
   rx2600 (2x900MHz McKinley) and an i2000 (fw 117) and it shows some
   benefit.  On McKinley systems, only the very latest PAL from Intel
   actually reduces power consumption in the halt_light state.  For HP
   rx2600/zx6000/zx2000, this means you need to be running firmware 1.82.
   
     Rohit Seth, at Intel, has run some benchmarks with this kind of
   modification and found the effects of enabling halt_light to fall
   within the noise of mosts tests.  I replaced pal_halt(1) in safe_halt
   with pal_halt_light() since halt_light is required to be implemented,
   but pal_halt(1) is an optional halt state.  I'd be interested to hear
   of any measurements anyone does using this, where it works/fails, and
   if any benchmarks/applications are impacted.

<jbarnes@sgi.com> (03/03/18 1.889.308.22)
   [PATCH] ia64: SN makefile update take
   
   David, here's an updated patch that doesn't mess with
   arch/ia64/Makefile in case you hadn't applied the last one yet

<mort@wildopensource.com> (03/03/18 1.889.308.21)
   [PATCH] ia64: print ISR for FPSWA faults
   
   Here is a simple patch to also print isr during the handling of a
   floating point assist fault.

<jbarnes@sgi.com> (03/03/18 1.889.308.20)
   [PATCH] ia64: remove stale mmiob function
   
   The consensus on lkml was that devices should do reads from safe
   registers to ensure PIO write ordering, which means we no longer need
   mmiob.  This patch removes the mmiob entries from the machine vector
   headers and io.h and updates the documentation about PIO ordering.

<davidm@tiger.hpl.hp.com> (03/03/18 1.889.308.19)
   ia64: Patch by Andreas Schwab: The read_lock and read_unlock macros
   should not use such innocent variable names like tmp because they
   have a high probability to clash with (part of) the argument.

<kaos@sgi.com> (03/03/14 1.889.308.18)
   [PATCH] ia64: unwind.c - allow unw_access_gr(r0)
   
   The patch allows unw_access_gr() to read from r0, to support unwind
   directives such as .save ar.pfs,r0 and .save rp,r0.

<davidm@tiger.hpl.hp.com> (03/03/14 1.889.308.17)
   ia64: Fix sys_clone() to take 5 input arguments.

<Eric.Piel@Bull.Net> (03/03/13 1.889.308.16)
   [PATCH] ia64: POSIX timer fixes
   
   Here is a patch to have the POSIX timer interface completly integrated
   in ia64 (2.5.64). The programs in userland can now access the siginfo
   structure. With that patch the test programs of the high resolution
   timers pass without error but one which seems to also be triggered on
   ix86: nanosleeps too short.

<davidm@tiger.hpl.hp.com> (03/03/13 1.889.308.15)
   ia64: Fix settimeofday().  Based on patch by Eric Piel.

<jakub@redhat.com> (03/03/13 1.889.308.14)
   [PATCH] ia64: clone2/clone argument order fixes
   
   do_fork is declared as:
   struct task_struct *do_fork(unsigned long clone_flags,
                               unsigned long stack_start,
                               struct pt_regs *regs,
                               unsigned long stack_size,
                               int *parent_tidptr,
                               int *child_tidptr)
   ie. parent_tidptr is out4 and child_tidptr is out5, but
   the comments in clone2 were suggesting otherwise.
   So, we either need a patch which will codify current order
   of clone arguments (ie. ptid, ctid, tls; attached below - has the advantage
   that clone2 stays with the same ABI as in 2.5.[56]x), or the arguments
   of clone2 and clone should be reordered to match the IA-32 order
   (which is ptid, tls, ctid).

<davidm@tiger.hpl.hp.com> (03/03/11 1.889.308.13)
   ia64: Rename __put_task_struct() to free_task_struct().  Based on patch by Peter Chubb.

<davidm@tiger.hpl.hp.com> (03/03/11 1.889.308.12)
   ia64: Remove ia64_spinlock_contention().

<peter@chubb.wattle.id.au> (03/03/11 1.889.308.11)
   [PATCH] ia64: declare test_bit() arg as "const"
   
   While you're fixing bitops.h, making test_bit take a const qualified
   arg will kill some warnings in reiserfs...

<alex_williamson@hp.com> (03/03/11 1.889.308.10)
   [PATCH] ia64: CPE & CMC polling for 2.5
   
   Here's another feature I'd like to add to MCA support; the ability
   to detect a flood of CMCs and switch to polling mode for retrieving
   CMC logs.  Once no more CMC logs are found, return to and interrupt
   driven handler.  If the flood threshold is never reached, the CMC
   handler simply behaves as it does today.
   
      It's useful to get the CMC logs to know that something isn't
   quite right, but if you end up with some bad memory it's too easy for
   them to interfere with useful work.  I've tested this on an HP rx2600,
   with a known bad DIMM.  This DIMM acts like it has a completely dead
   DRAM on it.  With the current CMC handler, once I hit that range of
   memory addresses, the system essentially dies, constantly handling
   CMC errors.  With this patch, the system hits the threshold quickly,
   but remains functional with no performance degredation once in polling
   mode.  This patch applies against linux-2.4.20-ia64-021210 and 
   includes:
   
    - Switching CMCs to polling mode at predeterimined threshold
    - If polling for CPEs, poll on all processors
    - Fix timestamp on log output

<davidm@tiger.hpl.hp.com> (03/03/11 1.889.308.9)
   ia64: Drop unused NEW_LOCK spinlock code and clean up unneeded test
   	in kernel unwinder.

