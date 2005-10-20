Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751771AbVJTGdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbVJTGdN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 02:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbVJTGdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 02:33:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8918 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751771AbVJTGdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 02:33:12 -0400
Date: Wed, 19 Oct 2005 23:33:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.14-rc5
Message-ID: <Pine.LNX.4.64.0510192328360.5909@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yeah, I know I said -rc4 was going to be the last one, but as some of you 
may have noticed from the discussions, a day before I was planning on 
releasing 2.6.14 we found a couple of bugs (nasty RCU callback delays, 
swiotlb, etc). The fixes for those weren't all that complicated, but the 
problems were subtle enough that I wanted to get them fixed and have 
another -rc before final release.

So here it is. There's a number of other small random fixes in there too.

		Linus

---
Abhay Salunke:
      dell_rbu: changes in packet update mechanism

Al Viro:
      [PATCH]: highest_possible_processor_id() has to be a macro
      build fix for uml/amd64

Alan Stern:
      Threads shouldn't inherit PF_NOFREEZE

Alexey Dobriyan:
      radio-cadet: check request_region() return value correctly

Andi Kleen:
      [NET]: Disable NET_SCH_CLK_CPU for SMP x86 hosts

Andreas Gruenbacher:
      nfsacl: Solaris VxFS compatibility fix

Andrew Morton:
      binfmt_elf bss padding fix
      [NETFILTER]: Fix ip6_table.c build with NETFILTER_DEBUG enabled.
      orinoco: limit message rate

Andy Wingo:
      raw1394: fix locking in the presence of SMP and interrupts

Anton Blanchard:
      ppc64: Fix PCI hotplug

Antonino A. Daplas:
      vesafb: Fix display corruption on display blank

Arnaldo Carvalho de Melo:
      [CCID]: Check if ccid is NULL in the hc_[tr]x_exit functions
      [DCCP]: Transition from PARTOPEN to OPEN when receiving DATA packets
      [TWSK]: Grab the module refcount for timewait sockets

Baris Cicek:
      [SERIAL] Add SupraExpress 336i Sp ASVD modem ID

Ben Dooks:
      [ARM] 2975/1: S3C2410: time.c missing include of cpu.h
      [ARM] 2976/1: S3C2410: add static to functions in serial driver
      [ARM] 2977/1: armksyms.c - make items in export table static
      [ARM] 2979/2: S3C2410 - add static to non-exported machine items
      [ARM] 2978/1: nwfpe - clean up sparse errors
      [NETPOLL]: wrong return for null netpoll_poll_lock()
      [ARM] 3005/1: S3C2440 - add definition for s3c2440_set_dsc() call in hardware.h
      [ARM] 3006/1: S3C2410 - arch/arm/mach-s3c2410 sparse fixes
      [ARM] 3007/1: BAST - add CONFIG_ISA to build
      [ARM] 3009/1: S3C2410 - io.h offsets too large for LDRH/STRH
      [ARM] 3018/1: S3C2410 - check de-referenced device is really a platform device

Benjamin Herrenschmidt:
      ppc32: Fix timekeeping
      ppc32: Tell userland about lack of standard TB
      ppc64: Fix G5 model in /proc/cpuinfo
      ppc64: Fix error in vDSO 32 bits date

Christian Krause:
      USB: fix bug in handling of highspeed usb HID devices

Cornelia Huck:
      s390: ccw device reconnect oops.

Dave Airlie:
      fix MGA DRM regression before 2.6.14

David McCullough:
      output of /proc/maps on nommu systems is incomplete

David S. Miller:
      [SPARC64]: Fix oops on runlevel change with serial console.
      [SPARC32]: Revert IOMAP change eb98129eec7fa605f0407dfd92d40ee8ddf5cd9a
      [SPARC64]: Fix net booting on Ultra5
      [SPARC64]: Fix boot failures on SunBlade-150
      [NETFILTER]: Fix OOPSes on machines with discontiguous cpu numbering.
      [SPARC64]: Consolidate common PCI IOMMU init code.
      [SPARC64]: Eliminate PCI IOMMU dma mapping size limit.
      [QLOGICPTI]: Handle INQUIRY response sniffing correctly.
      [SPARC64]: Fix powering off on SMP.

Deepak Saxena:
      [ARM] 2980/1: Fix L7200 core.c compile

Dmitry Torokhov:
      uniput - fix crash on SMP

