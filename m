Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUGRFm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUGRFm2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 01:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUGRFm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 01:42:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:48071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262356AbUGRFmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 01:42:03 -0400
Date: Sat, 17 Jul 2004 22:41:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.8-rc2
Message-ID: <Pine.LNX.4.58.0407172237370.12598@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


MTD updates, i2c updates and some USB updates, and a lot of small stuff
(sparse cleanups and fixes from Al etc).

		Linus

Summary of changes from v2.6.8-rc1 to v2.6.8-rc2
============================================

Adrian Bunk:
  o [IPV4]: Remove no longer available URL
  o #ifndef guard percpu_counter.h and blockgroup_lock.h
  o remove outdated Stallion contact information
  o USB:  USB w9968cf compile error

Alan Stern:
  o USB: Add usb_kill_urb()
  o USB: Make hub driver use usb_kill_urb()
  o USB: Don't ask for string descriptor lengths
  o USB: Store pointer to usb_device in private hub structure
  o USB: Fix endianness bug in UHCI driver
  o USB: Allow NULL argument in usb_unlink_urb() and usb_kill_urb()

Alexander Viro:
  o sparse: NULL noise in fs/reiserfs
  o sparse: misc NULL noise in fs/*
  o sparse: aacraid annotation
  o sparse: megaraid inline fixes
  o sparse: megaraid annotation
  o sparse: NULL noise in drivers/isdn
  o sparse: misc NULL noise in drivers/*
  o sparse: ISDN ->readstat() and ->writecmd() annotation
  o sparse: blind dereference of userland pointers in divasproc
  o sparse: drivers/isdn/* annotation
  o sparse: dvb_ringbuffer_pkt_write()/dvb_ringbuffer_write()
    annotation
  o sparse: blind dereference of userland pointers in ac7110
  o sparse: drivers/media/* annotation
  o sparse: switching afs to kvec
  o sparse: VIDIOCSWIN compat_ioctl fixes
  o sparse: usb ioctl cleanups
  o sparse: isdn compile fix for platforms with HZ > 1000
  o sparse: saa fix
  o sparse: compile fix for rrunner on big-endian platforms
  o sparse: tms380tr.c fix
  o sparse: NULL noise removal in drivers/sbus
  o sparse: drivers/sbus fixes
  o sparse: drivers/sbus annotation
  o sparse: alpha NULL noise removal
  o sparse: alpha sparse infrastructure
  o sparse: alpha topology.h compile fix
  o sparse: signal annotation
  o sparse: arch/* NULL noise removal
  o sparse: ipc compat annotations and cleanups
  o sparse: gemtek ioctl fix
  o sparse: drivers/media NULL noise removal
  o sparse: drivers/net partial NULL noise removal
  o sparse: drivers/usb NULL noise removal
  o sparse: net/* NULL noise removal
  o sparse: assorted drivers/* NULL noise removal
  o sparse: more fs/* NULL noise removal
  o __vfs_follow_link() made inline again
  o compat_fillonedir() warning fix
  o sparse: read_descriptor_t annotation
  o sparse: missing cpumask_t bits on sparc
  o sparse: aout32 sparse fixes for compat
  o sparse: __forced added to casts in arch-specific code
  o pointer-to-int done the canonical way
  o sparse: more drivers/scsi annotations
  o sparse: a couple of inline fixes in drivers'/scsi
  o sparse: more drivers/usb/* annotations
  o sparse: #if where #ifdef should've been (saa7146)
  o sparse: (ipv6/netfilter) initializer fix
  o sparse: sound compat ioctls annotations
  o mcdx irq handling cleanup
  o remove bogus casts of pointers to unsigned int in sound/*
  o au88x0: use proper field of snd_kcontrol_t and don't try to store
    pointer in int
  o ic31712: when storing a bitmask in pointer field, use unsigned long
  o annotated sound/pci/nm256/nm256.c
  o NULL noise removal in sound/usb/*
  o mark broken stuff as such in Kconfig
  o misc sparse cleanups
  o switch sys32_timer_create() to compat_alloc_user_space()
  o sparse: beginning of iovec cleanups - infrastructure
  o sparse: iovec cleanups - smbfs
  o sparse: iovec cleanups - ncpfs
  o sparse: iovec cleanups - cifs
  o sparse: iovec cleanups - rxrpc
  o sparse: iovec cleanups - sunrpc, nfs and nfsd
  o sparse: iovec cleanups - the rest
  o annotations and NULL noise removal in drivers/char/drm
  o 3w-9xxx.c annotated
  o fbmem.c partially annotated
  o hfs and hfsplus switched to use of ffs(3) instead of homegrown
    versions
  o more annotations in binfmt_aout.c
  o pointer-to-number cast in binfmt_elf.c done right

Alexandre d'Alton:
  o I2C: ADM1030 and Co sensors chips support

Andi Kleen:
  o Fix memory corruption at x86-64 SMP bootup
  o Fix i386 bootup with HIGHMEM+SLAB_DEBUG+NUMA and no real

Andras Bali:
  o I2C: Add support for LM77

Andrew Morton:
  o raw.c cleanups
  o JFS: jfs_dmap build fix
  o [SPARSE]: Fix warnings in net/sctp/
  o small style fixups for the new automount code
  o `unknown symbol' in sound/oss/kahlua.ko needs unknown symbol udelay
  o remove struct_cpy()
  o Altix serial driver updates

Anton Blanchard:
  o tg3 bug

Arthur Othieno:
  o fix return codes after i2c_add_driver() in tea6415c and tea6420

Bartlomiej Zolnierkiewicz:
  o ide: PIO-out fixes for ide-taskfile.c (CONFIG_IDE_TASKFILE_IO=n)
  o ide: PIO-out ->prehandler() fixes (CONFIG_IDE_TASKFILE_IO=y)
  o ide: PIO-out error handling fixes (CONFIG_IDE_TASKFILE_IO=y)
  o ide: remove BUSY check from task_in_intr()
    (CONFIG_IDE_TASKFILE_IO=n)
  o remove pre_task_out_intr() comment (CONFIG_IDE_TASKFILE_IO=n)
  o ide: pre_task_mulout_intr() cleanup (CONFIG_IDE_TASKFILE_IO=n)
  o ide: no partial completions for PIO (CONFIG_IDE_TASKFILE_IO=y)
  o ide: merge CONFIG_IDE_TASKFILE_IO=y|n PIO handlers together
  o ide: use "normal" handlers for "flagged" taskfiles (ide-taskfile.c)

Ben Dooks:
  o [ARM PATCH] 1961/1: S3C2410 - fix for UART FIFO size calculation
  o [ARM PATCH] 1962/1: S3C2410 - Rename MACH_VR1000 to Thorcom-VR1000

Bill Nottingham:
  o fix airo oops-on-removal

Bjorn Helgaas:
  o fix ia64 early_printk build problem

Brent Casavant:
  o ia64: Fix bug in ia64_atomic64_{add,sub}

Colin Leroy:
  o fix saa7146 compilation

Daniel McNeil:
  o mmap PROT_NONE fix for NX patch

Daniele Venzano:
  o sis900-fix-phy-transceiver-detection.patch

Dave Kleikamp:
  o JFS: Don't allow reading beyond the inode map's EOF
  o JFS: Error path released metadata page it shouldn't have
  o JFS: Updated field isn't always written to disk during truncate
  o JFS: Protect active_ag with a spinlock
  o JFS: prevent concurrent calls to txCommit on the imap inode
  o JFS: Check for dmap corruption before using leafidx
  o JFS: Add d_hash and d_compare operations for case-insensitive names

David Brownell:
  o USB: misc ohci tweaks
  o USB: usb serial gadget, add omap_udc
  o USB: usb gadgetfs, handle omap_udc
  o USB: usb gadget API updates
  o USB: usb gadget zero, basic OTG updates
  o USB: usb ethernet gadget, minor fixes + basic OTG support
  o USB: usb host side updates, mostly for suspend
  o USB: usb hub, don't check speed before reset

David Eger:
  o pmac_zilog: initialize port spinlock on all init paths

David Howells:
  o ppc32: openpic driver cpumask_t changes

David Mosberger:
  o ia64: Fix OSDL BugMe report 2885: realtime process can't preempt
    low priority process in kernel
  o ia64: Nuke two compiler warnings
  o ia64: Define machvec_noop as "static inline"
  o ia64: Fix EFI physical-mode stubs to correctly calculate physical
    address
  o ia64: Nuke a warning due to the syscall auditing patch

David S. Miller:
  o [TCP]: Type qualifiers, such as const, are ignored on function
    return type
  o [IPV4]: Fix multicast socket hangs
  o [PKT_SCHED]: Remove CSZ scheduler
  o [SPARC64]: Add CMT register defines
  o [SPARC64]: Update defconfig

David T. Hollis:
  o USB: usbnet:ax8817x - use interrupt URB for link detection
  o USB: ax8817x_unbind does not free the interrupt URB after unlinking

David Woodhouse:
  o NAND flash driver updates
  o JFFS2 file system update
  o MTD core include and device code cleanup
  o NOR flash drivers update
  o ppc32: Fix UART detection on WindRiver SBC8560
  o ppc32: Fix UART initialisation on WindRiver SBC8560
  o ppc32: Fix IRQ setup on WindRiver SBC8560
  o Remove /proc/fs/jffs2 support
  o M-Systems DiskOnChip driver: fix DiskOnChip Millennium ECC support
    and fix a few compiler warnings while we're at it.
  o Make obsolete NOR flash chip drivers depend on BROKEN

Dmitry Torokhov:
  o Driver core: add platform_device_register_simple to register
    platform
  o Driver core: add default driver attributes to struct bus_type
  o Driver core: kset_find_obj should increment refcount of the found
    object
  o Driver core: add driver_find helper to find a driver by its name
  o Driver core: Fix OOPS in device_platform_unregister

Eugene Surovegin:
  o I2C PPC4xx IIC driver: 0-length transactions bit-banging
    implementation

Gordon Jin:
  o ia64: IA-32 sigaltstack bug fix

Greg Kroah-Hartman:
  o Driver Core: remove extra space in Kconfig file
  o I2C: sparse cleanups for a few i2c drivers
  o I2C: small ADM1030 fix
  o 1 Wire: add Dallas 1-wire protocol driver subsystem
  o USB: add 3 Phidget device ids to the HID blacklist
  o USB: fix up the wording in the emi26 firmware file to match the
    other kernel firmware files
  o USB: more sparse cleanups (all pretty much NULL usages.)
  o USB: fix lockup with 2.6 keyspan_pda driver
  o USB: Trivial fix to include/linux/usb.h
  o USB: more sparse fixups that found a real bug in the se401 driver
  o USB: fix usbfs mount options ignored bug
  o USB: oops, revert hub patch that wasn't supposed to make it into
    this patch series yet
  o USB: change all usbserial drivers to use module_param()
  o USB: remove CONFIG_USB_SERIAL_DEBUG
  o USB: sort the order in which the usb-serial drivers get built
  o USB: fix SN9C10[12] driver for ia64
  o USB: unusual_devs.h update
  o USB: usbserial/ipaq update
  o USB: ftdi_sio debug trace for TIOCMSET
  o Upgrade security/root_plug.c to new module parameter syntax
  o add removeable sysfs block device attribute

Guennadi Liakhovetski:
  o [wireless airo] fix alignment problem (particularly on ARM)

Herbert Xu:
  o [XFRM]: Add FLUSHSA and FLUSHPOLICY
  o [IPSEC]: Fix uh->len when doing NATT with IP options
  o [IPSEC]: Move generic encap code into xfrm4_output
  o [IPCOMP6]: Exclude IPCOMP header from props.header_len

Hideaki Yoshifuji:
  o [NET]: Fix dst_underflow_bug_msg printk args

Hirofumi Ogawa:
  o [IPV4]: IPMR fixes
  o [NET]: Cleanup mis-usage of seq_release_private
  o autoselect FAT_FS in config

Hugh Dickins:
  o tmpfs preempt count panic

Ian Abbott:
  o USB: ftdi_sio VID/PID updates

Jack Steiner:
  o ia64: Reduce TLB flushing during process migration

Jamal Hadi Salim:
  o [PKT_SCHED]: Another missed tc_stats spinlock conversion

James Morris:
  o [CRYPTO]: Remove lazy allocation from deflate

Jan-Benedict Glaw:
  o mconf.c: Honor $LINES and $COLUMNS if TIOCGWINSZ failed

Janice M. Girouard:
  o [netdrvr acenic] fix RX descriptor memory ordering

Jean Delvare:
  o I2C: Class of scx200_acb
  o I2C: Add support for LM86, MAX6657 and MAX6658 to lm90
  o I2C: Documentation for i2c-parport
  o I2C: remove Documentation for i2c-pport
  o I2C: adm1025 driver ported to 2.6
  o I2C: Refine detection of LM75 chips

Jeff Garzik:
  o [netdrvr dmfe] remove ALi pci id
  o [netdrvr tg3] bump version and reldate
  o [PCI, libata] Fix "combined mode" PCI quirk for ICH6

Jens Axboe:
  o CFQ: allocation under lock, missing memset on allocation
  o fix cdrom mt rainier probe

John Heffner:
  o [TCP]: Do not round window to MSS if window scaling

John Lenz:
  o [ARM PATCH] 1958/1: make collie use INIT_MACHINE

Kam Leo:
  o floppy.c: remove superfluous variable initialization

Keith M. Wesolowski:
  o [SPARC32]: Regenerate defconfig
  o [SPARC32]: Move non-PCI DMA definitions out of pgtable.h
  o [SPARC32]: Continue to avoid the use of __builtin_trap for BUG()
  o [SPARC32]: Fix CONFIG_SUN4 build
  o [SPARC32]: Don't allow the kernel to read PAGE_NONE pages

Keith Owens:
  o ia64: Rename local move_irq to sn_move_irq
  o ia64: Correct invalid unwind data
  o ia64: build fixes for IA64_MCA_DEBUG_INFO

Kenneth W. Chen:
  o ia64: fix interpolation-bug in fsys_gettimeofday()

Linus Torvalds:
  o Remove obsoleted drivers/char/h8.c drivers/char/h8.h
  o x86: fix stackframe ownership confusion in sys_sigaltstack()
  o ppc64: fix up si_addr usage
  o It's a pointer, dummy. Use NULL, not 0
  o ppc64: More NULL/0 confusion in prom.c
  o Clean up ptrace child exit case
  o Linux 2.6.8-rc2

Luca Risolia:
  o Updates for W99[87]CF and new SN9C10[12] driver
  o USB: W99[87]CF fix

Luiz Capitulino:
  o I2C: i2c/i2c-dev.c::i2c_dev_init() cleanup
  o USB: usb/core/file.c::usb_major_init() cleanup
  o USB: usb/core/hcd.c::usb_init() missing audit

Manfred Spraul:
  o natsemi updates
  o natsemi 1: switch to netdev_priv()
  o natsemi 2: support packets > 1518 bytes
  o Gigabit Ethernet support for forcedeth

Marcel Holtmann:
  o [Bluetooth] Respond to L2CAP info requests
  o [Bluetooth] Don't reset the USB halted bits

Margit Schubert-While:
  o prism54 freq to channel incorrect for 5GHz
  o prism54 Fix wrong type for BSSID

Mark M. Hoffman:
  o I2C: Remove extra inits from lm78 driver

Martin Josefsson:
  o [NETFILTER]: Add timestamping to ipt_ULOG

Mika Kukkonen:
  o Fix 'unsigned' < 0 checks
  o Remove all uses of '#ifdef MODULE_PARM' from kernel

Miklos Szeredi:
  o fix inode state incoherency

Patrick McHardy:
  o [NETFILTER]: Fix two broken checks for options in ipt_LOG

Pavel Roskin:
  o [netdrvr pci-skeleton] refresh

Peter Martuccelli:
  o ia64: add audit support

Petri Koistinen:
  o Fix 3c59x.c uses of plain integer as NULL pointer

Richard Henderson:
  o [ALPHA] Pass pt_regs as pointer to execve and sigprocmask syscalls

Russell King:
  o [ARM] ohci-omap does not need asm/mach-types.h

Rusty Russell:
  o [TRIVIAL 2.6] sk98lin: kill dup include

Sergio Gelato:
  o libata: fix kunmap() of incorrect page, in PIO data xfer

Seth Rohit:
  o ia64: nointroute option needs to be parsed early

Stephen Hemminger:
  o [NET]: Deinline sock_i_uid, sock_i_ino
  o [BRIDGE]: Support different MTU sizes
  o [PKT_SCHED]: Add jitter support to netem

Steve French:
  o fix oops in build_wildcard_path_from_dentry
  o clean up NULL vs. 0 warnings generated by sparse tool
  o Set Type field when creating block/char/pipe e.g. via mknod
  o Set DevMajor/DevMinor when querying info on remote char/block
    devices

Stéphane Eranian:
  o ia64: fix various problems in pfm_check_task_state()

Thomas DuBuisson:
  o [CRYPTO]: Set CRYPTO_TFM_RES_BAD_KEY_LEN in twofish

Tim Chick:
  o USB: usbnet, Sitecom LN-029

Tony Luck:
  o ia64: allow module core code calls to module init code again

Örjan Persson:
  o I2C: patch quirks.c - SMBus hidden on hp laptop

