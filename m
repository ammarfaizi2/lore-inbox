Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310443AbSCBUef>; Sat, 2 Mar 2002 15:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310447AbSCBUe2>; Sat, 2 Mar 2002 15:34:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32260 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310443AbSCBUeI>; Sat, 2 Mar 2002 15:34:08 -0500
Subject: Linux 2.4.19pre2-ac2
To: linux-kernel@vger.kernel.org
Date: Sat, 2 Mar 2002 20:49:10 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hGRK-0008OM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should fix the weirdness with pre2-ac1 a few people saw (eg patch doing
odd things). One of the mismerges could cause very odd happenings. Please
retest anything that failed in -ac1 before reporting it...

[+ indicates stuff that went to Marcelo, o stuff that has not,
 * indicates stuff that is merged in mainstream now, X stuff that proved
   bad and was dropped out]

Linux 2.4.19pre2-ac2
o	Fix a mismerge (may explain the patch weirdo)
+	Fix highmem + sblive				(Daniel Bertrand)
+	Reiserfs updates				(Oleg Drokin)
o	Auto enable HT on HT capable systems		(Arjan van de Ven)
o	Fix init/do_mounts O(1) scheduler merge glitch	(Greg Louis)
o	Fix drm build problem on CPU=386		(Mark Cooke)
o	Fix incorrect sleep in ZR36067 driver		(me)
o	Add missing cpu_relax to iph5526 driver		(me)

Linux 2.4.19pre2-ac1
o	Merge aic7xxx update				(Justin Gibbs)
o	Fix handling of scsi 'medium error: recovered'	(Justin Gibbs)
+/o	Further request region fixups			(Marcus Alanen)
o	Add interlace/doublescan to voodoo1/2 fb driver	(Urs Ganse)
	| interlace is always handy with 3d glasses..
o	Merge O(1) scheduler				(Ingo Molnar)
	| Thanks to Martin Knoblauch for doing the merge work
	| Non x86 ports may need to clean up their mm/fault.c
+/o	Lseek usage cleanup				(Robert Love)
o	Merge with 2.4.19pre2
	-	Fixed bogus sysctl definitions
	-	Fixed incorrect MODULE_LICENSE backout
	-	Fixed gratuitous supercede spelling change
	-	Fixed double patches from mips people
	-	Fixed incorrect link order from mips people
	-	Fixed broken config rules from mips people
	-	Made cciss build
	-	Remove half written "meth.c" driver
+	Fix up some of the watchdog api text		(me)
	| Janitor job - go through that and make all the drivers
	| support all the things ('V' NOWAYOUT and ioctl core)
o	Fix wrong order in MAINTAINERS			(me)
o	Remove roadrunner reference from MAINTAINERS	(me)

Linux 2.4.19pre1-ac2
o	Fix chown/chmod on shmemfs			(me)
o	Fix accounting error in the shm code		(me)
o	Turn on mode2/mode3 overcommit protection	(me)
+	w83877f watchdog fix compile for SMP		(Mark Cooke)
+	Fix ide=nodma for serverworks			(Ken Brownfield)
*	USB2 controller support				(Greg Kroah-Hartmann)
*	Add more devices to the visor driver (m515,clie)(Greg Kroah-Hartmann)
*	IBM USB camera driver updates			(Greg Kroah-Hartmann)
+	USB auerswald driver				(Wolfgang Muees)
o	Trivial random match up with 2.2		(Marco Colombo)
*	Spelling fixes					(Jim Freeman)
*	Next batch of time_*() fixups			(Tim Schmielau)
+	Update video4linux API docs			(Gerd Knorr)
+	Merge some comment fixups			(John Kim)
o	ymfpci sync					(Pete Zaitcev)
*	Update maintainers to add pm3fb			(Romain DOLBEAU)
*	Hotplug updates (docs, fs, compaq driver)	(Greg Kroah-Hartmann)
*	IBM hotplug support	(Irene Zubarev, Tong Yu, Jyoti Shah, Chuck Cole)
*	ACPI hotplug driver support		(Hiroshi Aono, Takayoshi Kochi)
+	Blink keyboard lights on x86 panic		(Andi Kleen)
o	Further Configure.help changes			(Steven Cole)
o	Merge a version of the sard I/O accounting	(Stephen Tweedie,
							 Christoph Hellwig)
o	SC1200 watchdog driver				(Zwane Mwaikambo)
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
o	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)
o	Cleaned up and fixed some SC520 watchdog bugs	(me)
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
o	SIS IDE driver update (handle with care)	(Lionel Bouton)
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
+	Only turn off mediagx/geode TSC on 5510/5520	(me)
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
+	Update IDE DMA blacklist			(Jonathan Kamens)
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
+	Nat Semi now use their own ident on the Geode	(Hiroshi Miura)
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
o	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
*	Make NetROM incoming frame check stricter	(Tomi Manninen)
*	Use sock_orphan in AX.25/NetROM			(Jeroen PE1RXQ)
o	Pegasus update					(Petko Manolov)
o	Make reparent_to_init and exec_usermodehelper	(Andrew Morton)
	use set_user, fix a tiny set_user SMP race
*	Mark framebuffer mappings VM_IO			(Andrew Morton)
o	Neomagic frame buffer driver			(Denis Kropp)
	- Needs FPU code fixing before it can be merged
*	Hyperthreading awareness for MTRR driver
+	Correct NR_IRQ with no apic support		(Brian Gerst)
*	Fix missing includes in sound drivers		(Michal Jaegermann)

Linux 2.4.18pre7-ac2
*	i810 audio driver update			(Doug Ledford)
+	Early ioremap for x86 specific code		(Mikael Pettersson)
	| This is needed to do things like apic/dmi detect early enough
+	Pentium IV APIC/NMI watchdog			(Mikael Pettersson)
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
+	Fix acpitable oopses on boot and other problems	(James Cleverdon)
o	Fix io port type on the hpt366 driver		(Pete Popov)
*	Updated matrox drivers				(Petr Vandrovec)
*	IPchains fixes needed for 2.4.18pre7
o	IDE config text updates for the IDE patches	(Anton Altaparmakov)
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

+	Re-merge the IDE patches			(Andre Hedrick and co)
*	Fix check/request region in ali_ircc and lowcomx(Steven Walter)
	com90xx, sealevel, sb1000
*	Remove unused message from 6pack driver		(Adrian Bunk)
*	Fix unused variable warning in i60scsi		(Adrian Bunk)
*	Fix off by one floppy oops			(Keith Owens)
*	Fix i2o_config use of undefined C		(Andreas Dilger)
*	Fix fdomain scsi oopses				(Per Larsson)
*	Fix sf16fmi hang on boot			(me)
o	Add bridge resources to the resource tree	(Ivan Kokshaysky)
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

