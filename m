Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267306AbSLRSIO>; Wed, 18 Dec 2002 13:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267308AbSLRSIO>; Wed, 18 Dec 2002 13:08:14 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:15013 "HELO atlrel7.hp.com")
	by vger.kernel.org with SMTP id <S267306AbSLRSIH>;
	Wed, 18 Dec 2002 13:08:07 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] arch/ia64 update
Date: Wed, 18 Dec 2002 11:16:06 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212181116.06951.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please do a

	bk pull http://lia64.bkbits.net/to-marcelo-2.4

This will update the following files:

 arch/ia64/hp/sim/simeth.c           |  533 ---------------
 arch/ia64/hp/sim/simscsi.c          |  384 -----------
 arch/ia64/hp/sim/simscsi.h          |   39 -
 arch/ia64/hp/sim/simserial.c        | 1095 --------------------------------
 include/asm-ia64/offsets.h          |  142 ----
 arch/ia64/boot/bootloader.c         |   10 
 arch/ia64/config.in                 |   12 
 arch/ia64/defconfig                 |   76 --
 arch/ia64/hp/common/sba_iommu.c     |  229 ++++--
 arch/ia64/hp/sim/Makefile           |   10 
 arch/ia64/hp/sim/simeth.c           |  535 +++++++++++++++
 arch/ia64/hp/sim/simscsi.c          |  384 +++++++++++
 arch/ia64/hp/sim/simscsi.h          |   39 +
 arch/ia64/hp/sim/simserial.c        | 1097 ++++++++++++++++++++++++++++++++
 arch/ia64/hp/zx1/hpzx1_misc.c       |  514 +++++++--------
 arch/ia64/ia32/ia32_signal.c        |  415 +++++++++++-
 arch/ia64/ia32/sys_ia32.c           |  173 +++--
 arch/ia64/kernel/acpi.c             |   99 +-
 arch/ia64/kernel/efi.c              |  240 ++++---
 arch/ia64/kernel/entry.S            |   26 
 arch/ia64/kernel/fw-emu.c           |   80 +-
 arch/ia64/kernel/gate.S             |   65 +
 arch/ia64/kernel/head.S             |  485 +++++++-------
 arch/ia64/kernel/ia64_ksyms.c       |   14 
 arch/ia64/kernel/iosapic.c          |    4 
 arch/ia64/kernel/irq.c              |    2 
 arch/ia64/kernel/irq_ia64.c         |    2 
 arch/ia64/kernel/machvec.c          |    2 
 arch/ia64/kernel/mca.c              |  149 +++-
 arch/ia64/kernel/pal.S              |   46 +
 arch/ia64/kernel/pci.c              |   53 +
 arch/ia64/kernel/perfmon.c          | 1213 +++++++++++++++++++-----------------
 arch/ia64/kernel/perfmon_generic.h  |   71 +-
 arch/ia64/kernel/perfmon_itanium.h  |   89 +-
 arch/ia64/kernel/perfmon_mckinley.h |  121 ++-
 arch/ia64/kernel/process.c          |    4 
 arch/ia64/kernel/ptrace.c           |   83 ++
 arch/ia64/kernel/signal.c           |   47 +
 arch/ia64/kernel/smp.c              |   16 
 arch/ia64/kernel/smpboot.c          |    4 
 arch/ia64/kernel/sys_ia64.c         |   23 
 arch/ia64/kernel/traps.c            |    3 
 arch/ia64/kernel/unaligned.c        |   95 +-
 arch/ia64/lib/Makefile              |    2 
 arch/ia64/lib/carta_random.S        |   54 +
 arch/ia64/lib/memcpy_mck.S          |   27 
 arch/ia64/lib/swiotlb.c             |   47 -
 arch/ia64/mm/Makefile               |    2 
 arch/ia64/mm/fault.c                |    4 
 arch/ia64/mm/init.c                 |  132 ++-
 arch/ia64/mm/tlb.c                  |    4 
 arch/ia64/sn/io/pci_dma.c           |   64 -
 arch/ia64/sn/kernel/setup.c         |    2 
 arch/ia64/vmlinux.lds.S             |    2 
 include/asm-ia64/acpi.h             |   12 
 include/asm-ia64/ia32.h             |   74 ++
 include/asm-ia64/io.h               |   32 
 include/asm-ia64/machvec.h          |   10 
 include/asm-ia64/machvec_hpzx1.h    |    2 
 include/asm-ia64/machvec_sn1.h      |    2 
 include/asm-ia64/machvec_sn2.h      |    2 
 include/asm-ia64/mc146818rtc.h      |   10 
 include/asm-ia64/mca.h              |    2 
 include/asm-ia64/mca_asm.h          |    3 
 include/asm-ia64/mmu.h              |    8 
 include/asm-ia64/mmu_context.h      |   55 +
 include/asm-ia64/page.h             |   11 
 include/asm-ia64/pal.h              |   43 +
 include/asm-ia64/pci.h              |   11 
 include/asm-ia64/perfmon.h          |   53 +
 include/asm-ia64/pgalloc.h          |   45 -
 include/asm-ia64/pgtable.h          |   20 
 include/asm-ia64/processor.h        |    8 
 include/asm-ia64/sal.h              |    3 
 include/asm-ia64/scatterlist.h      |    3 
 include/asm-ia64/siginfo.h          |    4 
 include/asm-ia64/system.h           |    2 
 include/asm-ia64/unistd.h           |   21 
 78 files changed, 5271 insertions(+), 4228 deletions(-)

