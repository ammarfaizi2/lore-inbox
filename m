Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUCJA1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 19:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUCJA1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 19:27:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:57231 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262539AbUCJA13 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 19:27:29 -0500
Date: Tue, 9 Mar 2004 16:34:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.4-rc3
Message-ID: <Pine.LNX.4.58.0403091631250.1092@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm. Nothing earth-shaking here, most of the changes end up being minor
code cleanups and fixes for things like memory leaks in some error
handling paths etc.

See the full log for more details.

		Linus

---

Summary of changes from v2.6.4-rc2 to v2.6.4-rc3
============================================

Alexander Viro:
  o d_alloc_root() fixes: gadgetfs
  o d_alloc_root() fixes: adfs
  o d_alloc_root() fixes: afs
  o d_alloc_root() fixes: autofs4
  o d_alloc_root() fixes: befs
  o d_alloc_root() fixes: coda
  o d_alloc_root() fixes: cramfs
  o d_alloc_root() fixes: efs
  o d_alloc_root() fixes: ext2
  o d_alloc_root() fixes: ext3
  o d_alloc_root() fixes: freevxfs
  o d_alloc_root() fixes: hfs
  o d_alloc_root() fixes: hfsplus
  o d_alloc_root() fixes: romfs
  o d_alloc_root() fixes: hpfs

Andrew Morton:
  o another rd.c leak
  o Add missing AFAVLAB P030 PCI ID
  o svcauth_gss oops fix
  o dm: remove v1 ioctl interface
  o drivers/sbus/char/vfc_dev.c needs mm.h
  o fastcall / regparm fixes
  o ppc64: Make xmon survive exit after soft reset
  o ppc64: iSeries_vio_dev cleanup
  o ppc64: iSeries virtual cdrom driver
  o ppc64: Convert mm_context_t to a struct
  o fix put_compat_timespec prototype
  o char/rio/rioctrl: fix ioctl return values
  o Fix initrd Kconfig dependencies
  o c99 initializers for cs46xx_wrapper
  o kill a dead function in lockd
  o serial_core.h needs sched.h
  o sb16 sample size fix
  o ext2/ext3 -ENOSPC bug
  o add missing MODULE_LICENSEs
  o v4l1 compatibility module fix
  o i2o subsystem minor bugfixes
  o fix oops in emu10k1_wavein_open() error recovery
  o CONFIG_LBD fixes
  o Fix nobh_prepare_write() race
  o alpha ptrace race fix
  o Documentation/cdrom/ide-cd fix
  o fix i2c compile warnings
  o OSS Sound Driver Forte needs ac97_codec
  o floppy oops fix
  o arc4.c compile fix for older gcc's
  o tulip printk cleanup
  o update filemap_flush() comments
  o vma corruption fix
  o gcc-3.5 io_apic.c build fix
  o Print function names during do_initcall debugging

Arjan van de Ven:
  o sata vs suspend-to-ram

Bartlomiej Zolnierkiewicz:
  o fix CONFIG_PDC202XX_FORCE/BURST for modular pdc202xx new/old
    drivers

Benjamin Herrenschmidt:
  o Fix typo in radeonfb
  o High BAT initialization wrong
  o pmac_zillog 1/2 : Cosmetic only, change "up" to "uap" to avoid
    collision
  o pmac_zilog 2/2 : Fix various bugs

Bjorn Helgaas:
  o [SERIAL] Make serial console work for any port (take 2)

Brian Gerst:
  o PnP BIOS exception fixes

Chris Wright:
  o proper error cleanup on security_acct hook

Dave Jones:
  o mismatched syscall protos
  o R128 DRI limits checking

Dave Kleikamp:
  o JFS: setting xattr should update ctime
  o JFS: warn users of inaccessible file names
  o JFS: Avoid incrementing i_count on file create
  o JFS: Add lots of missing statics and remove dead code

David S. Miller:
  o [TIGON3]: tg3_phy_copper_begin() tweaks
  o [SPARC]: Kill sys_ioperm decl from unistd.h
  o [SPARC64]: Update defconfig
  o [SPARC64]: Update defconfig
  o [FFB]: Force-disable cursor in ffb_switch_from_graph()
  o [SPARC]: Pass a real page into do_mount() a final arg
  o [TIGON3]: Allow MAC address changing even when iface is up
  o [TIGON3]: Always force PHY reset after major hw config changes
  o [TIGON3]: Update driver version and reldate

David Stevens:
  o [IPV4]: Add sysctl for per-socket limit on number of mcast src
    filters
  o [IPV4/IPV6]: Add sysctl limits for mcast src filters

Deepak Saxena:
  o [ARM PATCH] 1762/1: Fix typo in CONFIG_CPU_BIG_ENDIAN help text
  o [ARM PATCH] 1757/1: Allow building of LE kernels with BE-default
    toolchain

Don Fry:
  o pcnet32 transmit hang fix

Eric Sandeen:
  o [XFS] zero log buffer during initialization at mount time

