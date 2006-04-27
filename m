Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWD0C3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWD0C3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 22:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964898AbWD0C3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 22:29:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10200 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964897AbWD0C3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 22:29:14 -0400
Date: Wed, 26 Apr 2006 19:29:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.17-rc3
Message-ID: <Pine.LNX.4.64.0604261923360.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, back to roughly a weekly schedule, and quite frankly, not a whole lot 
of excitement here. Which is as it should be, I guess.

ShortLog and diffstat appended: most of the commits are small and trivial, 
while most of the diffstat comes from a few bigger ones (ARM defconfig, a 
parisc update, some powerpc refreshes, and a couple of driver updates: 
TPM, isdn gigaset, bcm43xx, ad1889).

I think the shortlog really does describe it best. Go wild,

		Linus

---
Adrian Bunk:
      remove the obsolete IDEPCI_FLAG_FORCE_PDC
      NFS: fix PROC_FS=n compile error
      NFS: make 2 functions static
      IB/mthca: make a function static
      bcm43xx: fix dyn tssi2dbm memleak
      block/elevator.c: remove unused exports
      update OBSOLETE_OSS_DRIVER schedule and dependencies
      make the OSS SOUND_VIA82CXXX option available again
      memory_hotplug.h cleanup

Al Viro:
      uml: __user annotations
      fix leak in activate_ep_files()
      forgotten ->b_data in memcpy() call in ext3/resize.c (oopsable)
      fix mips sys32_p{read,write}
      protect ext3 ioctl modifying append_only, immutable, etc. with i_mutex

Ananth N Mavinakayanahalli:
      kprobes: NULL out non-relevant fields in struct kretprobe

Anatoli Antonovitch:
      ide: ATI SB600 IDE support

Andi Kleen:
      i386/x86-64: Fix x87 information leak between processes
      x86_64: Pass -32 to the assembler when compiling the 32bit vsyscall pages

Andrew Morton:
      oom-kill: mm locking fix
      page_alloc.c: buddy handling cleanup
      [ARM] add_memory() build fix
      pcmcia: remove unneeded forward declarations
      Altix snsc: duplicate kobject fix
      splice: fix min() warning

Andy Fleming:
      Fix locking in gianfar

Andy Whitcroft:
      x86_64: sparsemem does not need node_mem_map

Antonino A. Daplas:
      fbdev: Fix return error of fb_write

Arnaud MAZIN:
      sonypi: correct detection of new ICH7-based laptops

Arnd Bergmann:
      powerpc/cell: remove BUILD_BUG_ON and add sys_tee to spu_syscall_table

Arthur Othieno:
      hugetlbfs: add Kconfig help text

Auke Kok:
      e1000: Update truesize with the length of the packet for packet split

Ayaz Abdulla:
      forcedeth: fix initialization

Becky Bruce:
      ppc: Fix powersave code on arch/ppc

Benjamin Herrenschmidt:
      powermac: Fix i2c on keywest based chips
      powerpc: fix oops in alsa powermac driver

Carsten Otte:
      NFS: remove needless check in nfs_opendir()

Chandra Seetharaman:
      Remove __devinitdata from notifier block definitions
      Remove __devinit and __cpuinit from notifier_call definitions

Chris Zankel:
      xtensa: Fix TIOCGICOUNT macro

Christoph Lameter:
      Remove cond_resched in gather_stats()

Corey Minyard:
      IPMI maintainer

Coywolf Qi Hunt:
      [patch] cleanup: use blk_queue_stopped

Dan Williams:
      wireless/airo: clean up WEXT association and scan events
      wireless/atmel: send WEXT scan completion events

Daniel Ritz:
      pcmcia/pcmcia_resource.c: fix crash when using Cardbus cards

Darren Jenkins:
      fix section mismatch in pm2fb.o

Dave Airlie:
      drm: fixup r300 scratch on BE machines
      drm: possible cleanups

Dave Peterson:
      mm: fix mm_struct reference counting bugs in mm/oom_kill.c

David Barksdale:
      m41t00: fix bitmasks when writing to chip

David S. Miller:
      [SPARC]: __NR_sys_splice --> __NR_splice
      [LLC]: Use pskb_trim_rcsum() in llc_fixup_skb().
      [NET]: Add skb->truesize assertion checking.

Dipankar Sarma:
      Fix file lookup without ref

