Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVBMDfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVBMDfB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 22:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVBMDfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 22:35:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:30168 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261241AbVBMDeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 22:34:15 -0500
Date: Sat, 12 Feb 2005 19:34:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: Linux 2.6.11-rc4
Message-ID: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there everybody,
 this is hopefully the last -rc kernel before the real 2.6.11, so please 
give it a whirl, and complain loudly about anything broken.

As can be seen from the shortlog, most of the changes are pretty trivial. 
I think the biggest change is the radeon updates, and some of the NLS 
codepage things caused big diffs even if the changes themselves are pretty 
trivial (oh, and moving the ia64 "shubio.h" file accounts for about seven 
thousand lines of diffs, but no real changes ;)

In short: some driver updates, some arm/uml/sparc updates, and various 
random (mostly) one-liners all over. The most noticeable of the one-liners 
is hopefully that raid5/6 should work again.

		Linus
----

Summary of changes from v2.6.11-rc3 to v2.6.11-rc4
============================================

Adrian Bunk:
  o [ide] remove WAIT_READY dependency on APM
  o [ide] possible cleanups
  o [CRYPTO]: Make some code static in i386 crypto AES
  o [XFRM]: Kill xfrm_export.c
  o mark the mcd cdrom driver as BROKEN

Alan Cox:
  o more fixes for the Moxa driver

Alan Stern:
  o USB: Fix EHCI boot oops on AMD
  o USB: unusual_devs.h update

Alasdair G. Kergon:
  o device-mapper: stripe_width should be sector_t
  o device-mapper: Fixes for 64-bit sector_t

Albert Lee:
  o [libata] SCSI-to-ATA translation fixes

Alex Yustasov:
  o Add missing configure calls to intel agp resume code

Alexander Viro:
  o sparc64: fix compile with strict mm types
  o via82cxxx: fix ppc32 multiplatform config test
  o [ide] fix ide_dump_atapi_status()
  o [SPARC32]: Fix UP build with spinlock debugging enabled
  o [SPARC]: Trivial annotations in sparc signal.c / svr4.h
  o [SPARC]: NULL noise removal from sparc floppy.h
  o [SPARC64]: Fix prototype of check_signature() - it already gets a
    pointer
  o [SPARC64]: fbio.h __user annotations
  o [SPARC]: __user annotations around sparc{32,64} ptrace
    ...succ_return...()
  o [SPARC]: __user annotations in sparc checksum.h
  o [SPARC]: No iBCS2 on sparc, TYVM
  o [SPARC]: Fix I/O accessor routines
  o [SPARC]: __user annotations in ELF_CORE_COPY_REGS
  o [SPARC64]: NULL noise removal in arch/sparc64/prom/memory.c
  o [SPARC]: sunlance iomem annotations
  o portability problem in dm-stripe.c
  o i2c compat ioctl breakage
  o megaraid_mbox fix

Andi Kleen:
  o x86-64: CONFIG_PM=n build fix
  o Fix compat shmget overflow
  o Force read implies exec for all 32bit processes in x86-64
  o Fix small vmalloc per allocation limit

Andreas Gruenbacher:
  o Long-standing xattr sharing bug

Andreas Herrmann:
  o zfcp: bugfixes (without kfree) for -bk

Andrei Konovalov:
  o ppc32: fix typos in cpm_uart_cpm2.c

Andres Salomon:
  o cpufreq_resume() fix

Andrew Chew:
  o sata_nv: enable generic class support for future NVIDIA SATA

Andrew Morton:
  o pnpacpi build fix
  o nfsd needs exportfs

Andrew Vasquez:
  o qlogic nonatomic warning fix
  o qla2xxx: fix BUG's for smp_processor_id() on interrupt

Andries E. Brouwer:
  o nls_cp936.c is not synchronized with M$'s translation table

Anton Blanchard:
  o Use MM_VM_SIZE in exit_mmap

Arjan van de Ven:
  o [ide] unexport atapi_*_bytes() and ide_read_24()

