Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVGMFFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVGMFFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVGMFFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:05:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262560AbVGMFFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:05:05 -0400
Date: Tue, 12 Jul 2005 22:05:00 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.13-rc3
Message-ID: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes,
 it's _really_ -rc3 this time, never mind the confusion with the commit 
message last time (when the Makefile clearly said -rc2, but my over-eager 
fingers had typed in a commit message saying -rc3).

There's a bit more changes here than I would like, but I'm putting my foot 
down now. Not only are a lot of people going to be gone next week for LKS 
and OLS, but we've gotten enough stuff for 2.6.13, and we need to calm 
down.

Admittedly the diff looks a bit bigger than it really conceptually is, 
partly due to the hwmon drivers moving around, partly due to re-indenting 
reiserfs. No real changes, but huge diffs in both cases.

I think the shortlog speaks for itself.

			Linus

----
Adrian Bunk:
  Documentation/kernel-parameters.txt: fix a typo
  IBM_ASM Kconfig corrections
  [ACPI] fix potential NULL dereference in acpi/video.c
  I2C: SENSORS_ATXP1 must select I2C_SENSOR
  dvb: ttusb-dec: kfree cleanup
  FRV: Add defconfig
  [CRYPTO] Make crypto_alg_lookup static

Alasdair G Kergon:
  device-mapper snapshots: Handle origin extension
  device-mapper: Fix dm_swap_table error cases
  device-mapper multipath: Fix pg initialisation races
  device-mapper multipath: Avoid possible suspension deadlock
  device-mapper multipath: Flush workqueue when destroying
  device-mapper multipath: Barriers not supported
  device-mapper: dm-raid1: Limit bios to size of mirror region

Albert Herranz:
  kexec-ppc: fix for ksysfs crash_notes

Alexey Dobriyan:
  [NET]: __be'ify *_type_trans()
  [SCTP]: __nocast annotations
  propagate __nocast annotations

Alexey Kuznetsov:
  [IPV4]: Apply sysctl_icmp_echo_ignore_broadcasts to ICMP_TIMESTAMP as well.

Alexey Starikovskiy:
  [ACPI] ACPI poweroff fix
  [ACPI] Allow simultaneous Fixed Feature and Control Method buttons

Allan Stirling:
  dvb: Twinhan DST: frontend polarization fix

Andreas Gruenbacher:
  ext3 xattr: Don't write to the in-inode xattr space of reserved inodes
  acl kconfig cleanup

Andreas Oberritter:
  dvb: add Pluto2 driver

Andreas Steinmetz:
  [CRYPTO] Add x86_64 asm AES

Andrew de Quincey:
  dvb: ttpci: support for new TT DVB-T-CI
  dvb: ttpci: add support for Technotrend/Hauppauge DVB-S SE
  dvb: frontend: remove unused I2C ids
  dvb: core: add workaround for tuning problem

Andrew Hodgson:
  dvb: usb: A800 rc and timeout fixes

Andrew Morton:
  tlb.h warning fix
  alpha: pgprot_uncached() comment
  x86_64: section alignment fix
  name_to_dev_t warning fix
  [SPARC64]: Fix SMP build failure.
  USB: net2280 warning fix
  USB: khubd: use kthread API
  [ACPI] fix debug-mode build warning in acpi/hotkey.c
  [ACPI] fix build warning
  alpha(): pgprot_noncached
  i2o: config-osm build fix
  iounmap debugging

Andrew Victor:
  [JFFS2] Use a single config option for write buffer support
  [JFFS2] Add support for JFFS2-on-Dataflash devices.
  [JFFS2] Core changes required to support JFFS2-on-Dataflash devices.

Anssi Hannula:
  dvb: add missing release_firmware() calls

Anton Blanchard:
  ppc64: silence perfmon exception warnings
  ppc64: fix compile warning
  ppc64: idle fixups
  ppc64: pSeries idle fixups
  ppc64: iSeries idle fixups
  ppc64: remove duplicate syscall reservation
  ppc64: add ioprio syscalls
  ppc64: sys_ppc32.c cleanups
  move ioprio syscalls into syscalls.h
  ppc64: Turn runlatch on in exception entry
  ppc64: Fix runlatch code to work on pseries machines
  ppc64: use c99 initialisers in cputable code
  mm: quieten OOM killer noise

Arnd Bergmann:
  xtensa: remove old syscalls

