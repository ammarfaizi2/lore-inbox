Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTDUCPZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 22:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbTDUCPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 22:15:24 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:63208 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S263759AbTDUCPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 22:15:07 -0400
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.x arch/ia64 update
Date: Sun, 20 Apr 2003 20:22:21 -0600
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304202022.21554.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please do a

	bk pull http://lia64.bkbits.net/to-marcelo-2.4

This will update the following files:

 arch/ia64/Makefile                    |    3 
 arch/ia64/config.in                   |    4 
 arch/ia64/configs/dig                 |   13 
 arch/ia64/configs/generic             |   13 
 arch/ia64/configs/ski                 |    9 
 arch/ia64/configs/zx1                 |   13 
 arch/ia64/defconfig                   |   13 
 arch/ia64/dig/setup.c                 |    4 
 arch/ia64/hp/common/sba_iommu.c       |  230 ++++------
 arch/ia64/hp/sim/hpsim_console.c      |   12 
 arch/ia64/hp/sim/hpsim_irq.c          |   16 
 arch/ia64/ia32/binfmt_elf32.c         |    2 
 arch/ia64/ia32/ia32_entry.S           |    7 
 arch/ia64/ia32/ia32_ioctl.c           |    2 
 arch/ia64/ia32/sys_ia32.c             |   42 +
 arch/ia64/kernel/acpi.c               |  104 +---
 arch/ia64/kernel/brl_emu.c            |   10 
 arch/ia64/kernel/efi.c                |   21 
 arch/ia64/kernel/efivars.c            |   54 +-
 arch/ia64/kernel/entry.S              |   53 +-
 arch/ia64/kernel/gate.S               |   49 +-
 arch/ia64/kernel/ia64_ksyms.c         |    4 
 arch/ia64/kernel/iosapic.c            |  282 +++++-------
 arch/ia64/kernel/irq.c                |   10 
 arch/ia64/kernel/irq_ia64.c           |    6 
 arch/ia64/kernel/irq_lsapic.c         |   16 
 arch/ia64/kernel/machvec.c            |    2 
 arch/ia64/kernel/mca.c                |  592 ++++++++++++++++++++------
 arch/ia64/kernel/mca_asm.S            |    8 
 arch/ia64/kernel/palinfo.c            |   47 --
 arch/ia64/kernel/pci.c                |   78 +++
 arch/ia64/kernel/perfmon.c            |  132 +++--
 arch/ia64/kernel/perfmon_mckinley.h   |    4 
 arch/ia64/kernel/process.c            |   31 -
 arch/ia64/kernel/sal.c                |   16 
 arch/ia64/kernel/setup.c              |   23 -
 arch/ia64/kernel/sigframe.h           |    2 
 arch/ia64/kernel/signal.c             |   16 
 arch/ia64/kernel/smpboot.c            |   80 +--
 arch/ia64/kernel/time.c               |   25 -
 arch/ia64/kernel/traps.c              |   39 +
 arch/ia64/kernel/unwind.c             |  492 +++++++++++++--------
 arch/ia64/kernel/unwind_i.h           |    3 
 arch/ia64/lib/memcpy_mck.S            |    6 
 arch/ia64/lib/memset.S                |    6 
 arch/ia64/lib/swiotlb.c               |    2 
 arch/ia64/mm/fault.c                  |    2 
 arch/ia64/mm/init.c                   |    4 
 arch/ia64/mm/tlb.c                    |    8 
 arch/ia64/scripts/unwcheck.sh         |  109 ++++
 arch/ia64/sn/io/ifconfig_net.c        |    6 
 arch/ia64/sn/io/pciba.c               |   28 -
 arch/ia64/sn/io/sn1/hubcounters.c     |    2 
 arch/ia64/sn/io/sn1/pcibr.c           |   32 -
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c |   32 -
 arch/ia64/sn/kernel/setup.c           |   16 
 arch/ia64/tools/print_offsets.c       |    2 
 arch/ia64/vmlinux.lds.S               |   57 +-
 include/asm-ia64/atomic.h             |    2 
 include/asm-ia64/bitops.h             |    6 
 include/asm-ia64/fpu.h                |    7 
 include/asm-ia64/intrinsics.h         |  222 +++++++++
 include/asm-ia64/iosapic.h            |   25 -
 include/asm-ia64/mca.h                |    4 
 include/asm-ia64/pal.h                |    3 
 include/asm-ia64/pci.h                |    3 
 include/asm-ia64/perfmon.h            |    9 
 include/asm-ia64/processor.h          |    4 
 include/asm-ia64/ptrace.h             |    2 
 include/asm-ia64/rwsem.h              |  236 +++++++++-
 include/asm-ia64/sal.h                |  763 +++++++++++++++++-----------------
 include/asm-ia64/smp.h                |   10 
 include/asm-ia64/system.h             |  163 -------
 include/asm-ia64/unaligned.h          |  131 ++---
 include/asm-ia64/unwind.h             |   12 
 75 files changed, 2666 insertions(+), 1830 deletions(-)