Armin Schindler:
  o Eicon driver: convert to pci_register_driver
  o Eicon driver: code cleanups
  o Eicon driver: remove ^M characters from xdi_vers.h

Arnd Bergmann:
  o SERIAL_TXX9 fix

Art Haas:
  o [SPARC32]: Fix SPIN_LOCK_UNLOCKED define

Ashok Raj:
  o [IA64] mca.c: make cpu hot add work again

Aurelien Jarno:
  o I2C: Fix DS1621 detection

Bartlomiej Zolnierkiewicz:
  o [ide] fix it8172 build for real
  o [ide] fix printk in ide_allocate_dma_engine()
  o [ide pci generic] remove dead unknown_chipset[] table from
    generic.h
  o [ide pci generic] remove dummy init_chipset_generic()
  o [ide hpt366] remove dead fifty_base_hpt374[] table
  o [ide piix] remove useless comment

Ben Dooks:
  o [ARM PATCH] 2462/1: IXP2000 - fixes for warnings from io.h
  o [ARM PATCH] 2454/1: cleanup shark_defconfig
  o [ARM PATCH] 2455/1: shark: fix uninitialised variable in head
  o [ARM PATCH] 2468/1: S3C2440 - GPIOJ12 register fix
  o [ARM PATCH] 2471/1: S3C2440 - fix S3C2440_CAMDIVN register address

Benjamin Herrenschmidt:
  o Add try_acquire_console_sem
  o update aty128fb sleep/wakeup code for new powermac changes
  o radeonfb update

Bob Breuer:
  o [SPARC]: Fix crashing of cg14 driver when serial console and vsimm
    installed
  o [CG3]: FB mmap .voff and .poff were reversed

Bodo Stroesser:
  o uml: disallow stack access below $esp like i386 / x86_64
  o uml: use PTRACE_OLDSETOPTIONS instead of PTRACE_SETOPTIONS

Brett Russ:
  o [libata scsi] verify cmd bug fixes/support

Brian King:
  o pci: Add Citrine quirk

Chas Williams:
  o [ATM]: [horizon] replace interruptible_sleep_on() with
    wait_event_interruptible()
  o [ATM]: [iphase] remove sleep_on*() usage
  o [ATM]: [zatm] replace sleep_on() with wait_event()

Christian Bornträger:
  o s390: core changes
  o s390: cpcmd interface

Christoph Hellwig:
  o add MAP_POPULATE/sys_remap_file_pages support to XFS
  o cciss: handle scsi_add_host failure

Corey Minyard:
  o Update to IPMI driver to support old DMI spec

Cornelia Huck:
  o s390: common i/o layer

Daniel E. Markle:
  o [libata sata_sil] add another Seagate drive to blacklist

Dave Airlie:
  o Invalid bound check of driver defined ioctls in drm_ioctl

Dave Jones:
  o ppc32: unbreak perfctr build
  o ibmveth inlining failure

Dave Olien:
  o raid5 and raid6 fixes to current bk tree

David Brownell:
  o USB: another usbnet ax8817x device (goodway docking station)

David Howells:
  o FRV: Make switch_to() return previous task
  o FRV: cli/sti cleanup
  o FRV: Semaphore implementation race fix
  o FRV: Add TIF_MEMDIE
  o FRV: Make the bit finding functions take const pointers
  o FRV: vmlinux.lds.S comment cleanup
  o NOMMU: Improved handling of get_unmapped_area() errors
  o NOMMU: Documentation of no-MMU mmap
  o FRV: Fix sigaltstack handling for RT signals
  o Fix the mincore() syscall

David Mosberger:
  o [IA64] clean up pt_regs accesses
  o [IA64] fix ptrace debug-register handling bug
  o [IA64] fix per-CPU MCA mess and make UP kernels work again
  o [IA64] Remove Merced B-step support
  o [IA64] ptrace.c small comment fix
  o [IA64] head.S: clean away dead code (EARLY_PRINTK)
  o [IA64] Move allocation of per-CPU MCA data out of per_cpu_init()

