Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbULDAVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbULDAVk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 19:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262511AbULDAVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 19:21:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:45729 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262507AbULDATv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 19:19:51 -0500
Date: Fri, 3 Dec 2004 16:19:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.10-rc3
Message-ID: <Pine.LNX.4.58.0412031611460.22796@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, it's out there in all the normal places, and here's the shortlog for
the thing.

Mostly a lot of small fixes, although the MIPS update is pretty sizeable 
simply because it's been a while. 

ACPI updates and a new i2c driver, mtd, arm, uml updates.. fbdev and 
sparse fixes. And a lot of other small things better just described by the 
changelogs.

Please do test this - and don't send me anything but bug-fixes. Let's aim
for a real 2.6.10 before xmas (or hanukkah, or whatever your favourite
holiday happens to be).

		Linus

-----

Summary of changes from v2.6.10-rc2 to v2.6.10-rc3
============================================

Adam J. Richter:
  o sysfs: fix sysfs_dir_close memory leak

Adrian Bunk:
  o kill lockd_syms.c
  o SCSI_QLOGIC_1280_1040 dependencies
  o SCSI: aha1542.c: make some code static
  o SCSI atp870u.c: make a needlessly global function
  o SCSI dc395x.c: make a function static
  o SCSI: fdomain.c: make a struct static
  o SCSI qla1280: some firmware files cleanups
  o PCI Hotplug: remove unused drivers/pci/hotplug/pciehp_sysfs.c
  o ISDN divert_init.c build fix
  o ST_partstat multiple definition
  o remove outdated OSS Changelogs
  o [PCMCIA] make cardbus_type static

Al Borchers:
  o USB Gadget: gadget serial documentation

Alan Stern:
  o sd.c: adjust READ_CAPACITY for broken devices

Alasdair G. Kergon:
  o device-mapper: dm-crypt fix for zero-length key
  o device-mapper: Fix some DMERR macro usage
  o device-mapper: Add DM_TARGET_MSG
  o device-mapper: Allow referencing by device number

Alexander Kern:
  o USB quirk section fix

Alexander Viro:
  o alpha sysrq compile fix
  o sparse: add -m64 to CHECKFLAGS on alpha and sparc64
  o sparc io.h annotations and fixes
  o pcilynx iomem annotations
  o tgafb iomem annotations
  o iphase iomem annotations
  o 64bit portability fixes
  o ad1889 annotations and fixes
  o drivers/media annotations
  o (1/4) eicon iomem annotations and fixes
  o (2/4) eicon iomem annotations and fixes
  o (3/4) eicon iomem annotations and fixes
  o (4/4) eicon iomem annotations and fixes
  o pc300 portability fixes
  o i2o iomem annotations
  o cpqphp_nvram iomem annotations
  o misc __user annotations
  o more C99 initializers
  o drivers/w1 iomem annotations
  o sound/oss iomem annotations
  o zoran fix
  o imsttfb iomem annotations
  o pcbit fix
  o dpt_i2o partial iomem annotations
  o 3w-9xxx iomem annotations
  o ncr iomem annotations
  o isdn_divert annotations
  o fix for breakage introduced in hgafb.c
  o more sparc64 io.h annotations
  o fore200e iomem annotations
  o sunzilog iomem annotations
  o mesh iomem annotations
  o tpam annotations and cleanups
  o (1/12) bw2 iomem annotations
  o (2/12) cg14 iomem annotations
  o (3/12) cg3 iomem annotations
  o (4/12) cg6 iomem annotations
  o (5/12) controlfb iomem annotations
  o (6/12) hgafb iomem annotations
  o (7/12) leo iomem annotations
  o (8/12) offb iomem annotations
  o (9/12) p9100 iomem annotations
  o (10/12) platinumfb iomem annotations
  o (11/12) tcx iomem annotations
  o (12/12) valkyriefb iomem annotations
  o i2c iomem annotations
  o pmac iomem annotations
  o pmac sound iomem annotations
  o pmac_zilog iomem annotations
  o sunbpp iomem annotations
  o misc sparc iomem annotations
  o partial fc4 iomem annotations
  o iomem annotations and isa_-ectomy: media/video/pms.c
  o mtd/maps trivial annotations
  o misc iomem annotations
  o isa_check_signature() finally gone
  o t128 iomem annotations and isa_-ectomy
  o dtc iomem annotations and isa_-ectomy
  o seagate iomem annotations, cleanup and isa_-ectomy
  o wd7000 iomem annotations and fixes
  o swim3 __user annotation
  o misc drivers/atm iomem annotations and NULL noise removal
  o iomem annotations and fixes + isa_-ectomy in msnd
  o Work around devices with bogus media change indication on the first
    open

Andi Kleen:
  o x86-64: Fix get_user_pages access to vsyscall page
  o x86-64: fix boot crash on VIA systems
  o x86_64: fix async IPIs
  o x86_64: fix vsyscalls
  o x86_64: fix interrupt routing with nosmp
  o x86_64: fix early oops printing
  o x86_64: increase timer fallback threshold
  o PCI: Add sysfs file to map PCI busses to cpus
  o PCI: Disable mmconfig on AMD CPUs
  o x86_64: Fix lost edge triggered irqs on UP kernel

