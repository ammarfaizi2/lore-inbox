Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311841AbSDSJQF>; Fri, 19 Apr 2002 05:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSDSJQE>; Fri, 19 Apr 2002 05:16:04 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12278 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311841AbSDSJQA>; Fri, 19 Apr 2002 05:16:00 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200204190916.g3J9G0b01318@devserv.devel.redhat.com>
Subject: Linux 2.4.19pre7-ac1
To: linux-kernel@vger.kernel.org
Date: Fri, 19 Apr 2002 05:16:00 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is mostly a merge so I could resync stuff with Marcelo.
Software suspend and other fixes are not merged yet so soft suspend is
still broken.

[+ indicates stuff that went to Marcelo, o stuff that has not,
 * indicates stuff that is merged in mainstream now, X stuff that proved
   bad and was dropped out]

Linux 2.4.19pre7-ac1
o	Merge CPU speed control framework and support (Dave Jones, Russell King
	for VIA processors and AMD K6		Arjan van de Ven, Janne Pänkälä)
o	Merge with 2.4.19pre7
	-	drop out keyb changes (breaks some setups)
o	Lots more i2o debugging work 			(me)
	| I2O now seems to be working again and works
	| for the first time on the AMI Megaraid

Linux 2.4.19pre5-ac3
o	Software suspend initial patch 		(Pavel Machek, Gabor Kuti,..)
	| Don't enable this idly. Its here to get exposure and so
	| people can bring the rest of the code up to meet its needs as
	| well as fix it.
	| Read the docs first!
o	Small fix for the radeonfb			(Peter Horton)
o	Fix highmem truncation on DMA mapping bug	(Dave Miller)
o	Modules are not supposed to hack the syscall	(Arjan van de Ven)
	table so remove the export
+	Add ite sound configuration help		(Steven Cole)

Linux 2.4.19pre5-ac2
o	Fix compile error when using initrd		(Jeff Nguyen)
+	Make the KL133 onboard video happy again	(Andre Pang)
	| and a lot of people working to figure out the right bits
o	Reparent jdb to init and drop lock on exit	(Ishan Jayawardena)
o	Fix radeon corner case				(Arjan van de Ven)
o	Cache more group descriptors on ext2/ext3	(Arjan van de Ven)
+	SAB8253 series wan drivers			(Joachim Martillo)
o	Add more idents for PIIX IDE controllers	(Arjan van de Ven)
o	Lock signals in procfs				(Andrea Arcangeli)
o	Backport of 2.5 BUG_ON() functionality		(Robert Love)
o	Drop -O1 on sched.c - turns out its a CPU
	microcode bug on early Xeon not Linux
o	Fix Radeon fb reset problems as X11 did		(Peter Horton)
o	Radeon acceleration/mtrr updates		(Peter Horton)
o	JFS flushpage updates				(Christoph Hellwig)
o	BeOS file system support			(Will Dyson)
	| original work by Makoto Kato
+	Fix w83877 watchdog SMP compile failure		(Paul Komkoff, me)
o	Fix pty/tty POLL_OUT reporting			(Sapan Bhatia)
o	Update berkshire watchdog driver	(Lindsay Harris, Rob Radez)
o	Clean up duplicated path_init and __user_walk	(Hanna Linder)
	code
o	Enable MMX extensions on Geode GXm		(Zwane Mwaikambo)
o	O(1) scsi free command block finder		(Mark Hemment)
+	Updated IBM serveraid driver			(Jack Hammer)
o	S/390 makefile cross compile fixups		(Pete Zaitcev)

Linux 2.4.19pre5-ac1
o	Merge with 2.4.19pre5

Linux 2.4.19pre4-ac4
o	Fix an additional vm86 case			(Stas Sergeev)
	| Check DOSemu again and this code wants some good review
o	Do sanity checking to avoid mispoking PCI on	(me)
	the CMD640 [noted by Justin Gibbs]
o	Fix promise IDE error recovery			(Manfred Spraul)
o	Ali IDE hang fixes				(Sen Dong)
	| Extracts from a bigger ALi update
o	Ext3 balloc locking fix 			(Andrew Morton)
*	Fix escaped MWAVE configuration			(Thomas Hood)
+	Fix nls_utf8 problems				(Liyang Hu)
+	Fix mmx_memcpy over-prefetching on Athlon	(me)
o	Fix an error return the vm accounting code broke(Andrew Morton)
+	Fix bpck6 build on the powerpc platform		(Jens Schmalzing)
+	Fix bpck6 64bit cleanness and other minor bits	(me)
+	Fix sound Configure.help thinko			(Per von Zweigbergk)
+	Backport the 2.5 wireless driver stuff		(Jean Tourrilhes)
	| So 2.5 driver fix back merging is sane