through these ChangeSets:

<bjorn_helgaas@hp.com> (02/12/13 1.757.10.38)
   ia64: Alternate signal stack fix.  Patch from David Mosberger.

<bjorn_helgaas@hp.com> (02/12/13 1.757.10.37)
   ia64: break trap: die_if_kernel only if break value is 0.
           (Backport from 2.5 changeset of 02/08/29).

<bjorn_helgaas@hp.com> (02/12/12 1.757.10.36)
   ia64: Move simeth, simserial, simscsi back to drivers/ for init ordering.

<bjorn_helgaas@hp.com> (02/12/12 1.757.10.35)
   ia64: Update defconfig with 2.4.20 defaults, build in ext3.

<bjorn_helgaas@hp.com> (02/12/10 1.757.10.34)
   ia64: Avoid holding task lock while calling access_process_vm().

<bjorn_helgaas@hp.com> (02/12/10 1.757.10.33)
   ia64: Avoid holding tasklist_lock across routines that do IPIs (such as flush_tlb_all()).
   	(From 2.5 patch by David Mosberger).

<bjorn_helgaas@hp.com> (02/12/10 1.757.10.32)
   ia64: Fix typo in unaligned memory access handler (no functional change).

<davidm@tiger.hpl.hp.com> (02/12/10 1.757.10.31)
   ia64: Fix unaligned memory access handler.

<venkatesh.pallipadi@intel.com> (02/12/03 1.757.10.30)
   ia64: IA-32 ptrace: xmm reg support, fpstate 'tag' fix, fp TOS fix
   
   Attached is the patch to IA32 ptrace code in IA64 kernel. This
   patch basically helps gdb'ing of an ia32 app (with ia32
   gdb binary). The patch can easily be verified by running gdb and
   looking at all-registers.
   
   The changes done in the patch include:
   1) Support for xmm registers.
      At present xmm registers are not saved/restored during
      ptrace and gdb wont show them. Patch adds new ptrace
      options (IA32_PTRACE_GETFPXREGS and IA32_PTRACE_SETFPXREGS,
      used by gdb to get/set fp+xmm state).
   2) Bug fix in getting 'tag' field of fpstate
         (fsr>>16 in place of fsr>>32)
   3) Bug fix in calculating fp TOS
      (it is a 3 bit field in fsr. Using (fsr>>11) & 7 in place
       of (fsr>>11) & 3)
   Also, I had to add new structures in ia32.h, corresponding to
   the way gdb is expecting the data. Gdb uses structures
   defined in sys/user.h