Andrea Arcangeli:
  o fix for mpol mm corruption on tmpfs
  o mempolicy can select the wrong policy

Andreas Gruenbacher:
  o compat_sys_fcntl[64] contain superfluous, buggy test

Andreas Herrmann:
  o s390: zfcp host adapter
  o s390: zfcp act enhancements

Andrew Morton:
  o sound_alloc_dmap memory allocation warning suppression
  o vmscan: ignore swap token when in trouble
  o x86 current_stack_pointer warning fix
  o documentation: nmi_watchdog.txt update
  o x86_64: duplicated patch
  o e100: early reset fix
  o dont deprecate MODULE_PARM
  o e100 deadlock fix
  o generic_make_request stack savings
  o revert the "dio handle eof" fix
  o blkdev_get_blocks(): handle eof

Andrew Patterson:
  o cciss: Off-by-one error causing oops in CCISS_GETLUNIFO ioctl

Andrew Walrond:
  o fbdev: Fix rivafb breakage (typo introduced by NV IO access
    cleanups)

Andries E. Brouwer:
  o fix appletalk locking
  o dm_init unresolved reference to _exits
  o net: scheduling policing fix

Anton Blanchard:
  o ppc64: ratelimit some rtas errors
  o ppc64: Use pci_device_to_OF_node
  o ppc64: avoid 32bit only syscalls in unistd.h
  o ppc64: pci cleanup
  o ppc64: remove phb_set_model
  o ppc64: make fixup_winbond_82c105 pseries specific
  o ppc64: remove duplication in pci_alloc_*
  o ppc64: OF overrides for pci_probe_only, pci_assign_all_buses
  o ppc64: remove BUG()s in pcibios_fixup_bus
  o ppc64: get_phb_reg_prop only required on python PCI machines
  o ppc64: alloc_bootmem returns void *
  o ppc64: linux,rtas* fixes
  o ppc64: Reserve kernel memory in kernel instead of wrapper
  o ppc64: linux,tce* changes
  o Allow multiple cpus in irq affinity call

Antonino Daplas:
  o fbdev: Fix for using >16 pixel wide font in fb console
  o fbdev: Support for bigger than 16x32 fonts in softcursor
  o fbdev: Support for bigger than 16x32 fonts in rivafb cursor
  o fbcon: Disable fbcon cursor if vt softcursor is enabled
  o fbdev: Allow mode change even if EDID block is not found
  o fbdev: Fix cursor in doublescan mode in atyfb
  o fbdev: Fix typo in atyfb
  o fbdev: Change the find_mode behavior
  o rivafb: fix broken burst length calculation
  o fbdev: Fix screen corruption in neofb
  o fbdev: Fix lockup when switching to/from X/console
  o fbdev: Fix module_param in rivafb
  o fbdev: Fix crash if fb_set_var() called before
    register_framebuffer()
  o fbdev: fix wrong colors at 16 bpp in tridentfb

Aristeu Sergio Rozanski Filho:
  o i2c-elektor: get rid of cli/sti
  o [2/2] i2c-elektor: adding missing casts
  o i2c-ite: get rid of cli()/sti()

Armijn Hemel:
  o USB: add ati_remote.c device id

Arnaldo Carvalho de Melo:
  o [NET] Assign inet transport sockets to the right module

Bartlomiej Zolnierkiewicz:
  o [ide] update CRISv10 IDE driver
  o [ide] no need to alloc sg_table in CRISv10 IDE driver
  o [ide] small IDE cleanups
  o [ide] fix /proc/ide/hd?/settings to not spam logs

Ben Dooks:
  o [ARM PATCH] 2234/3: S3C2410 - new serial driver (1/4)
  o [ARM PATCH] 2241/1: S3C2410 - default configuration update
  o [ARM PATCH] 2242/1: BAST - default configuration update
  o [ARM PATCH] 2243/1: BAST - move pm init to init_machine
  o [ARM PATCH] 2246/1: S3C2410 - rename i2c depending on 2410/2440
  o [ARM PATCH] 2247/1: S3C2410 - serial low-level updates
  o [ARM PATCH] 2248/1: S3C2410 - missing serial config in
    arch/arm/mach-s3c2410/Kconfig
  o [ARM PATCH] 2251/1: S3C2410 - system timer rename [cosmetic]
  o [ARM PATCH] 2249/1: S3C2410 - update help for
    arch/arm/Kconfig.debug
  o [ARM PATCH] 2256/1: S3C2410 - dma load fixes
  o [ARM PATCH] 2263/1: S3C2410 - gpio pin config fixes
  o [ARM PATCH] 2272/1: S3C2410 - rtc should check for <0 on alarm set
  o [ARM PATCH] 2273/1: S3C2410 - timex.h CLOCK_TICK_RATE fix
  o [ARM PATCH] 2275/1: S3C2410 - serial rx fifo full check
  o [ARM PATCH] 2284/1: S3C2410 - core device registration update
  o [ARM PATCH] 2285/1: S3C2410 - regs-sdi.h fixes