Artem B. Bityuckiy:
  bugfix: two read_inode() calls without clear_inode() call between
  Merge with rsync://fileserver/linux
  [JFFS2] Simplify the tree insert code.
  [JFFS2] Kill GC thread before cleanup
  [JFFS2] Suppress annoying debug messages
  [JFFS2] Fix NOR only compile
  [JFFS2] Fix race in garbage collector
  [JFFS2] Add KERN_DEBUG level to printks
  [JFFS2] Fix race problems with wbuf.
  [MTD] NAND: Use arrays of needed size instead of constant-sized.
  [JFFS2] Prevent deadlock when flushing write buffer
  [JFFS2] Forbid to free inode_cache objects if its nlink isn't zero.
  [JFFS2] Improve garbage collector block selection
  [MTD] NAND nandsim: Use NAND_SKIP_BBT option
  [JFFS2] Use function to manipulate superblock dirty flag
  [JFFS2] Add symlink caching support.
  [JFFS2] Fix NOR specific scan BUG 
  [MTD] Fix unregister_mtd_user() public function documentation.
  [JFFS2] Fix node lookup
  [MTD] NAND: Fix bad block table scan for small page devices
  [MTD] NAND: Read only OOB bytes during bad block scan
  [MTD] NAND: Allow operation without bad block table

Ashok Raj:
  [ACPI] Evaluate CPEI Processor Override flag

Ben Collins:
  Sync up ieee-1394

Ben Dooks:
  [MTD] NAND s3c2410: Add missing NULL pointer check
  [MTD] NAND: s3c24xx updates
  [MTD] NAND s3c2410: Simplify command handling
  [MTD] plat-ram: removed extraneous debugging code
  [MTD] NAND: Fixed unused loop variable
  [MTD] Fixed signed 1bit bitfield
  [MTD] Sparse fixes
  [MTD] Update BAST driver configuration
  [MTD] Add SST 39VF1601 (MPF+) ID
  [MTD] Fixup probing logic for single 16bit devices
  [MTD] Platform RAM Driver
  [MTD] bast-flash partitions fixup

Benjamin Herrenschmidt:
  ppc64: Add new PHY to sungem

Benjamin LaHaise:
  uml: tlb flushing fix

Bernard Blackham:
  pm: fix u32 vs. pm_message_t confusion in cpufreq

Bob Picco:
  Documentation

bob.picco:
  [IA64] memory-less-nodes repost

Bodo Stroesser:
  uml: Proper clone support for skas0

Brian King:
  cdev: cdev_put oops

brian@murphy.dk:
  USB: fix usb reference count bug in cdc-acm driver
  USB: export usb_get_intf() and usb_put_intf()

Catalin Marinas:
  ARM: 2789/1: Enable access to both CP10 and CP11 on ARMv6

Chris Wright:
  Add MAINTAINERS entry for audit subsystem

Chris Zankel:
  xtensa: remove old syscalls

Christoph Lameter:
  mostly_read data section
  Fix broken kmalloc_node in rc1/rc2

Christophe Lucas:
  dvb: ttpci: kj printk fix
  dvb: saa7146: kj pci_module_init cleanup

Coywolf Qi Hunt:
  [MTD] mtdchar: Return the real error code when create_class() failed

Dag Arne Osvik:
  [CRYPTO] Add faster DES code from Dag Arne Osvik

Dan Brown:
  [MTD] DiskOnChip: Add some comments
  [MTD] DiskOnChip: Fix compile w/o CONFIG_MTD_PARTITIONS.
  [MTD] DiskOnChip: Prevent problems with existing filesystems
  [MTD] NAND: Fix reading of autoplaced OOB when there are multiple free sections.
  [MTD] DiskOnChip: Fix (?) free OOB array info.
  [MTD] NAND: Fix missing NULL pointer check
  [MTD] DiskOnChip: Scan the entire device for Media Headers.  

Dave Airlie:
  drm: fix stupid missing semicolon.
  drm: add 32/64 support for MGA/R128/i915
  drm: wrap config.h include in a ifdef KERNEL
  drm: misc cleanup
  drm: use kcalloc now that it is available..
  drm: ctx release can happen before dev->ctxlist is allocated
  drm: fix minor issues caused by core conversion
  Merge ../linux-2.6/
  drm: Add via unichrome support

Dave Jones:
  aacraid: swapped kmalloc args.
  Fix up non-NUMA breakage in mmzone.h
  Clean up numa defines in mmzone.h
  Fix bt87x.c build problem for real

David A. Marlin:
  [MTD] rtc_from4 error status check, disable virtual erase blocks
  [MTD] NAND Add optional ECC status check callback
  [MTD] NAND use symbols instead of literals
  [MTD] Renesas AG-AND device recovery
  [MTD] NAND workaround for AG-AND disturb issue. AG-AND recovery
  [MTD] NAND extended commands, badb block table autorefresh 

David Howells:
  Keys: Base keyring size on key pointer not key struct

