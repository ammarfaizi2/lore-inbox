Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbULXWj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbULXWj4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 17:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbULXWj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 17:39:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:33190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261340AbULXWjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 17:39:11 -0500
Date: Fri, 24 Dec 2004 14:39:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Ho ho ho - Linux v2.6.10
Message-ID: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, with a lot of people taking an xmas break, here's something to play
with over the holidays (not to mention an excuse for me to get into the
Glögg for real ;)

Mostly a lot of small fixes since 2.6.10-rc3, with the biggest thing being
probably the CIFS update and the switch-over to the new DVB frontend
driver world order.  Some MMC and USB work too, and ARM updates as usual.

Shortlog from 2.6.10-rc3 appended, with the full log from 2.6.9 on the 
normal distribution sites.

		Linus

------

Summary of changes from v2.6.10-rc3 to v2.6.10
============================================

<sundarapandian:gmail.com>:
  o Code to register amba serial console is missing

<vs:namesys.com>:
  o reiserfs bug fix: add missing pair of lock_kernel()/unlock_kernel()

Adrian Bunk:
  o USB uhci-debug.c: remove an unused function (fwd)
  o scsi/qla2xxx/qla_rscn.c: remove unused functions
  o fm801_gp_probe: fix use after free

Alan Cox:
  o Intel/Cyrix typo
  o [ide] ide-cd: fix possible race in PIO mode
  o Bring Moxa serial back into being

Alan Stern:
  o USB UHCI: minor bugfix for port resume

Andi Kleen:
  o x86_64: fix syscall/signal restart bug

Andreas Herrmann:
  o zfcp: act enhancements corrections

Andrew Morton:
  o direct-io: set PF_SYNCWRITE
  o do_task_stat() use pid_alive()
  o remove speedstep_coppermine docs
  o parenthesize init_wait() macro parameters
  o AB-BA deadlock between uidhash_lock and tasklist_lock
  o fix CONFIG_SWAP=n build

Andries E. Brouwer:
  o restore BLKRRPART semantics

Anton Blanchard:
  o ppc64: pSeries shared processor fixes

Bartlomiej Zolnierkiewicz:
  o [ide] remove PLEXTOR CD-R PX-W8432T from the DMA blacklist
  o [ide] remove SAMSUNG CD-ROM SC-148F from the DMA blacklist
  o [ide] pdc202xx_old: fix cable detection
  o [ide] fix creating of /proc/ide/ entries for legacy VLB modules
  o [ide] remove obsolete comment from ide-probe.c

Ben Dooks:
  o [ARM PATCH] 2290/1: S3C2410 - timer usec fixes
  o [ARM PATCH] 2299/1: S3C2410 - pm debug patch
  o [ARM PATCH] 2317/1: S3C2410 - fix clkout0 name in clock.c

Benjamin Herrenschmidt:
  o remove some PowerMac cruft from USB
  o ppc64: Workaround PCI issue on g5

Bjorn Helgaas:
  o [IA64] Document serial device names on ia64
  o Documentation for ia64 serial device name changes
  o hisax: don't look at pci_dev->irq before calling
    pci_enable_device()

Castor Fu:
  o support for 3PAR sparse SCSI LUNs

Catalin Marinas:
  o [ARM PATCH] 2304/1: versatile_defconfig fixed after adding
    Versatile/AB support
  o [ARM PATCH] 2309/1: ARCH->MACH replacement for the Versatile/AB
    platform
  o [ARM PATCH] 2310/1: CONFIG_FPE_NWFPE enabled in
    (integrator|versatile)_defconfig
  o [ARM PATCH] 2311/1: ARM1176 CPU detection
  o [ARM PATCH] 2312/1: Cache type information fix
  o [ARM PATCH] 2316/1: cacheflush.h included in copypage-v6.c

Chris Wright:
  o [IPV4/IPV6]: IGMP source filter fixes

Christoph Hellwig:
  o [XFS] remove useless S_ISREG check in ->mmap and ->mprotect
  o [XFS] split pagebuf_get into xfs_buf_get_flags and
    xfs_buf_read_flags
  o [XFS] handle inode creating race
  o [XFS] call the right function in pagebuf_readahead

Clear Zhang:
  o [ide] alim15x3: add support for ULi M5228

Con Kolivas:
  o vm: disable thrashing control by default

Dave Jiang:
  o [ARM PATCH] 2303/1: Remove unused file in iop331 port
  o [ARM PATCH] 2314/1: Enable physmap MTD driver for IOP platforms