Linux 2.4.19pre4-ac3
o	Fix NFS pathconf problem			(Neil Brown)
o	IBM memory key ident for usb_storage		(Alexander Inyukhin)
+	Add byte counters to mkiss driver		(Ken Koster)
o	Add more entries to the scsi scan lists		(Arjan van de Ven)
o	More eepro100 variants				(Arjan van de Ven)
+	Update wolfson codec initialisers		(Randolph Bentson)
+	USB serial oops fixes				(Greg Kroah Hartmann)
+	Mad16 register gameport with input layer	(Michael Haardt)
+	Update specialix driver to handle SI v1.x board	(Ismo Salonen)
+	Fix a wdt285 EFAULT return, remove crud		(Ron Gage, me)
+	Fix ioctl return errors on several sound cards	(Ron Gage)

Linux 2.4.19pre4-ac2
o	Hopefully correctly fix the vm86 problems	(Stas Sergeev)
	| Please test wine 16bit/dosemu/XFree stuff
*	Fix panic when writing 0 length ucode chunk	(Tigran Aivazian)
o	Fix incorrect use of hwif->index in ALI IDE	(Martin Dalecki)
o	Fix mmap rbtree corruption bug			(Ben LaHaise)
o	Fix incorrect 10 to 6 byte scsi command switch	(Jens Axboe)
*	TCP correctness fix				(Dave Miller)
+	Correct mwi acronym in docs			(Geert Uytterhoeven)
o	Merge the rest of Promise 20271 support		(YAMAWAKI Teruo)
+	Fix open/close races in indydog			(Dave Hansen)
o	Fix compile problem with ibm hotplug		(Greg Kroah-Hartmann)
+	Save the .config file in make rpm		(Kelly French)
+	Add another vaio with swapped minutes		(Michael Piotrowski)
o	Further atm fixes				(Maksim Krasnyanskiy 
							 Marcell Gal)
o	Even more atm fixes				(Francois Romieu)
*	USB support for palm m130			(Udo Eisenbarth)
*	USB fix for pegasus hotplug crash		(Petko Manolov)
* 	USB request sense help for some scanners	(Oliver ?)
*	USB support for Optus@home 			(Oliver ?)
*	USB printer updates			(David Paschal, Pete Zaitcev)
*	Work around USB ATEN keyboard switches		(Vojtech Pavlik)
*	PWC usb camera updates				("Nemosoft")
*	Small updates to the USB hub code		(Itai Nahshon)
*	Fix spinlock handling bugs in ipaq USB		(Ganesh Varadarajan)
*	OHCI fixes					(David Brownell)
*	USB docs update					(David Brownell)
*	UHCI fixes					(Johannes Erdfelt)
*	Quieten a USB message to debug			(Greg Kroah-Hartmann)
*	USB bandwidth reporting				(David Brownell)
+	Fix msync SuS v3 compliance			(Chris Yeoh)
o	CS8900 fixes (need testing)			(Paul Komkoff)
*	Adapt HP100 driver to pci api			(Jeff Garzik)
+	Acenic updates - fix leak and Tigon1		(Jes Sorensen)
*	DE620 region handling fixes			(K Kasprzak)
*	DLink DL2K gige updates			(Edward Peng, Jeff Garzik)
+	pcnet32 leak fix				(Jeff Garzik)
+	pcnet32 types fixes for non x86			(Anton Blanchard)
+	pcnet32 assorted fixes				(Dave Engebretsen)
+	pcnet32 fixes					(Paul Mackerras)
+	Fix missing linux/delay.h from eepro100		(me)
+	Further pcnet32 cleanup and probe fixes		(Go Taniguchi)
*	Merge gcc3 warning fixes for copy/csum		(Jeff Garzik)
*	Fix bmac build					(Joshua Uziel)
*	DE4x5 slight tidy up				(Jeff Garzik)
*	More AC97 ident strings				(Peter Christy)

Linux 2.4.19pre4-ac1
o	Merge 2.4.19pre4
+	Add PCI idents for mobility parallel port	(me)
o	Fix crash on boot with LLC if no devices present(me)

Linux 2.4.19pre3-ac6
o	Fix the oops initialising the CD-ROM		(Andre Hedrick)
*	Add devexit_p() to the wdt_pci watchdog		(Adrian Bunk)
o	Fix lm_sensors compile				(Eyal Lebedinsky)
o	Remove some dead JFS oddments			(Christoph Hellwig)
o	SCSI generic update			(Doug Gilbert, Travers Carter)
o	VM86 exception fixups			(Kasper Dupont, Manfred Spraul)
*	Fix an fcntl error corner case to match SuS	(Christopher Yeoh)