David L Stevens:
  [IPV4]: fix IPv4 leave-group group matching
  [IPV4]: (INCLUDE,empty)/leave-group equivalence for full-state MSF APIs & errno fix
  [IPV4]: multicast API "join" issues
  [IPV4]: multicast API "join" issues
  [IPV4]: multicast API "join" issues

David S. Miller:
  [NETLINK]: Reserve NETLINK_NETFILTER.
  [SPARC64]: Add missing asm-sparc64/seccomp.h file.
  [SPARC64]: Add syscall auditing support.
  [SPARC64]: Pass regs and entry/exit boolean to syscall_trace()
  [SPARC64]: Add SECCOMP support.
  [SPARC64]: Kill ancient and unused SYSCALL_TRACING debugging code.
  [SPARC64]: Add __read_mostly support.
  [SPARC]: Add ioprio system call support.
  [SCTP]: Use struct list_head for chunk lists, not sk_buff_head.
  [IPV6]: Fix warning in ip6_mc_msfilter.
  [SPARC64]: Support CONFIG_HZ
  [NET]: Transform skb_queue_len() binary tests into skb_queue_empty()
  [SPARC64]: Typo in dtlb_backend.S, _PAGE_SZ4M --> _PAGE_SZ4MB

David Shaohua Li:
  [ACPI] quiet dmesg related to ACPI PM of PCI devices
  [ACPI] PNPACPI vs sound IRQ
  [ACPI] pci_set_power_state() now calls
  [ACPI] PCI can now get suspend state from firmware
  [ACPI] Bind ACPI and PCI devices
  [ACPI] Bind PCI devices with ACPI devices
  [ACPI] S3 Suspend to RAM: fix driver suspend/resume methods
  [ACPI] S3 Suspend to RAM: interrupt resume fix
  [ACPI] Suspend to RAM fix

David Vrabel:
  [MTD] Remove Elan-104NC

David Woodhouse:
  [MTD] Remove MODULE_DEVICE_TABLE() for ICHx flash driver
  [JFFS2] Remove compatibilty cruft for ancient kernels
  [JFFS2] Optimise jffs2_add_tn_to_list 
  [JFFS2] Fix inode allocation race
  [JFFS2] Prevent ino cache removal for inodes in use
  [JFFS2] Remove NAND dependencies for NOR FLASH

david-b@pacbell.net:
  USB: another cdc descriptor
  USB: fix ohci merge glitch
  USB: ohci-omap pm updates
  USB: omap_udc tweaks
  I2C: minor I2C doc cleanups
  I2C: minor TPS6501x cleanups

Deepak Saxena:
  ARM: 2796/1: Fix ARMv5[TEJ] check in MMU initalization
  ARM: 2792/1: IXP4xx iomap API implementation

Denis Vlasenko:
  I2C: Coding style cleanups to via686a

Dmitry Torokhov:
  [ACPI] Enable EC Burst Mode

Domen Puncer:
  [MTD] Kernel Janitor fixes.

Dominik Brodowski:
  yenta: allocate resource fixes
  yenta: same resources in same structs
  pcmcia: Documentation update
  yenta: fix parent resource determination
  pcmcia: fix pcmcia-cs compilation
  yenta: don't depend on CardBus
  pcmcia: update MAINTAINERS entry
  pcmcia: remove references to pcmcia/version.h
  pcmcia: reduce client_handle_t usage
  pcmcia: remove client_t usage
  pcmcia: move event handler
  pcmcia: deprecate ioctl

Dr. Werner Fink:
  dvb: ttpci: fix AUDUIO_CONTINUE ioctl

Duncan Sands:
  USB ATM: fix line resync logic
  USB ATM: robustify poll throttling
  USB ATM: line speed measured in Kb not Kib

Eddie C. Dost:
  [SPARC64]: Fix enable_dma() in asm-sparc64/parport.h
  [DVB]: Do not include <linux/irq.h> from drivers.
  [SPARC64]: Fix set_intr_affinity()
  [SPARC]: Fix "Eddie C. Dost" e-mail address

Eric W. Biedermann:
  [MTD] CFI-0002 - Improve error checking

Estelle Hammache:
  [JFFS2] Prevent deadlock during write buffer recovery
  [JFFS2] Code cleanup 
  [JFFS2] Fix refile of blocks due to write failure. 
  [JFFS2] Fix block refiling
  [JFFS2] Fix write buffer retry case

Evgeniy Polyakov:
  w1: fix CRC calculation on bigendian platforms.

Gavin Hamill:
  dvb: ttpci: add support for Hauppauge/TT DVB-C budget

Geert Uytterhoeven:
  mm/filemap_xip.c compilation fix