through these ChangeSets:

<bjorn_helgaas@hp.com> (03/04/18 1.1118)
   ia64: Update configs.

<kaos@sgi.com> (03/04/18 1.1006.13.74)
   [PATCH] ia64: mca rendezvous fix
   
   We are not setting the 'always rendezvous for mca' flag.  kdb needs it
   set to get decent mca debugging on all cpus but I do not want kdb to
   change sal behaviour.  Since we do not recover from mca without a
   debugger, I see no reason why this flag should not be on for all
   kernels.
   
   The rendezvous timeout was set to 100 * HZ, but SAL expects the timeout
   to be in milliseconds, HZ may not be 1 millisecond.  The patch makes
   the timeout an explicit 20 seconds, semi-arbitrary value.

<bjorn_helgaas@hp.com> (03/04/18 1.1006.13.73)
   ia64: whitespace and trivial changes in mca.c.

<davidm@tiger.hpl.hp.com> (03/04/18 1.1006.13.72)
   ia64: Consolidate backtrace printing in a single routine (ia64_do_show_stack()).

<davidm@tiger.hpl.hp.com> (03/04/18 1.1006.13.71)
   ia64: Update platform INIT handler to print a backtrace.

<davidm@tiger.hpl.hp.com> (03/04/17 1.1006.13.70)
   ia64: dump the min-state area in the MCA INIT platform handler.

<davidm@tiger.hpl.hp.com> (03/04/17 1.1006.13.69)
   ia64: Manual merge of Keith Owen's patch to avoid deadlock on
   	ia64_sal_mc_rendez().  Also prefix local-variables in
   	SAL macros to avoid name collisions.

<davidm@tiger.hpl.hp.com> (03/04/17 1.1006.13.68)
   ia64: Fix SAL processor-log info handling.  Based on patch by
   	Keith Owens.

<davidm@tiger.hpl.hp.com> (03/04/17 1.1006.13.67)
   ia64: Minor whitespace & formatting fixups in asm-ia64/sal.h.

<james@cobaltmountain.com> (03/04/17 1.1006.13.66)
   [PATCH] include_asm-ia64_sal.h, typo: the the

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.65)
   ia64: remove incorrect and redundant "cpu not responding" message.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.64)
   ia64: sba_iommu: fix warning and use old-style ACPI typedef.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.63)
   ia64: Remove unused variable from acpi.c

<mort@wildopensource.com> (03/04/17 1.1006.13.62)
   [PATCH] ia64: print ISR for FPSWA faults
   
   Here is a simple patch to also print isr during the handling of a
   floating point assist fault.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.61)
   ia64: brl_emu.c: use temporary variable to avoid gcc3.1 warning.

<davidm@tiger.hpl.hp.com> (03/04/17 1.1006.13.60)
   ia64: Patch by Arun Sharma: In brl_emu.c, a 64 bit value was being assigned to an
   	int.

