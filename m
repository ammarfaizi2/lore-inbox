Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWIZKo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWIZKo4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWIZKo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:44:56 -0400
Received: from mail.suse.de ([195.135.220.2]:35480 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751116AbWIZKoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:44:55 -0400
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: x86/x86-64 merge for 2.6.19
Date: Tue, 26 Sep 2006 12:44:43 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200609261244.43863.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull 'for-linus' from
	
	http://one.firstfloor.org/home/andi/git/linus-2.6

[This is my first voyage into git land this so please excuse any mistakes.
This is actually just a quick merge of my quilt tree, which is still
the authoritative tree]

No diffs because it is far too much.

Changes:

Aaron Durbin:
      Insert GART region into resource map
      MMCONFIG and new Intel motherboards

Adam Henley:
      A few trivial spelling and grammar fixes

Adrian Bunk:
      i386: make functions static
      i386: Make acpi_force static
      i386: Make enable_local_apic static

adurbin@google.com:
      insert IOAPIC(s) and Local APIC into resource map
      i386: add HPET(s) into resource map

Andi Kleen:
      Update defconfig
      i386: Update defconfig
      i386: Allow to use GENERICARCH for UP kernels
      x86: Temporarily revert parts of the Core 2 nmi nmi watchdog support
      Add TIF_RESTORE_SIGMASK
      Add ppoll/pselect syscalls
      Fix up panic messages for different NMI panics
      i386: Enable NMI watchdog by default
      x86: Add portable getcpu call
      Clean up asm/smp.h includes
      Don't print virtual address in HPET initialization
      i386/x86-64: Don't randomize stack top when no randomization personality is set
      i386: Account spinlocks to the caller during profiling for !FP kernels
      Simplify profile_pc on x86-64
      Document backtracer selection options
      Support patchable lock prefix for pure assembly files
      Clean up read write lock assembly
      i386: Remove const case for rwlocks
      Add proper alignment to ENTRY
      i386: add alternative-asm.h to allow LOCK_PREFIX replacement in .S files
      i386: Redo semaphore and rwlock assembly helpers
      Remove leftover CVS Id in thunk.S
      Add some comments what tce.c actually does
      Remove all ifdefs for local/io apic
      Remove apic mismatch counter
      Remove old "focus disabled" chipset errata workaround
      Clean up and minor fixes to TLB flush
      i386: Minor fixes & cleanup to tlb flush
      Add some comments to entry.S
      Remove pirq overwrite support
      Remove leftover MCE/EISA support
      Remove obsolete PIC mode
      i386/x86-64: Remove obsolete sanity check in mptable parsing
      Factor out common io apic routing entry access
      i386: Factor out common io apic routing entry access
      Remove MPS table APIC renumbering
      Move early chipset quirks out to new file
      Replace mp bus array with bitmap for bus not pci
      Remove useless wrapper in mpparse.c code
      Remove some unneeded ACPI externs in mpparse.c
      Fix up some non linuxy style in ACPI functions in mpparse.c
      i386: Clean up code style in mpparse.c ACPI code
      Use BUILD_BUG_ON in apic.c build sanity checking
      x86: Detect CFI support in the assembler at runtime
      Remove obsolete CVS $Id$ from assembler files in arch/x86_64/kernel/*
      Add stack documentation document from Keith Owens
      i386: Remove lock section support in mutex.h
      i386: Remove lock section support in rwsem.h
      i386: Remove lock section support in semaphore.h
      Don't use lock section for mutexes and semaphores
      Clean up spin/rwlocks
      i386: Clean up spin/rwlocks
      Use early CPU identify before early command line parsing
      Convert x86-64 to early param
      Remove need for early lockdep init
      i386/x86-64: Move acpi_disabled variables into acpi/boot.c
      Clean up acpi_numa variable
      Move e820 map into e820.c
      Add sparse annotation to vsyscall.c
      Add sparse annotations to quiet sparse in arch/x86_64/mm/fault.c
      Fix most sparse warnings in sys_ia32.c
      Fix sparse warnings in compat aout code
      x86: Remove unneeded externs in acpi/boot.c
      x86: Some preparationary cleanup for stack trace
      Avoid recursion in lockdep when stack tracer takes locks
      Don't access the APIC in safe_smp_processor_id when it is not mapped yet
      Move unwind_init earlier
      Merge stacktrace and show_trace
      Check for end of stack trace before falling back
      i386: Do stacktracer conversion too
      i386: Terminate backtrace fallback early if unwinder stack pointer is zero
      i386: Get ebp from unwinder state when continuing fallback backtrace
      Don't force frame pointers for lockdep
      i386/x86-64: Improve Kconfig description of CRASH_DUMP
      Make boot_param_data pure BSS
      i386: Fix warning in mpparse.c
      make fault notifier unconditional and export it
      i386: make fault notifier unconditional and export it
      i386: move kernel_thread_helper into entry.S
      Don't force reserve the 640k-1MB range
      Move compiler check for modules to ia64 only
      Remove safe_smp_processor_id()
      Remove bogus warning from early_ioremap
      Fix pte_exec/mkexec and use it in change_page_attr()
      Use proper accessors to change PSE bits in change_page_attr()
      Remove APIC version/cpu capability mpparse checking/printing
      Remove some cruft in apic id checking during processor setup
      Fix coding style and output of the mptable parser
      Add a missing check for irq flags tracing in NMI
      Remove non e820 fallbacks in high level code
      optimize hweight64 for x86_64
      x86: Remove incorrect comment about ACPI e820 entries
      Optimize PDA accesses slightly
      Don't use kernel_text_address in oops context
      Document my tree in Documentation/HOWTO
      Fix a irqcount comment in entry.S
      Use %c instead of %P modifier in pda access
      Fix a PDA warning uncovered by the new type checking
      Fix zeroing on exception in copy_*_user
      Add __must_check to copy_*_user
      Check return value of copy_to_user in compat_sys_pselect7
      Check return values of __copy_to_user in uname emulation
      Fix some stylistic issues in uaccess.h
      Reindent macros in pda.h
      Define __bad_pda_field as noreturn
      Remove unused asm-x86_64/mmx.h
      Mark per cpu data initialization __initdata again
      Fix idle notifiers
      i386/x86-64: PCI: split probing and initialization of type 1 config space access
      i386/x86-64: Only do MCFG e820 check when type 1 works
      i386: Add MMCFG resources to i386 too
      Use string instructions for Core2 copy/clear
      Remove outdated comment in x86-64 mmconfig code
      Don't synchronize time reading on single core AMD systems
      Remove all traces of signal number conversion
      Initialize argument registers for 32bit signal handlers.
      Fix some broken white space in ia32_signal.c
      Don't leak NT bit into next task
      i386/x86-64: Make all early PCI scans dependent on CONFIG_PCI
      x86: Move direct PCI scanning functions out of line
      x86: Allow disabling early pci scans with pci=noearly or disallowing conf1
      Fix unwinder warning in traps.c
      Don't set calgary iommu as default y

Andrew Morton:
      wire up oops_enter()/oops_exit()
      make numa_emulation() __init

Arjan van de Ven:
      non lazy "sleazy" fpu implementation
      Add comments to the PDA structure to annotate offsets
      Add the Kconfig option for the stackprotector feature
      Add the canary field to the PDA area and the task struct
      Add the __stack_chk_fail() function
      Add the -fstack-protector option to the CFLAGS

Ashok Raj:
      i386: Support physical cpu hotplug for x86_64

Brice Goglin:
      fix bus numbering format in mmconfig warning

Chuck Ebbert:
      fix is_at_popf() for compat tasks
      remove lock prefix from is_at_popf() tests
      i386/x86-64: rename is_at_popf(), add iret to tests and fix
      i386: annotate FIX_STACK() and the rest of nmi()
      i386: Do better early exception handlers

Dave Jones:
      i386: don't taint UP K7's running SMP kernels.
      x86: remove config.h includes from asm-i386 & asm-x86_64
      i386: Split multi-line printk in oops output.
      i386/x86-64: New Intel feature flags

Diego Calleja:
      x86: AUX_DEVICE_INFO is one byte long, use 'movb'

Dimitri Sivanich:
      X86_64 monotonic_clock goes backwards

Dmitriy Zavin:
      Add 64bit jiffies compares (for use with get_jiffies_64)
      x86: Refactor thermal throttle processing
      i386: Make the jiffies compares use the 64bit safe macros.
      x86: Add a cumulative thermal throttle event counter.

Don Zickus:
      x86: Add performance counter reservation framework for UP kernels
      i386: Utilize performance counter reservation framework in oprofile
      Add SMP support on x86_64 to reservation framework
      i386: Add SMP support on i386 to reservation framework
      x86: Cleanup NMI interrupt path
      i386/x86-64: Remove un/set_nmi_callback and reserve/release_lapic_nmi functions
      x86: Add abilty to enable/disable nmi watchdog with sysctl
      x86: Add abilty to enable/disable nmi watchdog from procfs (update)
      x86: Allow users to force a panic on NMI
      x86: x86 clean up nmi panic messages

Eric W. Biederman:
      Fix gdt table size in trampoline.S
      Auto size the per cpu area.
      Reload CS when startup_64 is used.
      i386: Remove experimental mark of kexec
      Remove experimental mark of kexec

Fernando Luis Vázquez Cao:
      Replace local_save_flags+local_irq_disable with
      i386: Disallow kprobes on NMI handlers
      i386: Disallow kprobes on NMI handlers

H. Peter Anvin:
      i386: Fix the EDD code misparsing the command line

Ian Campbell:
      Put .note.* sections into a PT_NOTE segment

Jan Beulich:
      initialize end of memory variables as early as possible
      remove int_delivery_dest
      i386: initialize end-of-memory variables as early as possible
      annotate arch/x86_64/lib/*.S
      i386/x86-64: Work around gcc bug with noreturn functions in unwinder

Jeremy Fitzhardinge:
      i386: fix dubious segment register clear in cpu_init()
      Type checking for write_pda()
      i386: Fix pack_descriptor()

Keith Mannthey:
      x86_64 kernel mapping fix

Keith Owens:
      Remove most of the special cases for the debug IST stack

Magnus Damm:
      i386: clean up topology.c
      i386: mark two more functions as __init
      i386: remove redundant generic_identify() calls when identifying cpus
      mark init_amd() as __cpuinit
      i386: mark cpu_dev structures as __cpuinitdata
      i386: mark cpu init functions as __cpuinit, data as __cpuinitdata
      i386: mark cpu identify functions as __cpuinit
      i386: mark cpu cache functions as __cpuinit
      Avoid overwriting the current pgd (V4, x86_64)
      i386: Avoid overwriting the current pgd (V4, i386)

Matthew Garrett:
      x86: - restore i8259A eoi status on resume

Muli Ben-Yehuda:
      Calgary IOMMU: rearrange 'struct iommu_table' members
      Calgary IOMMU: consolidate per bus data structures
      Calgary IOMMU: break out of pci_find_device_reverse if dev not found
      Calgary IOMMU: fix error path memleak in calgary_free_tar
      Calgary IOMMU: fix reference counting of Calgary PCI devices
      Calgary IOMMU: calgary_init_one_nontraslated() can return void
      Calgary IOMMU: save a bit of space in bus_info
      remove superflous BUG_ON's in nommu and gart
      print whether CONFIG_IOMMU_DEBUG is enabled
      only verify the allocation bitmap if CONFIG_IOMMU_DEBUG is on
      remove tce_cache_blast_stress()
      Calgary IOMMU: eradicate sole remaining 80 chars per line offender

Paolo 'Blaisorblade' Giarrusso:
      Fix boot code head.S warning

Prasanna S.P:
      x86: error_code is not safe for kprobes

Rafael J. Wysocki:
      Detect clock skew during suspend

Rusty Russell:
      Allow early_param and identical __setup to exist
      i386: Replace i386 open-coded cmdline parsing with
      i386: Descriptor and trap table cleanups.
      i386: Abstract sensitive instructions
      i386: Allow a kernel not to be in ring 0

Shaohua Li:
      i386/x86-64: Fix NMI watchdog suspend/resume

Stephane Eranian:
      x86-64 TIF flags for debug regs and io bitmap in ctxsw

Venkatesh Pallipadi:
      x86: i386/x86-64 Add nmi watchdog support for new Intel CPUs

Vivek Goyal:
      kdump x86_64 nmi event notification fix
      i386: Kdump i386 nmi event notification fix

Vojtech Pavlik:
      Add macros for rdtscp
      Add initalization of the RDTSCP auxilliary values
      Add the vgetcpu vsyscall

 arch/i386/kernel/semaphore.c              |  134 ---
 arch/i386/kernel/stacktrace.c             |   93 --
 include/asm-i386/intel_arch_perfmon.h     |   19 
 include/asm-x86_64/intel_arch_perfmon.h   |   19 
 include/asm-x86_64/mmx.h                  |   14 
 Documentation/HOWTO                       |    3 
 Documentation/filesystems/proc.txt        |   14 
 Documentation/kbuild/makefiles.txt        |    5 
 Documentation/kernel-parameters.txt       |    6 
 Documentation/x86_64/boot-options.txt     |    7 
 Documentation/x86_64/kernel-stacks        |   99 ++
 arch/i386/Kconfig                         |   17 
 arch/i386/Makefile                        |    8 
 arch/i386/boot/edd.S                      |   97 +-
 arch/i386/boot/setup.S                    |    4 
 arch/i386/defconfig                       | 1063 +++++++++++++---------------
 arch/i386/kernel/Makefile                 |    3 
 arch/i386/kernel/acpi/Makefile            |    2 
 arch/i386/kernel/acpi/boot.c              |  183 ++++
 arch/i386/kernel/acpi/earlyquirk.c        |    6 
 arch/i386/kernel/apic.c                   |   31 
 arch/i386/kernel/cpu/amd.c                |    7 
 arch/i386/kernel/cpu/centaur.c            |   24 
 arch/i386/kernel/cpu/common.c             |    8 
 arch/i386/kernel/cpu/cpu.h                |    2 
 arch/i386/kernel/cpu/cyrix.c              |   42 -
 arch/i386/kernel/cpu/intel.c              |    3 
 arch/i386/kernel/cpu/mcheck/Makefile      |    2 
 arch/i386/kernel/cpu/mcheck/p4.c          |   26 
 arch/i386/kernel/cpu/mcheck/therm_throt.c |  198 ++++-
 arch/i386/kernel/cpu/nexgen.c             |    9 
 arch/i386/kernel/cpu/proc.c               |    4 
 arch/i386/kernel/cpu/rise.c               |    4 
 arch/i386/kernel/cpu/transmeta.c          |    7 
 arch/i386/kernel/cpu/umc.c                |    7 
 arch/i386/kernel/crash.c                  |   24 
 arch/i386/kernel/entry.S                  |  110 +-
 arch/i386/kernel/head.S                   |   67 +
 arch/i386/kernel/i8259.c                  |    6 
 arch/i386/kernel/io_apic.c                |  125 +--
 arch/i386/kernel/machine_kexec.c          |  140 +--
 arch/i386/kernel/mca.c                    |    8 
 arch/i386/kernel/mpparse.c                |   70 -
 arch/i386/kernel/nmi.c                    | 1138 +++++++++++++++++++-----------
 arch/i386/kernel/process.c                |   14 
 arch/i386/kernel/ptrace.c                 |   10 
 arch/i386/kernel/relocate_kernel.S        |  162 +++-
 arch/i386/kernel/setup.c                  |  367 +++------
 arch/i386/kernel/smpboot.c                |   19 
 arch/i386/kernel/stacktrace.c             |   11 
 arch/i386/kernel/syscall_table.S          |    1 
 arch/i386/kernel/time.c                   |   23 
 arch/i386/kernel/topology.c               |   21 
 arch/i386/kernel/traps.c                  |  246 +++---
 arch/i386/kernel/tsc.c                    |    2 
 arch/i386/lib/Makefile                    |    2 
 arch/i386/lib/semaphore.S                 |  217 +++++
 arch/i386/mach-generic/bigsmp.c           |    1 
 arch/i386/mach-generic/es7000.c           |    1 
 arch/i386/mach-generic/probe.c            |   60 -
 arch/i386/mach-generic/summit.c           |    1 
 arch/i386/mm/discontig.c                  |    5 
 arch/i386/mm/extable.c                    |    2 
 arch/i386/mm/fault.c                      |   25 
 arch/i386/mm/highmem.c                    |    2 
 arch/i386/mm/init.c                       |   38 -
 arch/i386/oprofile/nmi_int.c              |   92 +-
 arch/i386/oprofile/nmi_timer_int.c        |   41 -
 arch/i386/oprofile/op_model_athlon.c      |   54 +
 arch/i386/oprofile/op_model_p4.c          |  152 +---
 arch/i386/oprofile/op_model_ppro.c        |   65 +
 arch/i386/oprofile/op_x86_model.h         |    1 
 arch/i386/pci/Makefile                    |    2 
 arch/i386/pci/common.c                    |    4 
 arch/i386/pci/direct.c                    |   25 
 arch/i386/pci/early.c                     |   52 +
 arch/i386/pci/init.c                      |    9 
 arch/i386/pci/mmconfig.c                  |   41 +
 arch/i386/pci/pci.h                       |    7 
 arch/s390/kernel/stacktrace.c             |   17 
 arch/um/sys-i386/Makefile                 |    2 
 arch/x86_64/Kconfig                       |   40 -
 arch/x86_64/Makefile                      |   10 
 arch/x86_64/boot/compressed/Makefile      |    3 
 arch/x86_64/boot/setup.S                  |    4 
 arch/x86_64/defconfig                     |  109 ++
 arch/x86_64/ia32/ia32_aout.c              |    8 
 arch/x86_64/ia32/ia32_signal.c            |   53 -
 arch/x86_64/ia32/ia32entry.S              |    9 
 arch/x86_64/ia32/ptrace32.c               |   10 
 arch/x86_64/ia32/sys_ia32.c               |   52 -
 arch/x86_64/kernel/Makefile               |   13 
 arch/x86_64/kernel/aperture.c             |   25 
 arch/x86_64/kernel/apic.c                 |  231 ++----
 arch/x86_64/kernel/crash.c                |   28 
 arch/x86_64/kernel/e820.c                 |  118 +--
 arch/x86_64/kernel/early-quirks.c         |  122 +++
 arch/x86_64/kernel/early_printk.c         |   20 
 arch/x86_64/kernel/entry.S                |   63 +
 arch/x86_64/kernel/genapic_cluster.c      |    1 
 arch/x86_64/kernel/genapic_flat.c         |    5 
 arch/x86_64/kernel/head.S                 |   15 
 arch/x86_64/kernel/head64.c               |   44 -
 arch/x86_64/kernel/i8259.c                |   15 
 arch/x86_64/kernel/io_apic.c              |  486 +-----------
 arch/x86_64/kernel/ioport.c               |    1 
 arch/x86_64/kernel/irq.c                  |   12 
 arch/x86_64/kernel/machine_kexec.c        |   99 +-
 arch/x86_64/kernel/mce.c                  |   29 
 arch/x86_64/kernel/mce_intel.c            |   30 
 arch/x86_64/kernel/mpparse.c              |  238 +-----
 arch/x86_64/kernel/nmi.c                  | 1050 +++++++++++++++++----------
 arch/x86_64/kernel/pci-calgary.c          |  158 ++--
 arch/x86_64/kernel/pci-dma.c              |    7 
 arch/x86_64/kernel/pci-gart.c             |    3 
 arch/x86_64/kernel/pci-nommu.c            |    1 
 arch/x86_64/kernel/process.c              |  110 +-
 arch/x86_64/kernel/ptrace.c               |   29 
 arch/x86_64/kernel/relocate_kernel.S      |  171 ++++
 arch/x86_64/kernel/setup.c                |  243 +-----
 arch/x86_64/kernel/setup64.c              |   45 -
 arch/x86_64/kernel/signal.c               |   87 --
 arch/x86_64/kernel/smp.c                  |   25 
 arch/x86_64/kernel/smpboot.c              |   16 
 arch/x86_64/kernel/stacktrace.c           |  228 ------
 arch/x86_64/kernel/tce.c                  |   12 
 arch/x86_64/kernel/time.c                 |  110 +-
 arch/x86_64/kernel/trampoline.S           |    2 
 arch/x86_64/kernel/traps.c                |  208 +++--
 arch/x86_64/kernel/vmlinux.lds.S          |   25 
 arch/x86_64/kernel/vsmp.c                 |    3 
 arch/x86_64/kernel/vsyscall.c             |   98 ++
 arch/x86_64/kernel/x8664_ksyms.c          |    1 
 arch/x86_64/lib/Makefile                  |    2 
 arch/x86_64/lib/clear_page.S              |   47 -
 arch/x86_64/lib/copy_page.S               |   53 -
 arch/x86_64/lib/copy_user.S               |  163 ++--
 arch/x86_64/lib/csum-copy.S               |   26 
 arch/x86_64/lib/getuser.S                 |   32 
 arch/x86_64/lib/iomap_copy.S              |   10 
 arch/x86_64/lib/memcpy.S                  |   69 +
 arch/x86_64/lib/memset.S                  |   79 +-
 arch/x86_64/lib/putuser.S                 |   32 
 arch/x86_64/lib/rwlock.S                  |   38 +
 arch/x86_64/lib/thunk.S                   |   43 -
 arch/x86_64/mm/fault.c                    |   22 
 arch/x86_64/mm/init.c                     |   58 -
 arch/x86_64/mm/k8topology.c               |    3 
 arch/x86_64/mm/numa.c                     |   11 
 arch/x86_64/mm/pageattr.c                 |   24 
 arch/x86_64/mm/srat.c                     |    2 
 arch/x86_64/pci/Makefile                  |    3 
 arch/x86_64/pci/mmconfig.c                |   44 +
 drivers/char/hpet.c                       |    4 
 drivers/pci/pci.c                         |    5 
 fs/binfmt_elf.c                           |    3 
 fs/compat.c                               |    5 
 include/asm-i386/acpi.h                   |   14 
 include/asm-i386/alternative-asm.i        |   14 
 include/asm-i386/apic.h                   |   16 
 include/asm-i386/desc.h                   |  123 ++-
 include/asm-i386/dwarf2.h                 |   11 
 include/asm-i386/e820.h                   |    2 
 include/asm-i386/frame.i                  |   24 
 include/asm-i386/genapic.h                |   69 +
 include/asm-i386/intel_arch_perfmon.h     |   31 
 include/asm-i386/io_apic.h                |   11 
 include/asm-i386/kexec.h                  |   27 
 include/asm-i386/mach-es7000/mach_apic.h  |    4 
 include/asm-i386/mach-summit/mach_apic.h  |   11 
 include/asm-i386/mutex.h                  |   16 
 include/asm-i386/nmi.h                    |   37 
 include/asm-i386/pgtable.h                |    2 
 include/asm-i386/ptrace.h                 |    9 
 include/asm-i386/rwlock.h                 |   52 -
 include/asm-i386/rwsem.h                  |   62 -
 include/asm-i386/segment.h                |   17 
 include/asm-i386/semaphore.h              |   49 -
 include/asm-i386/smp.h                    |   20 
 include/asm-i386/spinlock.h               |  138 +--
 include/asm-i386/stacktrace.h             |    1 
 include/asm-i386/therm_throt.h            |    9 
 include/asm-i386/tlbflush.h               |    4 
 include/asm-i386/tsc.h                    |    1 
 include/asm-i386/unistd.h                 |    3 
 include/asm-i386/unwind.h                 |    8 
 include/asm-ia64/module.h                 |    3 
 include/asm-um/alternative-asm.i          |    6 
 include/asm-um/frame.i                    |    6 
 include/asm-x86_64/acpi.h                 |    2 
 include/asm-x86_64/alternative-asm.i      |   14 
 include/asm-x86_64/apic.h                 |    9 
 include/asm-x86_64/bitops.h               |    2 
 include/asm-x86_64/calgary.h              |    7 
 include/asm-x86_64/dwarf2.h               |    8 
 include/asm-x86_64/e820.h                 |    9 
 include/asm-x86_64/fixmap.h               |    4 
 include/asm-x86_64/genapic.h              |    1 
 include/asm-x86_64/i387.h                 |    9 
 include/asm-x86_64/intel_arch_perfmon.h   |   31 
 include/asm-x86_64/io_apic.h              |    6 
 include/asm-x86_64/irq.h                  |    2 
 include/asm-x86_64/kexec.h                |   29 
 include/asm-x86_64/linkage.h              |    2 
 include/asm-x86_64/mach_apic.h            |    1 
 include/asm-x86_64/mce.h                  |    2 
 include/asm-x86_64/mpspec.h               |   11 
 include/asm-x86_64/msr.h                  |   11 
 include/asm-x86_64/mutex.h                |   20 
 include/asm-x86_64/nmi.h                  |   46 -
 include/asm-x86_64/pci-direct.h           |   44 -
 include/asm-x86_64/pda.h                  |  171 ++--
 include/asm-x86_64/percpu.h               |   10 
 include/asm-x86_64/pgtable.h              |    8 
 include/asm-x86_64/proto.h                |   15 
 include/asm-x86_64/rwlock.h               |   82 --
 include/asm-x86_64/segment.h              |    5 
 include/asm-x86_64/semaphore.h            |   40 -
 include/asm-x86_64/signal.h               |    4 
 include/asm-x86_64/smp.h                  |   31 
 include/asm-x86_64/spinlock.h             |   91 +-
 include/asm-x86_64/stacktrace.h           |   18 
 include/asm-x86_64/system.h               |    5 
 include/asm-x86_64/tce.h                  |    1 
 include/asm-x86_64/therm_throt.h          |    1 
 include/asm-x86_64/thread_info.h          |    9 
 include/asm-x86_64/tlbflush.h             |   70 -
 include/asm-x86_64/uaccess.h              |   72 +
 include/asm-x86_64/unistd.h               |    5 
 include/asm-x86_64/unwind.h               |    9 
 include/asm-x86_64/vsyscall.h             |    9 
 include/linux/edd.h                       |    1 
 include/linux/getcpu.h                    |   16 
 include/linux/jiffies.h                   |   15 
 include/linux/kernel.h                    |    1 
 include/linux/linkage.h                   |    6 
 include/linux/sched.h                     |   14 
 include/linux/stacktrace.h                |    7 
 include/linux/syscalls.h                  |    2 
 include/linux/sysctl.h                    |    2 
 include/linux/vermagic.h                  |    4 
 init/main.c                               |   14 
 kernel/fork.c                             |    5 
 kernel/lockdep.c                          |    9 
 kernel/panic.c                            |   13 
 kernel/spinlock.c                         |    5 
 kernel/sys.c                              |   31 
 kernel/sysctl.c                           |   23 
 kernel/unwind.c                           |   35 
 lib/Kconfig.debug                         |    2 
 lib/hweight.c                             |   10 
 scripts/Kbuild.include                    |   11 
 scripts/gcc-x86_64-has-stack-protector.sh |    6 
 253 files changed, 7258 insertions(+), 5655 deletions(-)