George Anzinger:
  kbuild: build TAGS problem with O=

Greg KH:
  Fix bt87x.c build problem

Greg Kroah-Hartman:
  USB: fix ftdi_sio compiler warnings
  USB: add bMaxPacketSize0 attribute to sysfs
  cleanup: remove unnecessary initializer on static pointers
  PCI: fix !CONFIG_HOTPLUG pci build problem

H. J. Lu:
  [IA64] Fix a typo in arch/ia64/kernel/entry.S

Hartmut Hackmann:
  dvb: frontend: tda1004x: support tda827x tuners
  dvb: frontend: bcm3510: fix firmware version check
  dvb: frontend: tda1004x update

Herbert Valerio Riedel:
  [MTD] FTL Fix missing pointer assignment

Herbert Xu:
  [CRYPTO] Remove unused iv field from context structure
  [CRYPTO] Update IV correctly for Padlock CBC encryption
  [CRYPTO] Handle unaligned iv from encrypt_iv/decrypt_iv
  [CRYPTO] Ensure cit_iv is aligned correctly
  [PADLOCK] Implement multi-block operations
  [PADLOCK] Move fast path work into aes_set_key and upper layer
  [CRYPTO] Add alignmask for low-level cipher implementations
  [CRYPTO] Add support for low-level multi-block operations
  [CRYPTO] Add plumbing for multi-block operations

Hirokazu Takata:
  m32r: framebuffer device support

Hugh Dickins:
  lower VM_DONTCOPY total_vm

Ian Abbott:
  USB ftdi_sio: remove redundant TIOCMBIS and TIOCMBIC code
  USB ftdi_sio: reduce device id table clutter

Ian Campbell:
  USB: gadget/ether build fixes.
  USB: gadget/ether fixes
  pcmcia: fix i82365 request_region double usage

Ian Kent:
  autofs4: mistake in debug print

Ingo Molnar:
  cond_resched(): fix bogus might_sleep() warning

Ivan Kokshaysky:
  yet another fix for setup-bus.c/x86 merge

Jack Steiner:
  [IA64] - Disable tiocx driver on non-SN systems

Jan Kara:
  ext2: fix mount options parting
  ext3: fix options parsing

Jan Veldeman:
  I2C: Documentation fix

Jarkko Lavinen:
  [MTD] NAND: Fix the broken dynamic array allocations

Jean Delvare:
  I2C: Move hwmon drivers (3/3)
  I2C: Move hwmon drivers (2/3)
  I2C: Move hwmon drivers (1/3)
  I2C: Clarify the usage of i2c-dev.h
  I2C: drop bogus eeprom comment
  I2C: m41t00: fix incorrect kfree
  I2C: max6875 Kconfig update
  I2C: max6875 documentation update
  I2C: New max6875 driver may corrupt EEPROMs
  I2C: Strip trailing whitespace from strings

Jeff Dike:
  uml: skas0 - separate kernel address space on stock hosts
  uml: kill some useless vmalloc tlb flushing

Jeff Mahoney:
  reiserfs: fix up case where indent misreads the code
  openfirmware: implement hotplug for macio devices
  openfirmware: add sysfs nodes for open firmware devices
  openfirmware: generate device table for userspace

Jesper Juhl:
  [NET]: Trivial spelling fix patch for net/Kconfig
  [CRYPTO] Add null short circuit to crypto_free_tfm
  [CRYPTO] Don't check for NULL before kfree()

Jesse Barnes:
  [ACPI] cleanup: delete !IA64_SGI_SN from acpi/Kconfig

Jesse Millan:
  put_compat_shminfo() warning fix

Joern Engel:
  [MTD] Fix commandline parser alignement
  [MTD] mtdram: Quick cleanup of the driver:
  [MTD] phram: Allow short reads.  
  [MTD] block2mtd: Remove copyright. Fix offset calculation
  [MTD] Use after free, found by the Coverity tool

Johannes Stezenbach:
  dvb: dst: printk -> dprintk
  dvb: dvb-usb: support Artect T1 with broken USB ids
  dvb: ttpci: cleanup indentation + whitespace
  dvb: ttpci: error handling fix
  dvb: ttpci: budget-av / tu1216 fix for QAM128
  dvb: ttpci: fix bug in timeout handling
  dvb: DVB update
  dvb: frontend: l64781: improve tuning
  dvb: remove obsolete skystar2 driver

Jonas Holmberg:
  [MTD] amd_flash: Fix chip ID clash

Josh Boyer:
  [MTD] slram driver cleanup

Julian Anastasov:
  [IPVS]: Add and reorder bh locks after moving to keventd.

Julian Scheel:
  dvb: fix kobject names (no slashes)