Linux 2.4.19pre3-ac5
o	Further IDE updates				(Andre Hedrick)
o	Reduce ide tape debug noise			(Alfredo Sanjuán)
*	Sync devices on final close not each close	(Miquel van Smoorenburg)
o	Make max busses/irqs dynamic on x86		(James Cleverdon)
	| Needed for big IBM boxen
o	Remove exp_find in NFS (never used)		(Al Viro)
o	Fix read locking on NFS export_table		(Erik Habbinga)
o	Fix possible NFS error path mnt/dentry leak	(Al Viro)
o	Use MKDEV macro in NFS device create		(GOTO Masanori)
o	Clean up stale fh stats				(Neil Brown)
o	Tidy nfsd_lookup				(Al Viro)
o	nfsd_setattr fixes				(Neil Brown)
o	Tidy up nfsd vfs calls				(Neil Brown)
o	Clean up nfsd syscall interface			(Neil Brown)
o	Fix fat NFS handle interfaces			(Neil Brown)
o	Tidy up export list handling for NFS		(Al Viro)
o	Use seq_file for NFS exports proc file		(Al Viro)
o	Support for deviceless file system exports	(Steven Whitehouse)
o	Remove big kernel lock use for most of nfsd	(Neil Brown)
o	Convert sunrpc code to use generic linux lists	(Neil Brown)
o	Tidy up svc_sock NFS locking on SMP		(Neil Brown)
o	Improve tcp error/close handling		(Neil Brown)
o	Close down idle NFS tcp sockets			(Neil Brown)
o	NFS TCP fixes for buffer space tracking		(Neil Brown)
o	Handle TCP RPC service flooding			(Neil Brown)
o	Enable NFS over TCP via config options		(Neil Brown)

Linux 2.4.19pre3-ac4
o	Ensure jfs readdir doesn't spin on bad metadata	(Dave Kleikamp)
o	Fix iconfig with no modules			(Randy Dunlap)
*	Don't enfore rlimit on block device files	(Peter Hartley)
o	Add belkin wireless card idents			(Brendan McAdams)
o	Add HP VA7400 to the scsi blacklist quirks	(Alar Aun)
o	JFS race fix					(Dave Kleikamp)
*	Fix wafer5823 watchdog merge error I made	(Justin Cormack)
*	Fix Config rule for phonejack pcmcia card	(Eyal Lebedinsky)
o	Test improved OOM handler for rmap		(Rik van Riel)
*	Update defconfig/experimental bits		(Neils Jensen)
*	The incredible shrinking kernel patch		(Andrew Morton)
*	Clean up BUG() implementation			(Andrew Morton)

Linux 2.4.19pre3-ac3
o	Doh fixed the SYSVIPC build problem		(Everyone...)
o	Added 802.2LLC support			(Arnaldo Carvalho de Melo)
	| Based on 2.0 code contributed by Procom
o	Fix i2o build as module				(Mark Cooke)
o	Blacklist for machines where local apic fails	(Mikael Pettersson)
*	Clean up wdt_pci				(Zwane Mwaikambo)

Linux 2.4.19pre3-ac2
o	Hopefully fixed all the as accounting bugs	(me)
o	Bit more LS220 work (nothing useful yet)	(me)
o	Change should be long not int in shmem acct	(me)
o	Ignore MAP_NORESERVE in mode 2/3 accounting	(me)
+	Fix pci bar flag parsing			(Russell King)
+	Handle ELF setup_arg_pages failure		(Russell King)
*	AT1700 filter fix				(Sawa)
o	S/390 fix for O(1) scheduler			(Pete Zaitcev)
o	Fix /proc/kcore for non zero memory start	(Russell King)
*	Update USB config files				(Greg Kroah-Hartmann)
*	TCP minisocks fixes				(Dave Miller)
*	dnotify fixes					(Stephen Rothwell)
*	Remove pointles sysrq-L				(Russell King)
*	Reparent khubd to init				(Andrew Morton)
*	EEpro100 test updates				(Arjan van de Ven)
*	Use named initializers in hwc_con		(Pete Zaitcev)
*	SHM ipc fix					(Paul Larson)
o	Further printk level fixes			(Denis Vlasenko)
o	Revert epic100 changes - reports of problems	(me)
*	Water WDT watchdog driver			(Justin Cormack)
	| I did some cleanup - Justin please double check it
*	ITE8330G PIRQ map support			(Tobias Diedrich)
o	Trivial khttpd logging bug fix			(Rogier Wolff)
o	Stop module autoloader making user /proc/pid	(Andreas Ferber)
	dir root owned
o	Handle TF flag properly on debug trap		(Christoph Hellwig,
					Arjan van de Ven, Stephan Springl)
*	ALi M1701 watchdog driver			(Stve Hill)
	| I tidied/fixed this one too so please check
o	Add iconfig  (save/extract config from kernel	(Randy Dunlap)
	image file)
