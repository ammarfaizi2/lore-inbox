Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268805AbTBZRNu>; Wed, 26 Feb 2003 12:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268821AbTBZRNu>; Wed, 26 Feb 2003 12:13:50 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:41352 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id <S268805AbTBZRNm>;
	Wed, 26 Feb 2003 12:13:42 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 2.4.x. arch/ia64 update
Date: Wed, 26 Feb 2003 10:23:26 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302261023.26224.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Please do a

	bk pull http://lia64.bkbits.net/to-marcelo-2.4

This will update the following files:

 arch/ia64/configs/dig_defconfig                    |  946 ------
 arch/ia64/configs/generic_defconfig                |  969 ------
 arch/ia64/configs/ski_defconfig                    |  468 ---
 arch/ia64/configs/zx1_defconfig                    |  956 ------
 arch/ia64/sn/configs/sn1/defconfig-bigsur-mp       |  777 -----
 arch/ia64/sn/configs/sn1/defconfig-bigsur-sp       |  772 -----
 arch/ia64/sn/configs/sn1/defconfig-dig-mp          |  459 ---
 arch/ia64/sn/configs/sn1/defconfig-dig-sp          |  459 ---
 arch/ia64/sn/configs/sn1/defconfig-generic-mp      |  460 ---
 arch/ia64/sn/configs/sn1/defconfig-generic-sp      |  460 ---
 arch/ia64/sn/configs/sn1/defconfig-hp-sp           |  334 --
 arch/ia64/sn/configs/sn1/defconfig-prom-medusa     |  529 ---
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp          |  736 ----
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules  |  738 ----
 arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0   |  736 ----
 arch/ia64/sn/configs/sn1/defconfig-sn1-sp          |  736 ----
 arch/ia64/sn/configs/sn2/defconfig-dig-numa        |  460 ---
 arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp      |  459 ---
 arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp      |  459 ---
 arch/ia64/sn/configs/sn2/defconfig-sn2-mp          |  730 ----
 arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules  |  732 ----
 arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa |  537 ---
 arch/ia64/sn/configs/sn2/defconfig-sn2-sp          |  730 ----
 arch/ia64/configs/dig                              |  946 ++++++
 arch/ia64/configs/dig_defconfig                    |  946 ++++++
 arch/ia64/configs/generic                          |  969 ++++++
 arch/ia64/configs/generic_defconfig                |  969 ++++++
 arch/ia64/configs/ski                              |  468 +++
 arch/ia64/configs/ski_defconfig                    |  468 +++
 arch/ia64/configs/zx1                              |  956 ++++++
 arch/ia64/configs/zx1_defconfig                    |  956 ++++++
 arch/ia64/defconfig                                |  100 
 arch/ia64/ia32/ia32_entry.S                        |    2 
 arch/ia64/ia32/ia32_support.c                      |    2 
 arch/ia64/ia32/sys_ia32.c                          |   34 
 arch/ia64/kernel/acpi.c                            |   60 
 arch/ia64/kernel/pci.c                             |  175 +
 arch/ia64/kernel/perfmon.c                         |  325 +-
 arch/ia64/kernel/process.c                         |   22 
 arch/ia64/kernel/setup.c                           |    7 
 arch/ia64/kernel/smpboot.c                         |    2 
 arch/ia64/kernel/unwind.c                          |    8 
 arch/ia64/sn/fakeprom/Makefile                     |    2 
 arch/ia64/sn/fakeprom/README                       |   32 
 arch/ia64/sn/fakeprom/fpmem.c                      |   18 
 arch/ia64/sn/fakeprom/fprom.lds                    |   31 
 arch/ia64/sn/fakeprom/fpromasm.S                   |    2 
 arch/ia64/sn/fakeprom/fw-emu.c                     |  200 -
 arch/ia64/sn/fakeprom/klgraph_init.c               |    8 
 arch/ia64/sn/fakeprom/main.c                       |    4 
 arch/ia64/sn/io/Makefile                           |   48 
 arch/ia64/sn/io/cdl.c                              |   16 
 arch/ia64/sn/io/hcl.c                              |    8 
 arch/ia64/sn/io/hcl_util.c                         |   29 
 arch/ia64/sn/io/hubdev.c                           |    2 
 arch/ia64/sn/io/hubspc.c                           |   68 
 arch/ia64/sn/io/ifconfig_bus.c                     |  345 ++
 arch/ia64/sn/io/invent.c                           |    2 
 arch/ia64/sn/io/io.c                               |   91 
 arch/ia64/sn/io/klgraph_hack.c                     |  141 
 arch/ia64/sn/io/labelcl.c                          |    2 
 arch/ia64/sn/io/pci.c                              |   16 
 arch/ia64/sn/io/pci_dma.c                          |  204 -
 arch/ia64/sn/io/pciba.c                            |   42 
 arch/ia64/sn/io/sgi_if.c                           |  150 -
 arch/ia64/sn/io/sgi_io_sim.c                       |   29 
 arch/ia64/sn/io/sn1/Makefile                       |   25 
 arch/ia64/sn/io/sn1/eeprom.c                       | 1421 +++++++++
 arch/ia64/sn/io/sn1/efi-rtc.c                      |  202 +
 arch/ia64/sn/io/sn1/hubcounters.c                  |    3 
 arch/ia64/sn/io/sn1/klconflib.c                    |  979 ++++++
 arch/ia64/sn/io/sn1/klgraph.c                      |  940 ++++++
 arch/ia64/sn/io/sn1/l1.c                           | 3124 +++++++++++++++++++++
 arch/ia64/sn/io/sn1/l1_command.c                   | 1409 +++++++++
 arch/ia64/sn/io/sn1/mem_refcnt.c                   |    3 
 arch/ia64/sn/io/sn1/ml_SN_init.c                   |  211 +
 arch/ia64/sn/io/sn1/ml_iograph.c                   | 1505 ++++++++++
 arch/ia64/sn/io/sn1/module.c                       |  311 ++
 arch/ia64/sn/io/sn1/pci_bus_cvlink.c               |  696 ++++
 arch/ia64/sn/io/sn1/pcibr.c                        |  248 -
 arch/ia64/sn/io/sn1/pciio.c                        | 1681 +++++++++++
 arch/ia64/sn/io/sn1/sgi_io_init.c                  |  324 ++
 arch/ia64/sn/io/sn1/xbow.c                         | 1086 +++++++
 arch/ia64/sn/io/sn1/xtalk.c                        | 1003 ++++++
 arch/ia64/sn/io/sn2/Makefile                       |   27 
 arch/ia64/sn/io/sn2/bte_error.c                    |  147 
 arch/ia64/sn/io/sn2/efi-rtc.c                      |  202 +
 arch/ia64/sn/io/sn2/geo_op.c                       |  314 ++
 arch/ia64/sn/io/sn2/klconflib.c                    |  933 ++++++
 arch/ia64/sn/io/sn2/klgraph.c                      |  866 +++++
 arch/ia64/sn/io/sn2/l1.c                           |  239 +
 arch/ia64/sn/io/sn2/l1_command.c                   |  195 +
 arch/ia64/sn/io/sn2/ml_SN_init.c                   |  160 +
 arch/ia64/sn/io/sn2/ml_SN_intr.c                   |  198 -
 arch/ia64/sn/io/sn2/ml_iograph.c                   | 1395 +++++++++
 arch/ia64/sn/io/sn2/module.c                       |  280 +
 arch/ia64/sn/io/sn2/pci_bus_cvlink.c               |  811 +++++
 arch/ia64/sn/io/sn2/pcibr/Makefile                 |   23 
 arch/ia64/sn/io/sn2/pcibr/pcibr_ate.c              |  195 -
 arch/ia64/sn/io/sn2/pcibr/pcibr_config.c           |  290 +
 arch/ia64/sn/io/sn2/pcibr/pcibr_dvr.c              | 2448 ++++++++++------
 arch/ia64/sn/io/sn2/pcibr/pcibr_error.c            |  946 ++++--
 arch/ia64/sn/io/sn2/pcibr/pcibr_hints.c            |   50 
 arch/ia64/sn/io/sn2/pcibr/pcibr_intr.c             |  416 +-
 arch/ia64/sn/io/sn2/pcibr/pcibr_rrb.c              | 1032 +++---
 arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c             | 1338 ++++++--
 arch/ia64/sn/io/sn2/pciio.c                        | 1877 ++++++++++++
 arch/ia64/sn/io/sn2/pic.c                          |  176 +
 arch/ia64/sn/io/sn2/sgi_io_init.c                  |  230 +
 arch/ia64/sn/io/sn2/shub.c                         |  233 +
 arch/ia64/sn/io/sn2/shub_intr.c                    |   20 
 arch/ia64/sn/io/sn2/shuberror.c                    |  190 +
 arch/ia64/sn/io/sn2/shubio.c                       |  510 +++
 arch/ia64/sn/io/sn2/xbow.c                         | 1642 +++++++++++
 arch/ia64/sn/io/sn2/xtalk.c                        | 1087 +++++++
 arch/ia64/sn/io/stubs.c                            |   43 
 arch/ia64/sn/io/xswitch.c                          |    2 
 arch/ia64/sn/kernel/Makefile                       |   12 
 arch/ia64/sn/kernel/bte.c                          |  147 
 arch/ia64/sn/kernel/bte_regr_test.c                | 1062 +++++++
 arch/ia64/sn/kernel/iomv.c                         |   20 
 arch/ia64/sn/kernel/irq.c                          |   19 
 arch/ia64/sn/kernel/mca.c                          |  276 -
 arch/ia64/sn/kernel/misctest.c                     |  417 ++
 arch/ia64/sn/kernel/setup.c                        |  331 ++
 arch/ia64/sn/kernel/sn1/Makefile                   |    8 
 arch/ia64/sn/kernel/sn1/sn1_smp.c                  |   66 
 arch/ia64/sn/kernel/sn1/synergy.c                  |    5 
 arch/ia64/sn/kernel/sn2/Makefile                   |   10 
 arch/ia64/sn/kernel/sn2/iomv.c                     |    7 
 arch/ia64/sn/kernel/sn2/ptc_deadlock.S             |   80 
 arch/ia64/sn/kernel/sn2/sn2_smp.c                  |  589 +++
 arch/ia64/sn/kernel/sn2/sn_proc_fs.c               |   99 
 arch/ia64/sn/kernel/sn_asm.S                       |  133 
 arch/ia64/sn/kernel/sn_ksyms.c                     |   26 
 arch/ia64/sn/kernel/sv.c                           |    2 
 arch/ia64/sn/tools/make_textsym                    |  142 
 include/asm-ia64/bitops.h                          |    6 
 include/asm-ia64/delay.h                           |   10 
 include/asm-ia64/io.h                              |   32 
 include/asm-ia64/machvec_sn1.h                     |    4 
 include/asm-ia64/machvec_sn2.h                     |    4 
 include/asm-ia64/pci.h                             |    8 
 include/asm-ia64/perfmon.h                         |   69 
 include/asm-ia64/processor.h                       |    3 
 include/asm-ia64/sn/addrs.h                        |   15 
 include/asm-ia64/sn/arc/hinv.h                     |    4 
 include/asm-ia64/sn/arc/types.h                    |    2 
 include/asm-ia64/sn/arch.h                         |    1 
 include/asm-ia64/sn/bte.h                          |   57 
 include/asm-ia64/sn/bte_copy.h                     |  325 +-
 include/asm-ia64/sn/cdl.h                          |    2 
 include/asm-ia64/sn/clksupport.h                   |   28 
 include/asm-ia64/sn/dmamap.h                       |    2 
 include/asm-ia64/sn/eeprom.h                       |   15 
 include/asm-ia64/sn/fetchop.h                      |   69 
 include/asm-ia64/sn/gda.h                          |    2 
 include/asm-ia64/sn/geo.h                          |   54 
 include/asm-ia64/sn/hack.h                         |    6 
 include/asm-ia64/sn/hcl.h                          |    2 
 include/asm-ia64/sn/hires_clock.h                  |    2 
 include/asm-ia64/sn/ifconfig_net.h                 |    2 
 include/asm-ia64/sn/intr_public.h                  |    2 
 include/asm-ia64/sn/io.h                           |    2 
 include/asm-ia64/sn/ioc4.h                         |  801 +++++
 include/asm-ia64/sn/ioerror.h                      |   10 
 include/asm-ia64/sn/iograph.h                      |   15 
 include/asm-ia64/sn/klclock.h                      |    3 
 include/asm-ia64/sn/klconfig.h                     |  126 
 include/asm-ia64/sn/ksys/elsc.h                    |    7 
 include/asm-ia64/sn/ksys/l1.h                      |   56 
 include/asm-ia64/sn/leds.h                         |    8 
 include/asm-ia64/sn/module.h                       |  147 
 include/asm-ia64/sn/nag.h                          |    2 
 include/asm-ia64/sn/nodepda.h                      |   13 
 include/asm-ia64/sn/pci/bridge.h                   | 1038 ++++--
 include/asm-ia64/sn/pci/pci_bus_cvlink.h           |    3 
 include/asm-ia64/sn/pci/pci_defs.h                 |  205 +
 include/asm-ia64/sn/pci/pciba.h                    |    9 
 include/asm-ia64/sn/pci/pcibr.h                    |   38 
 include/asm-ia64/sn/pci/pcibr_private.h            |  354 ++
 include/asm-ia64/sn/pci/pciio.h                    |   97 
 include/asm-ia64/sn/pci/pciio_private.h            |   58 
 include/asm-ia64/sn/pci/pic.h                      | 2001 +++++++++++++
 include/asm-ia64/sn/pda.h                          |   20 
 include/asm-ia64/sn/rw_mmr.h                       |   73 
 include/asm-ia64/sn/sgi.h                          |  101 
 include/asm-ia64/sn/simulator.h                    |    2 
 include/asm-ia64/sn/slotnum.h                      |    2 
 include/asm-ia64/sn/sn1/addrs.h                    |    3 
 include/asm-ia64/sn/sn1/arch.h                     |    2 
 include/asm-ia64/sn/sn1/hubdev.h                   |    2 
 include/asm-ia64/sn/sn1/hubio.h                    |    2 
 include/asm-ia64/sn/sn1/hublb.h                    |    2 
 include/asm-ia64/sn/sn1/hublb_next.h               |    2 
 include/asm-ia64/sn/sn1/hubmd.h                    |    2 
 include/asm-ia64/sn/sn1/hubni.h                    |    2 
 include/asm-ia64/sn/sn1/hubni_next.h               |    2 
 include/asm-ia64/sn/sn1/hubpi.h                    |    2 
 include/asm-ia64/sn/sn1/hubpi_next.h               |    2 
 include/asm-ia64/sn/sn1/hubspc.h                   |    2 
 include/asm-ia64/sn/sn1/hubstat.h                  |    2 
 include/asm-ia64/sn/sn1/hubxb.h                    |    2 
 include/asm-ia64/sn/sn1/hubxb_next.h               |    2 
 include/asm-ia64/sn/sn1/hwcntrs.h                  |    2 
 include/asm-ia64/sn/sn1/intr_public.h              |    2 
 include/asm-ia64/sn/sn1/mem_refcnt.h               |    2 
 include/asm-ia64/sn/sn1/slotnum.h                  |    2 
 include/asm-ia64/sn/sn1/sn_private.h               |    2 
 include/asm-ia64/sn/sn1/synergy.h                  |    3 
 include/asm-ia64/sn/sn2/addrs.h                    |   19 
 include/asm-ia64/sn/sn2/arch.h                     |    2 
 include/asm-ia64/sn/sn2/geo.h                      |  109 
 include/asm-ia64/sn/sn2/intr.h                     |    4 
 include/asm-ia64/sn/sn2/shub.h                     |    2 
 include/asm-ia64/sn/sn2/shub_mmr.h                 |    2 
 include/asm-ia64/sn/sn2/shubio.h                   |   67 
 include/asm-ia64/sn/sn2/slotnum.h                  |    2 
 include/asm-ia64/sn/sn2/sn_private.h               |    4 
 include/asm-ia64/sn/sn_cpuid.h                     |   17 
 include/asm-ia64/sn/sn_fru.h                       |    3 
 include/asm-ia64/sn/sn_private.h                   |    2 
 include/asm-ia64/sn/sn_sal.h                       |  282 +
 include/asm-ia64/sn/snconfig.h                     |    2 
 include/asm-ia64/sn/sndrv.h                        |   39 
 include/asm-ia64/sn/sv.h                           |    2 
 include/asm-ia64/sn/types.h                        |    7 
 include/asm-ia64/sn/uart16550.h                    |    2 
 include/asm-ia64/sn/xtalk/xbow.h                   |   30 
 include/asm-ia64/sn/xtalk/xtalk.h                  |   13 
 include/asm-ia64/sn/xtalk/xtalk_private.h          |    6 
 include/asm-ia64/sn/xtalk/xtalkaddrs.h             |    3 
 include/asm-ia64/sn/xtalk/xwidget.h                |    4 
 include/asm-ia64/system.h                          |   34 
 234 files changed, 47672 insertions(+), 19630 deletions(-)