<davidm@tiger.hpl.hp.com> (02/12/03 1.757.10.29)
   ia64: Patch by Venkatesh Pallipadi to fix IA-32 signal handling to restore
   	instruction and data pointers.

<davidm@tiger.hpl.hp.com> (02/12/03 1.757.10.28)
   ia64: Some formatting cleanups.

<venkatesh.pallipadi@intel.com> (02/12/03 1.757.10.27)
   [PATCH] ia64: Clearing of exception status before calling IA32 user signal handler
   
   One more bug fix for IA32 exception handler. IA32 exception handler is
   not clearing the exception status, before calling the user signal handler
   routine.

<venkatesh.pallipadi@intel.com> (02/12/03 1.757.10.26)
   [PATCH] ia64: Save/Restore of IA32 fpstate in sigcontext
   
   The IA32 fpstate information is not getting saved/restored during IA32
   exception handling. The issue was first observed due to an IA32 binary
   (which runs fine on IA32 system), failing on Itanium based system. The
   binary was trying to access the fpstate information during an FPE and got a
   SEGV, as the fpstate was not getting saved and the sigcontext->fpstate
   pointer was NULL.

<eranian@frankl.hpl.hp.com> (02/12/03 1.757.10.25)
   ia64: perfmon: This patch adds:
           - full support for randomization of sampling periods
           - a hook for VTune and possibly Prospect so that they can
             synchronize access to the PMU with perfmon
           - updates the initialization to reflect what I have in my development
             kernel (we do not use PAL anymore).
           - update perfmon version to 1.2
   
   This patch fixes:
           - the bug your reported about perfmon_init_percpu()

<bjorn_helgaas@hp.com> (02/12/03 1.757.10.24)
   ia64: Include vendor/function ID for "Unknown" IOCs.

<bjorn_helgaas@hp.com> (02/12/03 1.757.10.23)
   ia64: Fix race between TLB purges and reload_context.
   	(From David Mosberger)

<alex_williamson@hp.com> (02/12/02 1.757.10.22)
   ia64: If no CPE interrupt, poll periodically for CPEs.

<bjorn_helgaas@hp.com> (02/11/19 1.757.10.19)
   ia64: Workaround for old toolchain (__get_user() in perfmon).

<eranian@frankl.hpl.hp.com> (02/11/19 1.757.10.18)
   ia64: perfmon update.

<jsm@udlkern.fc.hp.com> (02/11/15 1.757.10.16)
   ia64: Use virtual mem map automatically if >1GB gap found
   
   Enclosed is a patch for 2.4 that is similar to what is going out with Red
   Hat AS for ia64.  This makes the virtual mem map support "automatic", i.e.
   it will use a virtual mem map if CONFIG_DISCONTIGMEM is not defined and a
   gap of greater than 1 GB is found in the physical memory layout.

<bjorn_helgaas@hp.com> (02/11/14 1.757.10.15)
   ia64: Make mremap() work properly when returning "negative" addresses.
   	Based on patch by Matt Chapman, 2.5 fix by David Mosberger.

<davidm@tiger.hpl.hp.com> (02/11/14 1.757.10.14)
   ia64: Make it easier to set a breakpoint in the Ski simulator right before
   	starting the kernel (based on patch by Peter Chubb).

<kenneth.w.chen@intel.com> (02/11/14 1.757.10.13)
   ia64: Change memcpy to return dest address.

<bjorn_helgaas@hp.com> (02/11/14 1.757.10.12)
   ia64: Fix efi_memmap_walk() to work with more complicated memory maps.
   	Bug reported by Charles Sluder, 2.5 fix by David Mosberger.

<bjorn_helgaas@hp.com> (02/11/14 1.757.10.11)
   ia64: Fix ACPI_ACQUIRE_GLOBAL_LOCK and ACPI_RELEASE_GLOBAL_LOCK.
   	Bug reported by Charles Sluder, 2.5 fix by David Mosberger.

