Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVHXFIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVHXFIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 01:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbVHXFIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 01:08:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751457AbVHXFIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 01:08:21 -0400
Date: Tue, 23 Aug 2005 22:08:13 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.13-rc7
Message-ID: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hullo.

 I really wanted to release a 2.6.13, but there's been enough changes 
while we've been waiting for other issues to resolve that I think it's 
best to do a -rc7 first.

Most of the -rc7 changes are pretty trivial, either one-liners or 
affecting some particular specific driver or unusual configuration. The 
shortlog (appended) should give a pretty good idea of what's up.

		Linus

---
Al Viro:
  uml: fix the x86_64 build
  [SPARC]: Fix weak aliases
  jffs2: fix symlink error handling
  Fix up symlink function pointers
  Lots of Kconfig fixes
  alpha gcc4 warnings
  missing include in pcmcia_resource.c
  alpha xchg fix
  alpha spinlock code and bogus constraints
  m32r smp.h gcc4 fixes
  m32r icu_data gcc4 fixes
  m32r_sio gcc4 fixes
  broken inline asm on s390 (misuse of labels)
  vidc gcc4 fix
  emac netpoll fix
  typo fix in qdio.c
  qualifiers in return types - easy cases
  missing exports on m32r
  ad1980 makefile fix
  %t... in vsnprintf
  s390 __CHECKER__ ifdefs

Alexander Nyberg:
  ns558 list handling fix

Alexey Dobriyan:
  [NET]: Make skb->protocol __be16
  freevxfs: fix breakage introduced by symlink fixes
  zd1201 kmalloc size fix

Andi Kleen:
  x86: Remove obsolete get_cpu_vendor call
  x86_64: Don't print exceptions for ltrace
  x86_64: Fix race in TSC synchronization
  x86_64: Don't oops at boot when empty Opteron node has IO

Andrew Morton:
  [NET]: Fix memory leak in sys_{send,recv}msg() w/compat
  PCI: fix quirk-6700-fix.patch

Anton Altaparmakov:
  NTFS: Fix bug in mft record writing where we forgot to set the device in
  NTFS: Complete the previous fix for the unset device when mapping buffers

Antonino A. Daplas:
  intelfb/fbdev: Save info->flags in a local variable

Antonino Daplas:
  nvidiafb: Fix initial display corruption on certain laptops

Arnd Bergmann:
  ppc64: add default config for BPA

Bartlomiej Zolnierkiewicz:
  ide-floppy: fix IDEFLOPPY_TICKS_DELAY

Ben Colline:
  [SPARC]: Deal with glibc changing macro names in modpost.c

Ben Dooks:
  ARM: 2847/1: S3C24XX - Documentation for USB OHCI host
  ARM: 2849/1: S3C24XX - USB host update (2848/1)
  DM9000 - spinlock fixes
  DM9000 - incorrect ioctl() handling

Benjamin Herrenschmidt:
  ppc64: Fix Fan control for new PowerMac G5 2.7GHz machines

Bhavesh P. Davda:
  NPTL signal delivery deadlock fix

Brian King:
  ppc64: iommu vmerge fix

Christoph Hellwig:
  ARM: switch fd1772.c from sleep_on to wait_event
  [SPARC]: Use kthread infrastructure in envctrl
  [SPARC]: Use kthread infrastructure in bbc_envctrl
  [SPARC]: remove ifdef CONFIG_PCI from envctrl.c
  [IA64] update CONFIG_PCI description

Christoph Lameter:
  Fix ide-disk.c oops caused by hwif == NULL

Chuck Ebbert:
  i386: fix incorrect FP signal code

Chuck Lever:
  NFS: split nfsi->flags into two fields
  NFS: use atomic bitops to manipulate flags in nfsi->flags
  NFS: Introduce the use of inode->i_lock to protect fields in nfsi

Cornelia Huck:
  s390: use klist in qeth driver

Dave Johnson:
  [IPV4]: Fix negative timer loop with lots of ipv4 peers.

Dave Jones:
  icn driver fails to unload when no hardware present

Dave Kleikamp:
  Merge with /home/shaggy/git/linus-clean/
  JFS: Improve sync barrier processing
  Merge with /home/shaggy/git/linus-clean/
  Merge with /home/shaggy/git/linus-clean/
  JFS: Check for invalid inodes in jfs_delete_inode
  Merge with /home/shaggy/git/linus-clean/
  JFS: Fix race in txLock
  Merge with /home/shaggy/git/linus-clean/