through these ChangeSets:

<bjorn_helgaas@hp.com> (03/02/25 1.992.1.4)
   Rename configs.

<bjorn_helgaas@hp.com> (03/02/24 1.992.1.3)
   ia64: update defconfigs

<eranian@frankl.hpl.hp.com> (03/02/24 1.992.1.2)
   ia64: perfmon update
   
   This one does:
           - some more clean-ups on inline asm()
           - update copyright
           - fix bug in sys_perfmonctl(), system calls return long not int (important)
           - fix a bug in the PMU interrupt handler
           - some ANSI C clean for initialized structs

<bjorn_helgaas@hp.com> (03/02/14 1.981.1.5)
   ia64: add iomem_resource and ioport_resource allocation.

<bjorn_helgaas@hp.com> (03/02/14 1.981.1.4)
   ia64: add support for MMIO and IO port spaces from ACPI _CRS.

<bjorn_helgaas@hp.com> (03/02/14 1.981.1.3)
   ia64: add infrastructure for multiple IO port spaces.

<bjorn_helgaas@hp.com> (03/02/14 1.981.1.2)
   ia64: whitespace fixes.

<bjorn_helgaas@hp.com> (03/02/14 1.967.3.11)
   ia64: Add some default configs.

<davidm@tiger.hpl.hp.com> (03/02/13 1.967.3.10)
   ia64: Don't risk running past the end of the unwind-table.  Based on a patch by
   	Suresh Siddha.