David S. Miller:
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Consolidate pgd_cache calculations
  o [SPARC64]: atomic and bitop fixes
  o [DOC]: Add asm/atomic.h asm/bitops.h implementation specification
  o [SPARC64]: Kill spurious semicolons in some system.h macros
  o [SPARC64]: Add missing membars for xchg() and cmpxchg()
  o [SPARC64]: Correct rwlock membars
  o [DOC]: Some atomic_ops.txt updates
  o [SPARC64]: Fix off-by-one handling of size in user_fixup.c
  o [SPARC64]: Update defconfig
  o [SPARC64]: Mask off stack ptr in compat_alloc_user_space() for
    32-bit
  o [TG3]: Update driver version and reldate
  o [TCP]: Set PSH bit on all outgoing TSO frames
  o [SPARC]: nop() macro has bogus trailing semicolon
  o [DOC]: Fix typo in atomic_ops.txt
  o [TG3]: Update driver version and reldate
  o [SPARC]: Do not BUG() in srmmu_pte_pfn()

David Woodhouse:
  o USB: fix libusb endian issues
  o TASK_SIZE is variable

Dominik Brodowski:
  o pcmcia: i82365 registration failure fixup
  o pcmcia: m32 registration failure fixup

Eric Anholt:
  o drm: fix race condition in radeon driver

Fabio Massimo Di Nitto:
  o x86_64: parse noexec=[on|off]

Fanny Wakizaka:
  o avma1_cs: Inverted parameter order in outb

Gerd Knorr:
  o DVB: No signal with bt848/tda9887
  o tv-card tuner fixup

Grant Grundler:
  o [TG3]: Clean up grc_local_ctrl usage

Greg Kroah-Hartman:
  o PCI: add linux-pci mailing list to PCI maintainers entry
  o Update greg's email address

Hannes Reinecke:
  o s390: compat SI_TIMER conversion

Herbert Xu:
  o [XFRM]: Fix inverted strcmp() test in xfrm_get_byname()
  o [NET]: Add missing memory barrier to kfree_skb()
  o [NET]: Add barriers for dst refcnt

Hermann Kneissel:
  o USB: garmin_gps tweak

Hideaki Yoshifuji:
  o [IPV6]: Fix tunnel list locking in ip6_tunnel.c
  o [NET]: Use TASK_COMM_LEN instead of magic constant

Horst Hummel:
  o s390: dasd i/o scheduler & debug logs

Hugh Dickins:
  o tmpfs caused truncate BUG
  o remove truncate mapped BUG
  o do_munmap() hugetlb fix
  o general split_vma hugetlb fix

Ingo Molnar:
  o add design comment to kick_process()

James Bottomley:
  o SCSI: fix HBA removal problem with transport classes

James Lamanna:
  o s390: vfree checking cleanup

Jan Kara:
  o Fix reiserfs quota SMP locks

Jarno Paananen:
  o [libata sata_promise] add PCI ID for new SATAII TX2 card

Jean Delvare:
  o I2C: Resolve resource conflict between i2c-viapro and via686a
  o I2C: Use standard temperature converters for as99127f
  o I2C: Reduce it87 i2c address range
  o I2C: Fix i2c-sis5595 pci configuration accesses
  o I2C: Do not show disabled pc87360 fans
  o I2C: Prevent buffer overflow on SMBus block read in
  o [ide] fix hwif_init() to not return error for "empty" interfaces

Jeff Dike:
  o UML: remove not-yet-merged system calls
  o uml: Fix SKAS sig-handler reentrancy
  o uml: fix jiffies initialization
  o uml: fix broken #ifdef clause causing crashes
  o uml: fix STATIC_LINK compilation
  o uml: fix x86_64 submode compilation
  o uml: fix makefile typo