Dmitry Mishin:
      [NETFILTER]: x_tables: move table->lock initialization

Dominik Brodowski:
      pcmcia: add new ID to pcnet_cs
      pcmcia: do not set dev_node to NULL too early
      pcmcia: fix oops in static mapping case

Eric Dumazet:
      x86_64: bring back __read_mostly support to linux-2.6.17-rc2

Eric Sesterhenn:
      SUNRPC: Dead code in net/sunrpc/auth_gss/auth_gss.c

Eric W. Biederman:
      task: Make task list manipulations RCU safe

Erik Mouw:
      bcm43xx: iw_priv_args names should be <16 characters

Grant Grundler:
      [PARISC] Document that we tolerate "Relaxed Ordering"

Hal Rosenstock:
      IB/mad: Fix RMPP version check during agent registration

Heikki Orsila:
      Open IPMI BT overflow

Helge Deller:
      [PARISC] EISA regions must be mapped NO_CACHE
      [PARISC] Misc. janitorial work
      [PARISC] defconfig updates
      [PARISC] Further work for multiple page sizes

Herbert Xu:
      [TCP]: Account skb overhead in tcp_fragment

Hirokazu Takata:
      m32r: Fix pt_regs for !COFNIG_ISA_DSP_LEVEL2 target
      m32r: update include/asm-m32r/semaphore.h
      m32r: mappi3 reboot support
      m32r: Remove a warning in m32r_sio.c
      m32r: update switch_to macro for tuning

Hua Zhong:
      [NET]: sockfd_lookup_light() returns random error for -EBADFD

Hyok S. Choi:
      [ARM] nommu: trivial fixups for head-nommu.S and the Makefile

Ingo Molnar:
      md: locking fix

Ivan Kokshaysky:
      Alpha: strncpy() fix

J. Bruce Fields:
      RPCSEC_GSS: fix leak in krb5 code caused by superfluous kmalloc

James Morris:
      LSM: add missing hook to do_compat_readv_writev()

Jan Engelhardt:
      pnp: fix two messages in manager.c

Jan Kara:
      Fix reiserfs deadlock

Jayachandran C:
      [EBTABLES]: Clean up vmalloc usage in net/bridge/netfilter/ebtables.c

Jean Delvare:
      fb: Fix section mismatch in savagefb
      i2c-i801: Fix resume when PEC is used

Jean Tourrilhes:
      wext: Fix IWENCODEEXT security permissions
      Revert NET_RADIO Kconfig title change
      wext: Fix RtNetlink ENCODE security permissions

Jeff Dike:
      uml: MADV_REMOVE fixes
      uml: change sigjmp_buf to jmp_buf
      uml: add missing __volatile__

Jens Axboe:
      splice: close i_size truncate races on read
      splice: cleanup the SPLICE_F_NONBLOCK handling
      tee: link_pipe() must be careful when dropping one of the pipe locks
      splice: offset fixes
      splice: fixup writeout path after ->map changes
      Don't inherit ->splice_pipe across forks
      splice: fix smaller sized splice reads
      splice: fix offset problems
      Add support for the sys_vmsplice syscall
      splice: rearrange moving to/from pipe helpers
      splice: add ->splice_write support for /dev/null

Jesper Juhl:
      voyager: no need to define BITS_PER_BYTE when it's already in types.h
      Fix potential NULL pointer deref in gen_init_cpio

Johannes Berg:
      softmac: fix event sending
      softmac: report when scanning has finished
      [SUNGEM]: Marvell PHY suspend.
      softmac: fix SIOCSIWAP

Johannes Goecke:
      MSI-K8T-Neo2-Fir OnboardSound and additional Soundcard

johannes@sipsolutions.net:
      softmac: return -EAGAIN from getscan while scanning
      softmac: dont send out packets while scanning
      softmac: handle iw_mode properly

John Hawkes:
      mm/slob.c: for_each_possible_cpu(), not NR_CPUS
      NFS: nfs_show_stats; for_each_possible_cpu(), not NR_CPUS

Jon Masters:
      sound: fix hang in mpu401_uart.c

KAI.HSU:
      alim15x3: ULI M-1573 south Bridge support

KAMEZAWA Hiroyuki:
      for_each_possible_cpu: x86_64
      [ARM] for_each_possible_cpu