KAMBAROV, ZAUR:
  USB: coverity: (desc->bitmap)[] overrun fix
  coverity: sunrpc/xprt task null check
  coverity: fs/locks.c flp null check
  coverity: fix fbsysfs null pointer check

Keiichiro Tokunaga:
  [ACPI] hotplug Processor consideration in acpi_bus_add()
  [ACPI] update CONFIG_ACPI_CONTAINER Kconfig help

Keith Owens:
  [IA64] restore_sigcontext is not preempt safe
  [IA64] Make ia64 die() preempt safe

Kenji Kaneshige:
  [IA64] assign_irq_vector() should not panic

Kyungmin Park:
  [MTD] NAND: Early Manufacturer ID lookup

Len Brown:
  [ACPI] merge acpi-2.6.12 branch into latest Linux 2.6.13-rc...
  [ACPI] increase MAX_IO_APICS to 64 on i386
  [ACPI] fix merge error that broke CONFIG_ACPI_DEBUG=y build
  [ACPI] Deprecate /proc/acpi/sleep in favor of /sys/power/state
  [ACPI] gut acpi_pci_choose_state() to avoid conflict
  [ACPI] CONFIG_ACPI now depends on CONFIG_PM

Lennert Buytenhek:
  ARM: 2795/1: update ixp2000 defconfigs
  ARM: 2793/1: platform serial support for ixp2000
  [MTD] ixp2000: Remove port setting code

Linus Torvalds:
  Linux 2.6.13-rc3
  reiserfs: run scripts/Lindent on reiserfs code
  Merge master.kernel.org:/.../lenb/linux-2.6
  Merge master.kernel.org:/.../gregkh/i2c-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../davem/net-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/.../tglx/mtd-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:~rmk/linux-2.6-arm.git
  Merge head 'drm-fixes' of master.kernel.org:/.../airlied/drm-2.6
  Merge head 'drm-3264' of master.kernel.org:/.../airlied/drm-2.6
  Merge head 'drm-via' of master.kernel.org:/.../airlied/drm-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge master.kernel.org:/.../aegl/linux-2.6
  Merge master.kernel.org:/.../davem/sparc-2.6
  Merge rsync://rsync.kernel.org/.../davem/net-2.6
  Merge master.kernel.org:/home/rmk/linux-2.6-arm
  ieee1394: fix broken signed char assumption.

Luca Risolia:
  USB: SN9C10x driver updates

Luming Yu:
  [ACPI] EC GPE-disabled issue
  [ACPI] fix EC access width
  [ACPI] generic Hot Key support

Mac Michaels:
  dvb: frontend: add driver for LGDT3302

Maciej W. Rozycki:
  [MTD] ms02-nv: Fix 64bit operation

Manu Abraham:
  dvb: Twinhan DST: frontend fixes

Marcelo Tosatti:
  remove completly bogus comment inside __alloc_pages() try_to_free_pages handling
  print order information when OOM killing

Mark Fasheh:
  export generic_drop_inode() to modules

Mark M. Hoffman:
  i2c: make better use of IDR in i2c-core

Martin Loschwitz:
  dvb: cinergyT2: endianness fix for raw remote-control keys

Matt Mackall:
  quiet ide-cd warning

Matthieu Castet:
  [ACPI] PNPACPI parse error

Mauro Carvalho Chehab:
  v4l: TV EEPROM
  v4l: tuner-3026 - replace obsolete ioctl value
  v4l: SAA7134 Update
  v4l: MXB fix to correct tuner ioctl
  v4l: drivers/media/video/Kconfig
  v4l: I2C Tuner
  v4l: I2C Miscelaneous
  v4l: I2C Infrared Remote Control
  v4l: I2C BT832
  v4l: Documentation
  v4l: SAA7134 hybrid DVB
  v4l: CX88 Update
  v4l: BTTV update
  v4l: BTTV input
  v4l: cx88 update

Michael Downey:
  USB: add driver for Keyspan Digital Remote

Michael Ellerman:
  ppc64: Be consistent about printing which idle loop we're using
  ppc64: Remove obsolete idle_setup()
  ppc64: Fixup platforms for new ppc_md.idle
  ppc64: Move pSeries idle functions into pSeries_setup.c
  ppc64: Move iSeries_idle() into iSeries_setup.c
  ppc64: Make idle_loop a ppc_md function

Michael Hund:
  USB: add ldusb driver
  USB: add LD devices to hid blacklist

Michael Krufky:
  v4l: broken hybrid dvb inclusion
  dvb: LGDT3302 QAM256 initialization fix
  v4l: LGDT3302 read status fix
  v4l: add DVB support for DViCO FusionHDTV3 Gold-T
  v4l: add TerraTec Cinergy 1400 DVB-T
  v4l: add DVB support for DViCO FusionHDTV3 Gold-Q
  v4l: cx88 hue offset fix

