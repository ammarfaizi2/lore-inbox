Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbTD1Qwf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 12:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTD1Qwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 12:52:35 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:43131 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261203AbTD1QwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 12:52:21 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200304281704.h3SH4d609033@devserv.devel.redhat.com>
Subject: Linux 2.4.21-rc1-ac3
To: linux-kernel@vger.kernel.org
Date: Mon, 28 Apr 2003 13:04:39 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In theory the HPT372N stuff now works with the added clock switching,
but test *very* carefully if you have a 372N and only on data you have
another copy of. 

The rest seems pretty solid now so its time to add the next big chunks
that want testing pre-Marcelo.

Linux 2.4.21rc1-ac3
o	Fix copy/user handling errors in mpu401,	(me)
	mdc800, eicon, vicam
	| From Stanford checker
o	Fix an i810 error path bug that showed up	(John Stultz)
	in new Macromedia flash player
o	parisc arch code resync				(Joel Soete)
o	Merge big endian sstfb updates			(Joel Soete)
o	Fix compile with no quota again (without a	(me)
	typo this time)
o	Fix missing fc_type_trans			(Andreas Haumer)
o	Fix DRM 4.0 build				(Xosé Vázquez Pérez)
o	Fix SiS746 AGP merge				(Volker Armin Hemmann)
o	Merge XFS core code	(Steve Lord, Christoph Hellwig, and a load 
				 more people)
o	Merge current Intel ACPI
	| Except the mem= bits which need bootloader resyncs
	| This breaks ipmi but that shouldnt be too hard to clean up
	| and should end up a lot nicer

Linux 2.4.21rc1-ac2
o	Add hwif->rw_disk callout			(me)
	| This allows us to remove the PDC4030 special case
	| and also allows for the 372N clock switch stuff.
o	Add HPT372N clock switcher (needs testing carefully)
o	TDFX framebuffer improvements/fixes		(Jakub Bogusz)
o	Hopefully fix legacy hd only build 		(me)
	|Reported by Jerome Chantelauze but different fix