Benjamin Herrenschmidt:
  o [SUNZILOG]: Update timeout when setting termios
  o ppc64: Fix default command line
  o ppc64: Fix typo when parsing isa "reg" properties
  o ppc64: pci_bus_to_host() simplification
  o ppc64: Fix early serial setup baud rate
  o del_timer() vs. mod_timer() SMP race
  o ppc32: Fix an IRQ issue with cpufreq

Bjorn Helgaas:
  o Fix ia64 flush_tlb_page build error
  o early uart console support
  o move HCDP/PCDP to early uart console
  o [IA64] iosapic.c: don't direct interrupts to offline cpus
  o [IA64] Bigsur config: Add CONFIG_SERIAL_8250_ACPI so we can find
    serial devices
  o DAC960: Don't look at PCI_Device->irq before calling
    pci_enable_device()

Bob Breuer:
  o [CG14]: Fix NULL sbus_dev handling and colormap setup

Bob Tracy:
  o sym53c500_cs driver update

Bodo Stroesser:
  o uml: don't rule out syscall_nr == 0
  o uml: redundant code removal from signal delivery
  o uml: redundant argument removal from handle_signal
  o uml: handle_signal simplification
  o uml: fix setting of interrupted syscall return value
  o uml: make signal frame construction more resemble x86
  o uml: fix signal mask on delivery error
  o uml: Don't delay segfaults

Brian Gerst:
  o Regparm for x86 machine check handlers
  o fastcall fixes for x86 smp interrupts

Brian Haley:
  o [IPV6] improve ipv6_ifa_notify() readability

Brian King:
  o sg: Fix oops of sg_cmd_done and sg_release race

Cal Peake:
  o Documentation/kernel-parameters.txt: scsi param updates
  o fix typo in init/Kconfig
  o fix typo in init/Kconfig

Carsten Otte:
  o s390: dcss segments

Chris Wright:
  o setup_arg_pages can insert overlapping vma
  o a.out: error check on set_brk

Christoph Hellwig:
  o ppc64: reduce ifdef clutter in arch/ppc64/kernel/sysfs.c
  o ppc64: cleanups hpte_init_native, kill warning for !PSERIES builds
  o [IA64] remove dead wood from asm-ia64/hardirq.h
  o allow NFS exports of EFS filesystems
  o [ARM] kill unused call_irq()

Christoph Lameter:
  o mmtimer driver update

Colin Leroy:
  o Switch therm_adt746x to new module_param

Cornelia Huck:
  o s390: common i/o layer
  o s390: common i/o layer

Daniel Drake:
  o Permit LOG_SENSE and LOG_SELECT in SG_IO command table

Daniel Ritz:
  o USB: Add some help text for touchkitusb
  o USB touchkitusb: module_param to swap axes
  o yenta: don't enable read prefetch on older o2 bridges

Dave Kleikamp:
  o radix_tree_delete() fix

David Brownell:
  o USB: fix Genesys GL880S EHCI
  o USB: usb_sg_*() unlink deadlock fix
  o USB: "sparse -Wcontext" and USB HCDs
  o USB: ax8817x/usbnet, no GFP_KERNEL blocking in_irq

David Eriksson:
  o Re: The "ipaq" module: Updated list of vendor/product IDs

David Fries:
  o USB: fix for HID field index

David Gibson:
  o ppc64: Kill unused KRANGE_{START,END} macros

David Howells:
  o Fork fix fix

David Mosberger:
  o [IA64] speedup ptrace by avoiding kernel-stack walk

David S. Miller:
  o [SPARC64]: Update defconfig
  o [AF_UNIX]: Serialize dgram read using semaphore just like stream
  o [IPV6]: Temp fix for ipv6 link-local address problem
  o [TG3]: Update driver version and reldate
  o [SPARC64]: Couple of do_sparc64_fault fixes
  o [SPARC64]: Two io_remap_page_range() fixes
  o [SPARC64]: Do not set VM_LOCKED on I/O mapped areas
  o [SPARC64]: Update defconfig
  o [IPV6]: Set sk_prot early enough in inet6_create()
  o [SPARC]: Fix serial console handling

David Woodhouse:
  o RS library spelling fixes
  o MTD: Intel flash chip driver locking fixes
  o MTD: DiskOnChip drivers should no longer require old docecc code
  o MTD map/device driver cleanups -- remove bogus __iomem casts
  o MTD: Fix suspend/resume on Intel flash chip driver
  o MTD NAND drivers: cleanup MODULE_PARAM and bogus __iomem casts
  o MTD: DiskOnChip driver fixes: MODULE_PARAM and __iomem, and fix RS
    init
  o MTD: Fix oops after erase in NFTL/INFTL (DiskOnChip translation
    layers)
  o MTD: Fix Pb1550 board NAND driver to not read write-only registers
  o MTD: Compile fix for the typo fix in ixp2000 map driver
  o MTD: Avoid false positives in CFI probe due to floating data bus
  o MTD: Fix detection of hardware partitions in Intel flash chips
  o JFFS2: locking fixes
  o JFFS2: Remove redundant 'ino' arg from jffs2_get_inode_nodes()
  o JFFS2: make sync() actually work by providing ->sync_fs method
  o JFFS2: jffs2_fs_i.h needs <asm/semaphore.h>
  o JFFS2: fix printk argument type warning
  o MTD: some cleanups
  o MTD: Fix memory leak in FTL translation layer