<alex_williamson@hp.com> (03/02/13 1.967.3.9)
   [PATCH] ia64: fix typo in ia32_support.c
   
   Happened to notice the attached redundancy.

<davidm@wailua.hpl.hp.com> (03/02/13 1.967.3.8)
   ia64: Fix ia64_fls() so it works for all possible 64-bit values.
   	Reported by Dan Magenheimer (note: the bug didn't affect
   	the existing kernel, since the possible values passed to
   	the routine were always "safe").

<bjorn_helgaas@hp.com> (03/02/13 1.967.3.7)
   ia64: fix perfmon typo (PFM_CPU_SYST_WIDE should be PFM_CPUINFO_SYST_WIDE).

<eranian@frankl.hpl.hp.com> (03/02/13 1.967.3.6)
   ia64: new perfmon patch for 2.4.20
   
   Here is a new complete patch for perfmon against 2.4.20. Note that this 
   patch supersedes the one I sent you last week. This patch does:
   
   	- fix the SMP system-wide monitoring problem
   	- add support for excluding idle tasks from system wide monitoring sessions
   	- regroup all __asm__ into a set of inline functions: cleaner and will make it
   	  easier for the Secure Linux folks (Tom Cristian).
   	- optimize cost of psr fixup in system wide (simplify local_cpu_info).
   	- reestablish restriction of pfm_write_{pmds,pmcs} when passing the pid
             of another process. We do not support this yet.
   	- update perfmon revision to 1.3