Jeff Garzik:
  o [libata] add DMA blacklist
  o [libata] Remove CDROM drive from PATA DMA blacklist
  o [libata sata_promise] support Promise SATAII TX2/TX4 cards
  o [libata ahci] Add support for ULi M5288
  o [block sx8] fix warning
  o [BK] ignore drivers/md/raid6altivec[1248].c
  o [gen_init_cpio] When outputting a buffer, don't use char-at-a-time
    I/O

Jens Axboe:
  o md sync_page_io bio leak

Jesse Barnes:
  o [IA64-SGI] move shubio.h into include/asm-ia64/sn/

Jimi Xenidis:
  o Fix devfs name for the hvcs driver

John Rose:
  o PCI Hotplug: remove incorrect rpaphp firmware dependency
  o PCI Hotplug: fix rpaphp firmware dependency

Josh Green:
  o pcmcia: ds.c initialisation fix

Kay Sievers:
  o PCI: memset rom attribute before using it

Keith Owens:
  o [IA64] mca_asm.S: Correctly dereference ia64_mca_data

Kenneth W. Chen:
  o [IA64] Ensure that r9 can't be a NaT on return from sys_pipe()
  o [IA64] entry.S: another syscall exit path optimization

Kumar Gala:
  o ppc32: Fix PCI2 support on MPC8555/41 CDS systems

Lennert Buytenhek:
  o [ARM PATCH] 2457/1: fix two typos in arch/arm/mm/tlb*.S
  o [ARM PATCH] 2473/1: fix alignment trap handler for big-endian

Libor Michalek:
  o InfiniBand: add missing break between cases

Linus Torvalds:
  o Make read/write always do the full "access_ok()" tests
  o Make generic rw_verify_area check against file offset overflows
  o Add extra debugging help for bad user accesses
  o FRV: "len" is size_t
  o Undo recent tty_io.c "fix"
  o Fix ATM copy-to-user usage
  o Linux 2.6.11-rc4

Marcel Holtmann:
  o [Bluetooth] Support Broadcom BCM92035 USB dongles
  o [Bluetooth] Support for Digianswer BPA 100/105 sniffers

Mark A. Greer:
  o ppc32: include/asm-ppc/rwsem.h RWSEM_DEBUG usage
  o ppc32: fix locking bugs in mv64x60 code

Martin Kögler:
  o serial: fix low-latency mode deadlock

Martin Schwidefsky:
  o Fix shmget for ppc64, s390-64 & sparc64

Martins Krikis:
  o libata: fix ata_piix on ICH6R in RAID mode

Matt Porter:
  o ppc32: PPC4xx DMA fixes, burst, and sg improvements
  o ppc32: add PPC440SP and Luan ref board support

Matthew Wilcox:
  o [IPV4]: ipconfig should use memmove() instead of strcpy()

Matthias-Christian Ott:
  o speedstep-lib.c: fix frequency multiplier for Pentium4 models 0&1

Meelis Roos:
  o [SPARC32]: Fix syntax errors from smp_{mb,rmb,wmb} on sparc32

Michael Chan:
  o [TG3]: 5704 serdes fixes
  o [TG3]: capacitive coupling detection fix

Michael Ellerman:
  o Fix oops in alloc_zeroed_user_highpage() when page is NULL

Michael S. Tsirkin:
  o InfiniBand: remove unbalance refcnt decrement

Michal Ludvig:
  o Update Michal Ludvig details

Mikkel Krautz:
  o TIGLUSB Cleanups 1/3
  o TIGLUSB Cleanups 2/3
  o TIGLUSB Cleanups 3/3

Narayanan R S:
  o sonypi: add fan and temperature status/control

Nathan Lynch:
  o ppc64: show -1 for physical_id of non-present cpus

Neil Brown:
  o md: fix problems with verion-1 superblock code
  o md: prevent oops when drive set faulty in inactive md array
  o md: make md work a bit better with devfs
  o md: fix endless loop when syncing an array that doesn't need any
    resync
  o md: remove extra loop from copy_data
  o raid5 overlapping read hack
  o nfsd: Don't try to cache reply to nfsv2 readdir
  o nfsd: Allow read access over NFS to files with APPEND bit set