Deepak Saxena:
  o [ARM PATCH] 2252/1: Fix IXP4XX timer interrupt implementation
  o [ARM PATCH] 2253/1: Fix IXP4xx PCI config cycle routines
  o [ARM PATCH] 2254/1: Fix ixp4xx-regs.h PCI config address typo
  o [ARM PATCH] 2258/1: Add missing IXP2000 Makefile.boot file
  o [ARM PATCH] 2262/1: Various IXP2000 typo fixes and comment cleanups
  o [ARM PATCH] 2268/1: Update Documentation/arm/Booting
  o [ARM PATCH] 2270/1: [Trivial] Remove reference to head-armv.S
  o [ARM PATCH] 2255/1: Add IXDPG425 platform support
  o [ARM PATCH] 2257/1: Add I2C device to IXDP2x01 platforms
  o [ARM PATCH] 2259/1: Rip out ixp2000 IRQ_ERR_STATUS demultiplexing
  o [ARM PATCH] 2260/1: Rename IXP2000_IRQ_SWI to reduce user confusion
  o [ARM PATCH] 2261/1: Cleanup use of ixp_reg_write in
    arch/arm/mach-ixp2000

Dely Sy:
  o PCI Hotplug: Add pci_enable_device() in hot-plug drivers

Dmitry Krivoschokov:
  o USB Gadget: add and use gadget_is_pxa27x()

Dmitry Torokhov:
  o i8k: fix 'power_status' sysfs permissions
  o v4l: fix permissions on module parameters exported via sysfs

Domen Puncer:
  o video: semicolon bug in atyfb_base.c

Don Fry:
  o pcnet32: added pci_disable_device

Edward Falk:
  o Documentation for IDE and CDROM ioctls
  o fix typo in cdrom.c

Eric Brower:
  o [SPARC]: Remove unnecessary pm_idle comment

Eric Rossman:
  o s390: crypto driver

Evgeniy Polyakov:
  o w1: do not stop and oops if netlink socket was not allocated
  o w1: make W1_DS9490_BRIDGE available
  o drivers/w1/dscore: fix the inline mess
  o W1: check nls in return path

Fenghua Yu:
  o [IA64] add cpu_relax() in the body of spin loops
  o add cpu_relax() in spin loops & clean up barrier()

Gabriel Paubert:
  o I2C: minor comment fix

Geert Uytterhoeven:
  o M68k: Update defconfigs for 2.6.10-rc1
  o M68k: Add 3 missing syscalls
  o 68851 MMU: Fix harmless typo in the MMU configuration code
  o Sun-3: Fix link error
  o fm2fb: Update Steffen A. Mork's email address
  o M68k I/O: Move HP300 I/O macros close to other I/O macros again
  o M68k: Update defconfigs for 2.6.10-rc2
  o [DIO]: Fix typo in dio_resource_len()
  o M68k: Update Atari defconfig (enable Ethernet and MII)
  o M68k HP Lance Ethernet: Fix leaks on probe/removal
  o M68k: Update HP300 defconfig (enable DIO and HP Lance Ethernet)
  o M68k Ethernet drivers depend on NET_ETHERNET
  o M68k HP Lance Ethernet depends on DIO bus support

Gerald Schaefer:
  o s390: monreader docu
  o s390: z/VM monitor stream

Gerd Knorr:
  o fix kobject varargs bug
  o video-buf oops/crash fixes
  o v4l: disable unused function
  o v4l: more modparam
  o tuner update

Giuseppe Sacco:
  o gbefb.c build fix

Grant Grundler:
  o [IA64] perfmon: fix double end-of-comment in previous checkin

Greg Kroah-Hartman:
  o I2C: make fixup_fan_min static in adm1026 driver
  o PCI Hotplug: fix warning compile issue in cpqphp driver
  o USB: fix dev_dbg() call in visor.c
  o USB: fix oops in io_edgeport.c driver
  o USB: minor Makefile fix
  o PCI: fix build warning in pci-sysfs.c
  o USB: move a internal usbfs only structure out of a public header
    file
  o Driver Core: restore comment in kobject_uevent.c
  o Add documentation about why the in-kernel api is the way it is

Guennadi Liakhovetski:
  o tmascsim: (resend updated) track_queue_full
  o refactor tmscsim inititalization code

Guido Guenther:
  o fbdev: Add NV30 pci_id and cleanup of probe error returns

Haroldo Gamal:
  o smbfs: Bug #3758 - Broken symlinks on smbfs

Heiko Carstens:
  o s390: remove zfcp hba api callbacks

Herbert Xu:
  o [NETLINK]: Fix mc_list operations
  o [IPV6]: Fix xfrm6_tunnel_check_size mtu calc
  o [IPV4/IPV6]: Remove frag_list check from output path
  o [NETFILTER]: Apply ipsec to ipt_REJECT packets