Komuro:
      pcmcia: unload second device first
      pcmcia: fix comment for pcmcia_load_firmware

Kumar Gala:
      powerpc/ppc: export strncasecmp

Kyle McMartin:
      [PARISC] Add new entries to the syscall table
      [PARISC] Make ioremap default to _nocache
      [PARISC] MAINTAINERS

Kylene Jo Hall:
      tpm: fix memory leak
      tpm: fix missing string
      tpm: spacing cleanups
      tpm: reorganize sysfs files
      tpm: chip struct update
      tpm: return chip from tpm_register_hardware
      tpm: command duration update
      tpm: new 1.2 sysfs files
      tpm: msecs_to_jiffies cleanups
      tpm: use clear_bit
      tpm: check mem start and len
      tpm: update bios log code for 1.2
      tpm: spacing cleanups 2
      tpm: add interrupt module parameter
      tpm: add HID module parameter

Lee Schermerhorn:
      add migratepage address space op to shmem

Leendert van Doorn:
      tpm: driver for next generation TPM chips

Lennert Buytenhek:
      [ARM] 3480/1: ixp4xx: fix irq2gpio array type
      [ARM] 3481/1: ep93xx: update defconfig to 2.6.17-rc2
      [ARM] 3482/1: ixp2000: update defconfig to 2.6.17-rc2
      [ARM] 3483/1: ixp23xx: update defconfig to 2.6.17-rc2

lepton:
      asm-i386/atomic.h: local_irq_save should be used instead of local_irq_disable

Linus Torvalds:
      Linux v2.6.17-rc3

Marcel Selhorst:
      tpm: tpm_infineon updated to latest interface changes

Matthew Wilcox:
      [PARISC] Fix up hil_kbd.c mismerge

Michael Buesch:
      softmac: fix spinlock recursion on reassoc
      bcm43xx: set trans_start on TX to prevent bogus timeouts
      bcm43xx: fix pctl slowclock limit calculation
      bcm43xx: sysfs code cleanup
      bcm43xx: add to MAINTAINERS
      bcm43xx: make PIO mode usable

Mike Waychison:
      x86_64: Fix a race in the free_iommu path

Miklos Szeredi:
      Revert "[fuse] fix deadlock between fuse_put_super() and request_end()"
      [fuse] fix deadlock between fuse_put_super() and request_end(), try #2
      [fuse] fix race between checking and setting file->private_data
      [doc] add paragraph about 'fs' subsystem to sysfs.txt

OGAWA Hirofumi:
      Add more prevent_tail_call()
      [SPARC]: __NR_sys removal

Olof Johansson:
      powerpc: IOMMU support for honoring dma_mask
      powerpc: Lower threshold for DART enablement to 1GB

Paolo 'Blaisorblade' Giarrusso:
      uml: make 64-bit COW files compatible with 32-bit ones

Patrick McHardy:
      [NETFILTER]: Fix compat_xt_counters alignment for non-x86
      [NETFILTER]: ip6_tables: remove broken comefrom debugging
      [NETFILTER]: ipt action: use xt_check_target for basic verification

Paul Mackerras:
      powerpc: Fix define_machine so machine_is() works from modules

Pavel Roskin:
      orinoco: fix truncating commsquality RID with the latest Symbol firmware
      Fix crash on big-endian systems during scan

Prasanna S Panchamukhi:
      Switch Kprobes inline functions to __kprobes for i386
      Switch Kprobes inline functions to __kprobes for x86_64
      Switch Kprobes inline functions to __kprobes for ppc64
      Switch Kprobes inline functions to __kprobes for ia64
      Switch Kprobes inline functions to __kprobes for sparc64

Rafael J. Wysocki:
      swsusp: prevent possible image corruption on resume

Randy Dunlap:
      x86 cpuid and msr notifier callback section mismatches
      Doc: vm/hugetlbpage update-2
      IPMI: fix devinit placement
      config: update usage/help info
      radeonfb section mismatches
      savagefb: fix section mismatch warnings
      softmac uses Wiress Ext.
      bcm43xx wireless: fix printk format warnings
      bcm43xx: fix config menu alignment
      tpm_infineon section fixup

Randy.Dunlap:
      parport_pc: fix section mismatch warnings (v2)

Richard Purdie:
      [ARM] 3484/1: Correct AEABI CFLAGS for correct enum handling