David Brownell:
  o USB: EHCI qh update race fix
  o USB: OHCI "resume"/smp fix
  o USB: sl811-hcd driver, replaces hc_sl811
  o reduce ext3 log spamming (blank lines)
  o USB: fix Scheduling while atomic warning when resuming

David Mosberger:
  o [IA64] do early_console_setup() on UP, too

David S. Miller:
  o [SPARC64]: Fix SMP cpu bringup bug when bigkernel
  o [SPARC]: Fix syscall return value errno comparison
  o [IPV4]: Do not leak IP options
  o [NET]: CMSG compat code needs signedness fixes too
  o [SPARC]: asm/mostek.h needs asm/io.h
  o [SPARC64]: Update defconfig
  o [IPV6]: Do not use udp_poll for RAW sockets
  o [SPARC]: Adjust 32-bit ELF_ET_DYN_BASE

David Vrabel:
  o [ARM PATCH] 2298/1: Fix minor typo in ixp4xx_wdt
  o [ARM PATCH] 2300/1: IXP4xx: remove minor type mismatch warnings

Deepak Saxena:
  o [ARM PATCH] 2305/1: Add IXP46x CPU support

Dmitry Torokhov:
  o fix possible evdev usb mouse disconnect oops

Douglas Gilbert:
  o extracting resid from struct scsi_cmnd
  o off-by-1 libata-scsi INQUIRY VPD pages 0x80 and 0x83

Edward Falk:
  o [ide] final polish on disk ioctl documentation

Eric Moore:
  o mptfusion: delete MPTSCSIH_DBG_TIMEOUT
  o mptfusion: streamline slave_alloc
  o mptfusion: streamline queuecommand
  o mptfusion: replace chip_type
  o mptfusion: resid cleanup
  o mptfusion: kill fusion init called

Eric Sandeen:
  o [XFS] Wait for all async buffers to complete before tearing down
    the filesystem at umount time

Fenghua Yu:
  o Add cpu_relax in idle spin loop for no-hlt kernel option

François Romieu:
  o r8169: new PCI id

Geert Uytterhoeven:
  o M68k: Update defconfigs for 2.6.10-rc3

Geoffrey Wehrman:
  o [XFS] Add xfs_rotorstep sysctl for controlling placement of extents
    for new files by the inode32 allocator.

George G. Davis:
  o [ARM PATCH] 2318/1: Enable access to ARMv6 VFP coprocessr
  o [ARM PATCH] 2321/1: Update integrator_defconfig

Gerald Schaefer:
  o s390: z/VM monreader driver bugfix
  o s390: z/VM watchdog driver bugfix

Gerd Knorr:
  o msp3400 quick fix
  o uml: ramdisk config fix

Greg Kroah-Hartman:
  o USB: fix sparse warnings in sl811-hcd driver
  o USB: fix sparse warning in ehci-hcd driver
  o USB: removed unused hc_sl811 driver from the tree
  o USB: fix obvious build error in hc_chrisv10.c driver
  o USB: fix another sparse warning in the USB core
  o usbfs: Remove extraneous disconnection checks
  o USB: avoid OHCI autosuspend on some boxes
  o USB: drivers/usb/atm/usb_atm.c: fix nonzero snd_padding case
  o USB: fix up warning messages spit out by the keyspan driver

Heiko Carstens:
  o fix ext2/ext3 memory leak

Herbert Pötzl:
  o normalise wall_to_monotonic for i386 and m32r

Herbert Xu:
  o [NET]: Fix CMSG validation checks wrt. signedness

Hideaki Yoshifuji:
  o [IPV6]: Fix check if we're a router

Holger Freyther:
  o [ARM PATCH] 2294/1: SA1100 ide.h change superseed 2282/1
  o [ARM PATCH] 2319/1: SIMpad cill exportation of ChipSelect via
    ProcFS
  o [ARM PATCH] 2320/1: SIMpad add Flash device  depends on 2319/1

Hugh Dickins:
  o shmctl SHM_LOCK perms
  o VmLib wrapped: executable brk
  o VmLib wrapped: mprotect flags

James Bottomley:
  o mptfusion: command line parameters
  o aic7xxx: fix compiler warning from dma mask assignement
  o Fix cable pull problem with USB storage

James Nelson:
  o rocket: documentation changes

Jean Tourrilhes:
  o [IRDA]: Try to fix the worst abuse of the pci init code in via_ircc
  o [IRDA]: Use kill_urb() in stir4200
  o [IRDA]: Use kill_urb() in irda-usb