Hideaki Yoshifuji:
  o [IPV6] Fix possible dead-lock in ipv6_create_tempaddr()
  o [IPV6] Fix a race when dad completed during shutting down its owner
    interface
  o [IPV6] Stop DAD during shutting down the interface
  o [IPV6] Clean-up locking in ipv6_add_addr()
  o [IPV6]: Fix races in ip6_route_{input,output}()

Hirofumi Ogawa:
  o cont_prepare_write() fix

Hirokazu Takata:
  o m32r: update for m32r-g00ff
  o m32r: CF boot support for Mappi2
  o m32r: update defconfig files
  o m32r: update dot.gdbinit files
  o m32r: Fix build error of  arch/m32r/mm/fault.c
  o m32r: Kconfig.debug support
  o m32r: Fix a boot hang of UP kernel
  o m32r: make zImage a default build target
  o m32r: io_xxxxx.c cleanups
  o media: Update drivers/media/video/arv.c

Holger Freyther:
  o [ARM PATCH] 2276/1: [PATCH] SIMpad: make simpad.c compile
  o [ARM PATCH] 2277/1: [PATCH] SIMpad: fix warnings emitted by the
    compiler
  o [ARM PATCH] 2278/1: [PATCH] SIMpad: add a default config
  o [ARM PATCH] 2279/1: [PATCH] SIMpad: Add a mq200 device to the
    platform bus
  o [ARM PATCH] 2280/1: [PATCH] SIMpad: Change maintainer to me
  o [ARM PATCH] 2283/1: SA1100 USB Config options

Horst Hummel:
  o s390: dasd driver

Hugh Dickins:
  o low discontig highmem_start_page
  o tmpfs free_inodes leak
  o mlock-vs-VM_IO hang fix

Iacopo Spalletti:
  o Add PCI-quirks for ASUS M6Ne notebook

Ian Campbell:
  o Avoid deadlock in smc91x driver

Ian Pratt:
  o [IPV4]: Missing pskb_may_pull in icmp_filter

Ingo Molnar:
  o sched: fix ->nr_uninterruptible handling bugs
  o floppy boot-time detection fix
  o acpi_processor_idle() latency fix

Jakub Jelínek:
  o binfmt_elf: handle p_filesz == 0 on PT_INTERP section

James Bottomley:
  o SCSI: Fix Bug 3753 (multiple definition of ST_partstat)
  o SCSI: fix USB forced remove oops
  o Change MCA maintainer

James Morris:
  o [AF_UNIX]: Fix SELinux crashes with SOCK_SEQPACKET
  o [AF_UNIX]: Don't lose ECONNRESET in unix_seqpacket_sendmsg()

Jamie Lenehan:
  o SCSI dc395x.c: store pci device pointer
  o SCSI dc395x.c: Fix type for irq and io ports
  o SCSI dc395x.c: Call pci_disable during cleanup

Jamie Lokier:
  o revert recent futex_wait fix

Jan Kara:
  o Minor fix of inequalities in the quota code
  o Add missing DQUOT_OFF

Jean Delvare:
  o I2C: Do not register useless smsc47m1
  o I2C: Fixes to the i2c-amd756-s4882 driver
  o I2C: Cleanups to the recent smbus functions removal
  o I2C: More verbose w83l785ts driver
  o I2C: Add support for the nForce2 Ultra 400 to i2c-nforce2
  o I2C: macintoch/therm_* drivers cleanups

Jeff Dike:
  o uml: signal bug fix
  o uml: 64-bit cleanups in the system calls
  o uml: 64-bit type cleanups
  o uml: fix definitions of pte_unmap_*
  o uml: LFS 64-bit cleanups
  o uml: Remove unused declaration
  o uml: remove some dead code
  o uml: defconfig update

Jeff Garzik:
  o [libata] fix DocBook bugs
  o [libata ahci] minor fixes
  o [libata docs] add chapter on libata driver API

Jeff Mahoney:
  o selinux: cache not freed if load_policy fails; reload BUG's

Jeff Scheel:
  o ppc64: iSeries legacy model emulation of PURR

Jens Axboe:
  o io context leak on queue drain
  o 3ware bad queuecommand returns
  o ide-scsi bad queuecommand return
  o megaraid bad queuecommand return
  o ncr53c8xx bad queuecommand return
  o nsp32 bad queuecommand return
  o aacraid bad queuecommand return
  o megaraid2 bad queuecommand return
  o nsp_cs bad queuecommand return
  o cfq-iosched: fix allocation increment race #3
  o bio: fix leak in failure case in bio_copy_user()
  o cfq-iosched: kill show_status sysfs entry

Jeremy Fitzhardinge:
  o Buffer overrun in arch/x86_64/sys_ia32.c:sys32_ni_syscall()

Jesper Juhl:
  o [SCTP]: Fix static inline declarations
  o remove errornous semicolon in
    arch/i386/kernel/traps.c::do_general_protection
  o [NET]: Fix inline keyword usage in skbuff.c