<jung-ik.lee@intel.com> (02/11/14 1.757.10.10)
   [PATCH] ia64: PCI hotplug changes for 2.5.39 or later
   
   The following patch fixes ia64 kernel dump on Hot-Add of PCI bridge cards.
   
   pcibios_fixup_bus();
   pci_do_scan_bus();
   on Hot-Add of bridge adapter;
   	(pulled from 2.5 ia64 tree)

<bjorn_helgaas@hp.com> (02/11/14 1.757.10.9)
   ia64: Make flush_tlb_mm() work for multi-threaded address-spaces on SMP machines.
         (From David Mosberger's 2.5 patch).

<bjorn_helgaas@hp.com> (02/11/14 1.757.10.8)
   ia64: Rename __flush_tlb_all() to local_flush_tlb_all().

<jenna.s.hall@intel.com> (02/11/13 1.757.10.7)
   ia64: Minor MCA bugfixes.

<bjorn_helgaas@hp.com> (02/11/13 1.757.10.6)
   ia64: Restore "fake PCI device" support, for XFree86.  This is intended
         to go away in 2.5.x.

<alex_williamson@hp.com> (02/10/31 1.757.10.4)
   ia64: Fix potential MCA and silent data corruption in HP zx1
         IOMMU driver.
   
    - Fixes a potential silent data corruption because the pdir
      cache on the chipset set was getting improperly flushed.
      It's very hard to hit given the allocation mechanism for the
      pdir, but it is possible.
   
    - Demangles scatter-gather pointers.  The driver was taking far
      too much liberty in changing these.  A known MCA path caused
      by this is SCSI retries, which passed back in a pre-mangled
      scatter-gather array.
   
    - Adds an option for keeping the entire iommu pdir valid.  This
      is really just some debugging code that I added along the way.
      In the event that you've installed a device that aggressively
      tries to prefetch, you may get an MCA if it prefetches beyond
      it's pdir entry.  New boxes shouldn't see much of this because
      PCI will disconnect.  Older systems w/ < rev 3.0 LBAs might
      see issues.  Turning this on, makes all unused pdir entries
      point to a spill page that contains poisoned data. (off by
      default)
   
    - Removes platform_pci_dma_address().  With the extra scatterlist
      entries, it seems reasonable for DMA engines to store the
      address in dma_address.  pci_dma_length is now just a macro for
      sg->dma_length, this feels cleaner and reduces complexity for
      DMA engines that try to coalesce.  I believe it's even a
      benefit for swiotlb.  The sn pci_dma interface likely needs
      some touchups by those that know the interface in this area.
      (thanks to Grant Grundler for helping out here)
   
   One issue I've seen, that's simply because the scatterlist is
   bigger now, 64k pages and IDE don't get along.  ide-dma tries
   to kmalloc a _very_ large scatterlist.  The algorithm factors in
   PAGE_SIZE, but it only seems to produce a reasonable value if you
   have 4k pages.  It goes ballistic at 64k.  Replacing the kmalloc/
   kfree w/ a vmalloc/vfree solves the problem, but seems like it's
   only a bandaid.

<willy@fc.hp.com> (02/10/31 1.757.10.3)
   ia64: ACPI tidy-up.

<bjorn_helgaas@hp.com> (02/10/29 1.757.10.2)
   ia64: Detect HP ZX1 AGP bridge via ACPI instead of the old, unmaintainable
         "fake PCI device" scheme.

<bjorn_helgaas@hp.com> (02/10/18 1.742.2.3)
   ia64: Skip blind PCI probe when root bridges are reported by ACPI.

<bjorn_helgaas@hp.com> (02/10/18 1.742.2.2)
   ia64: Scan PCI buses 0-255 (not 0-254).

<bjorn_helgaas@hp.com> (02/10/09 1.717.10.2)
   ia64: more scatterlist page/offset cleanup.

<bjorn_helgaas@hp.com> (02/10/04 1.706.1.6)
   ia64: Optimize load/save FPU (Fenghua Yu, Intel).

<agruen@suse.de> (02/10/04 1.706.1.5)
   ia64: Extended Attribute VFS syscalls.

<bjorn_helgaas@hp.com> (02/10/04 1.706.1.4)
   ia64: Reserve hugetlb syscall numbers.

<bjorn_helgaas@hp.com> (02/10/03 1.706.1.3)
   ia64: Remove obsolete McKinley A0 workaround.

<davidm@tiger.hpl.hp.com> (02/10/01 1.706.1.2)
   ia64: Fix EFI runtime callbacks so they cannot corrupt fp regs.

<bjorn_helgaas@hp.com> (02/10/01 1.676.7.27)
   ia64: support scatterlist page/offset in sba_iommu.c.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.25)
   ia64: Add PCI_DMA_BUS_IS_PHYS definition.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.24)
   Remove include/asm-ia64/offsets.h.