Nick Piggin:
  o Fix kswapd spinning
  o fix wait_task_inactive race

Nico Huber:
  o USB: Logitech Cordeless Desktop Keyboard fails to report class
    descriptor

Nicolas Bouliane:
  o [NETFILTER]: Fix ip_conntrack_ftp crash with debugging enabled

Nicolas Pitre:
  o [ARM PATCH] 2456/1: fix futex syscall argument passing
  o [ARM PATCH] 2458/1: prevent PXA2xx defines from clashing with
    SA1111's
  o L18 flash corruption fix

Nishanth Aravamudan:
  o include/jiffies: fix usecs_to_jiffies()/jiffies_to_usecs() math
  o [NET]: Replace schedule_timeout() with msleep() in
    netdev_wait_allrefs()
  o [IPVS]: Replace schedule_timeout() with ssleep()
  o [IPV4]: ipconfig: Replace schedule_timeout() with msleep()

Olaf Hering:
  o PCI: typo in pci_scan_bus_parented
  o ppc64: typo in arch/ppc64/kernel/prom_init.c prom_debug

Oliver Neukum:
  o USB: fix for open/disconnect race in acm

Oskar Senft:
  o Fix ISDN4Linux bug in isdnhdlc.c

Pablo Neira:
  o [NETFILTER]: fix iptables userspace build

Paolo 'Blaisorblade' Giarrusso:
  o uml: makefile fix
  o uml: fix compilation for missing headers
  o uml: kconfig fixes
  o uml: kbuild: add further cleaning
  o uml: hostfs: (security) fix chmod +s permission check

Patrick McHardy:
  o [PKT_SCHED]: ipt action: add back pskb_expand_head() call
  o [NETFILTER]: Clean NAT status bits on module unload
  o [PKT_SCHED]: Fix u32 double listing

Paul Mackerras:
  o ppc64: correct return code in syscall auditing
  o Fix PPC rwlock code on SMP

Pavel Machek:
  o binfmt_elf: clearing bss may fail

Pete Zaitcev:
  o [libata] fix probe object allocation bugs

Peter Osterlund:
  o Make mousedev.c report all events to user space immediately

Phil Oester:
  o [NETFILTER]: Improve TCP window tracking retransmission detection

Prarit Bhargava:
  o [ide] fix error handling in probe_hwif_init() and sgiioc4 driver

Ralf Bächle:
  o mips: SGI IP22 updates

Randy Dunlap:
  o USB: hid-core: possible buffer overflow in hid-core.c

Robert Olsson:
  o [IPV4]: Add gc_min_interval_ms sysctl

Rogier Wolff:
  o Re: Bug when using custom baud rates

Russ Anderson:
  o [IA64] r23 was used without being set

Russell King:
  o [ARM] Fix sys_syscall
  o [ARM] Re-order lubbock includes
  o [ARM] Fix VFP for entry-armv.S macro-isation

Samuel Jean:
  o [NETFILTER]: Use GFP_ATOMIC in ipt_hashlimit

Sascha Hauer:
  o [ARM PATCH] 2463/1: Hynix h7202 serial ports fixes

Seokmann Ju:
  o megaraid_mbox 2.20.4.3 patch

Sripathi Kodi:
  o s390: compat_sys_old_readdir and compat_sys_getdents

Stefan Knoblich:
  o alpha: add missing dma_mapping_error

Steffen Thoss:
  o s390: qeth network driver

Stelian Pop:
  o sonypi: replace schedule_timeout() with msleep()
  o sonypi: add another HELP button event
  o sonypi: use MISC_DYNAMIC_MINOR in miscdevice.minor assignment
  o sonypi: fold the contents of sonypi.h into sonypi.c

Stephen D. Smalley:
  o SELinux: define execmod permission for character devices
  o SELinux: audit any unmapped permissions
  o SELinux: fix selinux_inode_setattr hook

Stephen Hemminger:
  o [PKT_SCHED]: netem: memory leak