Eric Dumazet:
      rcu: keep rcu callback event counter

Evgeniy Polyakov:
      [CONNECTOR]: Update documentation to match reality.
      Dallas's 1-wire bus compile error

George G. Davis:
      [ARM] 2970/1: Use -mtune=arm1136j-s when building for CPU_V6 targets
      [ARM] 2969/1: miscellaneous whitespace cleanup

Greg Edwards:
      [IA64] mbcs_init() should give up unless running on sn2

Harald Welte:
      [NETFILTER] PPTP helper: Add missing Kconfig dependency
      [NETFILTER] ipt_ULOG: Mark ipt_ULOG as OBSOLETE
      [NETFILTER] nfnetlink: use highest bit of nfa_type to indicate nested TLV
      [NETFILTER] nat: remove bogus structure member
      [NETFILTER] conntrack_netlink: Fix endian issue with status from userspace
      [NETFILTER]: Add missing include to ip_conntrack_tuple.h
      [NETFILTER]: Use only 32bit counters for CONNTRACK_ACCT

Herbert Xu:
      [IPSEC]: Use ALIGN macro in ESP
      [IPSEC] Fix block size/MTU bugs in ESP
      [TCP]: Add code to help track down "BUG at net/ipv4/tcp_output.c:438!"
      [TCP]: Ratelimit debugging warning.
      list: add missing rcu_dereference on first element

Hirokazu Takata:
      m32r: trap handler code for illegal traps
      m32r: Fix smp.c for preempt kernel

Hugh Dickins:
      Don't map the same page too much
      mm: hugetlb truncation fixes

Jeff Dike:
      uml: revert block driver use of host AIO

Jeff Garzik:
      e100: revert CPU cycle saver microcode, it causes severe problems
      sata_nv: Fixed bug introduced by 0.08's MCP51 and MCP55 support.
      Fix and clean up quirk_intel_ide_combined() configuration

Kenneth Tan:
      [ARM] 3020/1: Fixes typo error CONFIG_CPU_IXP465, which should be CONFIG_CPU_IXP46X
      [ARM] 3021/1: Interrupt 0 bug fix for ixp4xx

Kolli, Neela Syam:
      megaraid maintainers entry

Latchesar Ionkov:
      v9fs: remove additional buffer allocation from v9fs_file_read and v9fs_file_write

Liam Girdwood:
      [ARM] 3003/1: SSP channel map register updates for pxa2xx

Linus Torvalds:
      Fix memory ordering bug in page reclaim
      Increase default RCU batching sharply
      Add some basic .gitignore files
      Linux v2.6.14-rc5

Lothar Wassmann:
      [ARM] 3002/1: Wrong parameter to uart_update_timeout() in drivers/serial/pxa.c

Mark Haverkamp:
      aacraid: host_lock not released fix

Mark Rustad:
      kbuild: Eliminate build error when KALLSYMS not defined

Matteo Croce:
      wireless/airo: Build fix

maximilian attems:
      [SERIAL] Add SupraExpress 56i support

Michael Krufky:
      V4L: Enable s-video input on DViCO FusionHDTV5 Lite

NeilBrown:
      Three one-liners in md.c

Nicolas Pitre:
      [ARM] 2974/1: fix ARM710 swi bug workaround
      [ARM] 3008/1: the exception table is not read-only
      [ARM] 3019/1: fix wrong comments

Olav Kongas:
      isp116x-hcd: fix handling of short transfers

Oleg Nesterov:
      posix-timers: fix task accounting

Pablo Neira Ayuso:
      [NETFILTER] ctnetlink: ICMP ID is not mandatory
      [NETFILTER] ctnetlink: add one nesting level for TCP state
      [NETFILTER] ctnetlink: allow userspace to change TCP state
      [NETFILTER] ctnetlink: add support to change protocol info

Paolo 'Blaisorblade' Giarrusso:
      uml: compile-time fix recent patch

Paolo Galtieri:
      ppc highmem fix

Paul Mackerras:
      ppc64: update defconfigs

Paul Schulz:
      [ARM] 3023/1: pxa-regs: Typo in ARM pxa register definitions.

Pavel Machek:
      zaurus: fix compilation with cpufreq disabled
      zaurus: fix soc_common.c
      zaurus: fix dependencies on collie keyboard
      Fix /proc/acpi/events around suspend