*	Add mk712 touchscreen driver			(Daniel Quinlan)
	| Fixed various bugs in it - Dan please check

Linux 2.4.19pre3-ac1
o	Merge with 2.4.19pre3
	-	Revert buggy bluesmoke change
	-	Add missing pppox header change
*	Next SIS ide update				(Lionel Bouton)
o	Only try the flush and recycle trick for 	(me)
	known buggy I2O controllers.
o	Clean up module junk and use new init style	(me)
	for I2O.
o	Don't use cache hints on dim i2o controllers	(me)
*	Add vmalloc_to_page to 2.4 from 2.5		(Gerd Knorr)
o	JFS updates			(Christoph Hellwig, Dave Kleikamp)
*	Fix boot_cpu_data corruption bug		(Mikael Pettersson)
+	Clean up ppp vfree paths			(David Woodhouse)
*	Emagic EMI usb driver				(Tapio Laxström)
*	Edgeport fixes for multiple device case	 	(Greg Kroah-Hartmann)	
*	Ethtool support for catc usb			(Brad Hards)
*	Update to pegasus driver in base tree		(Petko Manolov)
*	Update USB maintainers				(Greg Kroah-Hartmann)
*	IPAQ usb driver fixup				(Ganesh Varadarajan)
*	Allow usbfs name for 2.5 compatibility		(Greg Kroah-Hartmann)
o	Committed_AS without a space in procfs		(Andy Dustman)
*	Fix an NFS file creation problem		(Trond Myklebust)
o	Fix a missing ksym				(Greg Kroah-Hartmann)
o	Increase init delay on ALI5451 audio setup	(Harald Jenny)
	| Needed for Acer Travelmate 521TE
*	Fix printk message levels in pci code		(Denis Vlasenko)
o	Add another laptop to the buggy APM tables	(Mihnea-Costin Grigore)
o	Fix an obscure acct race			(Bob Miller)
o	Sonypi driver update				(Stelian Pop)
o	Fix devfs glitch with namespace stuff		(Paul Komkoff, Al Viro)

Linux 2.4.19pre2-ac4
*	Initial Ricoh ZVbus support			(Marcus Metzler)
o	PnPBIOS fixes					(Brian Gerst)
o	Fix a case where sync_one might not start an	(Ben LaHaise)
	inode writeout
+	Corrected atm locking fix			(Maksim Krasnyanskiy)
o	mp table parsing corner case fix		(James Cleverdon)
o	NFS over JFS directory offset fix		(Christoph Hellwig)
*	Update reisefsprogs version			(Paul Komkoff)
*	RME Hammerfall driver update			(Günter Geiger)
o	Fix an off by one in the bluesmoke reporting	(Dave Jones)
+	Make irnet disconnect hang up ppp		(Jean Tourrilhes)
+	Fix abuse of cli() in irda socket connect	(Jean Tourrilhes)
*	Add help text to patch-kernel script		(Damjan Lango)
*	USB irda updates				(Jean Tourrilhes)
+	IRDA link layer updates				(Jean Tourrilhes)
*	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
*	Update sc1200 watchdog				(Zwane Mwaikambo)
*	Switch wdt501 watchdog driver to bitops		(me)
*	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
*	Wavelan driver updates				(Jean Tourrilhes)
o	Fix a race where we could hit init_idle after	(Kip Walker)
	freeing it (from rest_init)
*	Raylink driver bugfixes				(Jean Tourrilhes)
o	Switch 2.4 to using a shared zlib		(David Woodhouse)
*	Fix w83877 SMP deadlock, clean up locking	(me)
o	IBM lanstreamer update				(Kent Yoder)
o	Fix 32bitism in the PM code			(Pavel Machek)
o	Make irqsave use unsigned long for consistency	(Pavel Machek)
	| Just fixes a few exceptions
o	Make i2o_block fallback to blkpg for ioctls	(me)
o	All pids in use handling			(Paul Larson)
*	IDE code wasn't using ide_free_irq		(William Jhun)
o	Fix non procfs build				(Eric Sandeen)
*	Cyberjack bug fix				(Greg Kroah-Hartmann)
*	USB vicam fixes					(Oliver Neukum)
*	Add another device to the ftdi driver		(Greg Kroah-Hartmann)
*	UHCI performance fixes				(Johannes Erdfelt)
*	STV680 bug fixes				(Kevin Sisson)
*	Kaweth bug fixes				(Oliver Neukum)
*	Update hpusbscsi driver				(Oliver Neukum)
*	Update OV511 driver				(Mark McClelland)
*	Update usb-ipaq driver to support journada	(Ganesh Varadarajan)
*	Fix a bug in the USB skeleton driver		(Holger Waechtler)
*	Further SiS IDE updates				(Lionel Bouton)
*	Fix ufs mount failure bug			(Andries Brouwer)
o	Allow the max user frequency for the rtc to	(Mike Shaver)
	be configurable