Stephen Rothwell:
  o ppc64: replace last usage of vio dma mapping routines

Suresh B. Siddha:
  o x86_64: missing lock prefix in switch_to

Takashi Iwai:
  o [ALSA] Add quirk for HP pavilion ZV5030US
  o [ALSA] Add quirk for HP nc8000
  o [ALSA] Special AC97 patch for ASUS W1000/CMI9739 laptop
  o [ALSA] Fix silent output on some machines with AD1981x codecs
  o [ALSA] Enable HP jack sense for FSC Scenic-W
  o [ALSA] AC'97 Audio support for Intel ICH7
  o [ALSA] Fix struct alignment on PPC64
  o [ALSA] Add missing FORWARD ioctl

Tejun Heo:
  o [ide] remove adma100
  o [ide] cleanup it8172
  o [ide] cleanup opti621
  o [ide] cleanup piix
  o [ide] __ide_do_rw_disk() lba48 dma check fix
  o [ide] __ide_do_rw_disk() return value fix
  o [ide] ide-tape: use time_after() macro
  o [ide] remove NULL checking in ide_error()
  o [ide] comment fixes
  o [ide] add ide_drive_t.sleeping
  o [ide] add ide_hwgroup_t.polling
  o [ide aec62xx] remove SPLIT_BYTE() and MAKE_WORD() macros
  o [ide aec62xx] merge aec62xx.h into aec62xx.c
  o [ide cmd64x] merge cmd64x.h into cmd64x.c
  o [ide cy82c693] merge cy82c693.h into cy82c693.c
  o [ide pci generic] merge generic.h into generic.c
  o [ide hpt366] merge hpt366.h into hpt366.c
  o [ide it8172] merge it8172.h into it8172.c
  o [ide opti621] merge opti621.h into opti621.c
  o [ide pdc202xx_new] merge pdc202xx_new.h into pdc202xx_new.c
  o [ide pdc202xx_old] remove SPLIT_BYTE() macro
  o [ide pdc202xx_old] merge pdc202xx_old.h into pdc202xx_old.c
  o [ide piix] merge piix.h into piix.c
  o [ide serverworks] remove unused SVWKS_DEBUG_DRIVE_INFO
  o [ide serverworks] merge serverworks.h into serverworks.c
  o [ide] remove unused pkt_task_t definition from ide.h

Thomas Graf:
  o [PKT_SCHED]: Fix ingress qdisc to pick up IPv6 packets when using
    netfilter hooks
  o [NETLINK]: Use SKB_MAXORDER to calculate NLMSG_GOODSIZE
  o [TCP]: Fix calculation for collapsed skb size

Thomas Spatzier:
  o s390: key protected i/o

Tom 'spot' Callaway:
  o [CG3]: Set framebuffer cmap correctly
  o [SPARC]: fb: Fix putcmap handling in sbuslib

Tom L. Nguyen:
  o PCI: change sysfs representation of PCI-E devices

Tom Rini:
  o Move <linux/prio_tree.h> down in <linux/fs.h>
  o ppc32: MPC82xx PCI9 errata workaround broken

Tony Luck:
  o [IA64] ptrace.c: Format to make it fit in 80 cols
  o [IA64] pci_sal_read seg limit is 65535, not 255
  o [IA64] entry.S: .align in .text sections is broken, use
    TEXT_ALIGN()
  o [IA64] ivt.S: typo s/idirty_bit/dirty_bit/

Venkatesh Pallipadi:
  o x86: HPET setup, duplicate HPET_T0_CMP needed for some platforms
  o kmalloc() bug in pci-dma.c

Yoichi Yuasa:
  o mips: add unknown page size string
  o mips: remove TANBAC_TB0219 doubly registered in  kernel config

Zou Nanhai:
  o fix an error in /proc/slabinfo print

Zwane Mwaikambo:
  o OProfile: exit.text referenced in init.text
  o OProfile: ARM/XScale1 PMU support fix