Michael Paxton:
  dvb: usb: vp7045 IR map fix

Miklos Szeredi:
  __wait_on_freeing_inode fix
  namespace: rename _mntput to mntput_no_expire
  namespace: rename mnt_fslink to mnt_expire
  dcookies.c: use proper refcounting functions
  set mnt_namespace in the correct place
  namespace.c: fix mnt_namespace zeroing for expired mounts
  namespace.c: fix expiring of detached mount
  namespace.c: split mark_mounts_for_expiry()
  namespace.c: cleanup in mark_mounts_for_expiry()
  namespace.c: fix race in mark_mounts_for_expiry()
  namespace.c: fix mnt_namespace clearing

Miles Bader:
  v850: Update mmu.h header to match implementation changes
  v850: Update checksum.h to match changed function signatures

Milton Miller:
  hvc_console: Use hvc_get_chars in hvsi code
  hvc_console: Separate the NUL character filtering from get_hvc_chars
  hvc_console: Register ops when setting up hvc_console
  hvc_console: Separate hvc_console and vio code 2
  hvc_console: Separate hvc_console and vio code
  hvc_console: Add some sanity checks
  hvc_console: Statically initialize the vtermnos array
  hvc_console: remove num_vterms and some dead code
  hvc_console: Add missing include
  hvc_console: Unregister the console in the exit routine.
  hvc_console: MAGIC_SYSRQ should only be on console channel
  hvc_console: Dont always kick the poll thread in interrupt
  hvc_console: Match vio and console devices using vterm numbers
  hvc_console: Rearrange code

NeilBrown:
  nfsd4: fix fh_expire_type
  nfsd4: check lock type against openmode.
  nfsd4: clean up nfs4_preprocess_seqid_op
  nfsd4: clarify close_lru handling
  nfsd4: renew lease on seqid modifying operations
  nfsd4: return better error on io incompatible with open mode
  nfsd4: always update stateid on open
  nfsd4: relax new lock seqid check
  nfsd4: seqid comments
  nfsd4: fix open_reclaim seqid
  nfsd4: comment indentation
  nfsd4: stop overusing RECLAIM_BAD
  nfsd4: ERR_GRACE should bump seqid on lock
  nfsd4: ERR_GRACE should bump seqid on open
  nfsd4: fix release_lockowner
  nfsd4: prevent multiple unlinks of recovery directories
  nfsd4: lookup_one_len takes i_sem
  nfsd4: fix sync'ing of recovery directory
  nfsd4: reboot recovery fix

Nick Piggin:
  page_uptodate locking scalability

Nickolai Zeldovich:
  [ACPI] S3 resume -- use lgdtl, not lgdt

Nico Pitre:
  [MTD] Add mapping driver for Intel PXA27x Mainstone board flash.

Nicolas Pitre:
  [MTD] CFI flash locking reorg for XIP
  [MTD] Fix OTP for top-parameter devices
  [MTD] Reset file position when switching OTP mode
  [MTD] Add reboot notifier to Intel NOR flash driver
  [MTD] cfi_cmdset_0001: Fix state after sync
  [MTD] Make OTP actually work.
  [MTD] Quiet unused variable warning
  [MTD] Unabuse file-f_mode for OTP purpose
  [MTD] User interface to Protection Registers
  [MTD] Support for protection register support on Intel FLASH chips
  [MTD] Add OTP basisc

Nicolas S. Dade:
  [MTD] NAND: Add Hynix to manufacturer list

Nishanth Aravamudan:
  xtensa: use ssleep() instead of schedule_timeout()
  [IA64] use msleep_interruptible() instead of schedule_timeout

Olaf Hering:
  MAINTAINERS: irda-users@lists.sourceforge.net is subscribers only
  [IA64] remove linux/version.h include from arch/ia64
  ppc64: vdso32: fix link errors after recent toolchain changes

Olaf Kirch:
  [IPV4]: Prevent oops when printing martian source

Olav Kongas:
  USB: Fix kmalloc's flags type in USB
  USB: isp116x-hcd cleanup

Oliver Endriss:
  dvb: ttpci: fix timeout handling to be save with PREEMPT
  dvb: ttpci: make av7110_fe_lock_fix() retryable

Panagiotis Issaris:
  [ACPI] check for kmalloc failure in toshiba_acpi.c

Paolo 'Blaisorblade' Giarrusso:
  uml:remove user_constants.h on clean
  uml: remove winch sem
  uml: restore hppfs support

