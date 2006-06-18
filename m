Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWFRB73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWFRB73 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 21:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFRB73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 21:59:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11906 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751096AbWFRB72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 21:59:28 -0400
Date: Sat, 17 Jun 2006 18:59:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.17
Message-ID: <Pine.LNX.4.64.0606171856190.5498@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not a lot of changes since the last -rc, the bulk is actually some 
last-minute MIPS updates and s390 futex changes, the rest tend to be 
various very small fixes that trickled in over the last week.

Have fun with it,

		Linus

---

Aki M Nyrhinen:
      [TCP]: continued: reno sacked_out count fix

Andrea Bittau:
      [DCCP] Ackvec: fix soft lockup in ackvec handling code

Andrew Morton:
      powernow-k8 crash workaround
      PCI: fix pciehp compile issue when CONFIG_ACPI is not enabled

Andy Currid:
      Fix HPET operation on 32-bit NVIDIA platforms
      Fix HPET operation on 64-bit NVIDIA platforms

Arnd Bergmann:
      powerpc: Fix cell blade detection
      powerpc: Fix 64k pages on non-partitioned machines
      powerpc: enable CPU_FTR_CI_LARGE_PAGE for cell

Auke Kok:
      e1000: fix ethtool test irq alloc as "probe"
      e1000: remove risky prefetch on next_skb->data

Benjamin Herrenschmidt:
      powerpc: Fix call to ibm,client-architecture-support

Christoph Lameter:
      typo in vmscan.c

Dave Jones:
      PCI: Improve PCI config space writeback

David Howells:
      Further alterations for memory barrier document

David S. Miller:
      [SPARC64]: Dump local cpu registers in sun4v_log_error()
      [TG3]: Handle Sun onboard tg3 chips more correctly.
      [SPARC64]: Avoid JBUS errors on some Niagara systems.
      [SPARC64]: Set appropriate max_cache_size.
      [SPARC64]: Do not double-export sys_close() when CONFIG_SOLARIS_EMUL_MODULE

Jean Delvare:
      PCI: Error handling on PCI device resume

Jens Axboe:
      elevator switching race
      debugfs inode leak
      cfq-iosched: fix crash in do_div()
      fix cdrom open
      Fix missing ret assignment in __bio_map_user() error path

Kirill Korotaev:
      Return error in case flock_lock_file failure

Krzysztof Helt:
      [SPARC]: Migration cost tune up in sparc smp.

Lennert Buytenhek:
      ep93xx build fix

Linus Torvalds:
      [sky2] Fix sky2 network driver suspend/resume
      Linux v2.6.17

Malcom Parsons:
      fbcon: fix limited scroll in SCROLL_PAN_REDRAW mode

Mark Lord:
      sata_mv: grab host lock inside eng_timeout

Markus Lidel:
      I2O: Bugfixes to get I2O working again

Martin Schwidefsky:
      s390: fix in-user atomic futex operation.

Matt Reimer:
      [ARM] 3546/1: PATCH: subtle lost interrupts bug on i.MX

Michael Buesch:
      bcm43xx: add DMA rx poll workaround to DMA4

Milton Miller:
      powerpc: console_initcall ordering issues

Oleg Nesterov:
      check_process_timers: fix possible lockup
      run_posix_cpu_timers: remove a bogus BUG_ON()
      arm_timer: remove a racy and obsolete PF_EXITING check

Paul Mackerras:
      powerpc: Fix machine check problem on 32-bit kernels
      Fix for the PPTP hangs that have been reported

Ralf Baechle:
      Fix mempolicy.h build error

Randy Dunlap:
      alpha: generic hweight build fix

Richard Purdie:
      [ARM] 3547/1: PXA-OHCI: Allow platforms to specify a power budget

Robin H. Johnson:
      tmpfs: time granularity fix for [acm]time going backwards

Russell King:
      [ARM] Fix Neponset IRQ handling
      [ARM] Fix Integrator and Versatile interrupt initialisation

Sergey Vlasov:
      tmpfs: Decrement i_nlink correctly in shmem_rmdir()

Stephen Hemminger:
      sky2: set_power_state should be void
      sky2: don't hard code number of ports
      sky2: fix hotplug detect during poll
      sky2: save/restore base hardware irq during suspend/resume
      sky2: stop/start hardware idle timer on suspend/resume
      sky2: netconsole suspend/resume interaction

Tom "spot" Callaway:
      [FUSION]: Fix mptspi.c build with CONFIG_PM not set.

Weidong:
      [IPV4]: Increment ipInHdrErrors when TTL expires.

Yu, Luming:
      PCI: reverse pci config space restore order



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