David Meybohm:
  preempt race in getppid

David S. Miller:
  [TG3]: Save initial PCI state before registering the netdevice.
  [NETLINK]: Allocate and kill some netlink numbers.
  [SPARC]: envctrl: ERR_PTR() --> PTR_ERR()
  [SUNRPC]: Fix nsec --> usec conversion.
  [SPARC64]: Fix 2 bugs in cpufreq drivers.
  [TG3]: Update driver version and reldate.
  [SPARC64]: Move kernel unaligned trap handlers into assembler file.
  [TCP]: Unconditionally clear TCP_NAGLE_PUSH in skb_entail().
  [TCP]: Document non-trivial locking path in tcp_v{4,6}_get_port().
  [ROSE]: Fix missing unlocks in rose_route_frame()
  [ROSE]: Fix typo in rose_route_frame() locking fix.

David Woodhouse:
  Stop snd-powermac oopsing on non-pmac hardware.

Deepak Saxena:
  Fix IXP4xx CLOCK_TICK_RATE

Dimitry Andric:
  [ARM] 2850/1: Remove duplicate UART I/O mapping from s3c2410_iodesc

Dmitry Yusupov:
  [TCP]: Do TSO deferral even if tail SKB can go out now.

Eric W. Biederman:
  x86_64: Fix apicid versus cpu# confusion.

Evgeniy Polyakov:
  w1: more debug level decrease.

Grant Coady:
  ide: fix PCI_DEVIEC_ID_APPLE_UNI_N_ATA spelling

Greg Edwards:
  [IA64] Refresh arch/ia64/configs/sn2_defconfig.

Greg Kroah-Hartman:
  Fix manual binding infinite loop

Harald Welte:
  don't try to do any NAT on untracked connections

Heikki Orsila:
  [IPV4]: Debug cleanup

Herbert Xu:
  [IPSEC]: Restrict socket policy loading to CAP_NET_ADMIN.
  [TCP]: Adjust {p,f}ackets_out correctly in tcp_retransmit_skb()
  [TCP]: Fix bug #5070: kernel BUG at net/ipv4/tcp_output.c:864
  [TCP]: Fix bug #5070: kernel BUG at net/ipv4/tcp_output.c:864
  [IPCOMP]: Fix false smp_processor_id warning
  [RPC]: Kill bogus kmap in krb5

Ian Wienand:
  [IA64] Simulator bootloader fails with gcc 4

Ingo Molnar:
  [NETPOLL]: pre-fill skb pool

Ivan Kokshaysky:
  VIA VT8235 PCI quirk

James Bottomley:
  [SCSI] Bug 4940 Repeatable Kernel Panic on Adaptec 2015S I20 device on bootup
  remove name length check in a workqueue

James Morris:
  Update contact info for James Morris

James.Smart@Emulex.Com:
  [SCSI] fix target scanning oops with fc transport class

Jan Kara:
  Fix error handling in reiserfs
  reiserfs+acl+quota deadlock fix

Jaroslav Kysela:
  broken error path in drivers/pnp/card.c

Jay Vosburgh:
  [TOKENRING]: Use interrupt-safe locking with rif_lock.

Jeff Dike:
  uml: fix a crash under screen

Jeff Garzik:
  libata: release prep (bump versions, etc.)

Jeff Moyer:
  [NETPOLL]: rx_flags bugfix
  [NETPOLL]: deadlock bugfix

Jiri Slaby:
  PCI: update documentation

Johannes Stezenbach:
  Fix DVB URL

John Hawkes:
  fix for ia64 sched-domains code

John McCutchan:
  fsnotify_name/inoderemove
  fsnotify-cleanups
  inotify: add MOVE_SELF event

John W. Linville:
  i810_audio: fix release_region misordering in error exit from i810_probe

Juha-Matti Tapio:
  ide: fix the BLK_DEV_IDEDMA_PCI dependency for drivers/ide/ppc/pmac.c

Keith Owens:
  [IA64] Initialize some spinlocks

Ken Chen:
  [IA64] fix nohalt boot option

Kenji Kaneshige:
  [IA64] fix iosapic_remove build error for !HOTPLUG

Kristen Accardi:
  PCI: 6700/6702PXH quirk
  PCI Hotplug: new contact info

Kumar Gala:
  ppc32: Fix MPC834x USB memory map offsets
  cpm_uart: Fix dpram allocation and non-console uarts
  cpm_uart: needs some love to compile with GCC4.0.1

