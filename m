Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261421AbRE2Q7U>; Tue, 29 May 2001 12:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbRE2Q7L>; Tue, 29 May 2001 12:59:11 -0400
Received: from zeus.kernel.org ([209.10.41.242]:47020 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261394AbRE2Q7D>;
	Tue, 29 May 2001 12:59:03 -0400
Date: Tue, 29 May 2001 16:55:16 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.5-ac4
Message-ID: <20010529165515.A17555@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

		 Intermediate diffs are available from
			http://www.bzimage.org

In terms of going through the code audit almost all the sound drivers still 
need fixing to lock against format changes during a read/write. Poll creating 
and starting a buffer as write does and also mmap during write, write during
an mmap.

2.4.5-ac4
o	APIC parsing updates				(Ingo Molnar)
o	Retry rather than losing I/O on an IDE DMA	(Jens Axboe)
	timeout.
o	Add missing locking to cs46xx			(Frank Davis)
o	Clean up sym53c416 and add PnP support		(me)
o	Tidy up changelog in apm.c			(Stephen Rothwell)
o	Update jffs2, remove abuse of kdev_t		(David Woodhouse)
o	Fix oops on unplugging bluetooth		(Greg Kroah-Hartmann)
o	Move stuff into bss on aironet4500		(Rasmus Andersen)
o	Fix up alpha oops output			(George France)
o	Update SysKonnect PCI id list			(Mirko Lindner)
o	Update SysKonnect GigE driver			(Mirko Lindner)
o	Add ATM DS3/OC12 definitions to atmdev.h	(Mitchell Blank)
o	Clean up atm drivers, fixed up user space	(Mitchell Blank,
	access with irqs off, kmalloc and use after	 John Levon)
	free.
o	Update input device/joystick/gameport drivers	(Vojtech Pavlik)
o	Update USB hid drivers				(Vojtech Pavlik)
o	Fix out of memory oops in hysdn			(Rasmus Andersen)
o	Belarussian should be Belarusian according to	(Nerijus Baliunas)
	the standards
o	Support booting off old 720K floppies		(Niels Jensen, 
							 Chris Noe)

2.4.5-ac3
o	Ignore console writes from an IRQ handler	(me)
o	Make SIGBUS/SIGILL visible to UML debugger	(Jeff Dike)
o	Clean up UML syscalls add missing items		(Jeff Dike)
o	Clean up non portable UML code			(Jeff Dike)
o	Fix off by one and other oddments in hostfs	(Henrik Nordstrom)
o	Update UML to use CONFIG_SMP not __SMP__	(Jeff Dike)
o	Fix UML crash if console is typed at too early	(Jeff Dike)
o	Clean up UML host transports			(Lennert Buytenhek,
							 Jim Leu)
o	Resynchronize UML/ppc				(Chris Emerson)
o	Fix UML crash if it had an address space hole	(Jeff Dike)
	between text and data
o	Fix rd_ioctl crash with initrd			(Go Taniguchi)
o	Fix IRQ ack path on Alpha rawhide		(Richard Henderson)
o	Drop back to older 8139too driver from 2.4.3
	| Seems the new one causes lockups
o 	Experimental promise fastrak raid driver	(Arjan van de Ven)

2.4.5-ac2
o	Restore lock_kernel on umount			(Al Viro)
	| Should cure Reiserfs crash in 2.4.5
o	Fix additional scsi_ioctl leak			(John Martin)
o	Clean up scsi_ioctl error handling		(me)
o	Configure.help typo fixes			(Nerijus Baliunas)
o	Fix hgafb problems with logos			(Ferenc Bakonyi)
o	Fix lock problems in the rio driver		(Rasmus Andersen)
o	Make new cmpci SMP safe				(Carlos E Gorges)
o	Fix missing restore flags in soundmodem		(Rasmus Andersen)
o	Set max sectors in ps2esdi			(Paul Gortmaker)
o	Fix interrupt restore problems in mixcom	(Rasmus Andersen)
o	Fix alpha compile on dp264/generic		(Andrea Arcangeli)
o	Fix irda irport locking restores		(Rasmus Andersen)
o	Fix failed kmalloc handling in hisax		(Kai Germaschewski)
o	Add missing memory barrier in qlogicisp		(?)
o	Fix missing restore_flags in eata_dma		(Rasmus Andersen)
o	Fix procfs locking in irttp			(Rasmus Andersen)
o	Winbond updates					(Manfred Spraul)
o	Stop network eating PF_MEMALLOC ram		(Manfred Spraul)
o	Drop fs/buffer.c low mem flush changes		(me)
o	Drop changes to mm/highmem.c			(me)
	| I don't think the Linus one is quite right but its easier
	| for everyone to be working off one base
o	Revert GFP_FAIL and some other alloc bits	(me)
o	Hopefully fix initrd problem			(me)
o	Fix kmalloc check in ide-tape			(Rasmus Andersen)
o	Fix irda irtty locking				(Rasmus Andersen)
o	Fix missing irq restore in qla1280		(Rasmus Andersen)
o	Fix proc/pid/mem cross exec behaviour		(Arjan van de Ven)
o	Fix direct user space derefs in eicon		(me)
	| From Stanford checker
o	Fix direct user space derefs in ipddp		(me)
	| From Stanford checker
o	Fix direct user space derefs in ixj		(me)
	| From Stanford checker
o	Fix direct user space derefs in decnet		(me)
	| From Stanford checker

2.4.5-ac1
o	Merge Linus 2.4.5 tree

Summary of changes for Linux 2.4.5-ac versus Linus 2.4.5

o	Fix memory leak in wanrouter
o	Fix memory leak in wanmain
o	Use non atomic memory for linearising NFS buffers as they are 
	done in task context
o	Fix dereference of freed memory in NetROM drivers
o	Fix writing to freed memory in ax25_ip
o	Support debugging of slab pools
o	NinjaSCSI pcmcia scsi driver
o	Raw HID device for USB peripheral buttons/controllers
o	Updated NTFS
o	RAMfs with resource limits
o	NMI watchdog available on uniprocessor x86
o	Update CMPCI drivers (not yet SMP safe)
o	Configurable max_map_count
o	Dynamic sysctl key registration
o	SE401 USB camera driver
o	Updated Zoran ZR3606x driver (replaces buz)
o	w9966 parallel port camera driver (partially merged with Linus)
o	Include headers in etags
o	Don't delete empty directories on make distclean
o	Fix halt/reboot handling on Alcor Alpha
o	IDE driver support for Etrax E100
o	IDE infrastructure support for IDE using non standard data transfers
o	Run ~/bin/installkernel if present
o	Support for out of order stores on x86 with this mode (IDT Winchip)
	- worth 20% performance on them
o	Configure level debugging menu
o	Make BUG() default to an oops only - saves 70K
o	Power management help for UP-APIC
o	Work around 440BX APIC hang (eg the ne2000 SMP hang)
o	Run time configurable APM behaviour (interrupts, psr etc)
o	Smarter DMI parser - handles multiple use of names
o	DMI layer has blacklist tables fixing Dell Inspiron 5000e crashes,
	PowerEdge reboot problems , and IBM laptop APM problems
o	PNPBios support
o	Fix atomicity of IRQ error count
o	Handle PCI/ISA boxes that don't list edge levels but have an ELCR
o	Don't erroneously mangle settings on all VIA bridges - cures the 
	horrible performance problem in 2.4.5 vanilla with VIA
o	Fix bootmem corruption on x86 boot
o	Scan and retrieve multipliers for processors (not yet used to handle
	the SMP cases where we need to disable tsc use)
o	Support machine check on Athlon and Pentium
o	Fix SUS violation with signal stacks
o	Handle boxes where firmware resets the timer to 18Hz (this should
	now not show false positives)
o	Better OOPS formatting on x86
o	Fix nasty problems with interrupts being disabled for long periods
	in frame buffer drivers
o	PAE mode alignment assumption fixes
o	32bit UID clean quota
o	Fix quota deadlocks
o	Fix TLB shootdown races
o	Experimental merge of usermode Linux
o	Fix memory leaks and othe rproblems with the iphase driver
o	IBM AS/400 iSeries virtual drivers
o	DAC960 null pointer checks
o	CCISS driver leak fixes
o	MPT fusion drivers for scsi and networking
o	Handle out of memory allocating request queue entries and avoid oops
o	Free the initial ramdisk correctly
o	Small CD-ROM layer updates
o	AGP power management hooks
o	First basic applicom driver fixes
o	Fix copy_from_user with interrupts off in cyclades driver
o	Fix out of memory handling in DRM
o	Clean up dsp56K driver
o	Update generic serial driver with break support
o	Clean up h8 driver namespace
o	Fix keymap changing problems in console drivers
o	Fix locking in machzwd
o	Updated rio serial driver
o	A2232 driver
o	Fix serial driver mangling of some clone uarts
o	Handle xircom serial port setup delay bug
o	Updated sx driver for newer generic_serial
o	W83877F watchdog driver
o	ITE8172 IDE driver support
o	Q40/Q60 IDE support
o	Fix nodma handling bug in alim15x3
o	hpt366 DMA blacklist
o	IDE-CD updates
o	Updated IDE DMA blacklist
o	OOPS catch for sg reuse in IDE driver
o	Support formatting of IDE floppies
o	Support PIIX4U4 (851EM)
o	Enable second port on promise pseudo raid
o	Support nodma on pmac
o	Support more PCI irq sharing on IDE
o	IDE tape updates - DI-50 support, 
o	Much updated VIA IDE support
o	video1394 updated to newer module API
o	Support write on the input event driver
o	Quieten mouse and keyboard input drivers
o	Fix compile problem with pc110pad
o	Fix memory leak in isdnppp
o	LVM updates
o	Fix plan b locking
o	Fix saa5249 locking
o	Fix stradis locking
o	Acenic driver updates
o	aironet4500 cleanups, probe tables
o	Ariadne updated to newer API
o	Don't limit mtu to 68+ in arlan drivers
o	Updated eepro100 driver
o	Fix potential crash on downing a bpqether port
o	Updated nsc-ircc driver
o	Updated toshoboe driver
o	Intel Panther LP486e ethernet driver
o	Remove erroneous check in eth_change_mtu
o	Alternative xircom_cb driver
o	Avoid ibm tr being rebuilt each make
o	Updated ibm token ring drivers
o	Add 'static' to bits of ppp code
o	Add pci probe table to roadrunner
o	Fix memory leak in sk_ge
o	sk_g16 updates
o	sk_mca updates
o	Add tools to generate starfire firmware
o	Synclink driver can be compiled in
o	Fix possible oops in lapbether
o	Fix memory leak in lanmedia driver
o	Fix SDLA_X25 warnings
o	Fix syncppp negotiation loop bug
o	GSC parallel port support
o	PCMCIA parallel port support
o	Support PnPBIOS probing for PC parallel ports
o	Fix leak in PCMCIA bulkmem driver
o	Fix leak in PCMCIA ds driver
o	Add more cards to the ti list for the yenta pcmcia
o	Updated 3ware scsi driver
o	NCR 53c700 and 53c700/66 driver core
o	Fix pci_enable/resource read order on buslogic
o	Updated NCR53c8xx driver
o	Updated SYM53c8xx driver
o	Fix NCR53c406 warnings
o	NCR dual MCA driver
o	AIC7xxx pci probe table for hotplug
o	Updated aic7xxx_old
o	Fix resource leaks in dec esp driver
o	Fix printk levels in dmx3191 driver
o	Allow per device max sector counts. (2.4 workaround until 2.5 does
	this in the block layer per device)
o	Support SCSI2/SCSI3 extended LUN numbering
o	Limit qlogicisp and qlogicpti to 64 sectors/write
o	Fix missing EFAULT return in scsi proc
o	Fix locking of scsi_unregister_host
o	Fix leaks in scsi_ioctl
o	Fix potential lost requests in scsi merges
o	Fix leak on write when scsi driver has no proc write op
o	Extend the scsi black/whitelist
o	Fix locking/eject/rescan on removable scsi disk media
o	Updated scsi generic driver
o	Updated scsi cdrom driver
o	Correct ac97 handling on sparc
o	Fix use after kfree in cs4281
o	Update ess solo to new PCI style and PM
o	Update maestro to new PCI style and PM
o	Add docking station support to maestro
o	Update sonicvies to new PCI api
o	Fix trident locking problems
o	Fix buzzing on ymfpci
o	Power management for ymfpci
o	Fix leak/missized copy on xjack driver
o	CDCEther driver
o	ACM driver with fixed CLOCAL
o	Updated USB audio drivers
o	Fix locking/reporting in USB device list
o	Allow dsbr100 to take a radio_nr option
o	HP5300 series USB scanner driver
o	Updated IBM cam driver
o	Fix USB inode locking
o	Driver for Kawasaki based USB ethernet
o	Small ov511 fixes
o	Updated USB storage drivers
o	Entries for Sony MSC-U01N memory stick, Fujifilm FinePix 1400Zoom,
	Casio QV Digial Camera
o	USB Ultracam driver
o	Fix derefence of freed memory in the USB code
o	Generic USB host->host drivers for anchorchip 2270, ipaq, netchip
	1080, and Prolific PL-2301/2
o	Updated ATI frame buffer drivers
o	Updated clgen and control frame buffer drivers
o	Updated cyber2000 driver
o	Documentation for fbcon driver
o	Additional modes for titanium powerbook (1152x768)
o	Updated matrxofb drivers
o	Support __setup in mdacon
o	Radeon console driver
o	Handle out of memory on sun3 fb
o	Updated tga/vesa fb
o	CMS file system (basic R/O)
o	JFFS journalling flash file system with compression
o	Updated AFFS file system
o	Threaded core dumps
o	Fix security holes in binfmt_misc
o	Allow flushing of low buffers only when we need bounce buffers
o	Use brelse in cramfs
o	Fix memory leaks in freevxfs
o	Updated isofs
o	Small lockd updates (experimental)
o	Fix nfs alignment funnies
o	Report correct SuS errors on some opens
o	Add generic_file_open to get 64bit stuff right
o	Locking on make_inode_number for procfs
o	Report shmem size in shared memory proc field
o	Fail lseek outside of allowed range for filesystem
o	Fix select race with fdset growth
o	Kernel message levels and handle oom on superblock/mount ops
o	Updated frame buffer logos
o	Prefetch support for AMD Athlon
o	Support out of order stores in spinlocks on x86
o	m68k bitop compile fixes
o	Add truncatepage op to address operations
o	shmem filesystem cleanups and updates
o	Fix off by one on real time pre-emption in scheduler
o	Use prefetches in scheduler and wakeups
o	Support GFP_FAIL to avoid highmem deadlocks
 
---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