Jesse Barnes:
  o [IA64] fix phys. address conversion in ia64_pal_tr_read
  o correct copyright in arch/ia64/kernel/domain.c

Joe Korty:
  o fix uninitialized variable in waitid(2)

John W. Linville:
  o [VLAN]: change_mtu should return 0 on success
  o tulip: make tulip_stop_rxtx() wait for DMA to fully stop

Juerg Billeter:
  o Don't remove /sys in initramfs

Justin Thiessen:
  o I2C: add adm1026 chip driver

Kai Mäkisara:
  o "mt-st tell" fails in 2.6.10-rc1

Karsten Keil:
  o i4l: fix deadlock in CAPI code, reenable SMP

Len Brown:
  o [ACPI] acpi_pci_irq_enable() now returns 0 on success
  o fix non-ACPI IOAPIC build
  o Merge
  o [ACPI] handle out of spec EC bit width
    http://bugzilla.kernel.org/show_bug.cgi?id=1744
  o [ACPI] migrate to seq_file() interface
    http://bugzilla.kernel.org/show_bug.cgi?id=3333
  o [ACPI] automatic workaround for NFORCE timer-override BIOS bug
    http://bugzilla.kernel.org/show_bug.cgi?id=3551
  o [ACPI] clean up the NFORCE BIOS bug workaround delete now obsolete
    dmi_scan entries fix build for ACPI & !IOAPIC
  o [ACPI] fix warnings for 64-bit video build (Luming Yu)
  o Cset exclude:
    torvalds@ppc970.osdl.org|ChangeSet|20041111002817|28673 Cset
    exclude:
    acme@conectiva.com.br[torvalds]|ChangeSet|20041111002501|29509
  o [ACPI] remove acpi_ksyms.c
  o [ACPI] remove acpi_ksyms.c
  o [ACPI] add #ifdef ACPI_FUTURE_USAGE
  o [ACPI] survive a BIOS that erroneously supplies multiple MADTs
    http://bugzilla.redhat.com/beta2/show_bug.cgi?id=135449
  o [ACPI] fix build errors resulting from auto-merge
  o [ACPI] platform_rename_gsi() is no longer limited to ACPI specific
    code, so call it ioapic_renumber_irq().
  o [ACPI] fix IRQ assignment regression with CONFIG_PNPACPI=y
    http://bugzilla.kernel.org/show_bug.cgi?id=3762
  o [ACPI] fix reboot on poweroff regression due to enabled wakeup GPEs
    http://bugzilla.kernel.org/show_bug.cgi?id=3669
  o [ACPI] IPMI must supply the address of its GPE handler to install
    or remove it
  o Cset exclude:
    len.brown@intel.com[lenb]|ChangeSet|20041109085620|42985
  o [ACPI] disable LAPIC at reboot and poweroff if Linux forced it on
    http://bugzilla.kernel.org/show_bug.cgi?id=3643
  o [ACPI] update C-state limiting patch

Linus Torvalds:
  o Fix floppy driver lock-up when you have an irq storm
  o Fix reading /proc/<pid>/mem when parent dies
  o x86: clean up ptrace single-stepping, make PT_DTRACE exact
  o x86: make TF handling at signals consistent
  o acpi: don't disable PCI irq links that were active at boot
  o acpi: disable PCI links at boot again, fix ELCR
  o Linux 2.6.10-rc3

Maciej W. Rozycki:
  o i386: apic_printk() used before initialized

Magnus Damm:
  o [ide] update documentation for ide params
  o [ide] "ide=nodma" printout fix
  o documentation: nohighio
  o [IPV4]: Use schedule_timeout() instead of jiffies polling in
    ipconfig

Maneesh Soni:
  o fix oops in sysfs_remove_dir()

Manfred Schwarb:
  o [ATM]: Force -n option in gzip invocation
  o [DECNET]: dn_neigh.c needs linux/module.h

Manfred Spraul:
  o proc_pid_status() oops fix

Marc Leeman:
  o make number of ramdisks Kconfigurable

Marcel Holtmann:
  o [Bluetooth] Update copyright information
  o [Bluetooth] Correct locking for zero SCID responses
  o [Bluetooth] Add support for L2CAP secure mode
  o [Bluetooth] Check for L2CAP reliability
  o fix unnecessary increment in firmware_class_hotplug() and USB core

Mark Fortescue:
  o [SPARC]: In cg3 driver, access control reg using byte not long IOs

Mark Haverkamp:
  o 2.6 aacraid: Interrupt function cleanup
  o 2.6 aacraid: rx check health function update

Markus Lidel:
  o i2o: changed code with BUG() to BUG_ON()
  o i2o: remove unused code and make needlessly global code static
  o i2o: changed old queueing code with wait_event API
  o i2o: converted SPIN_LOCK_UNLOCKED into spin_lock_init()

Martin Schwidefsky:
  o s390: 3270 console
  o s390: core changes

Masaki Chikama:
  o USB: new defice for usb serial pl2303

Matt Porter:
  o ppc32: Fix uninitialized PPC40x vars
  o Fix warnings in ibm_emac driver