Grant Grundler:
  o [TIGON3]: Consolidate MMIO write flushing using tg3_f() macro

Harald Welte:
  o [SERIAL] Fix supprot for AFAVLAB 8port boards in 2.6.x

Herbert Xu:
  o [NETFILTER]: In ip_route_me_harder, don't forget to set fl.proto

Ian Campbell:
  o [ARM PATCH] 1764/1: Export __arch_strncpy_from_user for modules

Igmar Palsenberg:
  o [QLOGIC]: Mark mbox_param[] as static to avoid namespace pollution

Jean Tourrilhes:
  o [IRDA]: Flush irtty symbols that were exported but never used
  o [IRDA]: Move last of irsyms.c to irmod.c

Jeff Garzik:
  o [IA32] VIA C3 crypto/RNG bits
  o Fix ramdisk driver leak on module unload
  o [libata] Include linux/suspend.h
  o [libata ata_piix] Make sure annoying BIOSen don't disable our
    interrupts
  o [libata sata_promise] provide proper SCSI completion function

Jens Axboe:
  o add blk_queue_stopped() helper function
  o blk_insert_request() buglet
  o fix blk_start_queue()

Jon Oberheide:
  o [CRYPTO]: Add ARC4 module

Keith M. Wesolowski:
  o [SPARC32]: Small SMP build fixes
  o [SPARC]: Add stack usage instrumentation
  o [SPARC]: Make parport_sunbpp compile again
  o [SPARC32]: Avoid an oops if thread_info allocation fails

Krzysztof Halasa:
  o 2.6.x wanXL driver update

Len Brown:
  o ACPI URL update
  o [ACPI] delete unnecessary dmesg lines, fix spelling
  o [ACPI] include CONFIG_ACPI_RELAXED_AML code always add acpi=strict
    option to disable platform workarounds
  o [ACPI] ACPICA 20040220 from Bob Moore
  o [ACPI] acpi_boot_init() cleanup suggested by Matt Wilcox HPET
    doesn't depend on IOAPIC
  o [ACPI] Support for PCI MMCONFIG for PCI Express (Matt Wilcox)
  o [ACPI] delete ACPI table parsing code from bootflags module

Linus Torvalds:
  o Add missing QUEUE_FLAG_REENTER bit from Jens' blk_start_queue()
    fix.
  o Fix bogon in slab hotplug cleanup from Rusty
  o Linux 2.6.4-rc3

Marc Zyngier:
  o Fix hp100 EISA probing

Marcel Holtmann:
  o [Bluetooth] Send HCI_Reset for some Broadcom dongles
  o [Bluetooth] Add notify callback for host drivers
  o [Bluetooth] Dynamic allocation of the RFCOMM TTY devices

Nathan Scott:
  o [XFS] Fix out-of-space deadlock when flushing delalloc data with
    pages locked under write
  o xfs: filemap_flush() unresolved

Neil Brown:
  o kNFSd -  Tidy up new filehandle type

Patrick McHardy:
  o [PKT_SCHED]: Fix ipv6 ECN marking in RED scheduler

Roman Zippel:
  o hfsplus: symlink initialization fix

Russell King:
  o [SERIAL] Remove obsolete CLPS711x serial driver names
  o [SERIAL] Clear up comments concerning mapbase and membase
  o [SERIAL] Don't initialise port->mctrl before calling ->startup
  o [SERIAL] Correct Oxford Semiconductor 16PCI952 PCI type entry

Rusty Russell:
  o stop_machine_run: Move Bogolock Code Out of module.c
  o make module code use stop_machine.c
  o introduce __drain_pages() to take a CPU number
  o minor cleanups for hotplug CPUs
  o remove sparc64's num_possible_cpus()
  o minor slab cleanups for hotplug CPUs
  o Clean up hotplug slab some more

Scott Feldman:
  o missing setup for National DP83840 PHY rev b/c

Stephen Hemminger:
  o [IRDA]: stir4200 update for 2.6.4-rc1
  o [IRDA]: Move proc_irda export out of irsyms.c into irproc.c
  o [IRDA]: Move hashbin exports out of irsyms and into irqueue
  o [IRDA]: Move irttp exports out of irsyms
  o [IRDA]: Move iriap routines out of irsyms, rename missing to
    irias_missing
  o [IRDA]: Move irlmp routines out of irsyms
  o [IRDA]: Move async_wrap function exports out of irsyms
  o [IRDA]: Move crc16 exports out of irsyms
  o [IRDA]: Make irda_start_timer inline rather than exporting
  o [IRDA]: More irlap exports out of irsyms
  o [IRDA]: Make irda_get_mtt et al. inline and not defines for better
    type checking
  o [IRDA]: Move qos related exports out of irsyms
  o [IRDA]: Move irda_param related exports out of irsyms

Stephen Rothwell:
  o small iSeries cleanup

Trond Myklebust:
  o Fix knfsd filehandles

Wensong Zhang:
  o [IPVS]: Code tidy up