Jeff Garzik:
  o [libata] only DMA map data for DMA commands (fix >=4GB bug)
  o [libata sata_nv] fix dev detect by removing sata-reset flag

Jens Axboe:
  o cfq-iosched: bad accounting on non-fs requests
  o hack imm.c to work in highmem machines
  o highmem.c: fix bio error propagation
  o cfq-iosched: exit deadlock

Jeremy Huddleston:
  o [SPARC]: Make some asm headers more userland friendly

Jesper Juhl:
  o fix inlining related build failures in mxser.c

Johannes Stezenbach:
  o fix dvb-net Oops

Jon Krueger:
  o [XFS] Allow the option of skipping quotacheck processing

Jozsef Kadlecsik:
  o [NETFILTER]: TCP window tracking bug fixes

Jurij Smakov:
  o [SUNSAB]: Fix serial break handling

Jörn Engel:
  o phram maintainer update

Kumar Gala:
  o ppc32: fix SPE state corruption on e500

Li Shaohua:
  o eepro100 resume failure

Linus Torvalds:
  o Revert double patch application
  o Revert recent ext3_dx_readdir changes
  o Revert isolcpus option fix, pending better fix from Nick
  o Make sure VC resizing fits in s16
  o Clean up open_exec()/kmalloc() error case handling
  o x86 sysenter: clear %ebp on exit
  o Fix x86 src pointer type for memcpy_fromio()
  o Don't use "-march=pentium3" for gcc tuning
  o Linux 2.6.10

Luca Tettamanti:
  o ide-cd: Unable to read multisession DVDs

Magnus Damm:
  o documentation for mem=
  o aty128fb: do not release unrequested range