Matthew Dharm:
  o USB Storage: fixes to usb-storage scanning thread
  o USB Storage: Force INQUIRY length to be 36
  o USB Storage: Remove unnecessary state testing

Matthieu Castet:
  o [WATCHDOG] i8xx_tco.c-request_region-patch

Maximilian Attems:
  o [PCMCIA] replace schedule_timeout() with msleep()
  o [VLAN]: Handler register_netdevice_notifier() errors
  o [ATM]: Handle register_netdevice_notifier() errors in mpc.c

Michael Chan:
  o [TG3]: 5753 support and a bug fix

Michael Kerrisk:
  o RLIMIT_MEMLOCK accounting of shmctl() SHM_LOCK is broken

Michael Obster:
  o mc146818rtc.h include fix

Michal Rokos:
  o [PCMCIA] Exclude uneeded code when ! CONFIG_PROC_FS

Michal Schmidt:
  o md: fix jiffies handling in md.c

Mike Christie:
  o Fix badness in scsi_lib.c

Miles Bader:
  o Remove duplicate safe_for_read(READ_BUFFER) entry in scsi_ioctl.c
  o Remove duplicate safe_for_read(READ_BUFFER)

Mitchell Blank Jr.:
  o [NET]: Missing security_*() check in net/compat.c

Nathan Scott:
  o Fix an XFS direct I/O deadlock

Neil Brown:
  o kNFSd: fix d_find_alias brokenness
  o md: Fix problem with unsigned variable going "negative" in linear.c
  o knfsd: svcrpc: fqdn length fix
  o md: fix careless bug in raid10

Nick Piggin:
  o mm: tune the page allocator thresholds

Nicolas Pitre:
  o [ARM PATCH] 2267/1: don't fiddle with GPDR/GAFR directly
  o [ARM PATCH] 2271/3: MMC for Mainstone/PXA27x
  o [ARM PATCH] 2287/1: remove bogus EXPORT_SYMBOL(*)
  o [ARM PATCH] 2288/1: unlink MMC DMA on driver exit

Oleg Nesterov:
  o uninline do_trap(), remove get_cr2()

Olof Johansson:
  o ppc64: Make pci_alloc_consistent() conform to API docs
  o ppc64: Make early processor spinup based on physical ids

Paolo 'Blaisorblade' Giarrusso:
  o uml: update some copyrights
  o uml: partial KBUILD_OUTPUT fix
  o akpm has moved

Patrick Caulfield:
  o [DECNET]: Remove DECNET_SIOCGIFCONF
  o [DECNET]: Typo in accept causes OOPS

Patrick McHardy:
  o [NETFILTER]: Handle nonlinear skbs in ip_queue/ip6_queue
  o [NET]: Move rx timestamp functions to net/core/dev.c
  o [NETFILTER]: Enable rx timestamps in ip_queue/ip6_queue
  o [NETFILTER]: associate locally generated icmp errors with conntrack
    of original packet
  o [NETFILTER]: Fix invalid tcp/udp checksums within NATed icmp errors
  o [SCTP]: Fix inetaddr notifier chain corruption
  o [XFRM]: Fix endless loop in xfrm_policy_insert

Paul Mackerras:
  o PPC64 call ibm,os-term only if its available
  o PPC64 rtasd: window when error_log_cnt could get zeroed
  o Fix pmac_zilog.c so it compiles again
  o Do power_state conversion for mesh.c
  o Add __iomem annotations to drivers/scsi/mac53c94.c
  o power_state and __iomem for mediabay.c
  o __iomem annotations for swim3.c
  o Multilink fix for ppp_generic.c
  o ppc64: move emulate_step to arch/ppc64/lib
  o ppc64: fix compilation with recent toolchains
  o ppc64: remove the volatile from cpus_in_xmon
  o ppc64: fix hang on legacy iSeries

Paul Ortyl:
  o USB Storage: Unusual_dev entry for tekom/yakumo

Paulo Marques:
  o USB: add PID to ftdi_sio.c

Pete Zaitcev:
  o ub: flag day - major 180
  o ub: oops with preempt ("Sahara Workshop")

Peter Chubb:
  o [ARM PATCH] 2269/2: Updated Pleb-1 support patch for Linux 2.6

Petko Manolov:
  o USB: pegasus endian fixes

Phil Dibowitz:
  o USB Storage: Add unusual_devs entry for another yakumo camera

Phil Oester:
  o [NETFILTER]: revert MASQUERADE optimization for mostly static IPs

Prasanna Meda:
  o unlocked access to task->comm
  o /proc/cmdline missing mmput
  o sys_set/getpriority PRIO_USER semantics fix and optimisation

Prasanna S. Panchamukhi:
  o kprobes: dont steal interrupts from vm86

Ralf Bächle:
  o MIPS updates

Randy Dunlap:
  o x86_64 hpet: fix function warning
  o [SCTP]: Fix printk arg type
  o PCI Hotplug: cpcihp_generic: fix module_param data type
  o cdrom: handle SYSCTL without PROC_FS
  o usb-storage should enable scsi disk in Kconfig
  o eth1394: use SET_NETDEV_DEV() for udev
  o VISWS: prevent APM

