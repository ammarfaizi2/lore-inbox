Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751021AbWFFBM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWFFBM3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 21:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWFFBM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 21:12:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22748 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750939AbWFFBM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 21:12:28 -0400
Date: Mon, 5 Jun 2006 18:12:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.17-rc6
Message-ID: <Pine.LNX.4.64.0606051807310.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey, I lied. -rc5 wasn't the last RC, I wanted to make one more, because 
we've had enough small changes that I wasn't comfortable _not_ doing one 
more RC. 

Now, most of them are really quite trivial, and the shortlog and diffstat 
is appended. Some s390 and MIPS changes, but also, for example, some cfq 
IO scheduler locking and fairness fixes, and a SATA resume fix that is 
reported to fix resume on at least a couple of machines.

              Linus

---
Al Viro:
      uml: __user annotation in arch_prctl
      uml: more __user annotations

Alexey Dobriyan:
      [NETFILTER]: PPTP helper: fix sstate/cstate typo

Andi Kleen:
      [AGPGART] Enable SIS AGP driver on x86-64 for EM64T systems
      x86_64: Fix stack/mmap randomization for compat tasks
      x86_64: Fix no IOMMU warning in PCI-GART driver
      x86_64: Don't do syscall exit tracing twice

Andrew Morton:
      ext3 resize: fix double unlock_super()
      revert "swsusp add check for suspension of X controlled devices"
      net/compat.h build fix
      m48t86: ia64 build fix

Arthur Othieno:
      powerpc: linuxppc64.org no more

Atsushi Nemoto:
      [MIPS] Fix kgdb exception handler from user mode.
      [MIPS] Use generic DWARF_DEBUG
      [MIPS] Use generic STABS_DEBUG macro.
      [MIPS] Ignore unresolved weak symbols in modules.
      [MIPS] Fix modpost warning: Rename op_model_xxx to op_model_xxx_ops.
      [MIPS] Fix sparse warnings about too big constants.
      [MIPS] Fix compiler warnings (field width, unused variable)

Auke Kok:
      e1000: add shutdown handler back to fix WOL

Ben Dooks:
      s3c24xx: fix spi driver with CONFIG_PM

Benjamin Herrenschmidt:
      powerpc: Fix boot on eMac
      pmf_register_irq_client() gives sleep with locks held warning

Bryan Holty:
      [SCSI] scsi_lib.c: properly count the number of pages in scsi_req_map_sg()

Chad Reese:
      [MIPS] Fix sparsemem support.

Chris Dearman:
      [MIPS] Fix detection and handling of the 74K processor.

Corey Minyard:
      IPMI: reserve I/O ports separately

Cornelia Huck:
      s390: minor fix in cu3088
      s390: irb memcpy argument swap

Daniel Jacobowitz:
      [MIPS] Update struct sigcontext member names

Daniel Yeisley:
      x86_64: Handle empty node zero

Dave Jones:
      [AGPGART] Fix Nforce3 suspend on amd64.

David Brownell:
      ads7846 conversion accuracy

David Hollister:
      fbcon: fix scrollback with logo issue immediately after boot

David S. Miller:
      [SPARC64]: Make smp_processor_id() functional before start_kernel()
      [SPARC64]: Fix D-cache corruption in mremap
      [SPARC64]: Fix missing fold at end of checksums.

Deepak Saxena:
      ARM: explicitly disable BTB on ixp2350
      ARM: Fix XScale PMD setting

Dominik Brodowski:
      pcmcia: fix zeroing of cm4000_cs.c data

Don Fry:
      pcnet32: remove incorrect pcnet32_free_ring

Egry Gabor:
      [ARM] Trivial typo fixes

Eli Cohen:
      IPoIB: Fix AH leak at interface down

Eric Moore:
      [SCSI] scsi_transport_sas: make write attrs writeable

Florin Malita:
      affs: possible null pointer dereference in affs_rename()
      pcmcia: missing pcmcia_get_socket() result check
      nmclan_cs: dereferencing skb after netif_rx()
      [PPPOE]: Missing result check in __pppoe_xmit().
      [IRDA]: Missing allocation result check in irlap_change_speed().

Herbert Valerio Riedel:
      [MIPS] AU1xxx mips_timer_interrupt() fixes

