Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132922AbRDRACS>; Tue, 17 Apr 2001 20:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132925AbRDRACQ>; Tue, 17 Apr 2001 20:02:16 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6931 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132922AbRDRAB3>; Tue, 17 Apr 2001 20:01:29 -0400
Subject: Linux 2.4.3-ac9
To: linux-kernel@vger.kernel.org
Date: Wed, 18 Apr 2001 01:03:18 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E14pfRK-0003bR-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/

		Intermediate diffs are available from

			http://www.bzimage.org

VIA users should test this kernel carefully. It has what are supposed to be 
the right fixes for the VIA hardware bugs. Obviously the right fixes are not
as tested as the deduced ones.

You may well need to 'make clean' before building -ac8 as the GDT layout
has changed a little.

2.4.3-ac9
o	Fix ac8 pnpbios build bug			(me)
o	Fix ac8 sysrq build bug				(me)
o	Fix uml for new semaphores			(Jeff Dike)
o	Attempt to flush low memory buffers when short
	of bounce space on highmem machines		(Marcelo Tosatti)
o	Kill old filesystem_setup function		(Al Viro)
o	Small pnp bios tidy up				(me)

2.4.3-ac8
o	Restore wan router features backed out by the	(me)
	sangoma stuff Linus merged
o	Clean up #ifdefs in Sangoma code a bit		(me)
o	Fix missing kmalloc return checks in Sangoma 	(me)
o	Fix d_flags bit setting in knfsd		(Mikael Pettersson)
o	ACPI updates					(Andrew Grover)
o	Turn on winchip MCE				(Dave Jones)
o	IRDA USB driver fixups				(Dag Brattli, 
					Philipp Rumpf, Jean Tourrilhes)
o	Tidy up cpu capability mask reporting		(Rogier Wolff)
o	Refix icmp gcc warnings			(Andrzej M. Krzysztofowicz)
o	Remove 2.0 ioremap hacks from ISDN layer	(Kai Germaschewski)
o	Fix request_region ranges on hisax/bkm_a8	(Roland Klabunde)
o	Add rx fifo overlfow handling to pci hisax	(Werner Cornelius)
o	Hysdn driver updates				(Ulrich Albrecht)
o	Rewrite cisco hdlc keepalive code		(Bjoern Zeeb,
							 Kai Germaschewski)
o	Document CONFIG_TMSISA				(Jochen Friedrich)
o	Fix emu10k memory leak				(Hugh Dickins)
o	Fix i810 audio SMP lockups			(Doug Ledford)
o	Merge binfmt_elf changes for PPC	(Benjamin Herrenschmidt)
o	Make sysrq keybindings a clean API		(Crutcher Dunvant)
	| I think I caught all the sysrq updates from after
	| the patch was written and got them right - please check