<bjorn_helgaas@hp.com> (03/02/13 1.967.3.5)
   Cset exclude: eranian@frankl.hpl.hp.com[helgaas]|ChangeSet|20030103231109|26349

<bjorn_helgaas@hp.com> (03/02/13 1.967.3.4)
   ia64: Really remove ACPI SPCR parsing.

<bjorn_helgaas@hp.com> (03/02/13 1.967.3.3)
   ia64: Use has_8259 rather than initdata.

<bjorn_helgaas@hp.com> (03/02/13 1.967.3.2)
   ia64: Simple ndelay implementation.

<bjorn_helgaas@hp.com> (03/01/13 1.884.24.24)
   ia64: smp_threads_ready: make non-volatile.

<davidm@tiger.hpl.hp.com> (03/01/08 1.884.22.4)
   ia64: For ia32 emulation, do not turn on O_LARGEFILE automatically
   	on open().  Reported by Andi Kleen.

<bjorn_helgaas@hp.com> (03/01/08 1.884.22.3)
   ia64: Dont execute srlz.d needlessly (reported by Chris Ruemmler).

<arun.sharma@intel.com> (03/01/08 1.884.22.2)
   [PATCH] ia64: ia32 emulation layer bug fix
     
   sys32_mprotect code isn't dropping ia32_mmap_sem before returning.  This
   affects both 2.4 and 2.5.

<jh@sgi.com> (03/01/03 1.884.17.5)
   ia64: Update SGI SN files
   
   Below is a patch that updates the SGI SN files.
   You still won't be able to compile, though, as we're
   completely dependent on the discontig patch.

<bjorn_helgaas@hp.com> (03/01/03 1.884.17.4)
   ia64: Reverse SGI scatterlist changes so SGI update will apply.

<bjorn_helgaas@hp.com> (03/01/03 1.884.17.3)
   ia64: Delete all SGI SN defconfig files.

<eranian@frankl.hpl.hp.com> (03/01/03 1.884.17.2)
   ia64: perfmon task pinning fix for system-wide monitoring in SMP systems

<bjorn_helgaas@hp.com> (03/01/03 1.884.16.2)
   ia64: Use IA64_PSR_I rather than (1UL << 14).

<bjorn_helgaas@hp.com> (03/01/03 1.884.16.1)
   ia64: Add local_irq_set() and save_and_sti().


Thanks!

Bjorn