<davidm@tiger.hpl.hp.com> (03/04/17 1.1006.13.59)
   ia64: Sync sys32_ipc() with x86 counter-part.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.58)
   ia64: remove cpu_is_online local defs, in favor of a 2.5-style cpu_online.
   Based on a patch from Martin Hicks.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.57)
   ia64: sba_iommu: remove workarounds for broken, never released, firmware that
   didn't program IBASE/IMASK correctly.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.56)
   ia64: sba_iommu: Combine HWP0001 and HWP0004 ACPI claim (from 2.5
   changes by Alex Williamson).

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.55)
   ia64: sba_iommu: make sure devices are at least 32-bit capable (from 2.5).

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.54)
   ia64: sba_iommu: Encapsulate sba_proc_init to follow 2.5.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.53)
   ia64: sba_iommu: printk text and other trivial changes to align with 2.5.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.52)
   ia64: sba_iommu: prefetch_spill_page alignment with 2.5.

<bjorn_helgaas@hp.com> (03/04/17 1.1006.13.51)
   ia64: sba_iommu: whitespace and comment changes to align with 2.5.

<alex_williamson@hp.com> (03/04/16 1.1006.13.50)
   ia64: add wmb in sba_iommu to guarantee IOPDIR updates are visible
   
      This patch ensures that iopdir updates are visible on the bus
   before we return a DMA mapping.  Without this there is a small
   window where the chipset could fetch an invalid iodpir entry
   from memory.  As Grant mentioned before, we've only seen this
   problem exposed with multiple tulip NICs under load.

<davidm@wailua.hpl.hp.com> (03/04/16 1.1006.13.49)
   ia64: Change struct ia64_fpreg so it will get 16-byte alignment with all
   	ia64 compilers, not just GCC.

<schwab@suse.de> (03/04/16 1.1006.13.48)
   ia64: make sys32_ptrace() use ptrace_check_attach().

<schwab@suse.de> (03/04/16 1.1006.13.47)
   [PATCH] ia64: Fix request_module from ia32 process
   
   When an ia32 process triggers request_module the kernel cannot execute
   modprobe because the kernel thread still has the ia32 address limits in
   force.  I think a kernel thread should always have the ia64 address
   limits, similar to what sys32_execve is doing.

<davidm@tiger.hpl.hp.com> (03/04/16 1.1006.13.46)
   ia64: Sync itc after interrupts enabled.

<jes@wildopensource.com> (03/04/16 1.1006.13.45)
   [PATCH] ia64: don't try to synchronize ITCs on ITC_DRIFT platforms
   
   A small patch for 2.4 that stops the kernel from trying to syncrhonize
   ITC clocks between CPUs if we know that the ITC isn't synchronized
   across the backplane.

<bjorn_helgaas@hp.com> (03/04/16 1.1006.13.44)
   ia64: mca.c whitespace changes and dead code removal from 2.5.

<kaos@sgi.com> (03/04/16 1.1006.13.43)
   ia64: Trivial stack-size correction in mca.c.

<davidm@tiger.hpl.hp.com> (03/04/16 1.1006.13.42)
   ia64: Two small MCA fixes.

<schwab@suse.de> (03/04/16 1.1006.13.41)
   [PATCH] ia64: fix unwinder bug in unw_access_gr()
   
   I've found this by inspecting the code: pt_regs_off returns an offset into
   struct pt_regs.  Relative to latest bk, 2.5 has the same bug.

<sv@sw.com.sg> (03/04/16 1.1006.13.40)
   [PATCH] ia64: improve show_trace_task() portability
   
   Trying to port some patches from i386 to ia64 I've found that
   show_trace_task is the only portable way to show tasks' call
   traces(perhaps because it is called from ./kernel/sched.c:)).
   But its ia64 implementation can't work with running task.
   
   Attached patch fixes this issue.
   
   As I understand show_trace and show_stack are platform
   dependent or have different sense/args.