Marc Singer:
  o [ARM PATCH] 2293/1: Corrections to build for LPD7a400
  o [ARM PATCH] 2296/1: Corrections to build for LPD7a404
  o [ARM PATCH] 2297/1: SMC91x patch (#2) for LPD7a40x CardEngines

Marcel Holtmann:
  o [Bluetooth] Use separate inquiry data structure
  o [Bluetooth] Track the class of device value
  o [Bluetooth] Use module parameter for ISOC alternate setting

Mark Haverkamp:
  o 2.6.9 aacraid: Support ROMB RAID/SCSI mode - Resend -
  o aacraid: 2.6 fix panic on module removal

Markus Lidel:
  o i2o: increase timeout for LCT_NOTIFY

Martin Josefsson:
  o Fix ALSA resume

Matt Mackall:
  o Fix concurrent access to /dev/urandom

Matt Porter:
  o ppc32: PPC4XX DMA polarity init fix

Matthew Wilcox:
  o SCSI: spi_transport set_signalling is buggy
  o Blacklist devices that falsely claim an echo buffer
  o [IA64]delay.h: udelay() should call cpu_relax()

Michael Hunold:
  o dvb: documentation update
  o dvb: collateral frontend changes
  o dvb: frontend driver refactoring
  o dvb: saa7146 changes
  o dvb: follow frontend changes in drivers
  o dvb: Cinergy T2 update
  o dvb: dibusb driver update
  o dvb: core changes
  o dvb: remove dead files
  o dvb: follow changes in dvb-ttpci and budget drivers
  o dvb: saa7146 driver + misc updates
  o dvb: B2C2 driver splitup
  o dvb: update dib-usb driver
  o dvb: dvb-core update
  o dvb: frontend update
  o dvb: av7110 driver update

Mike Miller:
  o cciss: cciss_ioctl return code fix
  o cciss: cciss_ioctl return code fix

Mitchell Blank Jr.:
  o [IPV4]: Do not use udp_poll for RAW sockets

Nathan Scott:
  o [XFS] Low memory allocation improvements (quietness and blockdev
    congestion checks).
  o [XFS] Mark several functions as being static

Nick Piggin:
  o Fix broken domain debugging (aka "isolcpus option broken")

Nicolas Pitre:
  o [ARM PATCH] 2301/1: fix PXA definition of PSSR_OTGPH
  o [ARM PATCH] 2289/2: turn off PXA clock to MMC block when not in use

Nishanth Aravamudan:
  o USB: add wake-up for waitqueues in usbfs_remove_file() to fix bug
    387

Olaf Hering:
  o dvb: Kconfig help typo fix

Parag Warudkar:
  o ohci1394.c - Correct kmalloc usage in interrupt

Pascal Lengard:
  o [ide] atiixp: add new PCI identifier

Patrick McHardy:
  o [PKT_SCHED]: Fix hard freeze with QoS in 2.6.10-rc3
  o [NETFILTER]: Fix memory leak in ip_conntrack_ftp
  o [PKT_SCHED]: Fix oops in ipt action error path
  o [PKT_SCHED]: Keep netem queue running until inner qdisc is empty

Paul Mackerras:
  o PPC64: close firmware stdin
  o ppc64: make sure lppaca doesn't cross page boundary
  o ppc64: make UP kernel run on POWER4 logical partition
  o ppc64: fix signal handler arguments
  o ppc64: fix single-stepping into/out of signal handlers
  o ppc64: fix signal mask restoration when delivery fails

Pavel Machek:
  o swsusp bugfixes: do not oops when not enough memory during resume
  o swsusp bugfixes: fix memory leak
  o swsusp fixes: fix confusing printk
  o swsusp: Fix header typo
  o swsusp: fix types

Pavel Pisa:
  o VM86 interrupt emulation fix

Pawel Sikora:
  o gcc4 fixes

Philip R. Auld:
  o fix memory leak in free_percpu

Pierre Ossman:
  o [MMC] Add Winbond SD/MMC driver

Randy Dunlap:
  o PCI/x86-64: build with PCI=n

Richard Purdie:
  o [ARM PATCH] 2315/1: PXA PCMCIA Suspend/Resume bugfix

Roland McGrath:
  o fix bogus ECHILD return from wait* with zombie group leader
  o back out CPU clock additions to posix-timers

Russell King:
  o [SERIAL] Add missing definition for PORT_IMX
  o [ARM] Ensure user ops pass 64-bit constants in even,odd registers
  o [ARM] Add per_cpu data area to linker script
  o [SERIAL] Ensure correct units for close_delay and closing_wait
  o [ARM] Add platform-based IrDA device support
  o [ARM] Add resources for sa11x0ir device
  o [ARM] Fix compiler warning for set_speed irda method
  o [ARM] Fix ZBOOT_ROM configuration
  o [ARM] Clean up vector support code
  o [ARM] Deny user space mappings in first page even on hi-vec CPUs
  o [ARM] Add missing newline to a printk message

Rusty Russell:
  o ip_conntrack_irc:parse_dcc should be static
  o Fix return value when proc file creation fails in ip_conntrack

Santiago Leon:
  o fix buffer starvation race in ibmveth

Solar Designer:
  o [TCP]: Missing KERN_INFO in remotely triggerable printk

Sreenivas Bagalkote:
  o megaraid: fix a bug in kioc dma buffer deallocation

Stelian Pop:
  o enable meye even when CONFIG_HIGHMEM64G=y
  o correct dma_set_mask return code in DMA-API.txt

Stephen Hemminger:
  o [PKT_SCHED]: netem forgets to restart device after inserting
    packets
  o [TCP]: Missing newline character in printk

Steve French:
  o [CIFS] ignore guest mount option do not log warning on it
  o [CIFS] treat NTFS junctions (reparse points) as directories rather
    than symlinks since we can not follow them
  o [CIFS] Add cifs serverino mount parm to allow use of inode numbers
    reported from the server (rather than generated by the client). 
    Some apps require inode numbers to persist or inode numbers of
    hardlinked files to match and  this requires trusting the servers
    inode number.
  o [CIFS] level 261 findfirst part one (will help with returning
    stable server inode numbers from Windows servers)
  o [CIFS] level 261 findfirst part 2
  o [CIFS] cifs readdir fixes part 1
  o cifs readdir fixes part 2
  o [CIFS] cifs readdir changes part 3
  o [CIFS] CIFS readdir fixes part 4
  o [CIFS] Improve SMB transact2 error checking and fix typo in warning
    message
  o [CIFS] smb transact2 cleanup
  o CIFS: additional smb trans2 cleanup
  o [CIFS] Improve SMB buffer allocation make SMB sending more
    efficient part 1
  o [CIFS} cifs readdir part 5
  o [CIFS] cifs readdir changes part 6
  o [CIFS] POSIX ACL support part 1
  o [CIFS] cifs readdir changes part 7
  o [CIFS] cifs readdir rewrite part 8
  o [CIFS] cifs readdir rewrite part 9 - fix unicode strlen to be more
    readable following Shaggy's suggestion
  o [CIFS] POSIX ACL support part 2
  o [CIFS] POSIX ACL support part 3
  o [CIFS] cifs readdir changes part 10 remove unneeded debug function
  o [CIFS] fix ls -l warning on dirs when POSIX ACLs enabled
  o [CIFS] cifs readdir part 11.  Also renames unused
    /proc/fs/cifs/QuotaEnabled config switch to NewReaddirEnabled for
    turning on testing of new readdir code
  o [CIFS] Add setfacl support to cifs
  o [CIFS] cifs readdir rewrite fix resume key handling
  o [CIFS] CIFS buffer management improvements part 1
  o [CIFS] minor cleanup to cifs buffer allocation code
  o [CIFS] fix size of cifs small buffers to just barely fit within
    slab limit (which appears to be 116 bytes), otherwise they take 1
    page each.
  o [CIFS] Set inode number properly on new cifs_readdir code to
    Windows servers
  o [CIFS] fix error mapping on getfacl to windows and old samba
    servers to map to EOPNOTSUPP so the kernel's fall back mechanism
    works
  o [CIFS] Update Kconfig to make CIFS POSIX ACLs dependent on xattrs
    and fix related ifdef in fs/cifs/xattr.c
  o [CIFS] Add missing quote to cifs kconfig item
  o [CIFS] Make new cifs readdir code the default and rename the proc
    entry to /proc/fs/cifs/ReenableOldCifsReaddirCode (which is off by
    default, causing the new cifs_readdir2 code to be executed by
    default)
  o [CIFS] Fix endianness bug in new cifs_readdir2 in calculating dir
    entry name length. Fix "badness in" message on rmmod cifs caused by
    rename of /proc/fs/cifs/NewReaddirEnabled config switch (pointed
    out by Shaggy).   
  o add direct mount options to optionally bypass the page cache on
    reads and writes
  o [CIFS] zero more of SMB param area on SMB allocation
  o [CIFS] fix spelling of CONFIG_CIFS_EXPERIMENTAL ifdef in direct i/o
    write
  o [CIFS] cleanup various warning/debug messages
  o [CIFS] add debug message for trusted and security xattrs
  o [CIFS] Increase size of small SMB pool (and decrease number) and do
    not zero the beginning of the header twice.
  o [CIFS] parse ipv6 addresses on mount (ipv6 support for cifs part 2)
  o [CIFS] Check right mid state on hung network responses.  Fix remote
    dnotify to be disabled by default. Fix dnotify endianness.
  o [CIFS] Do not block on FindNotify response
  o [CIFS] Allow peek to return less than smb header so we do not
    prematurely kill session to server when socket stack is busy.
  o Add support for module init parms for number of small and large
    cifs network buffers and for maximum number of simultaneous
    requests.  Fix directio of  userbuffers to use copy_to_user.
  o [CIFS] remove sparse warning
  o [CIFS] Remove sparse warning in use of cifs_write function
  o [CIFS] Fix CIFS_MAX_MSGSIZE so it can be configured at
    module_install time, allowing buffer size to be changed
  o return the right return code on failed ExtendedSecurity mount to
    SPNEGO enabled servers to avoid mount oops.  Fix case in which tcp
    stack only returns 3 bytes
  o [CIFS] Fix path based calls to consistently allow up to PATH_MAX
    (some were incorrectly limited to just over 512)
  o Error mapping workaround for NT4 bug of reporting oldstyle DOS
    error for ERR invalid level (shows up on attempts to do SetPathInfo
    to NT4)

Stéphane Eranian:
  o [IA64] fix pfm_force_terminate() to really cleanup the state
  o [IA64] perfmon.c: fix bug in previous "fix"

Takashi Iwai:
  o alsa: fix sleep in atomic during prepare callback
  o alsa: add pci_disable_device() to removal and error paths
  o alsa: fix iomem mmap
  o alsa: fix oops with ALSA OSS emulation on PPC

Thomas Graf:
  o [PKT_SCHED]: Fix double locking in tcindex destroy path
  o [PKT_SCHED]: Provide compat policer stats in action policer

Timothy Shimmin:
  o [XFS] xfs reservation issues with xlog_sync roundoff

Tom Rini:
  o ppc32: fix Motorola PReP (PowerstackII Utah) PCI IRQ map
  o Add missing __KERNEL__ (or other) protections
  o ppc32: Compile classic PPC specific ASM only on CONFIG_6xx

Tony Luck:
  o [IA64] delete offsets.h in mrproper, not in clean rule
  o [IA64] Delete: Documentation/ia64/serial.txt

Wensong Zhang:
  o [IPVS] add a sysctl variable to expire quiescent template

Zou Nanhai:
  o Fix a race condition in pty.c