Roger Luethi:
  o USB: visor: Always do generic_startup
  o USB visor: Don't count outstanding URBs twice

Roland Dreier:
  o cdev_init: zero out cdev before kobject_init()
  o linux/mount.h: add atomic.h and spinlock.h #includes

Rolf Eike Beer:
  o PCI Hotplug: clean up rpaphp_pci.c::rpaphp_find_pci_dev
  o PCI: fix Documentation/pci.txt inconsistency

Russell King:
  o [SERIAL] s3c2410: remove duplicate include
  o [PCMCIA] Don't place Cardbus bridges into D3 state on suspend
  o parport_pc CONFIG_PCI=n build fix
  o [ARM] Sparse fixes
  o [ARM] Add missing ecard_resource_flags() macro
  o [ARM] Fix VFP NaN flag handling
  o smc91c92_cs outw() fix
  o [SERIAL] imx: remove two unnecessary includes
  o [ARM] sa1111: don't reference dev->power.saved_state if CONFIG_PM
    is unset
  o [ARM] icside: ensure interfaces are probed and correctly setup
  o [ARM] ARMv6 always selects correct user operations at runtime
  o [ARM] omap: remove unnecessary linux/device.h include

Rusty Russell:
  o [NETFILTER]: Cleanup find_appropriate_src() Fix
  o [NETFILTER]: Fix stack leakage in iptables
  o Remove Futex Warning
  o Fix parameter handling in ibm_acpi.c
  o Fix occasional stop_machine() lockup with > 2 CPUs

Sam Ravnborg:
  o kbuild: Major update of Documentation/kbuild/modules.txt

Santiago Leon:
  o make ibmveth link always up

Scott Feldman:
  o [PKTGEN]: Clean error count before each run

Sreenivas Bagalkote:
  o megaraid 2.20.4.1 Driver

Srihari Vijayaraghavan:
  o [ide] remove RICOH CD-R/RW MP7083A from DMA blacklist

Stefan Bader:
  o s390: core changes

Stefan Weinhuber:
  o s390: dasd driver

Steffen A. Mork:
  o Make dss1_divert ISDN module work on SMP again
  o fix dss1_divert fixes

Stelian Pop:
  o sonypi: return an error from sonypi_camera_command() if the camera
    isn't enabled

Stephen D. Smalley:
  o SELinux: map Unix seqpacket sockets to appropriate security class

Stephen Hemminger:
  o [RANDOM]: Remove TCP MD4 code if not CONFIG_INET
  o usb_unlink_urb: ratelimit warning
  o [UDP]: Select handling of bad checksums

Stephen Rothwell:
  o ppc64 iSeries: don't share request queues in viocd
  o ppc64: add missing braces to rtc driver
  o ppc64 iSeries: PURR emulation fix
  o ppc64 iSeries: fix viodasd remove

Stéphane Eranian:
  o [IA64] perfmon: enable interrupts around semaphore call

Sylvain Meyer:
  o fbdev: Add vram option to intelfb

Thomas Gleixner:
  o Lock initializer unifying Batch 2 (SCSI)
  o yenta_socket.c: Fix missing pci_disable_dev

Thomas Graf:
  o [GNET_STATS]: kernel-api doc for gnet stats/estimator

Thomas Leibold:
  o I2C: i2c-nforce2.c add support for nForce3 Pro 150 MCP

Thomas Spatzier:
  o s390: network driver
  o s390: qeth network driver

Tim T. Murphy:
  o serial: add support for Dell Remote Access Card 4

Tom Rini:
  o ppc32: Fix Motorola Sandpoint builds
  o ppc32: Fix CONFIG_8260 and CONFIG_BLK_DEV_INITRD
  o x86_64: only single-step into signal handlers if the tracer asked
    for it
  o ppc32: Have the 8260 board-hook happen a bit later
  o ppc32: Fix __iomem warnings in TODC code

Tony Lindgren:
  o [ARM PATCH] 2201/1: OMAP timer 1/2: Clean-up MPU timer

Tony Luck:
  o [IA64] Allocate syscall #1270 for waitid syscall
  o [IA64] Add add_key, request_key, keyctl syscalls
  o [IA64] if idle doesn't halt, it should at least relax

Vadim Lobanov:
  o swsusp kconfig: Change in wording

Volker Sameske:
  o s390: zfcp read-only lun sharing

William Lee Irwin III:
  o parport_pc warning fixes

Yasuyuki Kozakai:
  o [NETFILTER]: Fix multiple bugs in ipv6header match
  o [NETFILTER]: introduce skb_header_pointer() to ipv6header match
  o [NETFILTER]: Make eui64 match usuable in FORWARD chain

Yoshinori Sato:
  o H8/300: /proc/cpuinfo typo fix
  o H8/300: signal handling update
  o H8/300: read{b,w,l} / write{b,w,l} error fix
  o H8/300: vmlinux.lds.S update
  o CONFIG_UNIX98_PTY=n warning fix

Zou Nanhai:
  o ia64/x86_64/s390 overlapping vma fix