Peter Bergner:
      ppc64: Add R_PPC64_TOC16 module reloc

Peter Chubb:
      `unaligned access' in acpi get_root_bridge_busnr()

Randall Nortman:
      usbserial: Regression in USB generic serial driver

Richard Purdie:
      [ARM] 3011/1: pxafb: Add ability to set device parent + fix spitz compile error
      [ARM] 3012/1: Corgi/Spitz LCD: Use bus_find_device to locate pxafb - fix compile error
      [ARM] 3013/1: Spitz: Fix compile errors
      [ARM] 3014/1: Spitz keyboard: Correct the right shift key

Roland McGrath:
      Fix cpu timers exit deadlock and races

Ronald S. Bultje:
      fix vpx3220 offset issue in SECAM
      fix black/white-only svideo input in vpx3220 decoder

Samuel Thibault:
      SVGATextMode fix

Sascha Hauer:
      [ARM] 2971/1: i.MX uart handle rts irq

Seth, Rohit:
      Handle spurious page fault for hugetlb region

Stephan Brodkorb:
      n_r3964 mod_timer() fix

Stephen Hemminger:
      [BRIDGE]: fix race on bridge del if

Steven Rostedt:
      scsi_error thread exits in TASK_INTERRUPTIBLE state.

Suzuki:
      madvise: Avoid returning error code -EBADF for anonymous mappings

Takashi Iwai:
      Add missing export of getnstimeofday()

Tim Schmielau:
      Fix copy-and-paste error in BSD accounting

Tom Rini:
      Export RCS_TAR_IGNORE for rpm targets

Tony Lindgren:
      [ARM] 3024/1: Add cpu_v6_proc_fin

Trond Myklebust:
      NFS: Fix cache consistency races
      NFS: Fix Oopsable/unnecessary i_count manipulations in nfs_wait_on_inode()

Yasunori Goto:
      swiotlb: make sure initial DMA allocations really are in DMA memory

Yoichi Yuasa:
      mips: fix build error in TANBAC TB0226

Yoshinori Sato:
      nommu build error fix
      sh-sci.c sci_start_tx error

Zach Brown:
      aio: revert lock_kiocb()

 .gitignore                                         |   30 +
 Documentation/connector/connector.txt              |   44 ++
 Documentation/dell_rbu.txt                         |   38 +
 MAINTAINERS                                        |    7 
 Makefile                                           |    8 
 arch/arm/Makefile                                  |    2 
 arch/arm/kernel/armksyms.c                         |    4 
 arch/arm/kernel/entry-common.S                     |    7 
 arch/arm/kernel/vmlinux.lds.S                      |   15 -
 arch/arm/mach-l7200/core.c                         |   20 +
 arch/arm/mach-pxa/corgi_lcd.c                      |   20 +
 arch/arm/mach-pxa/generic.c                        |    5 
 arch/arm/mach-pxa/spitz.c                          |    4 
 arch/arm/mach-s3c2410/Kconfig                      |    1 
 arch/arm/mach-s3c2410/clock.c                      |    5 
 arch/arm/mach-s3c2410/mach-anubis.c                |    2 
 arch/arm/mach-s3c2410/mach-bast.c                  |    4 
 arch/arm/mach-s3c2410/mach-vr1000.c                |    2 
 arch/arm/mach-s3c2410/s3c2410.c                    |    3 
 arch/arm/mach-s3c2410/s3c2440.c                    |    4 
 arch/arm/mach-s3c2410/time.c                       |    1 
 arch/arm/mm/alignment.c                            |   48 +-
 arch/arm/mm/proc-v6.S                              |    9 
 arch/arm/nwfpe/fpa11.c                             |    5 
 arch/arm/nwfpe/fpa11.h                             |   20 +
 arch/arm/nwfpe/fpa11_cprt.c                        |    3 
 arch/arm/nwfpe/fpopcode.h                          |    6 
 arch/arm/nwfpe/softfloat.h                         |    3 
 arch/cris/arch-v32/kernel/smp.c                    |    2 
 arch/ia64/lib/swiotlb.c                            |    4 
 arch/m32r/kernel/entry.S                           |    9 
 arch/m32r/kernel/smp.c                             |   12 
 arch/m32r/kernel/traps.c                           |   33 +
 arch/mips/pci/fixup-tb0226.c                       |   33 +
 arch/ppc/kernel/cputable.c                         |    5 
 arch/ppc/kernel/dma-mapping.c                      |    4 
 arch/ppc64/configs/bpa_defconfig                   |   79 ++-
 arch/ppc64/configs/g5_defconfig                    |  124 +++-
 arch/ppc64/configs/iSeries_defconfig               |   78 ++-
 arch/ppc64/configs/maple_defconfig                 |   67 ++
 arch/ppc64/configs/pSeries_defconfig               |   95 ++-
 arch/ppc64/defconfig                               |  100 +++-
 arch/ppc64/kernel/module.c                         |   13 
 arch/ppc64/kernel/pSeries_pci.c                    |    4 
 arch/ppc64/kernel/pmac_setup.c                     |    3 
 arch/ppc64/kernel/vdso32/gettimeofday.S            |    2 
 arch/sh/kernel/smp.c                               |    3 
 arch/sparc/Kconfig                                 |    4 
 arch/sparc/defconfig                               |    1 
 arch/sparc64/kernel/dtlb_base.S                    |   14 
 arch/sparc64/kernel/dtlb_prot.S                    |   12 
 arch/sparc64/kernel/head.S                         |   69 +-
 arch/sparc64/kernel/itlb_base.S                    |   26 -
 arch/sparc64/kernel/ktlb.S                         |   90 ++-
 arch/sparc64/kernel/pci_iommu.c                    |  363 ++++++-------
 arch/sparc64/kernel/pci_psycho.c                   |   44 --
 arch/sparc64/kernel/pci_sabre.c                    |   39 -
 arch/sparc64/kernel/pci_schizo.c                   |   57 --
 arch/sparc64/kernel/smp.c                          |    7 
 arch/sparc64/mm/init.c                             |  187 +++----
 arch/sparc64/mm/ultra.S                            |   16 -
 arch/sparc64/prom/misc.c                           |   12 
 arch/um/drivers/Makefile                           |    2 
 arch/um/drivers/ubd_kern.c                         |  564 +++++++++++---------
 arch/um/drivers/ubd_user.c                         |   75 +++
 arch/um/include/aio.h                              |   18 -
 arch/um/include/os.h                               |    5 
 arch/um/include/sysdep-x86_64/ptrace.h             |    4 
 arch/um/os-Linux/aio.c                             |  205 +++----
 drivers/acpi/event.c                               |    5 
 drivers/acpi/glue.c                                |    8 
 drivers/char/.gitignore                            |    3 
 drivers/char/drm/mga_dma.c                         |   22 +
 drivers/char/mbcs.c                                |    3 
 drivers/char/n_r3964.c                             |    8 
 drivers/firmware/dell_rbu.c                        |  174 +++---
 drivers/ieee1394/ohci1394.c                        |    6 
 drivers/ieee1394/raw1394.c                         |  100 ++--
 drivers/input/keyboard/Kconfig                     |    2 
 drivers/input/keyboard/spitzkbd.c                  |    2 
 drivers/input/misc/uinput.c                        |    4 
 drivers/md/md.c                                    |    4 
 drivers/media/radio/radio-cadet.c                  |    2 
 drivers/media/video/bttv-cards.c                   |    4 
 drivers/media/video/vpx3220.c                      |   32 +
 drivers/net/e100.c                                 |  224 +-------
 drivers/net/wireless/Kconfig                       |    2 
 drivers/net/wireless/orinoco.c                     |    5 
 drivers/pci/.gitignore                             |    4 
 drivers/pci/quirks.c                               |    4 
 drivers/pcmcia/soc_common.c                        |   14 
 drivers/s390/cio/device.c                          |    2 
 drivers/scsi/Kconfig                               |    5 
 drivers/scsi/aacraid/linit.c                       |    2 
 drivers/scsi/qlogicpti.c                           |   39 +
 drivers/scsi/sata_nv.c                             |   14 
 drivers/scsi/scsi_error.c                          |    2 
 drivers/serial/8250_pnp.c                          |    4 
 drivers/serial/imx.c                               |   39 +
 drivers/serial/pxa.c                               |    2 
 drivers/serial/s3c2410.c                           |   15 -
 drivers/serial/sh-sci.c                            |    2 
 drivers/serial/sunsab.c                            |    1 
 drivers/serial/sunzilog.c                          |    5 
 drivers/usb/host/isp116x-hcd.c                     |    3 
 drivers/usb/input/hid-core.c                       |    3 
 drivers/usb/serial/generic.c                       |    2 
 drivers/video/console/vgacon.c                     |    9 
 drivers/video/logo/.gitignore                      |    7 
 drivers/video/sa1100fb.c                           |    2 
 drivers/video/vesafb.c                             |    6 
 drivers/w1/w1.c                                    |    3 
 fs/9p/vfs_file.c                                   |  114 +---
 fs/aio.c                                           |   26 -
 fs/binfmt_elf.c                                    |    2 
 fs/nfs/delegation.c                                |    4 
 fs/nfs/file.c                                      |    3 
 fs/nfs/inode.c                                     |    9 
 fs/nfs_common/nfsacl.c                             |   70 +-
 fs/proc/base.c                                     |   12 
 fs/proc/nommu.c                                    |    1 
 include/asm-arm/arch-ixp4xx/entry-macro.S          |    9 
 include/asm-arm/arch-ixp4xx/hardware.h             |    2 
 include/asm-arm/arch-pxa/pxa-regs.h                |    9 
 include/asm-arm/arch-pxa/pxafb.h                   |    1 
 include/asm-arm/arch-s3c2410/hardware.h            |    7 
 include/asm-arm/arch-s3c2410/io.h                  |   58 +-
 include/asm-arm/locks.h                            |    4 
 include/asm-powerpc/timex.h                        |    2 
 include/asm-ppc/cputable.h                         |    1 
 include/asm-sparc64/pbm.h                          |   30 -
 include/linux/acct.h                               |    4 
 include/linux/aio.h                                |    7 
 include/linux/bootmem.h                            |   32 +
 include/linux/cpumask.h                            |   10 
 include/linux/hugetlb.h                            |   13 
 include/linux/list.h                               |   39 +
 include/linux/netfilter/nfnetlink.h                |   12 
 include/linux/netfilter/nfnetlink_conntrack.h      |   15 -
 include/linux/netfilter_ipv4/ip_conntrack.h        |    8 
 .../linux/netfilter_ipv4/ip_conntrack_protocol.h   |    3 
 include/linux/netfilter_ipv4/ip_conntrack_tuple.h  |    2 
 include/linux/netfilter_ipv4/ip_nat.h              |    4 
 include/linux/netpoll.h                            |    2 
 include/linux/rcupdate.h                           |    1 
 include/net/inet_timewait_sock.h                   |    3 
 kernel/fork.c                                      |    2 
 kernel/posix-cpu-timers.c                          |   31 -
 kernel/rcupdate.c                                  |   13 
 kernel/time.c                                      |    1 
 lib/.gitignore                                     |    6 
 mm/bootmem.c                                       |   31 +
 mm/fremap.c                                        |    3 
 mm/hugetlb.c                                       |   35 +
 mm/madvise.c                                       |   11 
 mm/memory.c                                        |   14 
 mm/vmscan.c                                        |   13 
 net/bridge/br_if.c                                 |    2 
 net/bridge/netfilter/ebtables.c                    |   27 +
 net/dccp/ccid.h                                    |    4 
 net/dccp/input.c                                   |    6 
 net/ipv4/esp4.c                                    |   17 -
 net/ipv4/inet_timewait_sock.c                      |    1 
 net/ipv4/netfilter/Kconfig                         |    8 
 net/ipv4/netfilter/arp_tables.c                    |   14 
 net/ipv4/netfilter/ip_conntrack_core.c             |   13 
 net/ipv4/netfilter/ip_conntrack_netlink.c          |   48 ++
 net/ipv4/netfilter/ip_conntrack_proto_icmp.c       |    3 
 net/ipv4/netfilter/ip_conntrack_proto_tcp.c        |   27 +
 net/ipv4/netfilter/ip_tables.c                     |   17 -
 net/ipv4/tcp_output.c                              |   11 
 net/ipv6/esp6.c                                    |   18 -
 net/ipv6/netfilter/ip6_tables.c                    |   17 -
 net/netfilter/nfnetlink.c                          |    4 
 net/sched/Kconfig                                  |    4 
 scripts/.gitignore                                 |    4 
 scripts/basic/.gitignore                           |    3 
 scripts/kconfig/.gitignore                         |   16 +
 scripts/mod/.gitignore                             |    4 
 usr/.gitignore                                     |    7 
 180 files changed, 2505 insertions(+), 2052 deletions(-)