o	HPT37x crash on init fixups			(Vojtech Pavlik)

Linux 2.4.19pre2-ac3
o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason)
*	MIPS config fix					(Ralf Baechle)
*	Update AGP config entry				(Daniele Venzano)
*	SMBfs NLS oops fix				(Urban Widmark)
o	Fix expand_stack locking hang on OOM		(Kevin Buhr)
o	Restore 10Mbit half duplex eepro100 fix		(me)
o	3c509 full duplex and documentation		(David Ruggiero)
o	3c509 power management				(Zwane Mwaikambo)
*	Remove more surplus llseek methods		(Robert Love)
X	ATM locking fix					(Frode Isaksen)
o	Merge extra sound help texts			(Steven Cole)
	| plus one typo fix
o	Add help for IXJ pcmcia configuration		(Steven Cole, me)
	| Rewrote the text somewhat

Linux 2.4.19pre2-ac2
o	Fix a mismerge (may explain the patch weirdo)
+	Fix highmem + sblive				(Daniel Bertrand)
*	Reiserfs updates				(Oleg Drokin)
o	Auto enable HT on HT capable systems		(Arjan van de Ven)
o	Fix init/do_mounts O(1) scheduler merge glitch	(Greg Louis)
o	Fix drm build problem on CPU=386		(Mark Cooke)
+	Fix incorrect sleep in ZR36067 driver		(me)
*	Add missing cpu_relax to iph5526 driver		(me)

Linux 2.4.19pre2-ac1
*	Merge aic7xxx update				(Justin Gibbs)
*	Fix handling of scsi 'medium error: recovered'	(Justin Gibbs)
*	Further request region fixups			(Marcus Alanen)
o	Add interlace/doublescan to voodoo1/2 fb driver	(Urs Ganse)
	| interlace is always handy with 3d glasses..
o	Merge O(1) scheduler				(Ingo Molnar)
	| Thanks to Martin Knoblauch for doing the merge work
	| Non x86 ports may need to clean up their mm/fault.c
*	Lseek usage cleanup				(Robert Love)
o	Merge with 2.4.19pre2
	-	Fixed bogus sysctl definitions
	-	Fixed incorrect MODULE_LICENSE backout
	-	Fixed gratuitous supercede spelling change
	-	Fixed double patches from mips people
	-	Fixed incorrect link order from mips people
	-	Fixed broken config rules from mips people
	-	Made cciss build
	-	Remove half written "meth.c" driver
*	Fix up some of the watchdog api text		(me)
	| Janitor job - go through that and make all the drivers
	| support all the things ('V' NOWAYOUT and ioctl core)
o	Fix wrong order in MAINTAINERS			(me)
o	Remove roadrunner reference from MAINTAINERS	(me)

Linux 2.4.19pre1-ac2
o	Fix chown/chmod on shmemfs			(me)
o	Fix accounting error in the shm code		(me)
o	Turn on mode2/mode3 overcommit protection	(me)
*	w83877f watchdog fix compile for SMP		(Mark Cooke)
*	Fix ide=nodma for serverworks			(Ken Brownfield)
*	USB2 controller support				(Greg Kroah-Hartmann)
*	Add more devices to the visor driver (m515,clie)(Greg Kroah-Hartmann)
*	IBM USB camera driver updates			(Greg Kroah-Hartmann)
*	USB auerswald driver				(Wolfgang Muees)
o	Trivial random match up with 2.2		(Marco Colombo)
*	Spelling fixes					(Jim Freeman)
*	Next batch of time_*() fixups			(Tim Schmielau)
+	Update video4linux API docs			(Gerd Knorr)
*	Merge some comment fixups			(John Kim)
o	ymfpci sync					(Pete Zaitcev)
*	Update maintainers to add pm3fb			(Romain DOLBEAU)
*	Hotplug updates (docs, fs, compaq driver)	(Greg Kroah-Hartmann)
*	IBM hotplug support	(Irene Zubarev, Tong Yu, Jyoti Shah, Chuck Cole)
*	ACPI hotplug driver support		(Hiroshi Aono, Takayoshi Kochi)
*	Blink keyboard lights on x86 panic		(Andi Kleen)
o	Further Configure.help changes			(Steven Cole)
o	Merge a version of the sard I/O accounting	(Stephen Tweedie,
							 Christoph Hellwig)
+	SC1200 watchdog driver				(Zwane Mwaikambo)
*	Fix address ordering for 36bit MCE on x86	(Dave Jones)

Linux 2.4.19pre1-ac1
o	Merge with 2.4.19-pre1