o	Merge PnP bios enumeration and PnP BIOS		(Christian Schmidt,
	parport support			(Tom Lees, David Hinds, Gunther Mayer)
o	Bit more experimental work on fixing bounce	(Marcelo Tosatti, me)
	buffers

2.4.3-ac7
o	Updated VIA quirk handling for the chipset	(Andre Hedrick,
	flaws						 George Breese)
	| Experimental version removed
	| VIA users should check this kernel -carefully-!!!!
o	Remove KT7 dma kill				(me)
	| See above note
o	Merge Linus 2.4.4pre3
o	Fix winchip1 oops in mtrr from previous change	(me)
o	Add winchip3 support to mtrr/oostore		(me)
o	Fix the Zoran driver build			(me)
	| This is still not up to date with the master copy
	| that is intentional - first things first.
o	Fix CONFIG_WINCHIP kernel crash on cpu with	(me)
	fxsave
o	Fix UML options help bug			(Jeff Dike)
o	Fix pte corruption in user mode linux		(Jeff Dike)
o	Fix gdb and terminal initialisation in UML	(Jeff Dike)
o	UML code cleanup				(Jeff Dike)
o	Fix saved register corruption in UML		(Jeff Dike)
o	Add pci_disable_device				(Jeff Garzik)
o	Fix a slight bug in the parport help		(Tim Waugh)
o	Hopefully fix the sb1000 driver irq support	(James Anderson)
o	Fix missing signal lock in keventd		(Manfred Spraul)
o	Fix module build with io debugging on		(Markus Kossmann)
o	Fix dcache flag atomicty			(Al Viro)
o	Make cs4281 use pci_set_dma_mask, clean up 	(Jeff Garzik)
	wrappers
o	Use pci_set_dma_mask on maestro3		(Jeff Garzik)
o	Fix 3270 driver build bug 			(Dick Hitt)
o	Fix accidental sb driver bug revert		(Jeff Garzik)
o	Clean up PCI dependancies in sound drivers	(Jeff Garzik)
o	Update synclink driver				(Paul Fulghum)
o	rtl8139 driver update				(Jeff Garzik)
o	Update ps/2 esdi fixes to correct DMA access	(Hal Duston)
o	More aha1542 code marked __init			(Matthias Hanisch)
o	More random.c code marked __init		(Matthias Hanisch)

2.4.3-ac6
o	Remove tables.h include from fatfs_syms		(OGAWA Hirofumi)
o	Update UML					(Jeff Dike)
o	Protect more __KERNEL__ only stuff from 	(Phil Copeland)
	asm-alpha/io.h
o	Fix sound/Config.in bug with ARM		(Russell King)
o	Update network drivers for ARM bits		(Russell King)
	| 8390, pcnet_cs, tulip
o	Fix umount cleanups				(Al Viro)
o	Merge aic7xxx driver 6.11			(Justin Gibbs)
o	Added support for the pentium machine check	(me)
	| Also including thermal check
o	Add support for the winchip machine check	(me)
o	Fix mtrr support of the WinChip2		(me)
	| Existing code set uncachable not write gathering on winchip2
o	Support weak ordering mode on winchip cpus	(me)

2.4.3-ac5
o	Merge Linus 2.4.4pre1
o	New rwsem implementation			(David Howells)
o	Fix rwsem compile problem			(me)
o	Fix bust_spinlocks build fail if !CONFIG_VT	(me)
o	Merge Linus 2.4.4pre2 except for ipv6
o	Fix the corner case non zeroing bug in 		(me)
	copy_from_user for x86

2.4.3-ac4
o	Fix corruption case in ext2 inode handling	(Ingo Molnar, Al Viro)
o	Merge user mode linux port			(Jeff Dike)
o	Remove some surplus ifdefs from init/main.c	(me)
o	Update nwfpe					(Russell King)
o	Fix ps2esdi driver				(Hal Duston)
o	Update ARM documentation			(Russell King)
o	Update Symbios 53c8xx driver			(Gérard Roudier)
o	ARM frame buffer update				(Russell King)
o	Update ARM bootstrap code			(Russell King)
o	Eicon driver fix				(Armin Schindler)
o	Update S/390 Documentation			(Utz Bacher, Carsten
o	Update S/390 math emulation			 Otte, Holger Smolinski
o	S/390 tape driver				 Martin Schwidefsky
o	PAGEX support for Linux/390 under VM		 and probably others)
o	General S/390 fixes
o	Update S/390 tty drivers
o	Update S/390 irq handling
o	Update S/390 channel driver
o	Update S/390 include files
o	Update S/390 networking drivers
o	Update S/390 DASD drivers
o	Update S/390 mm to match generic mm changes
o	Update S/390 makefiles
o	Catch another subspecies of misidentifying CD	(Bob Mende Pie)
o	Fix bluesmoke formatting			(Solar Designer)
o	Fix rx error handling in rtl8139		(Jeff Garzik)
o	Update paths to e2fsprogs			(Steven Cole)
o	Fix proc alloc map locking			(Tom Leete)
o	Console blanking fix (continued..)		(Mikael Pettersson)
o	ARM tools update				(Russell King)
o	Update ARM includes				(Russell King)
o	Update ARM sound drivers			(Russell King)
o	Update the shark ARM support			(Alexander Schulz)
o	Update SA1100 support				(Russell King,
							 Nicolas Pitre)
o	Update ARM make and config files		(Russell King)
o	Update ARM mm/fault handling			(Russell King)
o	Update ARM network driver config		(Russell King)
o	Misc ARM updates				(Russell King)
o	Update ARM footbridge code			(Russell King)
o	EBSA ISA bus fixups				(Russell King)
o	Fix agp copy_from_user bug			(Dawson Engler)
o	Correct devfs docs on /dev/sg			(Herbert Xu)
o	/dev/sg doc update 				(Douglas Gilbert)

2.4.3-ac3
o	Fix console unblank from suspend bug		(Mikael Pettersson)
o	Fix unmap_buffer() race				(Al Viro)
o	Add a proper dmi blacklist			(me)
o	Fix alpha build for new mm changes		(Ivan Kokshaysky)
o	Resync setup-bus.c to pick up Alpha Noritake	(Ivan Kokshaysky)
	fixes
o	Fix swap accounting for major faults		(Marcelo Tosatti)
o	Add some bigendian support and voodoo5 support	(Ani Joshi)
	to tdfxfb
o	Fix failing build with CONFIG_VT=n		(Jason McMullan)
o	Fix some corner cases in iso9660 support	(Andreas Eckleder)
	for symlinks and XA attriubtes
o	Fix NTFS and quota sparc build problems on -ac	(Steve Ralston)
o	Resync to the Linus serial.c + B9600 fix	(me)
o	Avoid nasties with OHCI controller gets no IRQ	(Arjan van de Ven)
	assigned
o	Pull problem lance change			(Jeff Garzik)
o	Fix SMP lockup in usbdevfs			(Tony Hoyle)
o	Firestream atm update			(Patrick van de Lageweg)

2.4.3-ac2
o	Add the VIA C3 to the mtrr/setup code		(Dave Jones)
o	Report PAE mode oopses better			(Ingo Molnar)
o	Fix zap_low_mappings on PAE			(Hugh Dickins)
o	Tidy up parport resource handling, fix bug	(Tim Waugh)
o	Add series 6 backpack driver support		(Tim Waugh)
o	Make lockd use daemonize()			(Paul Mundt)
o	Fix aicasm to specify -I flags needed on some	(Mads Jørgensen)
	distributions
o	Add docbook manual on bus independant I/O	(Matthew Wilcox)
	| + a few additional notes I added
o	Make the VIA superIO driver honour the		(Tim Waugh)
	irq/dma settings passed
o	Update mpt fusion drivers			(Steve Ralston)
o	Add reiserfs maintainer entries			(Steven Cole)
o	Experimental driver for communcation class USB	(Brad Hards)
	| eg Broadcom and Ericsson USB cable modems
o	I2O updates, report SMART errors on i2o_block	(Boji Kannanthanam)
o	Fix shm locking, races on swapping, accounting	(Stephen Tweedie)
	and swapout of already mapped pages
o	Clean up REPORTING-BUGS				(Steven Cole)
o	Fix ACM handling of CLOCAL			(Vojtech Pavlik)
o	Fix sparc64 module_map/vfree bug		(Hugh Dickins)
o	Fix scsi race on requeued requests		(Mark Hemment)
o	Tulip driver update				(Jeff Garzik)
o	Update bmac and gmac driver			(Cort Dougan)
o	Winbond w9966cf webcam parport driver		(Jakob Kemi)

2.4.3-ac1
o	Merge Linus 2.4.3 final, diff versus 2.4.3	(me)

2.4.2-ac28
o	Fix another modules race			(me)
o	Add basic PM hooks to agpgart			(me)
o	Update new xircom_cb driver			(Arjan van de Ven)
o	Fix missing lock_kernel on truncate path	(Al Viro)
o	Update klsi usb ethernet ids			(Brad Hards)
o	Fix missing permission check in shm code	(Matthew Klahn)
o	Add extra doupdate() calls to menuconfig	(Moritz Schulte)
o	Update wireless extensions			(Jean Tourrilhes)
o	Fix cdda reading problem			(Jens Axboe)
o	Fix potential oops in usb-uhci			(David Brownell)

2.4.2-ac27
o	Rely on BIOS to setup apic bits on OSB4		(me)
o	Disable events when unloading cardbus yenta	(me)
	| Fixes shared irq unload hang
o	Fix x86 IPI replay problems			(Stephen Tweedie)
o	Add ALS100 gameport support			(Vojtech Pavlik)
o	Fix wrong path in comment in vesafb		(Andres Salomon)
o	Allow slab caches to force alignment always	(Ingo Molnar)
	and thus fix PAE+ slab poisoning
o	Fix problems in faulting raw I/O pages		(Stephen Tweedie)
o	Fix rawio error handling for raw I/O		(Stephen Tweedie)
	| + other oddments
o	Change default max printer ports to 8		(Tim Waugh)
o	Parport soft control state fixes		(Tim Waugh)
o	Fix cpu info compile				(Constantine Gavrilov)
o	Set warning levels on reiserfs warn etc		(Paul Mundt)
o	Fix duplicate IOVIRT debug config help		(Steven Cole)
o	Revert mmap change that broke assumptions (and	(Martin Diehl)
	it seems SuS) 
o	Clean up fpu emu warnings on gcc 3.0cvs a bit	(me)

2.4.2-ac26
o	Fix es1370 build bug				(me)
o	Fix sbpcd compile warnings			(me)
o	Update usbnet driver				(Oleg Drokin)
o	Update Alpha to pre8 vm changes			(Ivan Kokshaysky)
o	Fix radeonfb config selections			(Chris Lawrence)
o	Fix vmalloc mismerge				(Various)
o	Fix n_r3964 console panic			(Andrew Morton)
o	Update ibm camera drivers
o	Support 701b toshoboe fir
o	New xircom_cb driver		(Arjan van de Ven, Jeff Garzik,
					 Don Becker, Doug Ledford)
o	Fix procfs mount point for binfmt_misc		(Al Viro)
o	Update hpt366 ide blacklist
o	Further ide blacklist updates
o	Smooth vm balancing				(Marcelo Tosatti)
o	Fix irda assert					(Arjan van de Ven)
o	Keep contrack cache sizes sane			(Ben LaHaise)
o	Fix possible file truncate/write race		(Ben LaHaise)
o	Make bootmem panic sanely on out of memory	(Ben LaHaise)
o	Fix unload crash in pci_socket			(me)
o	Revert previous wrong bootmem change		(Ben LaHaise)

2.4.2-ac25
o	Handle PCI/ISA simple MP tables via ELCR	(John William)
o	Fix get_sb_single				(Al Viro)
o	Update es1370, es1371,esssolo			(Thomas Sailer,
							 Tjeerd Mulder,
							 Nathanial Daw)
o	Update orinoco_cs				(Jean Tourilhes)
o	Fix races found in the new kbd/console code	(Andrew Morton)
o	Remove dead timer.h docs			(Tim Wright)
o	Update ppc to new generic mm changes		(Paul Mackerras)
o	Clean up mdacon					(Paul Gortmaker)
o	Remove duplicate configure.help texts		(Steven Cole)
o	Fix symbol export for shm_file_open		(Keith Owens)
o	First batch of pointer reference bug fixes	(Andrew Morton)
	from Stanford report
o	Fix de4x5 oops on Alpha XP1000			(George France)
o	Chipsfb update					(Paul Mackerras)
o	Fix higmem block_prepare_write crash		(Stephen Tweedie)
o	Bring PAE36 back up to date, handle x86 errata	(Ingo Molnar)
o	Fix ov511 crash if opened while loading		(Pete Zaitcev)
o	Merge Linus 2.4.3pre8
o	Update Advansys scsi driver			(Bob Frey)

2.4.2-ac24
o	Fix build bug with tsc in ac23			(me)
o	Update contact info for Phil Blundell		(Phil Blundell)
o	Update mm locking comments/rss locking		(Andrew Morton)
o	Update toshiba SMM driver			(Jonathan Buzzard)
o	Update old adaptec driver to 5.2.4		(Doug Ledford)
o	CS46xx updates					(Tom Woller)
o	Quieten input layer printks a bit		(me)
o	Turn off APIC_DEBUG by default to cut noise down(me)
o	Add Orinoco PCMCIA wireless support		(David Gibson)
o	Go back to 2.4.3pre6 tulip			(Jeff Garzik)
o	Fix double accounting of cpu time bug		(Kevin Buhr)
o	Drop ppp patch					(me)

2.4.2-ac23
o	Fix a nasty shared memory locking bug		(Stephen Tweedie)
o	Fix off by one bootmem memory corruptor		(Ben LaHaise)
o	Fix avmb1 oops on init				(Carsten Paeth)
o	Fix isdn makefile bugs				(Kai Germaschewski)
o	Clean up isdn minor checks			(Julien Gaulmin)
o	Workaround PPP CCP negotiation bugs		(Kai Germaschewski)
o	Fix timer handling bug in ISDN			(Henk-Jan Slotboom)
o	Fix i386 #ifdef bug with notsc disable		(Anton Blanchard)
o	Fix NMI docs					(Keith Owens)
o	Fix oops on out of memory in proc_symlink	(me)
	| Found by Stanford tools
o	Fix oops caused by devfs changes to soundcore	(me)
	| Found by Stanford tools
o	Fix rmmod crash on sundance alta		(me)
	| Found by Stanford tools
o	Fix potential crash in nsc-ircc.c		(me)
	| Found by Stanford tools
o	Fix memory leak in i810 audio			(Doug Ledford)
o	Fix several compile warnings with gcc 3.0 cvs	(J Magallon)
o	Mark 60Hz modes in mac fb modes 		(Geert Uytterhoeven)
o	Chkconfig and ver_linux updates			(Niels Jensen)
o	Fix ctrlfb dac timing				(Takashi Oe)
o	Add vesa powerdown support for ctrlfb		(Takashi Oe)
o	Back out problem via bridge change		(me)
o	Fix bug in aironet4500_cs changes		(Arjan van de Ven)

2.4.2-ac22
o	Fix dereference after free in megaraid driver	(me)
o	Fix crash if we run out of memory during a link	(me)
	follow [found by Stanford tools]
o	Fix crash if we run out of memory during
	block_truncate_page [found by Stanford tools]	(me)
o	Update Alpha to pre6 style pte/pmd_alloc	(Ivan Kokshaysky)
o	Fix ppp memory corruption			(Kevin Buhr)
	| Bizzarely enough a direct re-invention of a 1.2 ppp bug
o	Fix heavy stack usage in tty_foo_devfs()	(Jeff Dike)
o	Make alloc_tty_struct always use kmalloc	(Andrew Morton)
o	Document task struct locking rules		(Andrew Morton)
o	Document SAK properly				(Andrew Morton)
o	Fix SAK deadlocks				(Andrew Morton)
o	Fix inline/type order for picky compiler tools	(Dave Jones)
o	Fix printk levels for various fs printks that	(Andrey Panin)
	lacked them
o	Next incarnation of the i810 audio driver	(Doug Ledford)
o	Add __init stuff to 3c515 driver	(Andrzej Krzysztofowicz)
o	Add __init stuff to ppp layer		(Andrzej Krzysztofowicz)
o	Remove duplicate NF_TARGET_TCPMSS config text	(Steven Cole)
o	Fix missing unlock_kernel in pcwd		(me)
	| Found by Stanford tools
o	Fix missing unlock_kernels in es1371		(me)
	| Found by Stanford tools
o	Fix missing unlock_kernels in es1370		(me)
	| Found by Stanford tools
o	Fix missing unlock_kernels in esssolo1		(me)
	| Found by Stanford tools
o	Fix missing unlock kernels in sonicvibes	(me)
	| Found by Stanford tools
o	Fix missing unlock kernels in fb mmap		(me)
	| Found by Stanford tools
o	Fix missing unlock_super in UFS code		(me)
	| Found by Stanford tools


2.4.2-ac21
o	Merge with Linus 2.4.3pre6
o	Close last known reiserfs tail bug		(Chris Mason)
o	Fix link order bug with iso8859_8 and cp1255	(Dan Aloni)
o	Generate generic CPU namings for 386/486	(Cesar Eduardo Barros)
o	First set of ISDN fixes from Stanford code	(Kai Germaschewski)
	analyser
o	Allow up to 16 parallel ports by default	(Tim Waugh)
o	Use long delays on low speed usb hub ports	(Pete Zaitcev)
o	Update credits for assorted Australians		(Stephen Rothwell)
o	Fix ali_restore_regs thinko			(Pavel Roskin)
o	Fix whiteheat usb driver bugs			(Greg Kroah-Hartman)
o	Fix kfree in belkin_sa				(Greg Kroah-Hartman)
o	Fix omninet copy*user bug			(Greg Kroah-Hartman)
o	Fix modular atyfb				(Geert Uytterhoeven)
o	Update joystick and input drivers		(Vojtech Pavlik)
o	Relax checksum enforcement on ISAPnP CSN	(Gunther Mayer)
o	Resync ids/comments with ISDN cvs		(Kai Germaschewski)
o	Update Harald Hoyer Credits entry		(Harald Hoyer)
o	Fix off by 2* mtrr handling bug			(David Wragg)
o	Fix irda hang on boot				(Dag Brattli)
o	FB device init updates				(Geert Uytterhoeven)
o	Add it8712 misp eval board support		(P. Popov)
o	Update NEC DDB5476 eval board support		(Jun Sun)
o	Update NEC DDB5074 eval board support		(Ralf Baechle)
o	Add Karsten Merker and Michael Engel to credits	(Ralf Baechle)
o	Update Baget port				(Vladimir Roganov,
							 Gleb Raiko)
o	Add LVM ioctls to sparc64 ioctl32 convertor	(Patrick Caulfield)
o	Powerpc updates for openfirmware mm, python etc	(Cort Dougan)
o	Add the casio qv digitalcamera to the usb
	unusual devices list				(Harald Schreiber)
o	atyfb mode updates for powermac			(Olaf Hering)
o	Fix khubd locking				(Pete Zaitcev)
o	More on the great aic7xxx libdb game		(Nathan Dabney)
o	Further console handling updates		(Andrew Morton)
o	Fix i2o build problem when half modular		(Michael Mueller)
o	Fix off by one in prink <foo> check		(Mitchell Blank Jr)
o	Fix do_swap_page hang				(Linus Torvalds)

2.4.2-ac20
o	Add support for the GoHubs GO-COM232		(Greg Kroah-Hartman)
o	Remove cobalt remnants				(Ralf Baechle)
o	First block of mm documentation			(Rik van Riel)
o	Replace ancient Zoran driver with new one	(Serguei Miridonov,
				Wolfgang Scherr, Rainer Johanni, Dave Perks)
o	Fix Alpha build					(Jeff Garzik)
o	Fix K7 mtrr breakage				(Dave Jones)
o	Fix pcnet32 touching resources before enable	(Dave Jones)
o	Merge with Linus 2.4.3pre4

2.4.2-ac19
o	Typo fixes					(David Weinehall)
o	Merge first block of OHCI non x86 support	(Greg Kroah-Hartman)
o	Add Edgeport USB serial support			(David Iacovelli,
							 Greg Kroah-Hartman)
o	Fix doorlock on scsi removables			(Alex Davies)
o	Fix hang when usb storage thread died		(me)
o	Change watchdog disable setup			(Ingo Molnar)
o	Fix bluetooth close and error bugs		(Narayan Mohanram)
o	mpt now has an assigned minor			(me)
	| Remember to fix your /dev/mptctl if using MPT
o	Clean up 3270 ifdefs/printk a little		(me)
o	Fix NBD deadlocks and update it 		(Steve Whitehouse)
o	Fix sercon printk divide by zero bug		(Roger Gammans)
o	Remove cosine support from MIPS tree		(Ralf Baechle)
o	bust_spinlocks for Alpha			(Jeff Garzik)
o	Hopefully fix the buslogic corruptions		(me)
	| This is a 'test if they went away' release not a 'its fixed' one.
o	Some mips makefile fixes			(Ralf Baechle)
	| except mips/kernel/Makefile (I got .rej Ralf)
o	ARC firmware interface fixes			(Harald Koerfgen)
o	DECstation console drivers			(Michael Engel,
							 Karsten Merker,
							 Harald Koerfgen)
o	Fix ipx build bug				(Anton Altaparmakov)
o	Fix ptrace race 				(Stephen Tweedie)
o	Update include/config.h stuff, ver_linux	(Niels Jensen)
o	Add missing pci_enable_device to cs4281		(Marcus Meissner,
							 Thomas Woller)
o	Fix non PPC build of clgenfb			(Andrew Morton)
o	Update CPU docs					(Dave Jones)
o	Add mips atlas/malta reference boards		(Carsten Langgaard)
o	Add gt91600 ethernet support			(SteveL)
o	Add philips SAA9730 ethernet			(Carsten Langgaard)
o	PCnet32 driver fixes				(Carsten Langgaard)
o	MIPS fpu emulator	(Algorithmics, Ralf Baechle, Kevin Kissell, 
			Carsten Langgaard, Harald Koerfgen, Maciej Rozycki)
o	mips network driver updates			(Ralf Baechle)
o	Fix FC920 workarounds in i2o			(me)
o	Fix i2o_block hang on exit, 0 event race	(me)
o	FIx i2o_core thread kill wakeup race		(me)
o	Backport 2.2 VIA 686a clock reset workaround	(Arjan van de Ven)
o	Further documentation updates			(Matthew Wilcox)

2.4.2-ac18
o	Debian has another location for db3		(Marc Volovic)
o	Remove duplicated flush_tlb_page export on 	(Elliot Lee)
	Alpha
o	Fix SB Live! build on SMP Alpha			(Elliot Lee)
o	Fix disk corruption on qlogicisp and qlogicpti	(Arjan van de Ven)
o	Fix reporting of >4Gig of swap			(Hugh Dickins)
o	Fix sign issues in mpt fusion			(Andrew Morton)
o	CMS minidisk file system (read only)		(Rick Troth)
			2.4 port			(me)
o	Disable nmi watchdog by default			(Andrew Morton)
o	Fix elsa_cs eject problems			(Klaus Lichtenwalder)
o	Remove duplicate config entries			(Steven Cole)
o	Fix further wrong license references	(Andrzej Krzysztofowicz)
o	Add nmi watchdog disable for sysrq		(Andrew Morton)
o	Experimental test for serverworks/intel AGP	(me)
	comptability
o	Fix ipx reference counting for routes		(Arnaldo Carvalho
							 de Melo)

2.4.2-ac17
o	Make the aic7xxx code handle multiple db3 paths	(me)
o	Small further via updates			(Vojtech Pavlik)
o	IDE tape updates for Onstream tape drives	(Marcel Mol)
o	Remove some bits of module.c that cant get	(Keith Owens
	executed					 Andrew Morton)
o	Configure.help fixups				(Steven Cole)
o	Add Cyrix MTRR data				(Dave Jones)
o	Fix a slight bogon in the i386 Makefile		(Dave Jones)
o	Kill an escaped modversions.h			(Keith Owens)
o	Further controlfb fixes				(Takashi Oe)
o	Fix console driver oops	in new locking		(Andrew Morton)
o	Add 'broken-psr' so you can command line tell	(Neale Banks)
	APM your BIOS is crap
o	Fix serial console 				(Dave Jones)
o	Fix megaraid kernel_version string		(Arjan van de Ven)
o	Fix off by one error in cpia			(Andrew Morton)
o	Fix lost dmfe typo fix				(Torsten Duwe)
o	Take kernel_lock for i_truncate method in 	(Al Viro)
	vmtruncate
o	Fix i2c sign check bug				(Andrew Morton)

2.4.2-ac16
o	Uniprocessor APIC fixes for misdetect		(Mikael Pettersso)
o	Small ymf_pci fixes/updates			(Pete Zaitcev)
o	Fix break support on sx serial			(Rogier Wolff)
o	Kill another dead config.in entry		(Steven Cole)
o	Add bust spinlocks logic to S/390		(Neale Ferguson)
o	Fix ramdisk buffer only page bug		(Philipp Rumpf)
o	Mark ips scsi experimental until IBM ship a 	(Adam Lackorzynski)
	proper 2.4 driver
o	Update lanstreamer to use module_init and more	(Mike Sullivan)
o	Switch to the updated irda fixes		(Jean Tourrilhes)
o	Vaio kaweth ethernet apparently has its own id	(Sven Anders)
o	d_validate clean ups 				(Petr Vandrovec)
o	Network further fixes from DaveM and co		(Dave Miller
	| This might fix the reported masuqerade crashes Alexey Kuznetsov
							 Werner Almesberger)
o	Acenic updates					(Jes Sorensen)

2.4.2-ac15
o	Add CyrixIII specific kernel configuration	(me)
	| Note there are CyrixIII problems with some distribution installers
	| because -m686 gcc output will not run on a model 6 cpu with no
	| cmov. 
o	Fix aic Makefile for older gnu make		(Keith Owens)
o	Assorted i2o updates/partition handling fixes	(Boji Kannanthanam)
o	Fix dcache problems with ncpfs			(Petr Vandrovec)
o	Update via drivers to 3.22			(Vojtech Pavlik)
o	Account for packet bytes on lmc driver		(Ernst Lehmann)
o	Atyfb rearrange					(Geert Uytterhoeven)
o	Fix sedlbauer_cs build bug add elsa_cs		(Than Ngo)
	| 			elsa_cs driver by	(Klaus Lichtenwalder)
o	Add support for the Fuji FinePix 1400Zoon	(Nate)
o	EISA initialisation changes for 3c59x		(Andrzej Krzysztofowicz)
o	Assorted small net protocol updates		(Dave Miller)
o	Fix dvd physical read bug			(Jens Axboe)
o	Fix ATM hang on SMP 				(Mike Westall)
	| more work left to do on atm_ioctl for someone
o	Changed get_addr and friends to atm_get_addr	(me)
o	Merge Linus 2.4.3pre3
o	Fix do_BUG for both cases this time		(me)
o	Fix prefetch for Athlon build
o	Fix an lvm oops case				(Pete Zaitcev)
o	Remove dead config.in entry			(Steven Cole)
o	Update reiserfs recommended tool revision	(Steven Cole)
o	Kill a few warnings				(Keith Owens)

2.4.2-ac14
o	Fix the non build problem with do_BUG		(Andrew Morton)
o	Fix interface autocreation bug in ipx		(Arnaldo Carvalho
	Also fix pprop routing bugs, tctrl handling	 de Melo)
	Fix wrong comments, fix ipx sysctl handling
	clean up code
o	Updated i810_audio.c 				(Doug Ledford)
o	Fix up printer status readback			(Tim Waugh)
o	Add support for "ide=nodma" on command line	(Arjan van de Ven)
o	More spelling fixes				(Dag Wieers)
o	Add pci vendor table to lanstreamer		(Mike Sullivan)
o	Do extra sanity checks on ext2 mount		(Andreas Dilger)
o	Multithreaded core dump handling		(Don Dugger)
	| This is fairly experimental so the more eyes
	| the better but it does sort out a very annoying weakness
o	Prefetch on lists for parisc and x86		(Arjan Van de Ven,
	| Work about 4% on scheduler performance on PIII Matthew Wilcox)
o	Natsemi power management changes		(Tjeerd Mulder)
o	Fix assorted smb bugs				(Urban Widmark)
o	Fix a sisfb build problem			(Andrew Morton)

2.4.2-ac13
o	Clean up mad16 detection stuff			(Pavel Rabel)
o	Fix epca unload					(Andrey Panin)
o	Change null apic handling			(Maciej Rozycki)
o	aicasm now uses db3				(Sergey Kubushin)
o	Fix aic7xxx cross compile			(Cort Dougan)
o	Merge small net driver fixups/config fixes	(Jeff Garzik)
o	Update symbios drivers				(Gérard Roudier)
o	Rusty has moved					(Rusty Russell)
o	3c509/3c515 compile fixes			(Jeff Garzik)
o	Console locking updates - should fix vesafb	(Andrew Morton)
	clock problems
o	Merge the serial.c 5.0.5 update			(Jeff Garzik, 
							Ted Ts'o)
o	Merge SiS framebuffer updates			(Can-Ru Yeou)
o	Update ctrlfb					(Takashi Oe,
							 Michel Lanners)
o	Add epson 640U scanner to the usb scanner list	(Patrick Dreker)

2.4.2-ac12
o	Move the pci_enable_device for cardbus		(David Hinds)
o	Add Sony MSC-U01N to the unusual devices	(Marcel Holtmann)
o	Final smc-mca fixups - should now work		(James Bottomley)
o	Document kernel string/mem* functions		(Matthew Wilcox)
	| and I added a memcpy warning
o	Update VIA IDE driver to 3.21			(Vojtech Pavlik)
	|No UDMA66 on 82c686, fix /proc and udma on
	|686b, fix dma disables
o	Allow sleeping in ctrl-alt-del callbacks	(Andrew Morton)
	|Fix i2o, dac960, watchdog, gdth hangs on exit
o	Fix binfmt_misc (and make the proc handling	(Al Viro)
	|a filesystem -
	|mount -t binfmt_misc none /proc/sys/fs/binfmt_misc
o	Update the ACI support for sound/radio stuff	(Robert Siemer)
o	Add RDS support to miroRadio			(Robert Siemer)
o	Remove serverworks handling. The BIOS is our	(me)
	best (and right now only) hope for that chip
o	Tune the vm behavioru a bit more		(Mike Galbraith)
o	Update PAS16 documentation			(Thomas Molina)
o	Reiserfs tools recommended are now 0d not 0b	(Steven Cole)
o	Wan driver small fixes				(Jeff Garzik)
o	Net driver fixes for 3c503, 3c509, 3c515,	(Jeff Garzik)
	8139too, de4x5, defxx, dgrs, dmfe, eth16i, 
	ewrk3, natsemi, ni5010, pci-skeleton, rcpci45,
	sis900, sk_g16, smc-ultra, sundance, tlan,
	via-rhine, winbond-840, yellowfin, wavelan_cs
	tms380tr
o	Trim 3K off the aha1542 driver size	(Andrzej Krzysztofowicz)
o	Trim 1K off qlogicfas			(Andrzej Krzysztofowicz)
o	Fix openfirmware/mm boot on ppc			(Cort Dougan)
o	Fix topdir handling in Makefile			(Keith Owens)
o	Minor fusion driver updates			(Steve Ralston)
o	Merge Etrax cris updates			(Bjorn Wesen)
o	Clgen fb copyright update			(Jeff Garzik)
o	AGP linkage fix					(Jeff Garzik)
o	Update visor driver to work with minijam	(Arnim Laeuger)
o	Fix a usb devio return code			(Dan Streetman)
o	Resync a few other net device changes with the
	submits Jeff sent to Linus			(Jeff Garzik)
o	Add missing md export symbol			(Mohammad Haque)

2.4.2-ac11
o	Fix NLS Config.in				(David Weinehall)
o	Sort out one escaped revert from the megaraid	(me)
	update
o	Resync with Linux 2.4.3pre1
	| Except tulip the network driver changes have
	| been used to replace the existing ones
o	Fix parport case where a reader could get stuck	(Tim Waugh)
o	Add ALi15x3 to the list of isa dma hangs	(Angelo Di Filippo)
o	Fix nasty bug in IPX routing of netbios frames	(Arnaldo Carvalho
							 de Melo)
o	Misc code cleanups				(Keith Owens)
o	Updated 3c527 driver				(Richard Proctor)
o	Further tulip updates				(Jeff Garzik)
o	i810_rng fixes (FIPS test, regions)		(Jeff Garzik)
o	Further cs89x0 cleanups				(Andrew Morton)
o	Further USB hub updates				(Dave Brownell)
o	Mall USB resource cleanup			(Jeff Garzik)
o	Resync hp100 changes from Jeff Garzik		(Jeff Garzik)
o	PCI documentation update			(Tim Waugh)
o	Fix irda crash					(Jean Tourrilhes)
o	PPC updates					(Cort Dougan)
o	Resync dmfe, hamachi, pci-skeleton and winbond	(Jeff Garzik)

2.4.2-ac10
o	Add ZF-Logic watchdog driver			(Fernando Fuganti)
o	Add devfs support to USB printers		(Mark McClelland)
o	Fix baud rate handling on keyspan		(Paul Mackerras)
o	USB documentation update			(Dave Brownell)
o	Fix disconnect leak				(Randy Dunlap)
o	ARM constants/fixes				(Russell King)
o	Includes for integrator ARM architecture	(Russell King)
o	Update NLS descriptions to be clearer		(Pablo Saratxaga)
o	Add iso-8859-13 (latvian/lithuanian)		(Pablo Saratxaga)
	iso-8859-4, cp1251 (windows cyrillic), cp1255
	(windows hebrew), and some alises
o	Merge 1.14 Megaraid driver			(Venkatesh Ramamurthy)
o	Reapply other fixes this version dropped	(me)
o	Reformat and clean up ifdefs in 1.14 Megaraid	(me)
o	I/O apic locking fixes				(Maciej Rozycki)
o	Print ioapic id to help debugging		(Maciej Rozycki)
o	Make the tpqic driver work			(Hugh Dickins)
o	USB scanner updates				(David Nelson)
o	Fix usbdevfs multimount				(Al Viro)
o	Fix wrong calculation of path buffer size	(Hugh Dickins)
o	cs89x0 allocated far too much memory		(Hugh Dickins)

2.4.2-ac9
o	misc device fix (ps/2 and drm are now back)	(Tachino Nobuhiro)
	| Believe it or not my main test box used no misc
	| device files..
o	Radeon build without 8bit			(Cha Young-Ho)
o	Fix oops in scc driver				(Andrew Morton)
o	Add __setup for ISAPnP, update docs		(Jaroslav Kysela)
o	Update E820 table sanitizer			(Brian Moyle)
o	i810 audio updates/mmap fixes			(Doug Ledford)
o	Be paranoid about VIA chipset configurations	(Arjan van de Ven)
	| Fixing VIA disk corruption bugs take 2
o	Fix PPC request_irq problems, some fpu emu	(Cort Dougan)
	and timers
o	Allow scsi drivers to limit request sizes	(Jens Axboe,
	(and fixed by Tim)				 Tim Waugh)
o	Configure.help cleanups				(Steve Cole)
o	Loop device fix of the day			(Jens Axboe)
o	CDROM fixes					(Jens Axboe)
o	Reiserfs crash on fsync of dir fix	(Alexander Zarochentcev)

2.4.2-ac8
o	Fix loop over loop crash			(Jens Axboe)
o	Fix radeon build problems			(ISHIKAWA Mutsumi)
o	Stop two people claiming the same misc dev id	(Philipp Rumpf)
o	capable not suser on sx.c			(Rob Radez)
o	Fix an ixj build combination bug	(Andrzej Krzysztofowicz)
o	Add integrator to ARM machines			(Russell King)
o	ARM include/constant cleanups			(Russell King)
o	Update ARM vmlinuz.in				(Russell King)
o	ARM i2c fixes					(Russell King)
o	ARM scsi updates				(Russell King)
o	ARM header updates				(Russell King)
o	Handle E820 bios returns with overlaps		(Brian Moyle)
o	Fix a sparc64 include build bug		(Andrzej Krzysztofowicz)
o	Loop race fix					(Jens Axboe)
o	s_maxbytes wasnt set for old style compat	(Chris Dukes)
	mounts in reiserfs
o	Fix the fact we dont see all busses on some	(Don Dupuis)
	Compaq machines
o	Fix missing watchdog configure.help		(Jakob Ostergaard)
o	Fix oom deadlock (hopefully)			(Rik van Riel)
o	Fix binfmt_aout sign handling bug		(Andrew Morton)

2.4.2-ac7
o	Fusion driver updates				(Steve Ralston)
o	Olympic fix					(Andrew Morton)
o	Work around hardware bug in older Rage128	(Gareth Hughes)
o	Handle broken PIV MP tables with a NULL ioapic
o	Use capable in esp serial driver		(Rob Radez)
o	Use capable not suser in console		(Rob Radez)
o	Small networking fixups				(Dave Miller)
o	Fix make menuconfig breakage			(Keith Owens)
o	Enable cmpxchg8 on Rise P6			(Dave Jones)
o	Fix wakeup losses on cpu_allowed using tasks	(Manfred Spraul)
o	Maestro3 now works with > 256Mb of ram		(Zach Brown)
o	Opl3sa2 isapnp=0 handling was wrong		(Jérôme Augé)
	| I've fixed it a little differently however
o	Turn off slow kmem chain check if not doing	(Ingo Molnar, me)
	slab debugging
o	Fix cpu speed checking code			(Mikael Pettersson)
o	Make bus computation more accurate		(me)
o	Advantech watchdog driver			(Marek Michalkiewicz)
o	dz.c serial clean up				(Rob Radez)
o	Fix MSG_TRUNC for OOB TCP			(Ingo Molnar)
o	Fix oops on unconfigured loop			(Arjan van de Ven)
o	Drop nbd ll_rw_blk change			(Linus has spoken ;))
o	pci resource api				(Jeff Garzik)
o	Further Natsemi updates				(Don Becker, 
							 Jeff Garzik)
o	Switch aurora serial to capable()		(Rob Radez)
o	Radeon frame buffer				(Ani Joshi)

2.4.2-ac6
o	Remove incorrect modules doc changes		(Keith Owens)
o	Fix elf.h defines				(Keith Owens)
o	Add 0x2B mtrr decode for intel/cyrix III	(me)
o	Make bigmem balancing somewhat saner		(Mark Hemment)
o	Update irda 					(Dag Brattli)
o	New FIR dongle support				(Dag Brattli)
o	3ware driver updates				(Adam Radford)
o	Further reiserfs tail conversion fixes		(Chris Mason)
o	Fix tpqic02 to use capable			(Rob Radez)
o	Set last_rx on comtrol hostess driver		(Arnaldo Carvalho 
							 de Melo)
o	Raid Oops fix					(Neil Brown)
o	Fix last_rx/skb refs on cyc_x25			(Arnaldo Carvalho 
							 de Melo)
o	Fix last_rx/skb refs on 3c589			(Arnaldo Carvalho 
							 de Melo)
o	Highmem fixes for deadlock			(Andrea Arcangeli,
							 Ingo Molnar)
o	Another minor tulip fix				(Jeff Garzik)
o	Fix hinote and maybe other ps/aux hangs		(me, Mark Clegg)
o	Fix resource handling on 53c7xxx		(Rasmus Andersen)
o	Fix scsi_register failure handling on AMD scsi	(Rasmus Andersen)
o	Fix resource handling on aha1740		(Rasmus Andersen)
o	Fix resource handling on blz1230		(Rasmus Andersen)
o	Fix resource handling for dec_esp driver	(Rasmus Andersen)
o	Fix resource handling for fastlane scsi		(Rasmus Andersen)
o	Fix scsi_register failure on qlogic_fas		(Rasmus Andersen)
o	Fix scsi_register failure on qlogicfc		(Rasmus Andersen)
o	Fix irq alloc failure leak on sun3x_esp		(Rasmus Andersen)
o	Fix wd7000 init failures			(Rasmus Andersen)
o	Fix nbd device					(Steve Whitehouse)
o	Fix try_atomic_semop				(Manfred Spraul)
o	Parport fixes					(Tim Waugh)
o	Starfire start/stop if fix			(Ion Badulescu)
o	Fix raw.c off by one bug			(Tigran Aivazian)
o	USB hub kmalloc wrong size corruption fix	(Peter Zaitcev)

2.4.2-ac5
o	Add Epson 1240U scanners to usb scanner		(Joel Becker)
o	Fix eth= compatibility				(Andrew Morton)
	| Should fix 3c509 problems for one
o	Add Pnp table to opl3sa2			(Bill Nottingham)
o	Update loop driver fixes			(Jens Axboe, Andrea
							 Arcangeli, Al Viro)
o	Fix busy loop in usb storage			(Arjan van de Ven)
o	Add cardbus support to olympic			(Mike Phillips)
o	Make BUG() configurable to save space		(Arjan van de Ven)
o	Add configurability to most kernel debugging	(various people)
	functions on x86
o	Richard Günther/binfmt_misc page move		(Richard Günther)
o	Fix de4x5 crash					(Nikita Schmidt)
o	Hopefully fix the smc-mca driver		(me)
o	Don't run the disk queue if we didnt launder	(Marcelo Tosatti)
	any pages
o	ALi 6 channel audio and sp/dif updates		(Matt Wu)
o	Fix USB thread wakeup scheduling		(Arjan van de Ven)
o	Fix alignment problems with uni16_to_x8		(Ivan Kokshaysky)

2.4.2-ac4
o	Fix Make xconfig failure			(J Magallon)
o	Fix a typo in the ISDN docs			(Jim Freeman)
o	Fix the 3ware driver a bit more			(Ben LaHaise)
	| should now be usable
o	Update Dave Jones contact info			(Dave Jones)
o	Revert wavelan inline->macro change		(Jean Tourillhes)
	| CVS gcc and 2.96-74 don't accidentally unline it now
o	Zerocopy TCP/IP patches				(Dave Miller, 
							 Alexey Kuznetsov,
							 and many more)
o	Fix up command line options to old ncr driver	(Martin Storsjö)
o	NFS locking should call fs layer locking if	(Brian Dixon)
	present
o	Fix cs46xx wakeup/poll problem			(David Huggins-Daines)
o	Add some missing MTD config help texts		(Steven Cole,
							 David Woodhouse)
o	Fix Alpha build bug				(Sven Koch)
o	Final i386/ptrace bit
o	Finish off the vmalloc/WP fixup			(me)
o	Include file config.h fixes			(Niels Jensen)
o	More dscc4 updates				(Francois Romieu)

2.4.2-ac3
o	Add documentation for the fb interfaces		(Brad Douglas)
o	Work around apic disable_irq hardware bugs	(Maciej Rozycki)
o	Rage128 not "Rage 128"				(Brad Douglas)
o	Make ioremap debugging conditional		(J Magallon)
o	Merge Ninja pcmcia scsi driver			(YOKOTA Hiroshi)
o	Update 8139too docs				(Jeff Garzik)
o	Tulip updates, merge bits from 0.92 		(Jeff Garzik,
							 Don Becker)
o	Epic100 update					(Jeff Garzik)
o	Clean up Ariadne driver				(Jeff Garzik)
o	Remove dead wavelan prototype			(Jeff Garzik)
o	Remove unused arlan variable			(Jeff Garzik)
o	Clean up lance public symbols			(Jeff Garzik)
o	Switch fmv18x to spinlocks, fix other bits	(Jeff Garzik)
o	Clean up acenic global symbols			(Jeff Garzik)
o	Fix IDE blocking kmalloc with irqs off		(Arjan van de Ven)
	| I've redone the code a bit so it might be wrong again 8)

2.4.2-ac2
o	Merge the loop device fixes			(Jens Axboe)
o	Fix af_unix SYSCTL=n build failure		(Russell King)
o	Adjust the throttling point for write		(Jens Axboe)
	throttles
o	Fix sunhme ioremap				(Andrey Panin)
o	Fix disk change handling with removable sd	(Alex Davis)
o	Update/fix irq docs				(Matthew Wilcox)
o	Update PPC gmac and ncr885e drivers		(Cort Dougan)
	| bmac patch dropped as it loses other fixes
o	Kai Petzke has moved				(Kai Petzke)
o	Fix starfire driver so pump doesnt kill it	(Ion Badulescu)

2.4.2-ac1
o	Merge Linus 2.4.2 tree
	| We now have disagreeing ymfpci fixes. I've kept the ones
	| I tested for now.
o	Back out sr.c change				(me)
o	Fix moxa smartio driver				(Tom Mraz)
o	Hugh Blemings change of address			(Hugh Blemings)
o	Allow more i2o config time for slow calls
o	Aty128fb updates				(Brad Douglas,
						      Benjamin Herrenschmidt,
							 Michel Danzer,
							 Andreas Hundt)
o	Add "loop" name to the root dev names		(Barry Nathan)
o	Further spelling cleanups			(Dag Wieers)
o	Remove bogus warning emissions from aha1740	(Nick Holloway)
o	Remove surplus assignment in vmalloc		(Francis Galiegue)
o	Remove unneeded ifdef in i386/kernel/irq.c	(Francis Galiegue)
o	Add door locking ioctl to ide-floppy		(Francis Galiegue)
o	Allow scsi disk opening O_NDELAY for removables	(me)
o	Fix cosa compile warnings			(me)
o	Clean up dumpable/setuid write ordering		(me)
o	Hopefully fix the 3ware crashes 		(me)


---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