Herbert Xu ~{PmVHI~}:
      [TCP]: Avoid skb_pull if possible when trimming head

Hollis Blanchard:
      powerpc: fix RTC/NVRAM accesses on Maple

Horst Schirmeier:
      [SERIAL] typo: buad -> baud

Ingo Molnar:
      slab.c: fix offslab_limit bug

Ivan Kokshaysky:
      alpha: SMP IRQ routing fix

James Bottomley:
      [SCSI] mptspi: reset handler shouldn't be called for other bus protocols
      [SCSI] scsi_transport_sas; fix user_scan

Jan Beulich:
      i386: apic= command line option should always be
      x86_64: fix last_tsc calculation of PM timer

Jeff Dike:
      uml: add asm/irqflags.h
      uml: fix wall_to_monotonic initialization
      uml: fix a typo in do_uml_initcalls
      uml: add -ffreestanding to CFLAGS

Jeff Garzik:
      [netdrvr s/390] trim trailing whitespace

Jens Axboe:
      x86: wire up vmsplice syscall
      cfq-iosched: fixup locking and ->queue_list list management
      cfq-iosched: check busy queues before deciding we are idle
      cfq-iosched: Detect idle process issuing async request
      cfq-iosched: Detect hardware queueing
      cfq-iosched: fix bug in timer handling for the idle class
      cfq-iosched: busy_rr fairness fix

Jeremy Higdon:
      sgiioc4: use mmio ops instead of port io

Jes Sorensen:
      [NET]: Eliminate unused /proc/sys/net/ethernet

Jesper Juhl:
      Input: sidewinder - fix memory leak

Jiri Benc:
      [BRIDGE]: fix locking and memory leak in br_add_bridge

Johannes Berg:
      PowerMac: force only suspend-to-disk to be valid

Kenan Esau:
      Input: psmouse - DMI updates for lifebook protocol

Klaus Wacker:
      s390: lcs driver bug fixes and improvements [1/2]
      s390: lcs driver bug fixes and improvements [2/2]

Kumba:
      [MIPS] Treat R14000 like R10000.

Kylene Jo Hall:
      tpm: fix bug for TPM on ThinkPad T60 and Z60

Lennert Buytenhek:
      [ARM] 3539/1: ixp23xx: fix __arch_ixp23xx_is_coherent() for A1 stepping
      [ARM] 3540/1: ixp23xx: deal with gap in interrupt bitmasks

Linus Torvalds:
      Revert "i386/x86_64: Force pci=noacpi on HP XW9300"
      Linux 2.6.17-rc6

Magnus Kessler:
      [AGPGART] VIA PT880 Ultra support.

Marcel Holtmann:
      [NETFILTER]: Fix small information leak in SO_ORIGINAL_DST (CVE-2006-1343)

Mark Lord:
      the latest consensus libata resume fix

Martin Michlmayr:
      maxinefb: Fix compilation error
      [MIPS] Create consistency in "system type" selection.

Martin Schwidefsky:
      s390: fix typo in stop_hz_timer.

masc@theaterzentrum.at:
      Input: wistron - add support for AOpen Barebook 1559as

Matt Mackall:
      [NETCONSOLE]: Clean up initcall warning.

Matthew Garrett:
      Input: add KEY_BATTERY keycode

Michael Chan:
      MAINTAINERS: Add entries for BNX2 and TG3

Michael S. Tsirkin:
      IB/mthca: Fix posting lists of 256 receive requests to SRQ for Tavor

Neil Brown:
      Unlock md devices when stopping them on reboot.

NeilBrown:
      md: Fix badness in sysfs_notify caused by md_new_event

Nigel Stephens:
      [MIPS] Add missing 34K processor IDs

Patrick McHardy:
      [NETFILTER]: mark H.323 helper experimental

Paul Mackerras:
      Add CMSPAR to termbits.h for powerpc and alpha
      ppc: Fix typo in TI_LOCAL_FLAGS definition

Peter Korsgaard:
      [SERIAL] Update parity handling documentation

Peter Oberparleiter:
      s390: cio non-unique path group ids