Len Brown:
  Merge ../to-linus-stable/
  Merge ../from-linus

lepton:
  usbnet oops fix

Linus Torvalds:
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/.../davem/net-2.6
  Revert "PCI: restore BAR values..."
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/.../jejb/scsi-rc-fixes-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Merge master.kernel.org:/home/rmk/linux-2.6-arm-smp
  Merge head 'upstream-fixes' of master.kernel.org:/.../jgarzik/libata-dev
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Fix up mmap of /dev/kmem
  Revert "dc395x: Fix support for highmem"
  Revert PCIBIOS_MIN_IO changes for 2.6.13
  um: fix __pa/__va macro expansion problem
  Merge master.kernel.org:/.../aia21/ntfs-2.6
  Merge master.kernel.org:/.../lenb/to-linus
  Merge head 'for-linus' of master.kernel.org:/.../shaggy/jfs-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  Revert unnecessary zlib_inflate/inftrees.c fix
  Merge head 'release' of master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../aia21/ntfs-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge head 'upstream-fixes' of master.kernel.org:/.../jgarzik/netdev-2.6
  Merge master.kernel.org:/.../bart/ide-2.6
  Fix nasty ncpfs symlink handling bug.
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  befs: fix up missed follow_link declaration change
  Don't allow normal users to set idle IO priority
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge head 'upstream-fixes' of master.kernel.org:/.../jgarzik/libata-dev
  Merge head 'upstream-fixes' of master.kernel.org:/.../jgarzik/misc-2.6
  Linux v2.6.13-rc7

Luming Yu:
  [ACPI] re-enable platform-specific hotkey drivers by default

Maneesh Soni:
  Driver core: potentially fix use after free in class_device_attr_show

Markus Lidel:
  i2o: remove new configuration API
  I2O: added pci_request_regions() before using the controller

Matt Gillette:
  ide: add support for Netcell Revolution to pci-ide generic driver

Matt Mackall:
  [NETPOLL]: e1000 netpoll tweak
  [NETPOLL]: netpoll_send_skb simplify
  [NETPOLL]: add retry timeout
  [NETPOLL]: fix initialization/NAPI race
  [NETPOLL]: remove unused variable
  Make RLIMIT_NICE ranges consistent with getpriority(2)

Matt Porter:
  ppc32: fix ppc4xx stb03xxx dma build
  ppc32: Fix PPC440SP SRAM controller DCRs

Michael Chan:
  [TG3]: Fix SerDes detection

Michael Iatrou:
  disable debug info in radeonfb old driver

Michael Krufky:
  dvb: lgdt330x frontend: some bug fixes & add lgdt3303 support
  dvb: lgdt330x frontend: trivial text cleanups
  DVB: lgdt330x frontend: some bug fixes & add lgdt3303 support

Narendra Sankar:
  serverworks: add support for new southbridge IDE

NeilBrown:
  md: make sure mddev->bitmap_offset gets cleared between array instantiations.
  md: make sure resync gets started when array starts.

Nicolas Pitre:
  ARM: 2846/1: proper handling of CKEN for pxafb

Olaf Hering:
  x86_64: add MODULE_ALIAS for aes

Patrick McHardy:
  [IPV6]: Fix raw socket hardware checksum failures
  [IPV6]: Fix SKB leak in ip6_input_finish()
  [IPV6]: Fix raw socket hardware checksum failures
  [IPV6]: Fix SKB leak in ip6_input_finish()
  [IPV4]: Fix DST leak in icmp_push_reply()
  [NETFILTER]: Fix ECN target TCP marking
  [NETFILTER]: Fix HW checksum handling in ECN target
  [NETFILTER]: Fix HW checksum handling in TCPMSS target
  [NETFILTER]: Fix HW checksum handling in ip_queue/ip6_queue

Paul E. McKenney:
  [DECNET]: Fix RCU race condition in dn_neigh_construct().

Paul Jackson:
  cpuset release ABBA deadlock fix
  cpu_exclusive sched domains on partial nodes temp fix

Paul Mackerras:
  ppc64: update defconfigs

Paul Mundt:
  sh: Make _syscall6() do the right thing.

Pete Zaitcev:
  USB: usbmon: Copyrights and a typo

Peter Chubb:
  [IA64] Updated zx1 defconfig
  [IA64] Fix simulator boot (for real this time).

Pierre Ossman:
  wbsd version bump
  8139cp - redetect link after suspend

Ping Cheng:
  USB: fix usb wacom tablet driver bug