Linux 2.4.18-ac1
o	Merge with 2.4.18 proper
o	Add missing -rc4 diff
o	Use attribute notifiers to account shmemfs	(me)
o	Initial luxsonor LS220/LS240 driver code	(me)
	| This is just setup code and only in the tree because
	| its where I keep my hacks in progress

Linux 2.4.18rc2-ac2
o	Fix a corruption problem in the jfs dir table	(Dave Kleikamp)
o	Fix trap when extending a single extent of	(Dave Kleikamp)
	over 64Gb in JFS
*	NBD deadlock fix				(Steven Whitehouse)
*	Fix device ref counting in netrom stack		(Tomi Manninen)
*	Fix shmemfs link counting			(Christoph Rohland)
*	Fix potential scsi disk oops			(Peter Wong)
*	eepro100 carrier init fix			(Jeff Garzik)
*	Fix wrong kfree in netrom stack			(Tomi Manninen)
*	Add TI1250 inits to ZV bus support		(me)
	| Zoom video now works on the IBM TP600 at least..
*	Fix off by one on loop devices limit		(Heinz Mauelshagen)
o	Improve handling of psaux open with no mouse	(Christoph Hellwig)
	present
*	3COM 3c359 token ring driver			(Mike Phillips)
*	Fix a case where hpfs didnt set block size	(Chris Mason)
	early enough
*	Remove use of lock_kernel in softdog driver	(me)
*	Make olympic driver use spinlocks not 		(Mike Phillips)
	lock_kernel
o	Fix type of detected devices in md.c		(Jakob Kemi)
*	Changes and defconfig update			(Niels Jensen)
o	PNP BIOS driver updates				(Thomas Hood)
*	Turn off excess printks in pnp quirk reporting	(Andrey Panin)
*	Add documentation for ITE I2C			(Steven Cole)
o	Add documentation for other zoran cards		(Steven Cole)
+	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)
+	Cleaned up and fixed some SC520 watchdog bugs	(me)
	| Scott - can you double check these
*	Fix return on generic lib/string.c memcmp	(Georg Nikodym)
*	Further zoom video cleanups			(me)

Linux 2.4.18rc2-ac1
o	Merge with 2.4.18rc2
*	Ignore i810 modem codecs			(me)
o	Core of address space accounting code		(me)
	| Enforcement, ptrace and some shmem corner bits to do
*	Fix security hole in shmfs			(me)
o	Fix various bits of 64bit file I/O in shmem	(me)
o	Merge with rmap12f				(Rik van Riel and co)