Ralf Baechle:
      [MIPS] Fix typo
      [MIPS] Remove support for sysmips(2) SETNAME and MIPS_RDNVRAM operations.
      [MIPS] Update/fix futex assembly
      [MIPS] Fix deadlock on MP with cache aliases.
      [MIPS] Remove EXPERIMENTAL from PAGE_SIZE_16KB
      [MMC] Prevent au1xmmc.c breakage on non-Au1200 Alchemy
      Sparsemem build fix
      [MIPS] Remove duplicate declaration of cpu_online_map.
      [MIPS] Fix SMP now that fixup_cpu_present_map is gone.
      [MIPS] Fix instable BogoMIPS on multi-issue processors.
      [MIPS] Fix declaration of smp_prepare_cpus() platform hook.
      [MIPS] Print more information if we're struck by a machine check exception.
      [MIPS] SB1: Only pass1 FPUs are broken beyond recovery.
      [MIPS] IP32: Fix warnings.
      [MIPS] Fix 64-bit build for RM7000.

Randy Dunlap:
      scx200_acb: fix section mismatch warning
      wavelan: fix section mismatch
      arlan: fix section mismatch warnings

Randy.Dunlap:
      [SCSI] ppa: fix for machines with highmem

Richard Purdie:
      Input: change from numbered to named switches

Robert Hentosh:
      x86_64: Fix off by one in bad_addr checking in find_e820_area

Rodolfo Giometti:
      au1100fb: Fix compilation

Rune Torgersen:
      sata_sil24: SII3124 sata driver endian problem

Russell King:
      [MMC] Add maintainers entry for MMC subsystem

Samuel Ortiz:
      [IRDA]: *_DONGLE should depend on IRTTY_SIR

Seiji Munetoh:
      tpm: bios log parsing fixes
      tpm: more bios log parsing fixes

Sergei Shtylyov:
      [MIPS] Fix marking buddy of pte global for MIPS32 w/36-bit physical address
      [MIPS] Save write-only Config.OD from being clobbered
      [MIPS] Fix mprotect() syscall for MIPS32 w/36-bit physical address support
      [MIPS] Fix swap entry for MIPS32 36-bit physical address
      [MIPS] Au1xx0: fix prom_getenv() to handle YAMON style environment
      [MIPS] Fix non-linear memory mapping on MIPS

Stefan Richter:
      sbp2: fix check of return value of hpsb_allocate_and_register_addrspace()

Stephen Hemminger:
      [MAINTAINERS]: Add entry for netem
      [NET]: dev.c comment fixes
      hrtimer: export symbols
      [TCP] tcp_highspeed: Fix problem observed by Xiaoliang (David) Wei

Stephen Smalley:
      selinux: fix sb_lock/sb_security_lock nesting