Prarit Bhargava:
  [IA64]: SN fix bus->sysdata pointer and memory cleanups

Ralf Baechle:
  Build fix for the Sibyte I2C driver
  IOC3 fixes
  [NET]: Fix comment in loopback driver.
  [NET]: Fix socket bitop damage
  [AX25]: UID fixes

Ralf Baechle DL5RB:
  6pack persistence fix

Richard Purdie:
  ARM: 2851/1: Fix NWFPE extended precision exception handling

Robert Love:
  [ARM] Add syscall stubs for inotify and ioprio system calls
  inotify: fix idr_get_new_above usage
  SH: inotify and ioprio syscalls
  SH64: inotify and ioprio syscalls

Russell King:
  ARM: Make sa1100fb_display_dma_period() an inline function
  [ARM SMP] Only enable V6K instructions on V6 MP core CPUs
  [ARM SMP] Clear the exclusive monitor on ARMv6 CPUs on context switch
  [ARM] Use #defined constants for manipulating v6 hardware PTE bits
  [ARM] Control v6 'global' bit via Linux PTE entries
  [ARM] Remove extraneous whitespace introduced in previous ARMv6 patch

Salyzyn, Mark:
  [SCSI] dpt_i2o pci_request_regions fix

Sean Lee:
  [ARM] 2852/1: Correct the mistake in arch/arm/mm/Kconfig file

stephane.eranian@hp.com:
  [IA64] fix perfmon context load

Stephen Rothwell:
  iSeries build with newer assemblers and compilers

Steve Dickson:
  NFSv4: unbalanced BKL in nfs_atomic_lookup()

Steve French:
  CIFS: Fix missing entries in search results
  CIFS: Fix path name conversion for long filenames

Steven Rostedt:
  nfsd to unlock kernel before exiting
  Mobil Pentium 4 HT and the NMI

Steven Whitehouse:
  [DECNET]: Use sk_stream_error function rather than DECnet's own

Sylvain Meyer:
  intelfb: Do not ioremap entire graphics aperture

Tejun Heo:
  sata: fix sata_sx4 dma_prep to not use sg->length
  libata: fix EH-related lockup by properly cleaning EH command list

Thomas Graf:
  [PKT_SCHED]: Fix missing qdisc_destroy() in qdisc_create_dflt()

Tony Luck:
  pull perfmon context load into release tree
  Auto-update from upstream
  Auto-update from upstream
  [IA64] Updated tiger defconfig
  [IA64] remove unused function __ia64_get_io_port_base
  Auto-update from upstream
  Auto-update from upstream
  Pull prarit-bus-sysdata into release branch
  [IA64] backout incorrect fix for simulator boot issue

Trond Myklebust:
  NFS: Ensure ACL xdr code doesn't overflow.
  NFS: Ensure we always update inode->i_mode when doing O_EXCL creates

Vlad Yasevich:
  [SCTP]: Add SENTINEL to SCTP MIB stats

Wim Van Sebroeck:
  i8xx_tco.c: arm watchdog only when started

Zachary Amsden:
  i386 / desc_empty macro is incorrect

Zwane Mwaikambo:
  Update email addresses for Zwane