o	Orinoco updates					(David Gibson)
o	AGP updat for Intel 852/855			(David Dawes)
o	Fix leak in rio firmware handler		(Oleg Drokin)
o	Fix leak on aironet4500 error path		(Oleg Drokin)
o	Fix leak in roadrunner exit path		(Oleg Drokin)
o	Use the FAT free cluster hints in Linux		(Björn Stenberg)
o	Update Intermezzo contacts			(Jörn Engel)
o	Add DMI handling for broken PnPBIOS		(me)
o	Fix build without quota support			(Pavel Roskin)
o	Backport 2.5 slab poison improvements		(Faik Uygur)
o	Initial SiS 746 AGP (not for 8x yet)		(Volker Hemmann)
o	CCISS updates (support for 6404/256, cross	(Mike M)
	platform fixes, 64bit DMA
o	Fix the ide unregister deadlock bug		(me)
o	Generic XAPIC support (8 way HT etc)	(Venkatesh Pallipadi,
							Ingo Molnar)
o	A collection of NFS fixes			(Steve Dixon)
o	Fix IDE makefile a bit further			(Christoph Hellwig)
o	Use new ieee1394 code				(Ben Collins)
o	Minimal S/390 fixes to get -ac running ok	(Martin Schwidefsky)
o	Update S/390 cio layer				(Martin Schwidefsky)
o	Update S/390 DASD drivers			(Martin Schwidefsky)
o	Update S/390 31bit emulation			(Martin Schwidefsky)
o	S/390 documentation updates			(Martin Schwidefsky)
o	3215 driver updates				(Martin Schwidefsky)
o	Update S/390 ctc layer				(Martin Schwidefsky)
o	S/390 iucv updates				(Martin Schwidefsky)
o	Replace hwc with backport of 2.5 sclp		(Martin Schwidefsky)
o	Do the same with the 2.4/2.5 S/390 tape		(Martin Schwidefsky)
o	Updates to Serverworks IDE			(Duncan Lane, me)

Linux 2.4.21rc1-ac1
	Merge Marcelo 2.4.21-rc1
	- Drop broken m68k ide change
o	Fix PPC build					(Olaf Hering)
o	Fix up d_path handling				(Christoph Hellwig)
o	Update IPMI					(Corey Minyard)
o	Fix ext3 orphan race				(Ernie Petrides)
o	Update seq_file to match 2.5			(Randy Dunlap)
o	Remove experimental runtime scsi switch for IDE	(me)
	| Fixing it requires major ide register rewriting
o	Fix a deadlock on ide_unregister_subdriver	(Ben Herrenschmidt, me)
o	Fix an ext3 quota deadlock			(Jan Kara)
o	Fix ohci single shot interrupt out		(Frode Isaken)
o	Update summit idents				(James Cleverdon)
o	Clear sense buffer before retrying command	(Alan Stern)
o	Fix 82092 on a PCI bus with no ISA bridge	(David Woodhouse)
o	Fix duplicate pid corner case			(Takayoshi Kochi)
o	Add VIA phy to SiS900 driver			(Pedro A Gracia Fajorda)

Linux 2.4.21pre7-ac2
o	HPT raid support for disk-spanning/initial bits	(Wilfried Weissmann)
	of raid1
o	Cyclades PC300 driver initial merge		(Henrique Gobbi)
o	Fix bigendian use of pegasus driver		(Paul Mackerras)
o	Fix copy/user bugs in zoran drivers		(me)
	|From Stanford checker
o	Fix copy/user bugs in sisfb			(me)
	|From Stanford checker
o	Fix copy/user bugs in intermezzo		(me)
	|From Stanford checker
o	Fix copy/user bug in cmi8330 driver		(me)
	|From Stanford checker
o	Fix copy/user bug in awe sound			(me)
	|From Stanford checker
o	Merge GPL version of UTS Global CLAW driver	(Bob Scardapane)
o	Make cardbus fall back to PCI irq routing if 	(Pavel Roskin)
	needed
o	Fix sign bug in decnet				(Oleg Drokin)
o	Add AZT1008 PnP identifiers to ad1848		(Zwane Mwaikambo)

Linux 2.4.21pre7-ac1
	Merge with Marcelo 2.4
o	Merge memory barrier bits			(Zwane Mwaikambo)
o	Fix ip_conntrack merge after free		(Martin Josefsson)
o	Stop failing sethostname from clearing entire	(Stephan Maciej)
	field
o	Fix Config.in syntax for ADMA-100		(Mark Lord)
o	Remove IDE_DEBUG macro from 2.4 as well		(Alexander Atanasov)
o	In some situatiosn rq->buffer changes under  (Stephan von Krawcyznski)
	us in scsi. Store the idescsi_pc in ->special
	where it probably belongs anyway
o	Arcnet oops fixes				(Herbert Xu)
o	Pmac IDE update					(Ben Herrenschmidt)
o	Jbd compile warnings fixes			(Stephen Tweedie)
o	Dquot lock fix					(Oleg Drokin)
o	I2c fixups					(Greg Kroah-Hartmann)
o	Scsi tape updates				(Kai Makisara)
o	Update DAC960 and Qlogic drivers for Alpha	(Jay Estabrook)
o	Fix non pci build				(Stephane Oullette)
o	Fix non DMA ide build				(Andries Brouwer)
o	Fix PIO boot serverworks IDE problem		(Robert Hentosh,
							 me)
o	Small nfs dentry/dir fix			(Steve Dickson)
o	Allow longer for diagnostic commands in scsi	(Douglas Gilbert)
o	Sunrpc locking fix				(Steve Dickson)
o	Make tty->count atomic				(Jes Sorensen)
o	Update ipmi					(Corey Minyard)
o	Fix multiplex syscall wrong return code		(Ulrich Drepper)
o	M68K IDE updates				(Geert Uytterhoeven)
o	Small quota compatibility fix			(Jan Kara)
o	FPU copy fix 					(Ingo Molnar)
o	MPT Fusion update				(Pam Delaney)
o	SonyPi update					(Stelian Pop)
o	Reiserfs journal fixup				(Oleg Drokin)
	| Sanity test fail on old fs's
o	Fix X.25 crash on unknown facilities		(Tiaan Wessels)
o	Fix iphase module on new binutils		(Adrian Bunk)
o	Fix ad1889 module on new binutils		(Adrian Bunk)
o	Ditto for nsp32, ips, rtl8169
o	SiS frame buffer updates			(Thomas Winischhofer)
o	ndelay for m68k systems				(Geert Uytterhoeven)
o	m68k raw I/O updates				(Geert Uytterhoeven)
o	Fix IDE completion race 		(Jens Axboe, Andrew Morton)
o	m68k needs WANT_PAGE_VIRTUAL except sun 	(Richard Zidlicky)
o	Remove duplicate copy of PROC_CONSOLE		(Geert Uytterhoeven)
o	Fix swapoff crash				(Szabolcs Berecz)
o	Fix is_dumpable on zombies		(Marc-Christian Petersen)
o	Add vicicam to unusual storage devices
o	Update sony unusual device entries		(Hanno Böck)
	

Linux 2.4.21pre5-ac4 (not released generally)
o	Add initial test support for HPT372N		(me)
o	Fall back to PIO if the BIOS got mmio setup	(me)
	wrong for an SI3112/CMD680
	| Still doesnt explain some problems
o	Update amiga floppy driver			(Geert Uytterhoeven)
o	AmigaFB wrong IRQ fix				(Geert Uytterhoeven)
o	Amiga RTC updates				(Kars de Jong)
o	Amiga PCMCIA ethernet cleanups			(Kars de Jong)
o	Fix Amiga isa space mapping			(Kars de Jong)
o	Update apollo MMIO and pseudio MMIO		(Geert Uytterhoeven)
o	Fix bitop abuse in 5380 drivers for m68k	(Geert Uytterhoeven)
o	Fix m68k with recent binutils			(Andreas Schwab)
o	m68k prototype fix				(Geert Uytterhoeven)
o	m68k heartbeat config fix			(Geert Uytterhoeven)
o	Convert m68k cache macros to be inline		(Geert Uytterhoeven)
o	Update m68k VIA stuff				(Ray Knight)
o	Make m68k page size to fix warnings		(Geert Uytterhoeven)
o	Allow mac68k to build with no fb		(Geert Uytterhoeven)
o	Fix m68k network driver warnings		(Geert Uytterhoeven)
o	Backport m68k page_to_phys from 2.5		(Richard Zidlicky)
o	Move m68k low level iomap defines around	(Richard Zidlicky)
o	Update sun3 contact info			(Geert Uytterhoeven)
o	m68k warning fixes for scsi			(Geert Uytterhoeven)
o	Optimised stack check for m68k			(Roman Zippel)
o	M68K spelling fixes				(Steven Cole)
o	Make all sun3 pages as zone 0			(Sam Creasey)
o	Add ioremap for sun3 and use it in drivers	(Sam Creasey)
o	Sun3/3x updates and cleanups			(Sam Creasey)
o	Fix page calculation for first virtual page	(Sam Creasey)
	on sun3
o	Rename sbus structs for sparc compatibility	(Sam Creasey)
o	Update sun3 vectored interrupts			(Sam Creasey)
o	Dont update rtc from clock eveyr 11 mins	(Geert Uytterhoeven)
o	Add Sun3 VME support				(Sam Creasey)
o	ISDN ppp locking fix				(Patrick McHardy)
o	Semtimedop backport				(Mark Fasheh)
o	Fix missing cli in isdn_net			(Patrick McHardy)
o	Handle radeonfb mobility cards reporting	(Hanno Bock)
	no memory
o	Add another broken APM bios			(Arjan van de Ven)
o	Add Centrino IDE support			(Dean Gaudet)
o	Fix ibm hotplug memory leaks 			(Oleg Drokin)
o	Fix xjack memory leaks				(Oleg Drokin)
o	I2O memory leak	fix				(Oleg Drokin)
o	Emu10K memory leak fix				(Oleg Drokin)
o	cpqfc memory leak fix				(Oleg Drokin)
o	dpt_i2o memory leak notes			(Oleg Drokin)
o	Fix -ac build on alpha				(Ivan Kokshaysky)
o	Fix fd leak in initrd				(Pete Zaitcev)
o	Megaraid cleanup/check fix			(Oleg Drokin)
o	sx memory leak fix				(Oleg Drokin)
o	Kobil USB memory leak fix			(Oleg Drokin)
o	USB memory leak fix on hub			(Oleg Drokin)
o	Fix iphase driver null cells bug		(Eric Leblond)
o	Fix non zero offset reads on /proc/cmdline	(Dick Streefland)
o	Fix pdcraid ioctl pass through			(Jens Axboe)
o	Make hdparm report error on cable refusal	(Jens Axboe)
o	Reiserfs warning fix				(Maciej Soltysiak)
o	Fix warning in make_configs			(Maciej Soltysiak)
o	Remove unused variable in ide-proc		(Maciej Soltysiak)
o	CMD640 locking bug fixups			(Alexander Atanasov)
o	General IDE driver resync
o	Add another datafab kecf to the dev list	(Chris Clayton)
o	Fix wrong type for timer in aha152x		(Christoph Hellwig)
o	Avoid IDE hang on SMP when doing DMA->PIO	(Petr Vandrovec)
	changedown on error
o	Fix ide_wait_50ms fencepost error		(Alexander Atanasov)


Linux 2.4.21pre5-ac3
o	Add cpuid for SiS processors (SiS SiS SiS)	(me)
o	Fix basic ADMA100 driver support		(Mark Lord)
o	Fix memory leak on UFS error path		(Oleg Drokin)
o	Fix eepro100 ethtool hang			(Jason Lunz)
o	Fix procfs memory leak				(Kazuto Miyoshi)
o	Forte media driver update			(Martin Petersen)
o	WIN_SET_MAX crashes some old Samsung disks so	(Jens Axboe)
	dont issue it on disks < 32Gb in size
o	Compaq MS1000 may have sparse lun		(Tom Coughlan)
o	Add SiS FB idents for newer chipsets		(Thomas Winischhofer)
o	Fix vsscanf in hex mode				(Kevin Corry)
o	Fix 64bit jiffy cleanness in sis900, shaper,	(Dave Miller)
	dgrs, qlogicfc and tty layer
o	Reiserfs journal overflow fix			(Hans Reiser)
o	PCMCIA oops fix with HostAP			(Pavel Roskin)
o	Handle more panasonic compact USB CD-ROMs	(Go Taniguchi)
o	Extend USB hotplug to handle multi interface	(Go Taniguchi)
	HID devices (eg IBM BladeCenter)
o	Update ALi PCI ident data			(TH Chou)
o	Fix memory leak in ldm error path		(Oleg Drokin)
o	NCPFs ioctl passed wrong parameter		(Oleg Drokin)
o	Fix leak in ircomm core error path		(Oleg Drokin)
o	Make xconfig syntax error fixes			(Andreas Gruenbacher)
o	Fix memory leak in vlanproc exit path		(Oleg Drokin)
o	Fix iphase misaligned skb (I hope)		(me, based on stuff by
							 Eric Leblond)
o	Fix a couple of printk levels in IDE		(Alan Cox)

Linux 2.4.21pre5-ac2
o	Add PCI idents for ALi 1563 to dmfe		(Clear Zhang)
o	Busproc operations now error if unsupported	(me)
o	Make busproc handler return a status
o	Fix IDE reset locking. We don't want an IRQ	(me)
	poking around during a reset while the iface
	state is undefined
o	Remove half baked request clean up code 	(me)
	from ide_do_reset. We require the caller
	cleans up first
o	Add ide_abort functions to abort due to 	(me)
	host not target triggered events
o	Remove a pile of surplus hwgroup checks		(me)
o	Fix the reset ioctl paths to use 		(me)
	ide_abort
o	Fix PCI posting on ide resets			(me)
o	Call the dma_check routine when trying to	(me)
	enable DMA via hdparm
o	Add per driver abort handlers and use them	(me)
o	Forward port 8.0 ALi driver updates from	(me)
	Clear Zhang at ALi

Linux 2.4.21pre5-ac1
o	Merge with 2.4.21pre5
o	Do the final hatchet work on drive->id		(me)
	| IDE drive->id is now always valid so people
	| can no longer get that one wrong. 
o	DRIVER(drive) in IDE != NULL always now		(me)
	| A dummy driver removes a ton of conditions 
	| and a load of bugs
o	Move modem awareness into ac97_codec.c		(me)
	| Fixes CXT66 support I hope
o	Minimal cmedia codec setup/bug stuff		(me)
	| Note these codecs dont yet support AC3 and also
	| don't support volume control. May fix some sis7012
	| laptop setups with luck.
o	Fix mkdep bug causing devlist.h problem with	(Pavel Roskin)
	some versions of make
o	Fix missing mtd Makefile entry			(Adrian Bunk)
o	APIC initialisation fix				(Mikael Pettersson)
o	CCISS update					(Stephen Cameron)
o	USB transport size handling fix			(Alan Stern)
o	Add AGP entry for the VIA EPIA			(John Eckerdal)
o	Add Laneed idents to pegasus usb ethernet	(Go Taniguchi)
o	Add HID workaround for OKI USB keyboard		(Go Taniguchi)
o	Add idents for MTT_TE MN128 USB ethernet	(Go Taniguchi)
o	Add USB quirks for another memorystick		(Go Taniguchi)
o	Some minor typo fixes to keep 2.4/2.5 easier	(Steven Cole)
	to diff
o	Fix several operator and precdence problems	(Norbert Kiesel)
o	cciss error handling unregister fix		(Herbert Xu)
o	Kerneldoc for user access functions		(Jon Foster)
o	Further ALi IDE fixes				(Ivan Kokshaysky)
o	Improved 440GX bios workarounds			(Arjan van de Ven)
	| Thanks to the guys at Intel for hints on this
o	AMD74xx cable detect fixes			(Zoltan Hidvegi,
							 Vojtech Pavlik)
o	io/irq in mpu401 must not be initdata		(Daniel Ritz)
o	Handle shared irq on pcmcia qlogicfas		(Komuro)

Linux 2.4.21pre4-ac7
o	Next chunk of DRM merge towards 4.3 codebase
o	Fix ide-scsi deadlock on reset with SMP		(me)
o	Add some sun arrays to the scsi quirks list	(Joel Buckley)
	| They want multilun scanning always
o	Fix skbuff abuse in atm lec			(Chas Williams)
o	Update the ips driver 				(Jack Hammer)
o	Fix intelfb compile on SMP			(Arjan van de Ven)
o	One shot elevator contention fixing cache 	(Stephen Tweedie)
o	Support swapoff from initrd			(Stephen Tweedie)
o	Add another transparent bridge quirk		(Arjan van de Ven)
o	ieee1394 sleep fixes				(Arjan van de Ven)
o	Use 0xff for cpu target				(Arjan van de Ven)
o	kmap leak fix for nfs symlink			(Arjan van de Ven)
o	Fix incorrect kernel/user address handling	(me)
	crash in swapoff (root only)
o	kiovec accelerator				(??)
o	Export symbol needed by ipmi			(Andreas Haumer)
o	Add another 3c59x pci identifier		(Daniel Kopko)
o	Alpha build fix					(Elliot Lee)
o	Add new chips to e100				(Matt Wilson)

Linux 2.4.21pre4-ac6
o	Update IPMI to v18				(Corey Minyard)
o	More intel PIIX identifiers			(Bill Nottingham)
o	Update e100 for new identifiers			(Jeff Garzik)
o	Update Athlon SSE enabler			(Dave Jones)
o	Update auerswald USB isdn driver		(Wolfgang)
o	USB storage updates				(Matthew Dharm)
o	Add tripp idents to the pl2303 usb serial	(John Moses)
o	Add a new ftdi_sio ident			(Philipp G�hring)
o	Remove unused ohci driver field			(Johannes Erdfelt)
o	Fix EHCI abuse of SLAB_KERNEL in interrupt	(Oliver Neukum)
o	Fix dhcp on kaweth				(Oliver Neukum)
o	Fix some wrong idents in the pegasus driver	(Petko Manolov)
o	Fix ipaq name in usbnet				(Carsten)
o	USB macro cleanup				(Joern Engel)
o	Remove proc files in uhci that get stuck
o	Remove wrong comment in ohci/uhci drivers	(Johannes Erdfelt)
o	Roland SC8820 USB midi support			(Andrew Wood)
o	Fix USB naming bug				(Johannes Edrfelt)
o	Add ontrack to the hid ignore list		(Greg Kroah Hartmann)
o	Add tangtop to the hid blacklist		(Greg Kroah Hartmann)
o	USB scanner updates				(Henning Meier-Geinitz)
o	Fix an oom handling bug in sis drm
o	DRM updates for Radeon
	| Flightgear now takes > 2hrs to hang on my R9000
o	Fix various abusers of GFP_KERNEL in USB	(Arjan van de Ven)
o	Fix aic7xxx updates eaten by exclude file	(Sergio Visinoni)
o	Use check_gcc on crusoe				(Stelian Pop)
o	Update sonypi and meye drivers			(Stelian Pop)
o	Make input layer accept jogdial as valid	(Stelian Pop)
o	Intel i8xx framebuffer driver			(David Dawes)

Linux 2.4.21pre4-ac5
o	Fix the AMD ide bug() on boot up
o	Pass device to outbsync so that we can whack	(Ben Herrenschmidt)
	the bridge on weird platforms
o	Default sl82c05 second channel to PIO0		(Ben Herrenschmidt)
o	EHCI speed up fixes				(David Brownell)
o	Assorted cpia fixes				(Duncan Haldane)
o	SSE enable for later Athlon			(Daniel Egger)
o	3com 3c990 driver 				(David Dillow)
o	Fix config syntax error in DRM config		(Andrzej Krzysztofowicz)
o	Update pci-skeleton to fix pad bug in example	(me)
	| Noted by Roger Luethi
o	Supress popping when audio starts on via82cxxx	(Jorg Schuler)
o	Fix reiserfs direct I/O crash			(Oleg Drokin)
o	Allow cramfs initrd				(Christoph Hellwig)
o	Fix error path on dscc wan driver		(me)
o	Fix sign mishandling in epca driver		(me)
o	Fix sign mishandling in mwave driver		(Oleg Drokin)
o	Fix sign mishandling in mpt fusion		(Oleg Drokin)
o	Fix sign mishandling in aacraid			(Oleg Drokin)
o	Fix sign mishandling in tun			(Oleg Drokin, me)

Linux 2.4.21pre4-ac4
o	Attach a fake id struct to old/unprobed drives	(me)
	| Fixes a ton of special casing some of which was
	| buggy.
o	Fix incorrect sign handling in setup-pci noted	(me)
	by Oleg Drokin
o	Fix bogon error returns from init_chipset noted	(me)
	by Oleg Drokin
	| Fixes hpt366 crash on 66Mhz bus
o	Fix mishandling of flash/disk combinations	(me)
o	Fix handling of /proc/ide/*/identify with	(me)
	no driver loaded (band aid for now)
o	Fix IDE hang on rmmod and on poweroff		(me)
o	Fix IDE printk <6> bug				(Henning Schmiedehausen)
o	Radeon no longer needs AGPgart			(James McClain)
o	REPORTING-BUGS typo fix				(Faik Uygur)
o	ndelay() for PPC				(Ben Herrenschmidt)
o	PPC ioflush handling				(Ben Herrenschmidt)
o	PowerMac IDE updates				(Ben Herrenschmidt)
o	8169 missing includes for Alpha build		(Geoffrey Lee)
o	Fix sisfb build on boxes with no MTRR		(Geoffrey Lee)
o	Fix cpqfc build on Alpha			(Geoffrey Lee)
o	Fix forte build on Alpha			(Geoffrey Lee)
o	Add eth_io_copy_and_sum for Alpha		(Geoffrey Lee)
o	Fix bogus semicolon in 8253xtty			(Oleg Drokin)
o	Fix incorrect if in megaraid driver		(Oleg Drokin)
o	Fix sign warning in radio_cadet driver found	(me)
	by Oleg Drokin

Linux 2.4.21pre4-ac3
o	ALi FIFO setup channel fix			(Al Viro)
	| This needs careful testing. Treat -ac3 with a lot of care
	| on ALi platforms and report how it goes
o	Fix the dma waiting overflow			(Ben Herrenschmidt)
o	Fix ATAPI devices on VIA8235			(Vojtech Pavlik)
o	Add ndelay for Alpha				(Ivan kokshaysky)
o	Give ndelay sensible argument names		(Geert Uytterhoeven)
o	Fix pcnet32 big endian filtering		(Marcus Meissner)
o	Fix ordering problem with PCI radeon causing	(Chris Ison)
	DRI hangs
o	Fix C3 gcc compiler flags for newer gcc		(Jeff Garzik)
o	Replace nvidia and amd IDE drivers with new	(Vojtech Pavlik)
	driver
o	Fix missing ; in aicasm_gram.y			(Thibaut VARENE)
o	NCR5380 trivial fix				(Geert Uytterhoeven)
o	Make constants in maxiradio static		(Arnd Bergmann)
o	Fix typos of 'available'			(Alfredo Sanjuan)
o	Fix wrong checks in bttv ioctl code	(Alexandre Pereira Nunes)
o	Fix i2c_ack cris extra ";"
o	Fix JSIOCSBTNMAP extra ";"
o	Fix VIDIOCGTUNER on w9966
o	Fix amd8111e_read_regs
o	Fix smctr_load_node_addr
o	Fix sym53c8xxx extra ";"
o	Fix sym53c8xxx_2 extra ";"
o	Fix cs46xx download area clear
o	Fix hysdn bootup error handling
o	Fix mtd mount error checks
o	Fix dpt_i2o reset error paths
o	Fix a jffs error path handler
o	Fix es1371 error path on register
o	Fix sscape operator precedence
o	Fix copy counting in vrc5477 audio
o	Fix cdu31a oops with data cd			(Mauricio Martinez)
o	Fix ide taskfile if ";" errors			(Oleg Drokin)
o	Add 3com 3c460 to kaweth			(Oliver Neukum)
o	Kaweth length/dhcp fix				(Oliver Neukum)
o	ISD-200 requires IDE				(Olaf Hering)

Linux 2.4.21pre4-ac2
o	Turn on use of ide_execute_command everywhere	(Ross Biro, me)
o	First cut at settings locking for IDE		(me)
o	Add driver for CS5530 Kahlua audio		(me)
o	Fix wrong semicolons in system.h		(Mikael Pettersson)
o	Support root=nbd				(Ben LaHaise)
o	x86 byte order swapping optimisations		(Andi Kleen)
o	PMAC ide updates				(Ben Herrenschmidt)
o	Fix mishandling of nfsroot port= option		(Eric Lammerts)
o	Fix ALi audio on systems with > 2Gb RAM		(Ivan Kokshaysky)
o	Enable generic rtc on PPC boxes			(Geert Uytterhoeven)
o	Fix ide build with gcc 3.3 snapshot		(Olaf Hering)
o	Merge EHCI updates (qh state machine fix etc)	(David Brownell)
o	Fix radio-cadet SMP build			(Adrian Bunk)
o	Starfire updates				(Ion Badulescu)
o	Backport seq_file fix to 2.4			(Eric Sandeen)
o	Fix ext3 crash deleting a single non sparse	(Stephen Tweedie)
	file exceeding 1Tb

Linux 2.4.21pre4-ac1
o	Restore the mmap corner case fix		(Raul)
o	Add sendfile64 to 2.4.x				(Christoph Hellwig)
o	NLM garbage collection hang fix			(Daniel Forrest)
o	Enable kernel side pcigart for radeon		(Michael Danzer)
	| Requires recent XFree and ForcePCIMode
o	Don't bash legacy floppy on x86_64 bootup	(Mikael Petersson)
o	Forward sony joygdial input to input layer	(Stelian Pop)
o	TCP session stall fix				(Alexey Kuznetsov)
o	Ian Nelson has moved				(Ian Nelson)
o	Add unplugged iops ready for hotplug IDE support(me)
o	Add an OUTBSYNC iop for the IDE layer		(Ben Herrenschmidt)
o	Finish the ide_execute_command code		(me)
o	Switch ide-cd to ide_execute_command 		(me)
	| Always good to test stuff on read only devices first 8)
o	Fix IDE masking logic error			(Ross Biro)
o	Fix IDE mishandling of IRQ 0 devices		(me)
o	Fix printk levels on promise drivers		(me)
o	Clean up duplicate mmio ops/printk in siimage	(me)
o	Always set interrupt line with VIA northbridge	(me)
	| Should fix apic mode problems with USB/audio/net on VIA boards
o	Add Diamond technology dt0893 codec		(Thomas Davis)
o	Add IBM 'Ruthless' platform string to summit
o	Don't warn about IRQ when enabling a pure	(me)
	legacy mode IDE class device
o	Clean up radio_cadet locking and other bugs	(me)
o	Fix jiffies mishandling in eata drivers		(Tim Schmielau)
o	Quieten confusing DMA disabled messages		(Tomas Szepe)
o	i830 DRM update port over			(Arjan van de Ven)

Linux 2.4.21pre3-ac5
o	Fix erratic oopsing on 2.4.21pre3-ac*		(Hugh Dickins)
o	Fix an incorrect check in raw.c			(Artur Frycze)
o	Fix highmem IDE DMA				(Jens Axboe)
o	Fix the size of the EDD area			(Kevin Lawton)
o	Remove incorrect ACPI blacklist entry		(Pavel Machek)
o	SCSI memory leak fix				(Justin Gibbs)
o	Fix mmap of vmalloc area in kmem giving wrong	(Tony Dziedzic)
	results
o	Fix date in the microcode driver		(Jonah Sherman)
o	Fix incorrect smc9194 handling of skb_padto	(David McCullough)
o	Fix use of old check_regio function in umc8672	(William Stinson)
o	Remove unused variable in sc1200		(Bob Miller)
o	Perform ide_cs unregister in task context	(Paul Mackerras)
	| This doesn't fix all the bugs yet...
o	Fix bugs in the gx power management code	(Hiroshi Miura)
o	Fix the sl82c105 driver for the new IDE code	(Benjamin Herrenschmidt,
							 Russell King)
o	Remove cacheflush debug printk			(me)
o	Fix IDE paths in docs for new layout		(Karl-Heinz Eischer)
o	Generic RTC driver backport			(Geert Uytterhoeven)
o	HDLC driver updates				(Krzysztof Halasa)
o	AMD8111 random number generator support		(Andi Kleen)
o	Fix crashes on e2100 driver			(me)

Linux 2.4.21pre3-ac4
o	Finish verifying PIIX/ICH drivers versus errata	(me)
o	Fix handling of DMA0 MWDMA on early ICH		(me)
o	Fix compile in kernel for Aurora SIO16		(Adrian Bunk)
o	Clean up various Configure.help bits		(Adrian Bunk)
o	Disallow write combining on 450NX		(me)
o	Ensure rev C0 450NX has restreaming off		(me)
o	Don't do IDE DMA on rev B0 450NX or later	(me)
	450NX without BIOS workarounds for the hang
o	Update Configure.help for HPT IDE		(Adrian Bunk)
o	Fix harmless code error in sb_mixer		(Jeff Garzik)
o	Fix ethernet padding on via-rhine		(Roger Luethi)
o	Add ndelay functionality for x86		(me)
	| Based on Ross Biro's code
o	Add ide_execute_command 			(me)
	| Again based on Ross Biro's changed. Not yet used
	| This will be the new correct way to kick off an 
	| IDE command from non IRQ context
o	Matroxfb compile fix for one option combination	(Petr Vandrovec)

Linux 2.4.21pre3-ac3
o	Address comments on wcache value/issuing	(me)
	cache flush requests
o	Update credits entry for Stelian Pop		(Stelian Pop)
o	Backport some sonypi improvements from 2.5	(Kunihiko IMAI)
o	Fix pdcraid/silraid symbol clash		(Arjan van de Ven)
o	Fix ehci build with older gcc			(Greg Kroah-Hartmann)
o	Fix via 8233/5 hang				(me)
o	Fix non SMP cpufreq build			(Eyal Lebidinsky)
o	Fix sbp2 build with some config options		(Eyal Lebidinsky)
o	Fix ATM build bugs				(Francois Romieu)
o	Fix an ipc/sem.c race				(Bernhard Kaindl)
o	Fix toshiba keyboard double release		(Unknown)
o	CPUFreq updaes/fixes				(Dominik Brodowski)
o	Natsemi Geode/Cyrix MediaGX cpufreq support	(Hiroshi Miura,
							 Zwane Mwaikambo)
o	Add frequency table helpers to CPUfreq		(Dominik Brodowski)

Linux 2.4.21pre3-ac2
o	Fix the dumb bug in skb_pad			(Dave Miller)
o	Confirm some sparc bits are wrong and drop them	(Dave Miller)
o	Remove a wrong additional copyright comment	(Dave Miller)
o	Upgrade IPMI driver to v16			(Corey Minyard)
o	Fix 3c523 compile				(Francois Romieu)
o	Handle newer rpm where -ta is rpmbuild not rpm	(me)
o	Driver for Aurora Sio16 PCI adapter series	(Joachim Martillo)
	(SIO8000P, 16000P, and CPCI)
	| Initial merge
o	Backport Hammer 32bit mtrr/nmi changes		(Andi Kleen)
o	Add the fast IRQ path to via 8233/5 audio	(me)

Linux 2.4.21pre3-ac1
+	Handle battery quirk on the Vaio Z600-RE	(Paul Mitcheson)
*	EHCI USB updates				(David Brownell)
+	IDE Raid support for AMI/SI 'Medley' IDE Raid	(Arjan van de Ven)
+	NVIDIA nForce2 IDE PCI identifiers		(Johannes Deisenhofer,
							 Tim Krieglstein)
*	CPU bitmask truncation fix			(Bjorn Helgaas)
o	HP100 cleanup					(Pavel Machek)
o	Fix initial capslock handling on USB keyboard	(Pete Zaitcev)
+	Update dscc4 driver for new wan			(Francois Romieu)
+	Fix boot on Chaintech 4BEA/4BEA-R and		(Alexander Achenbach)
	Gigabyte 9EJL by handing wacky E820 memory
	reporting
o	SysKonnect driver updates			(Mirko Lindner)
o	Fix memory leak in n_hdlc			(Paul Fulghum)
o	Fix missing mtd dependancy			(Herbert Xu)
+	Clean up ide-tape printk stuff			(Pete Zaitcev)
+	IDE tape fixes					(Pete Zaitcev)
o	Fix size reporting of large disks in scsi	(Andries Brouwer)
+	Fix excessive stack usage in NMI handlers	(Mikael Pettersson)
+	Add support for Epson 785EPX USB printer pcmcia	(Khalid Aziz)
*	Quirk handler to sort out IDE compatibility	(Ivan Kokshaysky)
	mishandling
+	Model 1 is valid for PIV in MP table		(Egenera)
+	Ethernet padding fixes for various drivers	(me)
o	Allow trident codec setup to time out		(Ian Soboroff)
	This can happen with non PM codecs
o	Fix broken documentation link			(Henning Meier-Geinitz)
o	Update video4linux docbook			(William Stimson)
o	Correct kmalloc check in dpt_i2o		(Pablo Menichini)
o	Shrink kmap area to required space only		(Manfred Spraul)
o	Fix irq balancing				(Ben LaHaise)
o	CPUfreq updates					(Dominik Brodowski)
o	Fix typo in pmagb fb				(John Bradford)
o	EDD backport					(Matt Domsch)


REMOVED FOR NOW

-	RMAP

REMOVED FOR GOOD

-	LLC 	(See 2.5)
-	VaryIO  (Never accepted mainstream)

--
  "In the same way it might be interesting to see what happens if you put
 		  cigarette into gasoline tank?"
			  -- Pavel Machek