Steve French:
      [CIFS] Fix new POSIX Locking for setting lock_type correctly on unlock
      [CIFS] Do not limit the length of share names (was 100 for whole UNC name)
      [CIFS] ACPI suspend oops
      [CIFS] fix memory leak in cifs session info struct on reconnect
      [CIFS] endian fix for new POSIX byte range lock support
      [CIFS] Fix typos in previous fix
      [[CIFS] Pass truncate open flag through on file open in case setattr fails

Steve Yang:
      [ARM] 3543/1: [Fwd: PXA270 bootparams address not set]

Thiemo Seufer:
      [MIPS] DSP and MDMX share the same config flag bit.
      [MIPS] Update/Fix instruction definitions
      [MIPS] open() forces O_LARGEFILE for o32 on 64bit kernels

Thomas Bogendoerfer:
      [SCSI] Blacklist entry for HP dat changer

Trond Myklebust:
      fs/namei.c: Call to file_permission() under a spinlock in do_lookup_path()

Ursula Braun:
      s390: qeth driver fixes
      s390: qeth driver fixes

Vitaly Bordug:
      ppc32 CPM_UART: various fixes for pq2 uart users

Yasunori Goto:
      spanned_pages is not updated at a case of memory hot-add

YOSHIFUJI Hideaki:
      [IPV6] ROUTE: Don't try less preferred routes for on-link routes.

Yotam Medini:
      Input: alps - fix old protocol decoding

Zachary Amsden:
      Implement get / set tso for forcedeth driver

Zbigniew Luszpinski:
      Input: psmouse - add detection of Logitech TrackMan Wheel trackball

-- diffstat --
 Documentation/serial/driver                    |    9 
 MAINTAINERS                                    |   27 +
 Makefile                                       |    4 
 arch/alpha/kernel/alpha_ksyms.c                |    1 
 arch/alpha/kernel/process.c                    |    6 
 arch/alpha/kernel/smp.c                        |   14 -
 arch/alpha/kernel/sys_titan.c                  |    2 
 arch/arm/Kconfig.debug                         |    2 
 arch/arm/mach-ixp23xx/core.c                   |   18 +
 arch/arm/mach-ixp4xx/Kconfig                   |    2 
 arch/arm/mach-pxa/mainstone.c                  |    1 
 arch/arm/mach-s3c2410/Kconfig                  |    2 
 arch/arm/mm/mm-armv.c                          |    4 
 arch/arm/mm/proc-xsc3.S                        |    3 
 arch/i386/kernel/acpi/boot.c                   |    8 
 arch/i386/kernel/syscall_table.S               |    1 
 arch/i386/mach-generic/probe.c                 |   16 -
 arch/mips/Kconfig                              |   96 ++--
 arch/mips/au1000/common/irq.c                  |    1 
 arch/mips/au1000/common/prom.c                 |   24 -
 arch/mips/au1000/common/sleeper.S              |    5 
 arch/mips/au1000/common/time.c                 |    1 
 arch/mips/ddb5xxx/ddb5476/dbg_io.c             |    2 
 arch/mips/ddb5xxx/ddb5477/kgdb_io.c            |    2 
 arch/mips/gt64120/ev64120/serialGT.c           |    2 
 arch/mips/gt64120/momenco_ocelot/dbg_io.c      |    2 
 arch/mips/ite-boards/generic/dbg_io.c          |    2 
 arch/mips/kernel/asm-offsets.c                 |    4 
 arch/mips/kernel/cpu-bugs64.c                  |    8 
 arch/mips/kernel/cpu-probe.c                   |   15 +
 arch/mips/kernel/entry.S                       |    2 
 arch/mips/kernel/gdb-low.S                     |    8 
 arch/mips/kernel/module.c                      |    6 
 arch/mips/kernel/proc.c                        |    2 
 arch/mips/kernel/scall64-o32.S                 |    2 
 arch/mips/kernel/setup.c                       |   18 -
 arch/mips/kernel/signal-common.h               |   30 -
 arch/mips/kernel/smp.c                         |    5 
 arch/mips/kernel/syscall.c                     |   27 -
 arch/mips/kernel/traps.c                       |   20 +
 arch/mips/kernel/vmlinux.lds.S                 |   20 -
 arch/mips/math-emu/dp_fint.c                   |    4 
 arch/mips/math-emu/dp_flong.c                  |    4 
 arch/mips/math-emu/sp_fint.c                   |    4 
 arch/mips/math-emu/sp_flong.c                  |    4 
 arch/mips/mm/c-r4k.c                           |   78 +++
 arch/mips/mm/init.c                            |    2 
 arch/mips/mm/pg-r4k.c                          |    1 
 arch/mips/mm/tlbex.c                           |    2 
 arch/mips/momentum/jaguar_atx/dbg_io.c         |    2 
 arch/mips/momentum/ocelot_c/dbg_io.c           |    2 
 arch/mips/momentum/ocelot_g/dbg_io.c           |    2 
 arch/mips/oprofile/common.c                    |    9 
 arch/mips/oprofile/op_model_mipsxx.c           |   34 +
 arch/mips/oprofile/op_model_rm9000.c           |    2 
 arch/mips/sgi-ip32/ip32-irq.c                  |    4 
 arch/powerpc/kernel/prom_init.c                |   48 ++
 arch/powerpc/platforms/powermac/low_i2c.c      |   12 
 arch/powerpc/platforms/powermac/pfunc_core.c   |   18 -
 arch/powerpc/platforms/powermac/setup.c        |   12 
 arch/ppc/kernel/asm-offsets.c                  |    2 
 arch/ppc/platforms/mpc8272ads_setup.c          |   10 
 arch/ppc/syslib/pq2_devices.c                  |   16 -
 arch/ppc/syslib/pq2_sys.c                      |    8 
 arch/s390/kernel/time.c                        |    2 
 arch/sparc64/kernel/head.S                     |   30 +
 arch/sparc64/kernel/setup.c                    |   23 -
 arch/sparc64/kernel/smp.c                      |   16 -
 arch/sparc64/lib/checksum.S                    |    5 
 arch/sparc64/lib/csum_copy.S                   |    5 
 arch/um/Makefile-i386                          |    4 
 arch/um/include/kern_util.h                    |   13 -
 arch/um/kernel/time_kern.c                     |   10 
 arch/um/os-Linux/main.c                        |    2 
 arch/um/os-Linux/time.c                        |   10 
 arch/um/sys-i386/syscalls.c                    |    9 
 arch/um/sys-x86_64/signal.c                    |   24 +
 arch/um/sys-x86_64/syscalls.c                  |    2 
 arch/x86_64/ia32/ia32_binfmt.c                 |    4 
 arch/x86_64/kernel/e820.c                      |    2 
 arch/x86_64/kernel/entry.S                     |    7 
 arch/x86_64/kernel/pci-dma.c                   |    4 
 arch/x86_64/kernel/pci-gart.c                  |    6 
 arch/x86_64/kernel/pmtimer.c                   |    2 
 arch/x86_64/kernel/setup.c                     |    2 
 arch/x86_64/mm/srat.c                          |    4 
 block/cfq-iosched.c                            |   77 ++-
 drivers/base/power/suspend.c                   |    5 
 drivers/char/agp/Kconfig                       |    2 
 drivers/char/agp/amd64-agp.c                   |    3 
 drivers/char/agp/via-agp.c                     |    7 
 drivers/char/ipmi/ipmi_si_intf.c               |   38 +
 drivers/char/pcmcia/cm4000_cs.c                |    2 
 drivers/char/tpm/tpm_bios.c                    |   89 +--
 drivers/char/tpm/tpm_tis.c                     |    4 
 drivers/char/vt.c                              |    8 
 drivers/i2c/busses/scx200_acb.c                |    2 
 drivers/ide/pci/sgiioc4.c                      |   16 -
 drivers/ieee1394/sbp2.c                        |    2 
 drivers/infiniband/hw/mthca/mthca_srq.c        |   41 +-
 drivers/infiniband/ulp/ipoib/ipoib_ib.c        |    1 
 drivers/input/joystick/sidewinder.c            |   11 
 drivers/input/keyboard/corgikbd.c              |   12 
 drivers/input/keyboard/spitzkbd.c              |   12 
 drivers/input/misc/wistron_btns.c              |   19 +
 drivers/input/mouse/alps.c                     |    4 
 drivers/input/mouse/lifebook.c                 |   24 +
 drivers/input/mouse/logips2pp.c                |    6 
 drivers/input/touchscreen/ads7846.c            |   53 +-
 drivers/md/md.c                                |   15 +
 drivers/message/fusion/mptbase.c               |   27 +
 drivers/mmc/Kconfig                            |    2 
 drivers/net/e1000/e1000_main.c                 |   10 
 drivers/net/forcedeth.c                        |   16 +
 drivers/net/irda/Kconfig                       |   20 -
 drivers/net/netconsole.c                       |    2 
 drivers/net/pcmcia/nmclan_cs.c                 |    2 
 drivers/net/pcnet32.c                          |    2 
 drivers/net/pppoe.c                            |    3 
 drivers/net/wireless/arlan-main.c              |    4 
 drivers/net/wireless/wavelan.c                 |    2 
 drivers/pcmcia/ds.c                            |    6 
 drivers/rtc/rtc-m48t86.c                       |   72 +--
 drivers/s390/cio/css.h                         |    4 
 drivers/s390/cio/device_fsm.c                  |    2 
 drivers/s390/net/ctcmain.c                     |   26 +
 drivers/s390/net/ctctty.c                      |   10 
 drivers/s390/net/cu3088.c                      |   10 
 drivers/s390/net/iucv.c                        |   36 +
 drivers/s390/net/iucv.h                        |  622 ++++++++++++------------
 drivers/s390/net/lcs.c                         |  345 +++++++------
 drivers/s390/net/lcs.h                         |   14 -
 drivers/s390/net/netiucv.c                     |   36 +
 drivers/s390/net/qeth.h                        |   18 -
 drivers/s390/net/qeth_eddp.c                   |   18 -
 drivers/s390/net/qeth_fs.h                     |    2 
 drivers/s390/net/qeth_main.c                   |  107 ++--
 drivers/s390/net/qeth_mpc.h                    |    4 
 drivers/s390/net/qeth_proc.c                   |    8 
 drivers/s390/net/qeth_sys.c                    |    6 
 drivers/s390/net/qeth_tso.h                    |    4 
 drivers/scsi/libata-core.c                     |    1 
 drivers/scsi/ppa.c                             |    7 
 drivers/scsi/sata_sil24.c                      |    6 
 drivers/scsi/scsi_devinfo.c                    |    1 
 drivers/scsi/scsi_lib.c                        |    2 
 drivers/scsi/scsi_transport_sas.c              |    4 
 drivers/serial/cpm_uart/cpm_uart_core.c        |    8 
 drivers/serial/cpm_uart/cpm_uart_cpm2.c        |    2 
 drivers/spi/spi_s3c24xx.c                      |    4 
 drivers/video/au1100fb.c                       |   21 +
 drivers/video/console/fbcon.c                  |    2 
 drivers/video/maxinefb.c                       |    4 
 fs/affs/namei.c                                |    3 
 fs/cifs/CHANGES                                |    7 
 fs/cifs/cifsfs.h                               |    2 
 fs/cifs/cifsproto.h                            |    2 
 fs/cifs/cifssmb.c                              |   40 +-
 fs/cifs/connect.c                              |   97 +++-
 fs/cifs/file.c                                 |   12 
 fs/ext3/resize.c                               |    1 
 fs/namei.c                                     |   19 -
 include/asm-alpha/smp.h                        |    4 
 include/asm-alpha/termbits.h                   |    1 
 include/asm-arm/arch-ixp23xx/memory.h          |    2 
 include/asm-arm/arch-l7200/serial_l7200.h      |    2 
 include/asm-arm/arch-l7200/uncompress.h        |    2 
 include/asm-arm/system.h                       |    6 
 include/asm-generic/pgtable.h                  |   11 
 include/asm-mips/addrspace.h                   |    1 
 include/asm-mips/cpu.h                         |    6 
 include/asm-mips/delay.h                       |   22 -
 include/asm-mips/futex.h                       |  141 ++++-
 include/asm-mips/inst.h                        |   33 +
 include/asm-mips/mipsregs.h                    |    2 
 include/asm-mips/page.h                        |    2 
 include/asm-mips/pgtable-32.h                  |   61 ++
 include/asm-mips/pgtable-64.h                  |   13 -
 include/asm-mips/pgtable.h                     |  103 ++--
 include/asm-mips/sigcontext.h                  |   10 
 include/asm-mips/smp.h                         |    5 
 include/asm-mips/sparsemem.h                   |   14 +
 include/asm-powerpc/termbits.h                 |    1 
 include/asm-s390/lowcore.h                     |    4 
 include/asm-sparc64/pgtable.h                  |   17 +
 include/asm-um/irqflags.h                      |    6 
 include/asm-um/uaccess.h                       |    6 
 include/asm-x86_64/elf.h                       |    2 
 include/linux/input.h                          |   13 -
 include/linux/m48t86.h                         |    4 
 include/linux/mmzone.h                         |    1 
 include/linux/pci_ids.h                        |    1 
 include/linux/vt_kern.h                        |    5 
 include/net/compat.h                           |    3 
 kernel/hrtimer.c                               |    6 
 mm/memory_hotplug.c                            |    8 
 mm/slab.c                                      |   27 +
 net/bridge/br_if.c                             |   19 -
 net/core/dev.c                                 |   20 -
 net/ethernet/Makefile                          |    1 
 net/ethernet/sysctl_net_ether.c                |   14 -
 net/ipv4/netfilter/Kconfig                     |    4 
 net/ipv4/netfilter/ip_conntrack_core.c         |    1 
 net/ipv4/netfilter/ip_conntrack_helper_pptp.c  |    4 
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c |    1 
 net/ipv4/tcp_highspeed.c                       |    3 
 net/ipv4/tcp_output.c                          |   12 
 net/ipv6/route.c                               |   16 -
 net/irda/irlap.c                               |    3 
 net/sysctl_net.c                               |    8 
 security/selinux/hooks.c                       |    6 
 211 files changed, 2151 insertions(+), 1534 deletions(-)