<davidm@tiger.hpl.hp.com> (03/04/16 1.1006.13.39)
   ia64: Minor fixes.

<davidm@tiger.hpl.hp.com> (03/04/16 1.1006.13.38)
   ia64: More vmlinux.lds.S cleanups (__start/__end inside sections).

<rusty@rustcorp.com.au> (03/03/17 1.1006.13.36)
   [PATCH] Designated initializers for ia64
   
   The old form of designated initializers are obsolete: we need to
   replace them with the ISO C forms before 2.6.  Gcc has always supported
   both forms anyway.
   
   (Ported from 2.5 to 2.4 by Bjorn Helgaas to reduce gratuitous diffs).

<eranian@hpl.hp.com> (03/03/17 1.1006.13.35)
   ia64: perfmon update to v1.4
   
   Please apply this patch to your 2.4 BK tree. The patch includes:
   
           - a fix for a sampling bug. When sampling was enabled we
             were record a sample each time a HW counter overflowed instead
             of only when a 64-bit counter value (maintained in software) would
             overflow. This caused bogus samples to be stored in the sampling buffer.
   
           - fix a problem when a HW counter overflow by which we would get a new
             PMU overflow right away because the top bits were not cleared.
   
           - moves PFM_CPUINFO_* into perfmon.h (needed by oprofile)
   
           - adds a new context option PFM_FL_UNSECURE to allow a monitored application
             to start/stop monitoring using rum/sum
   
           - perfmon is now at version 1.4

<Matt_Domsch@Dell.com> (03/03/14 1.1006.13.34)
   ia64: efivars fix by Matt Domsch and Peter Chubb.

<kaos@sgi.com> (03/03/14 1.1006.13.33)
   [PATCH] ia64: unwind.c - allow unw_access_gr(r0)
   
   The patch allows unw_access_gr() to read from r0, to support unwind
   directives such as .save ar.pfs,r0 and .save rp,r0.

<davidm@tiger.hpl.hp.com> (03/03/14 1.1006.13.32)
   ia64: clean up unneeded test in kernel unwinder.