--- diffstat ---

 CREDITS                                        |    7 
 Documentation/acpi-hotkey.txt                  |    3 
 Documentation/arm/Samsung-S3C24XX/USB-Host.txt |   93 ++
 Documentation/kernel-parameters.txt            |    5 
 Documentation/pci.txt                          |   14 
 MAINTAINERS                                    |   22 -
 Makefile                                       |    2 
 arch/alpha/Kconfig                             |    2 
 arch/alpha/kernel/smp.c                        |    6 
 arch/alpha/oprofile/common.c                   |    6 
 arch/arm/Kconfig                               |    2 
 arch/arm/kernel/calls.S                        |    6 
 arch/arm/kernel/entry-armv.S                   |    7 
 arch/arm/kernel/traps.c                        |    2 
 arch/arm/lib/bitops.h                          |    4 
 arch/arm/mach-s3c2410/s3c2410.c                |    4 
 arch/arm/mach-s3c2410/usb-simtec.c             |   18 
 arch/arm/mm/Kconfig                            |    2 
 arch/arm/mm/mm-armv.c                          |   17 
 arch/arm/mm/proc-v6.S                          |   24 -
 arch/arm/nwfpe/fpopcode.h                      |    6 
 arch/arm/nwfpe/softfloat.c                     |   34 -
 arch/i386/kernel/apic.c                        |    4 
 arch/i386/kernel/nmi.c                         |    4 
 arch/i386/kernel/traps.c                       |   10 
 arch/ia64/Kconfig                              |   11 
 arch/ia64/configs/sn2_defconfig                |  262 ++++--
 arch/ia64/configs/tiger_defconfig              |  149 ++--
 arch/ia64/configs/zx1_defconfig                |  224 ++---
 arch/ia64/hp/sim/boot/boot_head.S              |    2 
 arch/ia64/kernel/domain.c                      |    2 
 arch/ia64/kernel/perfmon.c                     |    1 
 arch/ia64/kernel/process.c                     |    2 
 arch/ia64/kernel/salinfo.c                     |    3 
 arch/ia64/sn/kernel/io_init.c                  |   19 
 arch/m32r/Kconfig                              |    3 
 arch/m32r/Kconfig.debug                        |    2 
 arch/m32r/kernel/setup_m32700ut.c              |    4 
 arch/m32r/kernel/setup_opsput.c                |    4 
 arch/m32r/kernel/smpboot.c                     |    1 
 arch/m32r/lib/csum_partial_copy.c              |    1 
 arch/m32r/mm/discontig.c                       |    2 
 arch/ppc/Kconfig                               |    5 
 arch/ppc/platforms/4xx/Kconfig                 |   14 
 arch/ppc/syslib/mpc83xx_devices.c              |    8 
 arch/ppc/syslib/ppc4xx_dma.c                   |   10 
 arch/ppc64/configs/bpa_defconfig               |  987 ++++++++++++++++++++++++
 arch/ppc64/configs/g5_defconfig                |   12 
 arch/ppc64/configs/iSeries_defconfig           |   14 
 arch/ppc64/configs/maple_defconfig             |    9 
 arch/ppc64/configs/pSeries_defconfig           |   14 
 arch/ppc64/defconfig                           |   16 
 arch/ppc64/kernel/LparData.c                   |   79 --
 arch/ppc64/kernel/Makefile                     |    5 
 arch/ppc64/kernel/head.S                       |    6 
 arch/ppc64/kernel/iommu.c                      |    7 
 arch/ppc64/kernel/lparmap.c                    |   31 +
 arch/ppc64/kernel/prom_init.c                  |    2 
 arch/s390/kernel/cpcmd.c                       |    8 
 arch/sh/kernel/entry.S                         |    5 
 arch/sh64/kernel/syscalls.S                    |    5 
 arch/sparc/kernel/sparc_ksyms.c                |    5 
 arch/sparc64/kernel/Makefile                   |    2 
 arch/sparc64/kernel/pci.c                      |    6 
 arch/sparc64/kernel/traps.c                    |    3 
 arch/sparc64/kernel/una_asm.S                  |  153 ++++
 arch/sparc64/kernel/unaligned.c                |  261 +-----
 arch/sparc64/kernel/us2e_cpufreq.c             |   36 +
 arch/sparc64/kernel/us3_cpufreq.c              |   29 +
 arch/sparc64/solaris/socket.c                  |  191 +++--
 arch/um/kernel/skas/process.c                  |    6 
 arch/um/os-Linux/elf_aux.c                     |    1 
 arch/x86_64/crypto/aes.c                       |    1 
 arch/x86_64/kernel/smpboot.c                   |   17 
 arch/x86_64/mm/fault.c                         |    4 
 arch/x86_64/pci/k8-bus.c                       |   13 
 drivers/acorn/block/fd1772.c                   |    3 
 drivers/acpi/motherboard.c                     |    2 
 drivers/acpi/osl.c                             |    6 
 drivers/base/bus.c                             |    4 
 drivers/base/class.c                           |   10 
 drivers/char/Kconfig                           |    8 
 drivers/char/mem.c                             |   12 
 drivers/char/watchdog/i8xx_tco.c               |   41 +
 drivers/i2c/busses/i2c-sibyte.c                |    4 
 drivers/ide/Kconfig                            |    1 
 drivers/ide/ide-disk.c                         |    2 
 drivers/ide/ide-floppy.c                       |    2 
 drivers/ide/ide-probe.c                        |    9 
 drivers/ide/pci/generic.c                      |    7 
 drivers/ide/pci/serverworks.c                  |   23 +
 drivers/ide/ppc/pmac.c                         |    2 
 drivers/ide/setup-pci.c                        |    1 
 drivers/infiniband/Kconfig                     |    1 
 drivers/input/gameport/ns558.c                 |    4 
 drivers/isdn/hisax/Kconfig                     |    1 
 drivers/isdn/icn/icn.c                         |    5 
 drivers/macintosh/Kconfig                      |    2 
 drivers/md/md.c                                |   10 
 drivers/media/dvb/frontends/Kconfig            |    2 
 drivers/media/dvb/frontends/dvb-pll.c          |   16 
 drivers/media/dvb/frontends/dvb-pll.h          |    1 
 drivers/media/dvb/frontends/lgdt330x.c         |  514 +++++++++---
 drivers/media/dvb/frontends/lgdt330x.h         |   16 
 drivers/media/dvb/frontends/lgdt330x_priv.h    |    8 
 drivers/media/video/Kconfig                    |    2 
 drivers/media/video/cx88/cx88-dvb.c            |   26 -
 drivers/message/i2o/Kconfig                    |    3 
 drivers/message/i2o/config-osm.c               |  494 ------------
 drivers/message/i2o/pci.c                      |   10 
 drivers/mmc/wbsd.c                             |    2 
 drivers/net/8139cp.c                           |    7 
 drivers/net/Kconfig                            |    4 
 drivers/net/dm9000.c                           |   52 +
 drivers/net/e1000/e1000_main.c                 |    1 
 drivers/net/hamradio/6pack.c                   |   20 
 drivers/net/ibm_emac/ibm_emac_core.c           |    3 
 drivers/net/ioc3-eth.c                         |    8 
 drivers/net/loopback.c                         |    2 
 drivers/net/tg3.c                              |   18 
 drivers/net/tokenring/Kconfig                  |    2 
 drivers/net/wireless/Kconfig                   |    2 
 drivers/parport/Kconfig                        |    2 
 drivers/pci/hotplug/pciehp.h                   |    2 
 drivers/pci/hotplug/pciehp_core.c              |    2 
 drivers/pci/hotplug/pciehp_ctrl.c              |    2 
 drivers/pci/hotplug/pciehp_hpc.c               |    2 
 drivers/pci/hotplug/pciehp_pci.c               |    2 
 drivers/pci/hotplug/pciehprm.h                 |    2 
 drivers/pci/hotplug/pciehprm_acpi.c            |    2 
 drivers/pci/hotplug/pciehprm_nonacpi.c         |    2 
 drivers/pci/hotplug/pciehprm_nonacpi.h         |    2 
 drivers/pci/hotplug/shpchp.h                   |    2 
 drivers/pci/hotplug/shpchp_core.c              |    2 
 drivers/pci/hotplug/shpchp_ctrl.c              |    2 
 drivers/pci/hotplug/shpchp_hpc.c               |    2 
 drivers/pci/hotplug/shpchp_pci.c               |    2 
 drivers/pci/hotplug/shpchprm.h                 |    2 
 drivers/pci/hotplug/shpchprm_acpi.c            |    2 
 drivers/pci/hotplug/shpchprm_legacy.c          |    2 
 drivers/pci/hotplug/shpchprm_legacy.h          |    2 
 drivers/pci/hotplug/shpchprm_nonacpi.c         |    2 
 drivers/pci/hotplug/shpchprm_nonacpi.h         |    2 
 drivers/pci/msi.c                              |    5 
 drivers/pci/pci.c                              |   59 -
 drivers/pci/pci.h                              |    6 
 drivers/pci/quirks.c                           |   40 +
 drivers/pci/setup-res.c                        |    2 
 drivers/pcmcia/pcmcia_resource.c               |    1 
 drivers/pnp/card.c                             |    2 
 drivers/s390/cio/qdio.c                        |    2 
 drivers/s390/crypto/z90crypt.h                 |    9 
 drivers/s390/net/qeth_main.c                   |   24 -
 drivers/s390/net/qeth_proc.c                   |  126 ++-
 drivers/sbus/char/bbc_envctrl.c                |   39 -
 drivers/sbus/char/envctrl.c                    |   45 -
 drivers/scsi/Kconfig                           |    6 
 drivers/scsi/ahci.c                            |    1 
 drivers/scsi/arm/Kconfig                       |    2 
 drivers/scsi/ata_piix.c                        |    2 
 drivers/scsi/dc395x.c                          |   48 -
 drivers/scsi/dpt_i2o.c                         |    9 
 drivers/scsi/libata-core.c                     |   25 -
 drivers/scsi/libata-scsi.c                     |    1 
 drivers/scsi/libata.h                          |    2 
 drivers/scsi/sata_promise.c                    |    2 
 drivers/scsi/sata_sx4.c                        |    2 
 drivers/scsi/scsi_scan.c                       |   16 
 drivers/scsi/scsi_transport_fc.c               |   19 
 drivers/serial/Kconfig                         |    4 
 drivers/serial/cpm_uart/cpm_uart.h             |   10 
 drivers/serial/cpm_uart/cpm_uart_core.c        |  132 ++-
 drivers/serial/cpm_uart/cpm_uart_cpm1.c        |   53 +
 drivers/serial/m32r_sio.c                      |    2 
 drivers/serial/sn_console.c                    |    1 
 drivers/usb/input/wacom.c                      |   21 -
 drivers/usb/mon/mon_main.c                     |    4 
 drivers/usb/mon/usb_mon.h                      |    2 
 drivers/usb/net/usbnet.c                       |    2 
 drivers/usb/net/zd1201.c                       |    3 
 drivers/video/console/Kconfig                  |    2 
 drivers/video/fbmem.c                          |    4 
 drivers/video/intelfb/intelfbdrv.c             |   50 +
 drivers/video/modedb.c                         |    5 
 drivers/video/nvidia/nvidia.c                  |    7 
 drivers/video/pxafb.c                          |    8 
 drivers/video/radeonfb.c                       |    2 
 drivers/video/sa1100fb.c                       |    2 
 drivers/w1/w1.c                                |    2 
 fs/afs/mntpt.c                                 |    8 
 fs/autofs/symlink.c                            |    5 
 fs/autofs4/symlink.c                           |    4 
 fs/befs/linuxvfs.c                             |   10 
 fs/cifs/CHANGES                                |    6 
 fs/cifs/cifsfs.h                               |    4 
 fs/cifs/cifssmb.c                              |    3 
 fs/cifs/link.c                                 |    6 
 fs/cifs/misc.c                                 |    1 
 fs/dcache.c                                    |    7 
 fs/devfs/base.c                                |    4 
 fs/ext2/symlink.c                              |    4 
 fs/ext3/symlink.c                              |    4 
 fs/freevxfs/vxfs_immed.c                       |    6 
 fs/inotify.c                                   |    2 
 fs/ioprio.c                                    |    2 
 fs/jffs2/symlink.c                             |   16 
 fs/jfs/inode.c                                 |    4 
 fs/jfs/jfs_logmgr.c                            |   36 -
 fs/jfs/jfs_logmgr.h                            |    2 
 fs/jfs/jfs_txnmgr.c                            |   12 
 fs/jfs/super.c                                 |    4 
 fs/jfs/symlink.c                               |    4 
 fs/namei.c                                     |   46 +
 fs/nfs/dir.c                                   |   28 -
 fs/nfs/file.c                                  |    5 
 fs/nfs/inode.c                                 |  197 +++--
 fs/nfs/nfs3acl.c                               |    4 
 fs/nfs/nfs3proc.c                              |    4 
 fs/nfs/nfs4proc.c                              |   10 
 fs/nfs/proc.c                                  |    2 
 fs/nfs/read.c                                  |    8 
 fs/nfs/symlink.c                               |   37 -
 fs/nfs_common/nfsacl.c                         |    1 
 fs/nfsd/nfssvc.c                               |    1 
 fs/ntfs/ChangeLog                              |    3 
 fs/ntfs/aops.c                                 |    1 
 fs/ntfs/mft.c                                  |    2 
 fs/proc/base.c                                 |    8 
 fs/proc/generic.c                              |    4 
 fs/reiserfs/inode.c                            |    2 
 fs/reiserfs/namei.c                            |    3 
 fs/smbfs/symlink.c                             |    6 
 fs/sysfs/symlink.c                             |    6 
 fs/sysv/symlink.c                              |    4 
 fs/ufs/symlink.c                               |    4 
 fs/xfs/linux-2.6/xfs_iops.c                    |   10 
 include/asm-alpha/system.h                     |   29 -
 include/asm-arm/arch-ixp4xx/timex.h            |    6 
 include/asm-arm/arch-s3c2410/usb-control.h     |    3 
 include/asm-arm/bug.h                          |    2 
 include/asm-arm/cpu-multi32.h                  |    2 
 include/asm-arm/cpu-single.h                   |    2 
 include/asm-arm/pgtable.h                      |   14 
 include/asm-arm/unistd.h                       |    5 
 include/asm-i386/pci.h                         |    4 
 include/asm-i386/processor.h                   |    2 
 include/asm-ia64/io.h                          |    8 
 include/asm-ia64/iosapic.h                     |    4 
 include/asm-m32r/smp.h                         |    2 
 include/asm-ppc/ibm44x.h                       |    4 
 include/asm-ppc/ppc4xx_dma.h                   |    2 
 include/asm-ppc/time.h                         |    2 
 include/asm-ppc64/iSeries/LparMap.h            |    9 
 include/asm-s390/uaccess.h                     |   21 -
 include/asm-sh/unistd.h                        |   10 
 include/asm-sh64/unistd.h                      |    7 
 include/asm-sparc64/thread_info.h              |    5 
 include/asm-um/page.h                          |    4 
 include/asm-x86_64/pci.h                       |    4 
 include/asm-x86_64/processor.h                 |    2 
 include/linux/fs.h                             |    8 
 include/linux/fsnotify.h                       |   28 -
 include/linux/ide.h                            |    6 
 include/linux/inotify.h                        |    4 
 include/linux/netlink.h                        |    4 
 include/linux/netpoll.h                        |   20 
 include/linux/nfs_fs.h                         |   42 +
 include/linux/pci.h                            |    6 
 include/linux/pci_ids.h                        |   11 
 include/linux/skbuff.h                         |    2 
 include/linux/sunrpc/xdr.h                     |    1 
 include/net/ax25.h                             |   18 
 include/net/sock.h                             |    5 
 include/scsi/scsi_transport.h                  |    8 
 include/sound/core.h                           |    2 
 kernel/cpuset.c                                |   85 ++
 kernel/sched.c                                 |    4 
 kernel/signal.c                                |    2 
 kernel/timer.c                                 |    2 
 kernel/workqueue.c                             |    2 
 lib/vsprintf.c                                 |    5 
 lib/zlib_inflate/inftrees.c                    |    2 
 mm/shmem.c                                     |   17 
 net/802/tr.c                                   |   22 -
 net/ax25/af_ax25.c                             |   27 -
 net/ax25/ax25_route.c                          |   12 
 net/ax25/ax25_uid.c                            |   83 +-
 net/compat.c                                   |    9 
 net/core/dev.c                                 |    9 
 net/core/netpoll.c                             |   63 +-
 net/decnet/af_decnet.c                         |   11 
 net/decnet/dn_neigh.c                          |    2 
 net/ipv4/icmp.c                                |   15 
 net/ipv4/inetpeer.c                            |   11 
 net/ipv4/ip_fragment.c                         |    8 
 net/ipv4/ip_sockglue.c                         |    3 
 net/ipv4/ipcomp.c                              |    2 
 net/ipv4/netfilter/ip_nat_standalone.c         |    4 
 net/ipv4/netfilter/ip_queue.c                  |    7 
 net/ipv4/netfilter/ipt_ECN.c                   |   17 
 net/ipv4/netfilter/ipt_TCPMSS.c                |    7 
 net/ipv4/tcp.c                                 |    2 
 net/ipv4/tcp_ipv4.c                            |   23 -
 net/ipv4/tcp_output.c                          |   57 +
 net/ipv4/udp.c                                 |   34 -
 net/ipv6/ip6_input.c                           |    9 
 net/ipv6/ipcomp6.c                             |    2 
 net/ipv6/ipv6_sockglue.c                       |    3 
 net/ipv6/netfilter/ip6_queue.c                 |    7 
 net/ipv6/raw.c                                 |    2 
 net/ipv6/tcp_ipv6.c                            |    9 
 net/netrom/af_netrom.c                         |   31 -
 net/rose/af_rose.c                             |   27 -
 net/rose/rose_route.c                          |    6 
 net/sched/sch_generic.c                        |    1 
 net/sctp/proc.c                                |    1 
 net/sunrpc/auth_gss/gss_krb5_crypto.c          |    2 
 net/sunrpc/svcsock.c                           |    2 
 net/sunrpc/xdr.c                               |    1 
 scripts/mod/modpost.c                          |    9 
 sound/Kconfig                                  |    2 
 sound/core/Makefile                            |    2 
 sound/core/sound.c                             |    2 
 sound/isa/Kconfig                              |    2 
 sound/oss/Kconfig                              |   16 
 sound/oss/Makefile                             |    2 
 sound/oss/i810_audio.c                         |    4 
 sound/oss/vidc.h                               |    4 
 sound/pci/Kconfig                              |    2 
 sound/ppc/pmac.c                               |    3 
 330 files changed, 4042 insertions(+), 2711 deletions(-)