Linux 2.4.18pre9-ac4
*	SIS IDE driver update (handle with care)	(Lionel Bouton)
o	First set of I2O endian cleanups		(me)
o	Make i2o_pci.c 64bit/BE clean			(me)
o	Maybe fix crash on i2o scsi abort/reset paths	(me)
o	Make i2o use the passed scsi direction flag	(me)
*	Fix awk failure path in menuconfig		(Andrew Church)
+	Merge varies doc updates			(Steven Cole)
o	Add serial support for the Lava Octopus-550	(Jim Treadway)
*	OPL3SA2 cleanup					(Zwane Mwaikambo)
o	Add missing blkdev_varyio export		(Todd Roy)
o/*	Update Changes file, config and experimental	(Niels Jensen)
	checks
*	Fix highmem warning in aacraid			(Andrew Morton)
*	Make tpqic02 use new style request region	(Marcus Alanen)
*	Only turn off mediagx/geode TSC on 5510/5520	(me)
	| From information provided by Hiroshi MIURA
*	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
o	Fix oops if you try to use the RW wq locks	(Bob Miller)
o	Remove FPU usage in neomagic fb			(Denis Kropp)
o	Merge IBM JFS			(Steve Best, Dave Kleikamp, 
					 Barry Arndt, Christoph Hellwig, ..)
*	Updated sis frame buffer driver			(Thomas Winischhofer)

Linux 2.4.18pre9-ac3
*	Clean up various macros and misuse of ;		(Timothy Ball)
*	Correct procfs locking fixup			(Al Viro)
o	Speed up ext2/ext3 synchronous mounts		(Andrew Morton)
*	Update IDE DMA blacklist			(Jonathan Kamens)
o	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith, 
	and adds I830 DRM				 Jeff Hartmann,
							 Keith Whitwell,
							 Abraham vd Merwe
							 and others)
*	IBM Lanstreamer updates				(Mike Phillips)
*	Fix acct rlimit problem (I hope)		(me)
	| Problem noted by Ian Allen
o	Automatically set file limits based on mem size	(Andi Kleen)
*	Correct scsi reservation conflict handling	(James Bottomley)
	and add the scsi reset api code
o	Add further kernel docs				(me)
o	Merge to rmap-12e				(Rik van Riel and co)
	|merge patch from Nick Orlov
*	Small fix to the eata driver update		(Dario Ballabio)


Linux 2.4.18pre9-ac2
*	Nat Semi now use their own ident on the Geode	(Hiroshi Miura)
*	Put #error in two files that need FPU fixups	(me)
*	Correct a specific mmap return to match posix	(Christopher Yeoh)
*	Add Eepro100/VE ident				(Hanno Boeck)
*	Add provides for DRM to the kernel make rpm	(Alexander Hoogerhuis)
*	Fix a problem where vm86 irq releasing could be	(Stas Sergeev)
	missed
*	EATA and U14/34F driver updates			(Dario Ballabio)
*	Handle EMC storage arrays that report SCSI-2 	(Kurt Garloff)
	but want REPORT_LUNs
*	Update README, defconfig, remove autogen files	(Niels Jensen)
o	Add AFAVLAB PCI serial support			(Harald Welte)
*	Fix incorrect resource free in eexpress		(Gianluca Anzolin)
o	Variable size rawio optimisations		(Badari Pulavarty)
*	Add AT's compatible 8139 cardbus chip		(Go Taniguchi)
o	Fix crash with newest hpt ide chips		(Arjan van de Ven)
*	Fix tiny SMP race in pid selection		(Erik Hendriks)
o	Hopefully fix pnpbios crash caused by early	(me)
	kernel_thread creation

Linux 2.4.18pre9-ac1
o	Initial merge of DVD card driver  (Christian Wolff,Marcus Metzler)
	| This is just an initial testing piece. DVB needs merging
	| properly and this is only a first bit of testing
*	Random number generator support for AMD768	(me)
*	Add AMD768 to i810 driver pci ident list	(me)
o	Initial AMD768 power management work		(me)
	| Unfinished pending some docs clarifications
*	Fix bugbuf mishandling for modular es1370	(me)
*	Fix up i2o readl abuse, post_wait race, and	(me, Arjan van de Ven)
	some deadlock cases
*	Added cpu_relax to yam driver 			(me)
*	Fixup AMD762 if the BIOS apparently got it wrong(me)
	(eg ASUS boards)
*	MP1.4 alignment fixup
*	pcwd cleanup, backport of fixes from 2.5	(Rob Radez)
*	Add support for more Moxa cards to mxser	(Damian Wrobel)
*	Add remaining missing MODULE_LICENSE tags	(Hubert Mantel)
*	Fix floppy reservation ranges			(Anton Altaparmakov)
*	Fix max file size setup				(Andi Kleen)

Linux 2.4.18pre7-ac3
o	Fix a wrong error return in the megaraid driver	(Arjan van de Ven)
*	FreeVXFS update					(Christoph Hellwig)
*	Qnxfs update					(Anders Larsen)
o	Fix non compile with PCI=n			(Adrian Bunk)
o	Fix DRM 4.0 non compile in i810			(me)
*	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
*	Make NetROM incoming frame check stricter	(Tomi Manninen)
*	Use sock_orphan in AX.25/NetROM			(Jeroen PE1RXQ)
*	Pegasus update					(Petko Manolov)
o	Make reparent_to_init and exec_usermodehelper	(Andrew Morton)
	use set_user, fix a tiny set_user SMP race
*	Mark framebuffer mappings VM_IO			(Andrew Morton)
o	Neomagic frame buffer driver			(Denis Kropp)
	- Needs FPU code fixing before it can be merged
*	Hyperthreading awareness for MTRR driver
*	Correct NR_IRQ with no apic support		(Brian Gerst)
*	Fix missing includes in sound drivers		(Michal Jaegermann)

Linux 2.4.18pre7-ac2
*	i810 audio driver update			(Doug Ledford)
*	Early ioremap for x86 specific code		(Mikael Pettersson)
	| This is needed to do things like apic/dmi detect early enough
*	Pentium IV APIC/NMI watchdog			(Mikael Pettersson)
*	Add C1MRX support to sonypi driver		(Junichi Morita)
*	Fix "make rpm" with two '-' in extraversion	(Gerald Britton)
*	Fix aacraid hang/irq storm on i960 boards	(Chris Pascoe)
*	Fix isdn audio compiler behaviour dependancy	(Urs Thuermann)
*	YAM driver fixes				(Jean-Paul Roubelat)
*	ROSE protocol stack update/fixes		(Jean-Paul Roubelat)
*	Fix UFS/CDROM oops				(Zwane Mwaikambo)
*	Fix nm256 hang on Dell Latitude			(origin unknown)
	| Please test this tree with other NM256 based boxes and check
	| those still work...
o	Merge PnPBIOS patch		(Thomas Hood, David Hinds, Tom Lees,
					 Christian Schmidt, ..)
*	Merge new sis frame buffer drivers		(Thomas Winischhofer)
*	cs46xx oops fix					(Mike Gorse)
*	Fix a second cs46xx bug related to this		(me)
*	Fix acpitable oopses on boot and other problems	(James Cleverdon)
o	Fix io port type on the hpt366 driver		(Pete Popov)
*	Updated matrox drivers				(Petr Vandrovec)
*	IPchains fixes needed for 2.4.18pre7
+	IDE config text updates for the IDE patches	(Anton Altaparmakov)
*	Merge the first bits of ZV support		(Marcus Metzler)
*	Add initial ZV support to yenta socket driver	(me)
	for TI cards
*	Fix pirq routing on the CS5530 			(me)
	| Finally the palmax pcmcia/cardbus works properly

Linux 2.4.18pre7-ac1
o	Merge with 2.4.18pre7				(Arjan van de Ven)
	| + some quota fixups redone by me
	| several 18pre7 netfilter bugs left unfixed for now
o	Rmap-12a					(Rik van Riel and co)

Linux 2.4.18pre3-ac2

*	Re-merge the IDE patches			(Andre Hedrick and co)
*	Fix check/request region in ali_ircc and lowcomx(Steven Walter)
	com90xx, sealevel, sb1000
*	Remove unused message from 6pack driver		(Adrian Bunk)
*	Fix unused variable warning in i60scsi		(Adrian Bunk)
*	Fix off by one floppy oops			(Keith Owens)
*	Fix i2o_config use of undefined C		(Andreas Dilger)
*	Fix fdomain scsi oopses				(Per Larsson)
*	Fix sf16fmi hang on boot			(me)
+	Add bridge resources to the resource tree	(Ivan Kokshaysky)
*	Fix iphase ATM oops on close in on case	   (Till Immanuel Patzschke)
*	Enable OOSTORE on winchip processors		(Dave Jones, me)
	| Worth about 10-20% performance 
*	Code Page 1250 support				(Petr Titera)
*	Fix sdla and hpfs doc typos			(Sven Vermeulen)
o	Document /proc/stat				(Sven Heinicke)
*	Update cs4281 drivers				(Tom Woller)
	| Fixes xmms stutter, remove wrapper code
	| handle tosh boxes, allow record device change
	| trigger wakeups on ioctl triggered changes
+/o/X	Fix locking of file struct stuff found by ibm	(Dipankar Sarma)
	audit
o	Use spin_lock_init in serial.c			(Dave Miller)
*	Fix AF_UNIX shutdown bug			(Dave Miller)

Linux 2.4.18pre3-ac1

o	32bit uid quota
o	rmap-11b VM					(Rik van Riel,
							 William Irwin etc)
*	Make scsi printer visible			(Stefan Wieseckel)
*	Report Hercules Fortissimo card			(Minya Sorakinu)
*	Fix O_NDELAY close mishandling on the following	(me)
	sound cards: cmpci, cs46xx, es1370, es1371,
	esssolo1, sonicvibes
*	tdfx pixclock handling fix			(Jurriaan)
+	Fix mishandling of file system size limiting	(Andrea Arcangeli)
*	generic_serial cleanups				(Rasmus Andersen)
o	serial.c locking fixes for SMP - move from cli	(Kees)
	too
*	Truncate fixes from old -ac tree		(Andrew Morton)
*	Hopefully fix the i2o oops			(me)
	| Not the right fix but it'll do till I rewrite this
*	Fix non blocking tty blocking bug		(Peter Benie)
o	IRQ routing workaround for problem HP laptops	(Cory Bell)
*	Fix the rcpci driver				(Pete Popov)
*	Fix documentation of aedsp location		(Adrian Bunk)
*	Fix the worst of the APM ate my cpu problems	(Andreas Steinmetz)
*	Correct icmp documentation			(Pierre Lombard)
*	Multiple mxser crash on boot fix	(Stephan von Krawczynski)
o	ldm header fix					(Anton Altaparmakov)
*	Fix unchecked kmalloc in i2c_proc	(Ragnar Hojland Espinosa)
*	Fix unchecked kmalloc in airo_cs	(Ragnar Hojland Espinosa)
*	Fix unchecked kmalloc in btaudio	(Ragnar Hojland Espinosa)
*	Fix unchecked kmalloc in qnx4/inode.c	(Ragnar Hojland Espinosa)
*	Disable DRM4.1 GMX2000 driver (4.0 required)	(me)
*	Fix sb16 lower speed limit bug			(Jori Liesenborgs)
*	Fix compilation of orinoco driver		(Ben Herrenschmidt)
*	ISAPnP init fix					(Chris Rankin)
o	Export release_console_sem			(Andrew Morton)
*	Output nat crash fix				(Rusty Russell)
*	Fix PLIP					(Niels Jensen)
*	Natsemi driver hang fix				(Manfred Spraul)
*	Add mono/stereo reporting to gemtek pci radio	(Jonathan Hudson)