<bjorn_helgaas@hp.com> (03/03/14 1.1006.13.31)
   ia64: cleanup unwind.c warnings (from David's 2.5 change).

<davidm@tiger.hpl.hp.com> (03/03/14 1.1006.13.30)
   ia64: Correct region_start calculation in kernel unwinder.

<bjorn_helgaas@hp.com> (03/03/14 1.1006.13.29)
   ia64: Use printk severity-levels where appropriate.
           Triggered by analysis done by Philipp Marek.
   	(Ported from 2.5 change by Bjorn Helgaas).

<peter@chubb.wattle.id.au> (03/03/14 1.1006.13.28)
   [PATCH] ia64: declare test_bit() arg as "const"
   
   While you're fixing bitops.h, making test_bit take a const qualified
   arg will kill some warnings in reiserfs...

<bjorn_helgaas@hp.com> (03/03/13 1.1006.13.27)
   ia64: Export io_space so drivers using legacy I/O ports can insmod.
   (From Jes Sorensen).

<bjorn_helgaas@hp.com> (03/03/12 1.1006.13.26)
   ia64: iosapic: Remove gratuitous differences with 2.5 (whitespace,
         C99 initializers, printk levels, etc).

<bjorn_helgaas@hp.com> (03/03/12 1.1006.13.25)
   [PATCH] ia64: iosapic: rationalize __init/__devinit
   
   Rationalize __init/__devinit attributes.  The noteworthy changes are that
       iosapic_system_init(),
       iosapic_init(),
       iosapic_register_platform_intr(), and
       iosapic_override_isa_irq()
   are __init (only called from ACPI __init functions), but
       iosapic_lists[],
       num_iosapic,
       find_iosapic(),
       register_intr(),
       iosapic_register_intr(), and
       acpi_register_irq()
   are not because they may be used after init-time by modules.
   
   More detailed analysis:
   
           iosapic_lists[], num_iosapic: normal, referenced by
                   find_iosapic (normal)
                   register_intr (normal)
                   iosapic_init (__init)
   
           pcat_compat: __initdata, referenced by
                   iosapic_system_init (__init)
                   iosapic_init (__init)
                   iosapic_parse_prt (__init)
   
           find_iosapic: normal, called by
                   register_intr (normal)
   
           register_intr: normal, called by
                   iosapic_register_intr (normal), called by
                           acpi_register_irq (normal), called by
                                   modules (=> can't be __init or __devinit)
                   iosapic_register_platform_intr (__init)
                   iosapic_override_isa_irq (__init)
                   iosapic_parse_prt (__init)
   
           iosapic_reassign_vector: __init, called by
                   iosapic_register_platform_intr (__init), called by
                           acpi_parse_plat_int_src (__init)
   
           iosapic_system_init: __init, called by
                   acpi_parse_madt (__init)
   
           iosapic_init: __init, called by
                   acpi_parse_iosapic (__init)
   
           iosapic_register_platform_intr: __init, called by
                   acpi_parse_plat_int_src (__init)
   
           iosapic_override_isa_irq: __init, called by
                   acpi_parse_int_src_ovr (__init)
                   iosapic_init (__init)
   
           fixup_vector: __init, called by
                   iosapic_parse_prt (__init), called by
                           acpi_pci_irq_init (__init)

<bjorn_helgaas@hp.com> (03/03/12 1.1006.13.24)
   [PATCH] ia64: iosapic: self-documenting polarity/trigger arguments
   
   Make interrupt registration functions take named constants for
   polarity and trigger mode.  Old -> new magic decoder ring:
   polarity 0 -> IOSAPIC_POL_LOW    (#defined to 1)
   polarity 1 -> IOSAPIC_POL_HIGH   (#defined to 0)
   trigger 0  -> IOSAPIC_LEVEL      (#defined to 1)
   trigger 1  -> IOSAPIC_EDGE       (#defined to 0)

<bjorn_helgaas@hp.com> (03/03/12 1.1006.13.23)
   [PATCH] ia64: iosapic: simplify ISA IRQ init
   
   Simplify ISA IRQ init by taking advantage of iosapic_override_isa_irq(),
   which already does what we need.

<bjorn_helgaas@hp.com> (03/03/12 1.1006.13.22)
   [PATCH] ia64: iosapic: remove find_iosapic duplication
   
   Remove IOSAPIC address and GSI base from external interrupt
   registration interfaces.  This lets us remove acpi_find_iosapic(),
   which is functionally similar to find_iosapic().

<bjorn_helgaas@hp.com> (03/03/12 1.1006.13.21)
   [PATCH] ia64: iosapic: make pcat_compat system property
   
   Make pcat_compat a system property, not a per-IOSAPIC property.

<alex_williamson@hp.com> (03/03/10 1.1006.4.21)
   ia64: CMC deadlock fix.
   
     Here's a bugfix update to my previous patch.  I was mistakenly
   using smp_call_function w/ interrupts disabled.  There's a definite
   danger of deadlock under those circumstances.

<bjorn_helgaas@hp.com> (03/03/10 1.1006.4.20)
   ia64: chmod +x unwcheck.sh script

<davidm@tiger.hpl.hp.com> (03/03/07 1.1006.4.19)
   ia64: Make signal deliver work when the current register frame is
   	incomplete (as a result of a faulting mandatory RSE load).

<davidm@tiger.hpl.hp.com> (03/03/07 1.1006.4.18)
   ia64: Minor cleanups.  (From 2.5 by Bjorn Helgaas).

<davidm@tiger.hpl.hp.com> (03/03/07 1.1006.4.17)
   ia64: Add unwcheck.sh script contributed by Harish Patil.  It checks
   	the unwind info for consistency (well, just the obvious
   	stuff, but it's a start).
   	Fix the couple of bugs that this script uncovered (and work
   	around one false positive).
   	(Ported to 2.4 by Bjorn Helgaas).

<davidm@tiger.hpl.hp.com> (03/03/07 1.1006.4.16)
   ia64: In kernel unwinder, replace dump_info_pt() with get_scratch_regs()
   	and reformat to make it fit in 100 columns.

<davidm@tiger.hpl.hp.com> (03/03/07 1.1006.4.15)
   ia64; Improve debug output from kernel unwinder.  Based on patch by
   	Keith Owens.  (Ported to 2.4 by Bjorn Helgaas).

<kaos@sgi.com> (03/03/07 1.1006.4.14)
   [PATCH] ia64: fix scratch-regs handling in kernel unwinder
   
   This patch has been running inside SGI for 2 months.  It
   handles kernel stacks with multiple struct pt_regs, as found
   while debugging the kernel.

<jbarnes@sgi.com> (03/03/07 1.1006.4.13)
   [PATCH] ia64: ACPI fix for no PCI
   
   Andy Grover told me this should be posted here.  It allows ACPI to
   compile even with PCI turned off.  Patch against 2.5.60.

<bjorn_helgaas@hp.com> (03/03/06 1.1006.4.12)
   ia64: Update default configs.

<davidm@tiger.hpl.hp.com> (03/03/06 1.1006.4.11)
   ia64: Implement pcibios_set_mwi() and define HAVE_ARCH_PCI_MWI to
   	ensure that PCI line-size gets programmed properly.  Based
   	on patch by Grant Grundler, ported from 2.5 by Bjorn Helgaas.

<davidm@tiger.hpl.hp.com> (03/03/06 1.1006.4.10)
   ia64: Make ia64_fetch_and_add() simpler to optimize so lib/rwsem.c
   	can be optimized properly.

<bjorn_helgaas@hp.com> (03/03/06 1.1006.4.9)
   ia64: ia64_fetch_and_add(), xchg(), ia64_cmpxchg(), etc.
   to intrinsics.h.  (From similar 2.5 changes by David Mosberger).

<kenneth.w.chen@intel.com> (03/03/06 1.1006.4.8)
   [PATCH] ia64: rwsem using atomic primitive

<davidm@hpl.hp.com> (03/03/06 1.1006.4.7)
   ia64: For SIGSEGV triggered by NaT page, set si_addr to faulting
   data address, not the faulting IP.

<bjorn_helgaas@hp.com> (03/03/06 1.1006.4.6)
   ia64: Make CONFIG_SYSCTL control sys32_sysctl as well.  Based on a
   patch from Peter Chubb.

<bjorn_helgaas@hp.com> (03/03/04 1.1006.4.5)
   ia64: Make struct sysinfo32 internal padding explicit.

<alex_williamson@hp.com> (03/03/04 1.1006.4.4)
   ia64: Switch to polling for CMCs if they happen too fast.
   
      Here's another feature I'd like to add to MCA support; the ability
   to detect a flood of CMCs and switch to polling mode for retrieving
   CMC logs.  Once no more CMC logs are found, return to and interrupt
   driven handler.  If the "flood" threshold is never reached, the CMC
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

<alex_williamson@hp.com> (03/03/04 1.1006.4.3)
   ia64: Poll for CPEs on all CPUs, improve check for # of CPEs logged
   
     Here's an update to the patch I sent a couple weeks ago.  I'm going
   to retract the memory scrubbing piece of the patch till I get some
   more validation that it's beneficial.  I kept the CPE polling on all
   processors, the MCA timestamp fix, and added a better mechanism for
   the CPE polling to determine if a log was found.  Previously, if an
   even number of CPE logs were retrieved, the index looked like nothing
   happened.  Feedback welcome.  Thanks,

<bjorn_helgaas@hp.com> (03/03/04 1.1006.4.2)
   ia64: sys32_sysinfo: update to current struct sysinfo (add totalhigh,
   freehigh, mem_unit).

<bjorn_helgaas@hp.com> (03/03/04 1.1006.4.1)
   ia64: Export pm_idle.


Thanks!

Bjorn