Rob Landley:
      uml: physical memory map file fixes

Roland Dreier:
      IB/srp: Remove request from list when SCSI abort succeeds
      IB/ipath: Make more names static
      IB/ipath: Fix whitespace

Ron Yorston:
      selinux: Fix MLS compatibility off-by-one bug

Russell King:
      [MMC] pxamci: fix data timeout calculation
      [ARM] vfp: fix leak of VFP_NAN_FLAG into FPSCR

Samuel Thibault:
      apm: fix Armada laptops again

Sergei Shtylyov:
      NEx000: fix RTL8019AS base address for RBTX4938

Stephen Hemminger:
      [BRIDGE]: allow full size vlan packets
      sky2: reschedule if irq still pending
      sky2: add fake idle irq timer
      sky2: use ALIGN() macro
      sky2: reset function can be devinit
      sky2: version 1.2

Steve French:
      [CIFS] [CIFS] Do not take rename sem on most path based calls (during
      [CIFS] Don't allow a backslash in a path component
      [CIFS] Use the kthread_ API instead of opencoding lots of hairy code for kernel
      [CIFS] Readdir fixes to allow search to start at arbitrary position
      [CIFS] Fix typo in previous
      [CIFS] Fix compile error when CONFIG_CIFS_EXPERIMENTAL is undefined

Stuart Brady:
      [PARISC] OSS ad1889: Match register names with ALSA driver

Thayumanavar Sachithanantham:
      cs5535_gpio.c: call cdev_del() during module_exit to unmap kobject references and other cleanups

Thomas Voegtle:
      [NETFILTER]: ULOG target is not obsolete

Tilman Schmidt:
      isdn4linux: Siemens Gigaset base driver: fix disconnect handling

Tim Chen:
      Kconfig.debug: Set DEBUG_MUTEX to off by default

Trond Myklebust:
      VFS: Fix another open intent Oops
      NFS,SUNRPC: Fix compiler warnings if CONFIG_PROC_FS & CONFIG_SYSCTL are unset

Valdis Kletnieks:
      Document online io scheduler switching

Will Schmidt:
      powerpc: update {g5,iseries,pseries}_defconfigs

Yasuyuki Kozakai:
      [NETFILTER]: nf_conntrack: Fix module refcount dropping too far
      [NETFILTER]: nf_conntrack: kill unused callback init_conntrack

Yoichi Yuasa:
      vrc4171: update config

---
 Documentation/block/switching-sched.txt         |   22 +
 Documentation/feature-removal-schedule.txt      |    5 
 Documentation/filesystems/sysfs.txt             |    5 
 Documentation/vm/hugetlbpage.txt                |   11 
 MAINTAINERS                                     |   19 +
 Makefile                                        |    2 
 README                                          |   23 +
 arch/alpha/lib/strncpy.S                        |    8 
 arch/arm/Makefile                               |    2 
 arch/arm/configs/ep93xx_defconfig               |   79 ++
 arch/arm/configs/ixp2000_defconfig              |   59 +-
 arch/arm/configs/ixp23xx_defconfig              |   58 +-
 arch/arm/kernel/Makefile                        |    2 
 arch/arm/kernel/head-nommu.S                    |    4 
 arch/arm/kernel/setup.c                         |    8 
 arch/arm/mach-ixp4xx/common.c                   |    2 
 arch/arm/vfp/vfpdouble.c                        |    2 
 arch/arm/vfp/vfpmodule.c                        |    2 
 arch/arm/vfp/vfpsingle.c                        |    2 
 arch/i386/kernel/apm.c                          |    2 
 arch/i386/kernel/cpu/amd.c                      |    2 
 arch/i386/kernel/cpu/intel_cacheinfo.c          |    2 
 arch/i386/kernel/cpuid.c                        |    2 
 arch/i386/kernel/kprobes.c                      |   18 -
 arch/i386/kernel/msr.c                          |    2 
 arch/i386/mach-voyager/voyager_cat.c            |    1 
 arch/ia64/kernel/entry.S                        |    1 
 arch/ia64/kernel/kprobes.c                      |   10 
 arch/ia64/kernel/palinfo.c                      |    2 
 arch/ia64/kernel/salinfo.c                      |    2 
 arch/ia64/kernel/topology.c                     |    2 
 arch/m32r/kernel/entry.S                        |   55 +-
 arch/m32r/kernel/process.c                      |    4 
 arch/m32r/kernel/signal.c                       |    4 
 arch/mips/kernel/linux32.c                      |   64 --
 arch/parisc/Kconfig                             |   31 +
 arch/parisc/defconfig                           |  494 +++++++++-----
 arch/parisc/kernel/asm-offsets.c                |    3 
 arch/parisc/kernel/cache.c                      |    4 
 arch/parisc/kernel/entry.S                      |   36 +
 arch/parisc/kernel/head.S                       |   15 
 arch/parisc/kernel/init_task.c                  |   10 
 arch/parisc/kernel/pacache.S                    |   25 -
 arch/parisc/kernel/sys_parisc.c                 |    8 
 arch/parisc/kernel/syscall.S                    |   10 
 arch/parisc/kernel/syscall_table.S              |    8 
 arch/parisc/kernel/vmlinux.lds.S                |   54 +-
 arch/parisc/mm/fault.c                          |    2 
 arch/parisc/mm/init.c                           |   28 -
 arch/parisc/mm/ioremap.c                        |    3 
 arch/powerpc/configs/g5_defconfig               |   58 +-
 arch/powerpc/configs/iseries_defconfig          |   43 +
 arch/powerpc/configs/pseries_defconfig          |   54 +-
 arch/powerpc/kernel/iommu.c                     |   36 +
 arch/powerpc/kernel/kprobes.c                   |   14 
 arch/powerpc/kernel/pci_iommu.c                 |   40 +
 arch/powerpc/kernel/ppc_ksyms.c                 |    1 
 arch/powerpc/kernel/prom.c                      |    2 
 arch/powerpc/kernel/sysfs.c                     |    4 
 arch/powerpc/kernel/systbl.S                    |    6 
 arch/powerpc/kernel/vio.c                       |    6 
 arch/powerpc/platforms/cell/spu_callbacks.c     |    6 
 arch/powerpc/platforms/powermac/low_i2c.c       |   78 +-
 arch/powerpc/sysdev/dart_iommu.c                |   12 
 arch/ppc/kernel/asm-offsets.c                   |    1 
 arch/ppc/kernel/entry.S                         |   33 -
 arch/ppc/kernel/ppc_ksyms.c                     |    1 
 arch/s390/appldata/appldata_base.c              |    2 
 arch/sparc64/kernel/kprobes.c                   |   12 
 arch/um/drivers/cow_user.c                      |    2 
 arch/um/include/longjmp.h                       |    4 
 arch/um/include/sysdep-i386/kernel-offsets.h    |    2 
 arch/um/include/sysdep-x86_64/kernel-offsets.h  |    2 
 arch/um/os-Linux/mem.c                          |  118 +++
 arch/um/os-Linux/process.c                      |    8 
 arch/um/os-Linux/skas/process.c                 |   36 +
 arch/um/os-Linux/start_up.c                     |   24 -
 arch/um/os-Linux/trap.c                         |    4 
 arch/um/os-Linux/uaccess.c                      |    4 
 arch/um/os-Linux/util.c                         |    2 
 arch/um/sys-i386/signal.c                       |    6 
 arch/um/sys-i386/stub_segv.c                    |    4 
 arch/um/sys-x86_64/stub_segv.c                  |   10 
 arch/x86_64/ia32/Makefile                       |    4 
 arch/x86_64/kernel/kprobes.c                    |   10 
 arch/x86_64/kernel/mce.c                        |    2 
 arch/x86_64/kernel/mce_amd.c                    |    2 
 arch/x86_64/kernel/pci-gart.c                   |    4 
 arch/x86_64/kernel/process.c                    |    4 
 arch/x86_64/kernel/setup.c                      |    4 
 arch/x86_64/mm/numa.c                           |    2 
 block/elevator.c                                |    2 
 block/ll_rw_blk.c                               |    6 
 drivers/base/topology.c                         |    2 
 drivers/char/cs5535_gpio.c                      |    5 
 drivers/char/drm/drmP.h                         |    1 
 drivers/char/drm/drm_agpsupport.c               |    2 
 drivers/char/drm/drm_bufs.c                     |    5 
 drivers/char/drm/drm_stub.c                     |    2 
 drivers/char/drm/r300_cmdbuf.c                  |    2 
 drivers/char/ipmi/ipmi_bt_sm.c                  |    2 
 drivers/char/ipmi/ipmi_si_intf.c                |    4 
 drivers/char/mem.c                              |   14 
 drivers/char/snsc.c                             |    3 
 drivers/char/sonypi.c                           |    3 
 drivers/char/tpm/Kconfig                        |   11 
 drivers/char/tpm/Makefile                       |    1 
 drivers/char/tpm/tpm.c                          |  786 ++++++++++++++++++++---
 drivers/char/tpm/tpm.h                          |   37 +
 drivers/char/tpm/tpm_atmel.c                    |   58 +-
 drivers/char/tpm/tpm_atmel.h                    |   25 -
 drivers/char/tpm/tpm_bios.c                     |   52 +-
 drivers/char/tpm/tpm_infineon.c                 |   61 +-
 drivers/char/tpm/tpm_nsc.c                      |   49 +
 drivers/char/tpm/tpm_tis.c                      |  669 ++++++++++++++++++++
 drivers/char/tty_io.c                           |    8 
 drivers/cpufreq/cpufreq.c                       |    2 
 drivers/i2c/busses/i2c-i801.c                   |    5 
 drivers/i2c/chips/m41t00.c                      |    8 
 drivers/ide/pci/alim15x3.c                      |    2 
 drivers/ide/pci/atiixp.c                        |    1 
 drivers/ide/pci/pdc202xx_old.c                  |    2 
 drivers/ide/setup-pci.c                         |   13 
 drivers/infiniband/core/mad.c                   |    5 
 drivers/infiniband/hw/ipath/ipath_diag.c        |   12 
 drivers/infiniband/hw/ipath/ipath_driver.c      |    2 
 drivers/infiniband/hw/ipath/ipath_intr.c        |    4 
 drivers/infiniband/hw/ipath/ipath_kernel.h      |    1 
 drivers/infiniband/hw/ipath/ipath_layer.c       |    2 
 drivers/infiniband/hw/ipath/ipath_pe800.c       |   10 
 drivers/infiniband/hw/ipath/ipath_qp.c          |  124 ++--
 drivers/infiniband/hw/ipath/ipath_ud.c          |    4 
 drivers/infiniband/hw/ipath/ipath_verbs.c       |  118 ++-
 drivers/infiniband/hw/ipath/ipath_verbs.h       |    5 
 drivers/infiniband/hw/mthca/mthca_mad.c         |    2 
 drivers/infiniband/ulp/srp/ib_srp.c             |   18 -
 drivers/input/keyboard/hil_kbd.c                |    2 
 drivers/isdn/gigaset/bas-gigaset.c              |  597 ++++++++++-------
 drivers/isdn/gigaset/common.c                   |    3 
 drivers/isdn/gigaset/ev-layer.c                 |    3 
 drivers/isdn/gigaset/gigaset.h                  |    7 
 drivers/isdn/gigaset/i4l.c                      |    2 
 drivers/isdn/gigaset/isocdata.c                 |   10 
 drivers/macintosh/therm_adt746x.c               |    4 
 drivers/md/md.c                                 |   24 -
 drivers/mmc/pxamci.c                            |   10 
 drivers/net/e1000/e1000_main.c                  |    1 
 drivers/net/forcedeth.c                         |   79 ++
 drivers/net/gianfar.c                           |   56 +-
 drivers/net/gianfar.h                           |   67 +-
 drivers/net/gianfar_ethtool.c                   |   20 -
 drivers/net/gianfar_sysfs.c                     |   24 -
 drivers/net/ne.c                                |    2 
 drivers/net/pcmcia/pcnet_cs.c                   |    1 
 drivers/net/sky2.c                              |   52 +-
 drivers/net/sky2.h                              |    2 
 drivers/net/sungem_phy.c                        |   11 
 drivers/net/wireless/Kconfig                    |    2 
 drivers/net/wireless/airo.c                     |   46 -
 drivers/net/wireless/atmel.c                    |   11 
 drivers/net/wireless/bcm43xx/Kconfig            |    3 
 drivers/net/wireless/bcm43xx/bcm43xx.h          |   17 
 drivers/net/wireless/bcm43xx/bcm43xx_debugfs.c  |    8 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.c      |   13 
 drivers/net/wireless/bcm43xx/bcm43xx_dma.h      |    8 
 drivers/net/wireless/bcm43xx/bcm43xx_main.c     |    2 
 drivers/net/wireless/bcm43xx/bcm43xx_phy.c      |    1 
 drivers/net/wireless/bcm43xx/bcm43xx_pio.c      |   92 ++-
 drivers/net/wireless/bcm43xx/bcm43xx_pio.h      |   16 
 drivers/net/wireless/bcm43xx/bcm43xx_power.c    |  115 ++-
 drivers/net/wireless/bcm43xx/bcm43xx_power.h    |    9 
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.c    |  115 ++-
 drivers/net/wireless/bcm43xx/bcm43xx_sysfs.h    |   16 
 drivers/net/wireless/bcm43xx/bcm43xx_wx.c       |    8 
 drivers/net/wireless/hostap/hostap_ioctl.c      |    4 
 drivers/net/wireless/orinoco.c                  |    2 
 drivers/parisc/pdc_stable.c                     |    2 
 drivers/parisc/sba_iommu.c                      |   45 +
 drivers/parisc/superio.c                        |    4 
 drivers/parport/parport_pc.c                    |   20 -
 drivers/pci/quirks.c                            |   29 +
 drivers/pcmcia/Kconfig                          |    2 
 drivers/pcmcia/ds.c                             |   16 
 drivers/pcmcia/pcmcia_resource.c                |   18 -
 drivers/pnp/manager.c                           |    4 
 drivers/serial/m32r_sio.c                       |    1 
 drivers/usb/gadget/inode.c                      |    1 
 drivers/video/aty/radeon_base.c                 |    2 
 drivers/video/fbmem.c                           |   14 
 drivers/video/pm2fb.c                           |    4 
 drivers/video/savage/savagefb_driver.c          |    8 
 fs/Kconfig                                      |    6 
 fs/cifs/CHANGES                                 |    6 
 fs/cifs/README                                  |    8 
 fs/cifs/cifsfs.c                                |   99 +--
 fs/cifs/cifssmb.c                               |    2 
 fs/cifs/connect.c                               |    6 
 fs/cifs/dir.c                                   |   18 -
 fs/cifs/fcntl.c                                 |    2 
 fs/cifs/file.c                                  |   34 +
 fs/cifs/inode.c                                 |    6 
 fs/cifs/link.c                                  |    6 
 fs/cifs/ntlmssp.c                               |   14 
 fs/cifs/readdir.c                               |   45 +
 fs/cifs/xattr.c                                 |    8 
 fs/compat.c                                     |    4 
 fs/exec.c                                       |    2 
 fs/ext3/ioctl.c                                 |   18 -
 fs/ext3/resize.c                                |    2 
 fs/fuse/dev.c                                   |   35 +
 fs/fuse/fuse_i.h                                |   12 
 fs/fuse/inode.c                                 |   40 +
 fs/lockd/svclock.c                              |    2 
 fs/locks.c                                      |    9 
 fs/nfs/dir.c                                    |    5 
 fs/nfs/direct.c                                 |    8 
 fs/nfs/file.c                                   |    5 
 fs/nfs/inode.c                                  |    5 
 fs/nfs/nfs4proc.c                               |   10 
 fs/proc/base.c                                  |   21 -
 fs/reiserfs/xattr_acl.c                         |    5 
 fs/splice.c                                     |  529 ++++++++++++---
 include/asm-i386/atomic.h                       |    5 
 include/asm-i386/cpufeature.h                   |    1 
 include/asm-i386/i387.h                         |   30 +
 include/asm-i386/unistd.h                       |    3 
 include/asm-ia64/unistd.h                       |    3 
 include/asm-m32r/assembler.h                    |    5 
 include/asm-m32r/mappi3/mappi3_pld.h            |   22 -
 include/asm-m32r/ptrace.h                       |   25 -
 include/asm-m32r/semaphore.h                    |   64 --
 include/asm-m32r/sigcontext.h                   |    2 
 include/asm-m32r/system.h                       |   67 +-
 include/asm-parisc/io.h                         |   17 
 include/asm-parisc/page.h                       |   25 +
 include/asm-parisc/pgtable.h                    |   63 +-
 include/asm-parisc/unistd.h                     |    8 
 include/asm-powerpc/iommu.h                     |    7 
 include/asm-powerpc/machdep.h                   |    6 
 include/asm-powerpc/unistd.h                    |    3 
 include/asm-sparc/unistd.h                      |    4 
 include/asm-sparc64/unistd.h                    |    4 
 include/asm-x86_64/cache.h                      |    4 
 include/asm-x86_64/cpufeature.h                 |    1 
 include/asm-x86_64/i387.h                       |   20 +
 include/asm-x86_64/percpu.h                     |    2 
 include/asm-x86_64/unistd.h                     |    4 
 include/asm-xtensa/ioctls.h                     |    2 
 include/linux/ide.h                             |    1 
 include/linux/memory_hotplug.h                  |    3 
 include/linux/netdevice.h                       |   18 -
 include/linux/netfilter/x_tables.h              |    4 
 include/linux/pci_ids.h                         |    4 
 include/linux/pipe_fs_i.h                       |   17 
 include/linux/sched.h                           |    3 
 include/linux/skbuff.h                          |    7 
 include/linux/sunrpc/metrics.h                  |   12 
 include/linux/sunrpc/xprt.h                     |    1 
 include/linux/syscalls.h                        |    3 
 include/net/ieee80211softmac.h                  |    8 
 include/net/sock.h                              |    1 
 kernel/exit.c                                   |    2 
 kernel/fork.c                                   |    3 
 kernel/hrtimer.c                                |    4 
 kernel/kprobes.c                                |    3 
 kernel/power/snapshot.c                         |    9 
 kernel/profile.c                                |    2 
 kernel/rcupdate.c                               |    4 
 kernel/sched.c                                  |    2 
 kernel/softirq.c                                |    4 
 kernel/softlockup.c                             |    4 
 kernel/timer.c                                  |    4 
 kernel/uid16.c                                  |   59 +-
 kernel/workqueue.c                              |    2 
 lib/Kconfig.debug                               |    2 
 mm/mempolicy.c                                  |    1 
 mm/oom_kill.c                                   |   71 +-
 mm/page_alloc.c                                 |   12 
 mm/shmem.c                                      |    3 
 mm/slab.c                                       |    2 
 mm/slob.c                                       |   10 
 mm/vmscan.c                                     |    2 
 net/bridge/br_forward.c                         |    8 
 net/bridge/netfilter/ebtables.c                 |   20 -
 net/core/dev.c                                  |    3 
 net/core/skbuff.c                               |    8 
 net/core/stream.c                               |    1 
 net/core/wireless.c                             |    8 
 net/ieee80211/softmac/Kconfig                   |    1 
 net/ieee80211/softmac/ieee80211softmac_assoc.c  |   25 +
 net/ieee80211/softmac/ieee80211softmac_event.c  |   40 +
 net/ieee80211/softmac/ieee80211softmac_io.c     |   18 -
 net/ieee80211/softmac/ieee80211softmac_module.c |    2 
 net/ieee80211/softmac/ieee80211softmac_scan.c   |    2 
 net/ieee80211/softmac/ieee80211softmac_wx.c     |   37 +
 net/ipv4/netfilter/Kconfig                      |    2 
 net/ipv4/tcp_output.c                           |   10 
 net/ipv6/netfilter/ip6_tables.c                 |   13 
 net/llc/llc_input.c                             |    3 
 net/netfilter/nf_conntrack_core.c               |   15 
 net/netfilter/nf_conntrack_l3proto_generic.c    |    1 
 net/netfilter/x_tables.c                        |    2 
 net/sched/act_ipt.c                             |    5 
 net/socket.c                                    |    1 
 net/sunrpc/auth_gss/auth_gss.c                  |    1 
 net/sunrpc/auth_gss/gss_krb5_crypto.c           |   11 
 net/sunrpc/stats.c                              |    3 
 scripts/kconfig/conf.c                          |    3 
 security/selinux/ss/mls.c                       |    2 
 sound/drivers/mpu401/mpu401_uart.c              |   42 +
 sound/oss/Kconfig                               |  318 ---------
 sound/oss/ad1889.c                              |  198 +++---
 sound/oss/ad1889.h                              |  101 +--
 sound/oss/dmasound/tas_common.c                 |    4 
 sound/ppc/daca.c                                |    2 
 sound/ppc/tumbler.c                             |    2 
 usr/gen_init_cpio.c                             |    4 
 317 files changed, 5296 insertions(+), 2947 deletions(-)