Patrick Boettcher:
  dvb: usb: fix some typos
  dvb: usb: README update
  dvb: usb: add supprt for WideView WT-220U
  dvb: usb/pci: correct syntax of driver name fields
  dvb: usb: dont use HZ for timeouts
  dvb: usb: IR input fixes
  dvb: usb: fix WideView USB ids
  dvb: usb: add vp7045 IR keymap
  dvb: usb Kconfig help text update
  dvb: usb doc update
  dvb: usb: digitv memcpy fix
  dvb: usb: add VideoWalker DVB-T USB ids
  dvb: usb: cxusb DVB-T fixes
  dvb: usb: dvb_usb_properties init fix
  dvb: usb: digitv-usb fixes
  dvb: frontend: add ALPS TDED4 PLL
  dvb: usb: add module parm to disable remote control polling
  dvb: usb: support Medion hybrid USB2.0 DVB-T/analogue box
  dvb: frontend: add FMD1216ME PLL
  dvb: usb: add isochronous streaming method
  dvb: usb: fix ADSTech Instant TV DVB-T USB2.0 support
  dvb: flexcop: woraround irq stop problem
  dvb: flexcop: add big endian register definitions
  dvb: frontend: cx22702: support for cxusb

Paulo Marques:
  [ACPI] fix kmalloc size bug in acpi/video.c

Pavel Machek:
  video doc: one more system where video works with S3
  pm: clean up process.c
  swsusp: fix error handling
  pm: Fix resume from initrd
  pm: more u32 vs. pm_message_t fixes

Pavel Roskin:
  pcmcia: remove client services version (fix)
  pcmcia: remove client services version

Pete Popov:
  [MTD] Replace all the Au1x mapping drivers with a simplified single driver

Pete Zaitcev:
  USB: Patch to make usbmon to print control setup packets

Peter Beutner:
  dvb: core: dmxdev cleanups
  dvb: core: demux error handling fix
  dvb: core: fix race condition in FE_READ_STATUS ioctl

Phil Dibowitz:
  USB Storage: Remove unneeded SC/P

Phil Oester:
  [NETFILTER]: Revert nf_reset change

Prarit Bhargava:
  [IA64] hotplug/ia64: SN Hotplug Driver - PREEMPT/pcibus_info fix
  [IA64] hotplug/ia64: SN Hotplug Driver - SN Hotplug Driver code
  [IA64] hotplug/ia64: SN Hotplug Driver - new SN PROM version code
  [IA64] hotplug/ia64: SN Hotplug Driver - pci_find_next_bus export
  [IA64] hotplug/ia64: SN Hotplug Driver: moving of header files
  [IA64] hotplug/ia64: SN Hotplug Driver: SN IRQ Fixes

Randy Dunlap:
  hardirq uses preempt

Richard Purdie:
  [MTD] sharpsl-flash: Correct error paths
  [MTD] Add support for more SharpSL machines and fix missing mapping init
  [MTD] NAND SharpSL fix default partition size

Robert Love:
  inotify

Robert Moore:
  ACPICA 20050408 from Bob Moore

Roland Dreier:
  IB uverbs: add documentation file
  IB uverbs: add mthca user QP support
  IB uverbs: add mthca user CQ support
  IB uverbs: add mthca user MR support
  IB uverbs: add mthca user PD support
  IB uverbs: add mthca mmap support
  IB uverbs: add mthca user context support
  IB uverbs: add mthca user doorbell record support
  IB uverbs: add mthca ABI header
  IB uverbs: hook up Kconfig/Makefile
  IB uverbs: memory pinning implementation
  IB uverbs: core implementation
  IB uverbs: add user verbs ABI header
  IB uverbs: update mthca for new API
  IB uverbs: update kernel midlayer for new API
  IB uverbs: core API extensions

Roland McGrath:
  reset real_timer target on exec leader change

Roman Zippel:
  tty output lossage fix

Russell King:
  yenta: no CardBus if IRQ fails
  [MTD] Fix MTD device probing

Sam Ravnborg:
  [NET]: move config options out to individual protocols
  [NET]: add a top-level Networking menu to *config
  kbuild: build a single module using 'make dir/module.ko'

Sean Young:
  [MTD] Use correct major number for INFTL

Shaohua Li:
  MTRR suspend/resume cleanup

Stefan Sorensen:
  ARM: 2790/1: Properly terminate plat_serial8250_port arrays on ixdp425 and

Steffen Motzer:
  dvb: dst: fix tuning problem

Stephen Rothwell:
  remove asm-xtensa/ipc.h