<davidm@tiger.hpl.hp.com> (02/09/27 1.676.7.23)
   ia64: Create dummy file include/asm-ia64/mc146818rtc.h since ide-geometry.c continues to
   insist on it.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.22)
   ia64: Sync with pcibios_enable_device interface change

<davidm@tiger.hpl.hp.com> (02/09/27 1.676.7.21)
   ia64: Fix edge-triggered IRQ handling.  See Linus's 2.5 cset 1.611 for details.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.20)
   ia64: Remove McKinley A-step config stuff.

<willy@fc.hp.com> (02/09/27 1.676.7.19)
   ia64: Discard *.text.exit and *.data.exit sections.

<willy@fc.hp.com> (02/09/27 1.676.7.18)
   ia64: Remove support for HP prototypes.

<davidm@tiger.hpl.hp.com> (02/09/27 1.676.7.17)
   ia64: Fix narrow window during which signal could be delivered with only the memory
         stack switched over to the alternate signal stack.

<davidm@tiger.hpl.hp.com> (02/09/27 1.676.7.16)
   ia64: Fix return path of signal delivery for sigaltstack() case.

<eranian@hpl.hp.com> (02/09/27 1.676.7.15)
   ia64: Fix perfmon error path leaks.

<eranian@hpl.hp.com> (02/09/27 1.676.7.14)
   ia64: Fix perfmon error path missing unlock.

<davidm@tiger.hpl.hp.com> (02/09/27 1.676.7.13)
   ia64: Fix x86 struct ipc_kludge (reported by R Sreelatha, fix proposed by
         Dave Miller).

<jsm@udlkern.fc.hp.com> (02/09/27 1.676.7.12)
   ia64: Preserve f11-f15 around calls into firmware.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.11)
   ia64: Print EFI call status in hex, not decimal.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.10)
   ia64: Rename ia64_alloc_irq to ia64_alloc_vector.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.9)
   ia64: Move simeth, simserial, simscsi to arch/ia64/hp/sim.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.8)
   ia64: If more than NR_CPUS found, ignore the extras.

<bjorn_helgaas@hp.com> (02/09/27 1.676.7.7)
   ia64: Reserve syscall numbers 1238-1242 for AIO.

<davidm@tiger.hpl.hp.com> (02/09/27 1.676.7.6)
   ia64: Fix I/O macros in asm-ia64/io.h.  Based on patch by Andreas Schwab.

<t-kouchi@mvf.biglobe.ne.jp> (02/09/27 1.676.7.5)
   ia64: ACPI CRS cleanup.

<schwab@suse.de> (02/09/27 1.676.7.4)
   ia64: Remove many warnings.

<t-kouchi@mvf.biglobe.ne.jp> (02/09/27 1.676.7.3)
   ia64: Fix iosapic debug code.

<schwab@suse.de> (02/09/27 1.676.7.2)
   ia64: Add missing symbol exports for modules.


Thanks!

Bjorn