Thomas Gleixner:
  [MTD] XIP cleanup
  [MTD] NAND: Remove unmaintained tx49xx board drivers
  [MTD] NAND: sharpsl.c set correct file permissions
  [MTD] cfi_cmdset_0002: Remove bogus include
  [MTD] NAND: Add ST chip IDs. 
  [MTD] NAND: Change exports to _GPL
  [MTD] NAND: Fix broken bad block table scan
  [MTD] NAND: Reorganize chip locking
  Merge with rsync://fileserver/linux
  [MTD] Fix it really
  [MTD] map.h Use the correct macro and fix the resulting compiler warning
  [MTD] Make map_word_ff ware of the flash buswidth
  [MTD] cfi_cmdset_0002: Fix broken status check
  Merge with rsync://rsync.kernel.org/.../torvalds/linux-2.6.git
  [JFFS2] Whitespace cleanup. Fix missing debug message
  [JFFS2] Fix crosscompile
  [JFFS2] Fix cleanup in case of GC-Task not started
  [JFFS2] Convert thread start semaphore to completion
  [MTD] NAND: Honour autoplacement schemes supplied by the caller
  [MTD] Fix broken user ABI
  [MTD] NAND: Move the NULL check into the calling function
  [MTD] NAND: Fix oob available calculation
  [MTD] plat-ram: Make it usable on non ARM platforms
  [MTD] block2mtd: Fix incompatible pointer type
  [MTD] cfi_cmdset_0001: Fix compiler warnings
  [MTD] Fix typo in Kconfig
  [MTD] cfi_cmdset_0001: Fix the buggy status check. 
  [MTD] Add the reverse operation of cfi_build_cmd()
  [MTD] NAND: Use cond_resched instead of msleep
  [MTD] NAND: Check command timeout
  [MTD] DiskOnChip: Wait for the command to finish.
  [MTD] NAND: Skip bad block table scan on request
  [MTD] DiskOnChip: big endian fix for NFTL devices
  [MTD] DiskOnChip code cleanup
  [MTD] DiskOnChip use CONFIG_ options instead of random symbols
  [MTD] NAND replace yield

Thomas Winischhofer:
  USB: SiS USB Makefile fixes

Todd Poynor:
  ARM: 2791/1: Add CRCs for aliased ARM symbols
  [MTD] NOR flash map driver for TI OMAP boards.
  [MTD] mtdchar.c: Replace DEVFS by udev
  [MTD] XIP for AMD CFI flash.
  [MTD] CFI DEBUG_LOCK_BITS fixes for Intel NOR flash:
  [MTD] Avoid compile warnings for Intel CFI flash without OTP support.
  [MTD] cfi_cmdset_0001: Skip delay if Instant Block Locking is set
  [JFFS2] Avoid warning for empty filesystems

Tommy Christensen:
  [VLAN]: Fix early vlan adding leads to not functional device

Tony Lindgren:
  ARM: 2803/1: OMAP update 11/11: Add cpufreq support
  ARM: 2805/1: OMAP update 10/11: Update H2 defconfig
  ARM: 2804/1: OMAP update 9/11: Update OMAP arch files
  ARM: 2802/1: OMAP update 8/11: Update OMAP arch files
  ARM: 2812/1: OMAP update 7c/11: Move arch-omap to plat-omap
  ARM: 2809/1: OMAP update 7b/11: Move arch-omap to plat-omap
  ARM: 2807/1: OMAP update 7a/11: Move arch-omap to plat-omap
  ARM: 2801/1: OMAP update 6/11: Split OMAP1 common code into id, io and serial
  ARM: 2806/1: OMAP update 5/11: Move board files into mach-omap1 directory
  ARM: 2799/1: OMAP update 4/11: Move OMAP1 LED code into mach-omap1 directory
  ARM: 2800/1: OMAP update 3/11: Move OMAP1 core code into mach-omap1 directory
  ARM: 2798/1: OMAP update 2/11: Change ARM Kconfig to support omap1 and omap2
  ARM: 2797/1: OMAP update 1/11: Update include files

Tony Luck:
  Auto merge with /home/aegl/GIT/linus
  Auto merge with /home/aegl/GIT/linus
  [IA64] fix generic/up builds
  Auto merge with /home/aegl/GIT/linus

Uwe Bugla:
  fix for Documentation/dvb/bt8xx.txt?=

Venkatesh Pallipadi:
  [ACPI] enable C2 and C3 idle power states on SMP
  [ACPI] fix C1 patch for IA64
  [ACPI] update /proc/acpi/processor/*/power even if only C1 support

Victor Fusco:
  [NET]: Fix sparse warnings

Wolfgang Rohdewald:
  dvb: ttpci: more error handling for firmware communication
  dvb: ttpci: fix error handling for firmware communication

Yoichi Yuasa:
  TB0219: add PCI IRQ initialization

