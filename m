Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSILPui>; Thu, 12 Sep 2002 11:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSILPui>; Thu, 12 Sep 2002 11:50:38 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3951 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316213AbSILPuT>; Thu, 12 Sep 2002 11:50:19 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200209121555.g8CFt9G22831@devserv.devel.redhat.com>
Subject: Linux 2.4.20-pre5-ac6
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2002 11:55:09 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 [+ indicates stuff that went to Marcelo, o stuff that has not,
 * indicates stuff that is merged in mainstream now, X stuff that proved
   bad and was dropped out, - indicates stuff not relevant to the main tree]

**	Next stage IDE cleanup. This still has the ide-scsi oops, and
**	simplex breakage. We know why both of those occur I think so they
** 	should be fixed next time.
**
**	You can now load ide pci drivers at boot time or as modules.
**	Don't try unloading the modules yet.
**

Linux 2.4.20-pre5-ac6
o	Fix ide BUG() with cdrom stuff			(Jens Axboe)
o	Inode kernel data leak fix			(Ben LaHaise)
o	Fix spinlock workaround to keep sparc people	(Dave Miller)
	happy
o	Transparent pci-pci bridge fixes		(Ivan Kokshaysky)
o	Backport sched_yield O(1) fixes from 2.5	(Robert Love)
o	Comments for scheduler code			(Ingo Molnar)
o	Implement 2.5 compatible task_cpu wrappers	(Robert Love)
o	Backport minor scheduler fixes for O(1) from 2.5(Robert Love)
o	Add configure.help for new USB bits		(Adrian Bunk)
o	OHCI takeover fix				(Zwane Mwaikambo)
o	Add ALI1541 gameport support			(Pascal Schmidt)
o	Make rs_read_proc static			(Geert Uytterhoeven)
o	cpufreq updates					(Dominik Brodowski)
o	Radeonfb fixups for mobility P/M		(H Peter Anvin)
o	synclink MP link fix				(Andrian Bunk)
o	Fix mad16 gameport unload			(Greg Alexander)
o	Indent cpqfc so I can actually read it		(me)
	| No code changes

Linux 2.4.20-pre5-ac5
o	Fix ALi OOPS on RLX blades			(Dan Eaton)
o	Finish up ide pci register code			(me)
o	Switch IDE PCI drivers to use new register code	(me)
o	Fix scribble over constant data in hpt34x	(me)

Linux 2.4.20-pre5-ac4
o	Fix error path bug in pci resource code		(Keith)
o	Fix p4-clockmod compile error			(Adrian Bunk)
o	Align packets nicely on kaweth USB ethernet	(Oliver Neukum)
o	Further Changes file fix			(Steven Cole)
o	TCP timestamp handling fix			(Dave Miller)
o	Compile warning fixes				(Niels Jensen)
o	Next batch of IDE header updates		(Andre Hedrick)
o	IDE scsi update					(Andre Hedrick)
	| Needs some highio cleanup yet
o	IDE DMA updates					(Andre Hedrick)
o	Update the IDE PCI driver layer			(Andre Hedrick)
o	Fix pdc202xx further braindamage		(me)
o	Further icside fixes			(Bartlomiej Zolnierkiewicz)
o	Fix ide-lib atapi DMA check		(Bartlomiej Zolnierkiewicz)
o	CMD64x rev 5/7 UDMA check fix		(Bartlomiej Zolnierkiewicz)
o	Add blk_fs_request helper			(Jens Axboe)
o	IDE highmem fixes (scsi needs doing		(Jens Axboe)
	I suspect)
o	Longer PIO timeout for taskfile write		(Andre Hedrick)
o	Fix promise cable detect			(Andre Hedrick)
o	Split promise into old and new drivers		(me)

Linux 2.4.20-pre5-ac3
o	Fix procfs handling for zoran driver		(Silvio Cesare)
o	ZR36067 doesn't support bitmask clipping so	(Silvio Cesare)
	error such a request.
o	LBA48 on older promise IDE fix			(Mike Isely)
o	Report jfs tools version in ver_linux		(Steven Cole)
o	HP XP arrays can need largelun			(Steve Mickeler)
o	Allow maestro3 gpio amp control setup by	(Michael Olson)
	hand for odd machines (Panasonic CF-72)
o	Add autodetect to the CF-72 maestro3 funny	(me)
o	Fix overlarge read in vicam usb			(Silvio Cesare)
o	Length limit S/390 cio proc write files		(Silvio Cesare)
o	Length limit S/390 chandev proc write files	(Silvio Cesare)
o	Length limut S/390 dasd statistics write	(Silvio Cesare)
o	Two fixes to 3270 driver for S/390		(Silvio Cesare, me)
o	Fix buffer limits in tubfs for S/390		(Silvio Cesare)
	| Really this code wants redoing to loop rather than do shorter
	| read/writes on full buffers. but thats not trivial
o	Use define values not magic constants on S/390	(Silvio Cesare)
	netiucv buffer checks
o	Correct a vmalloc corner case			(Dave Miller)
o	Fix hisax oops with out of range card type	(Alan Hourihane)
o	Update Documentation/Changes for reiserfs	(Neils Jensen)
o	Fix incorrect type in i2c-core			(Silvio Cesare)
o	Fix length limits in i2c-dev			(Silvio Cesare)
o	Fix incorrect type in amdtp			(Silvio Cesare)
o	Update Buslogic maintiners entry 8(
o	Don't register a gameport at I/O zero if none	(me)
	is configured on es1370, es1371, 
o	Handle unprintable ac97 codec names (STAC)	(me)
o	Restructure pcigame and trident audio not to	(me)
	fall over each other

Linux 2.4.20-pre5-ac2
o	BeFS updates					(Will Dyson)
o	Fix prototype mismatch in tc/tc.c		(Silvio Cesare)
o	SunRPC oops fix					(Chuck Lever)
o	Fix SunRPC TCP handling for write_space		(Chuck Lever)
o	Update ver_linux reporting further		(Steven Cole)
o	Cpufreq updates					(Dominik Brodowski)
o	Update pegasus.h license header			(Petko Manolov)
o	USB lcd driver					(Adams IT)
o	Update bluetooth drivers			(Greg Kroah-Hartmann,
							 Masoodur Rahman)
o	USB serial update				(Greg Kroah Hartmann)
o	Workaround for some usb keyboards		(Itai Nahshon)
o	Minolta DImage4 entry for unusual_devices	(Petr Konecny)
o	OHCI completion of unlinked urbs fix		(David Brownell)
o	Tighten AC97 modem detect rules			(me)
o	Report AC97 codecs by their PNP ID		(me)
o	Further sis memory checks			(Zwane Mwaikambo)
o	Add new opcodes to the hdreg.h IDE table	(Andre Hedrick)
o	Update cris and x86_64 ide.h files		(Andre Hedrick)
o	Fix includes in freecom.c			(Andre Hedrick)
o	Winbond IDE requires PCI			(Andre Hedrick)
o	icside cleanup					(Andre Hedrick)
o	Report ide unregister failures			(Andre Hedrick)
o	Clean up legacy hd driver to use outb		(Andre Hedrick)
o	Ditto for ide-cs				(Andre Hedrick)
o	ns87415 needed to call its own ide_dma_end	(Andre Hedrick)
o	Make via_base unsigned long not uint		(Andre Hedrick)
o	Update ide-ppc (probably broken until some  (Bartlomiej Zolnierkiewicz
	other changes go in)			     Andre Hedrick)
o	Fix bugs in the ide-cd -> ide-scsi pass over	(Andre Hedrick)
o	Kill GET_ERR macro in ide-disk			(Andre Hedrick)
o	IDE dma hack fix for etrax - needs to be	(Andre Hedrick)
	generalised
o	Update as yet unused ide-lib code		(Andre Hedrick)
o	Fix types in ide_probe reporting		(Roman Zippel)
o	Add disable/enable irq probe handling		(Roman Zippel)
o	Fix non PCI IDE build problems			(me)
o	Merge Matrox G450 updates			(Petr Vandrovec)
o	Re-enable DRM for GMX2000 (it doesnt work yet)	(me)

Linux 2.4.20-pre5-ac1
	Resync with 2.4.20pre5
o	Fix IDE compile					(me)
o	Update defconfig				(Niels Jensen)
o	Various warning fixes				(Niels Jensen)
+	Remove epat debug printk that escaped		(Moritz Barsnick)
o	Fix PPC build for pre4-ac			(Ben Herrenschmidt)
o	Fix hang in Matrox DRM				(Jonny Strom)
o	Backport 2.5 LDT allocation improvements	(Manfred Spraul)
+	Lp tidy and printk levels	 	(Lucas Correia Villa Real)
o	Update yenta region size patch			(Manfred Spraul)
+	Fix an i2c bus leak on the acorn pcf8583	(Silvio Cesare)
+	Fix e100 phy build				(Linus Torvalds)
o	Further i810 audio updates			(Juergen Sawinski)
+	Tidy ver_linux output with gcc 3.x		(Steven Cole)
o	ppp_generic fixes for building on boxes		(Bjorn Helgaas)
	with out* as macros
o	pdc4030 updates					(Peter Denison)
+	Forte sound driver updates			(Martin Petersen)
o	Fix AMD7441 PCI ID error
o	Tighten asm-ia64 io macros			(Andreas Schwab)

Linux 2.4.20-pre4-ac2
-	Pull NFSD back in line with Marcelo
o	Fix IDE PCMCIA build error			(me)
o	Fix check/request region race in IDE DMA	(me)
o	Fix I/O handling of dma_base2 request fail	(me)
o	More debugging around the simplex ide DMA	(me)
+	Fix kmalloc error leak in fd1772		(Silvio Cesare)
+	Handle out of memory on acorn ps/2		(Silvio Cesare)
+	IEEE1394 integer overflow fix			(Silvio Cesare)
+	Khttpd race fixes				(Dan Kegel)
+	Backport kaweth fixes from 2.5			(Oliver Neukum)
O	Fix gcc 2.x build of brlvger			(Eyal Lebedinsky)
*	Error handling clean ups for USB storage	(Pete Zaitcev)
o	Fix loops_per_jiffy mod calculation overflow	(Yoann Vandoorselaere)
o	PCI hotplug oops fixes				(Greg Kroah-Hartmann)
o	APM do idle now doesnt keep warning on error	(Ben LaHaise)
o	Reinitialize AGP on i845 after a suspend	(Charl Botha)
o	Don't rserve port 0x45 on sbc60xxwdt		(Anders Pedersen)
o	Export elevator_init so modules can switch	(Arnd Bergmann)
	to no-op elevators
o	Fix gmac link status reporting			(Roberto Gordo Saez)
o	Radeonfb update					(Peter Horton,
							 Erik Andersen)
+	Fix resource leak on error in sisfb		(me)
+	Fix sisfb to fail the load if no card is	(me)
	found

Linux 2.4.20-pre4-ac1
-	Resync with Marcelo
	- JFS files from Marcelo tree taken to be definitive
o	Remove undefined signed overflow in readv/writev(me)
*	Fixed the pci resource mess. Turns out the bug
	was in the 2.4 core PCI code not IDE		(me)
o	Fix 3D hangs with screensaver and forking	(Tim Smith)
*	Add an apparently buggy Intel APM to DMI table	(me)
*	Fix non compile of kernel in French 		(Keith Owens)
*	Typo fixes					(James Mayer)
o	Quieten harmless invalidate_bdev warnings	(Christoph Hellwig)
+	Forte sound driver for OSS			(Martin Petersen)
	| Based Jaroslav's ALSA driver
+	Remove some bogus printks, fix an error		(me)
	handler, correct non blocking open
	| spin_lock/copy needs fixing still
*	Fix wrong struct in range check in ixj.c	(Silvio Cesare)
*	Use loff_t types in zorro/proc.c		(Silvio Cesare)
o	Abort IDE cd reads immediately on medium	(Erik Andersen)
	error as that isnt correctable
*	USB typo fixes					(James)
*	UHCI FSBR and bitop fixes			(Greg Kroah-Hartmann)
*	Fix OHCI on slow machines			(Greg Kroah-Hartmann)
*	Update to latest rtl8150 driver			(Petko Manolov)
*	Update Microtek scanner driver			(Oliver Neukum
*	EHCI fixes					(Greg Kroah-Hartmann)
*	__FUNCTION__ cleanups for USB			(Greg Kroah-Hartmann)
*	Update to latest pegasus driver			(Petko Manolov)
*	Update to latest OV511				(Mark McClelland)

Linux 2.4.20-pre2-ac6
o	Next collection of code cleanups 		(Andre Hedrick)
	-	Clean up the rest of the ratefilters
		(no functional change)
	-	Clean ups for the attach logic
o	Removed 'have you read the release notes' check	(me)
o	Kill AUTODMA ifdefs in the drivers		(me)
o	Rework OSB4 bug handling - we now keep disk
	devices out of UDMA mode. Fix the sanity check
	so we don't blow up with CD-ROM media errors
o	Kill remaining if(dmabase) checks in init_dma	(me)
	| init_dma isnt called with !dmabase...
o	Create ide-lib for some common stuff		(me, Andre Hedrick,
							 Jeff Garzik)
o	Fix the ide-proc crash on boot			(me)
	| May also fix the 'where did my proc file go' bits
o	Move q40 driver into legacy not pci		(me)
o	Remove do-nothing casts from slc90e66		(me)
o	Make all the pci driver functions static	(me)
o	Add printk levels to trm290 driver		(me)
o	Restore irq state at the end of the ali chipset	(Arjan van de Ven)
	initialiser
o	Ripple errors back further. An unsupported	(me)
	hpt374 will now print errors and skip the
	controller
*	Fix crash mounting EFS from a CD-ROM		(me)

Linux 2.4.20-pre2-ac5
*	Fix sparc64 pcibios to match the new behaviour
o	Comment, add FIXME notes to the via ide driver	(me)
o	Add a FIXME note that we need to update PIIX
	to handle /proc for dual controller
o	Bump versions on ide stuff we have changed	(me)
o	Add VIA vt8235 IDE support			(Vojtech Pavlik)
o	Delete xp_fixup - the new enable_device_bars	(me)
	resolves this properly.
o	Add BUG() checks to verify dmabase check	(me)
	is unneeded before removal
o	Further splitting of the setup_pci_device code	(me)
	| Again no functionality changes
o	Make cs5530 use pci_set_mwi/pci_set_master	(me)
	(also clean up add docs)
o	Move all the actual IDE drivers into 		(me)
	subdirectories so we can see what is what
o	Clean up ide-pnp a little			(me)
o	Further i810_audio updates for 845		(Juergen Sawinski)
o	USB quirks for konica/mintola digital cams	(Jan Willamowius)

Linux 2.4.20-pre2-ac4
o	Clean up ALi rate selection code		(me)
o	Clean up PIIX rate selection code		(me)
o	Don't frob bit 1 on later ALi chips		(me)
	| Should fix Fujitsu hang
o	Remove dead PIIX DMA setup function		(me)
o	Make new ide code using pci_set_master		(me)
o	Chop up some of the big chunks of setup-pci.c	(me)
	into smaller functions
o	When pulling an unconfigured IDE controller	(me)
	native try assigning missing resources
o	Fix wrong case in ide_get_or_set_dma_base	(me)
	(dma_base is ulong not u32)
o	Disable winxp fix (it shouldnt be needed now)	(me)
*	Blacklist a Dell with APM bugs			(Peter Bowen)
o	Fix SMP ps2esdi build				(Adrian Bunk)
*	Fix gcc2.95 build of st5481 driver		(me)
o	Handle wrap cases in pcilynx			(Silvio Cesare, me)
o	Fix efi/raid problem				(Matt Domsch)
o	Fix hd.c build					(me)
o	Fix a wrong type in bttv-driver			(Silvio Cesare, me)
o	Updated scsi-debug driver			(Douglas Gilbert)
o	Fix a khttpd null dereference			(Dan Kegel)
*	Fix isdn/gcc 2.95 build fail			(Kai Germaschewski)
o	Don't synchronize the tsc in "badtsc" mode	(me)
	| Fixes oops noted by John Stultz
o	Initial work on reverse engineering the IBM	(me)
	thinkpad docking bridge
o	Return EEXIST on pci hotplug duplicate name	(me)
o	Fix IDE code reporting wrong I/O setup in	(me)
	error

Linux 2.4.20-pre2-ac3
o	IDE updates					(Andre Hedrick)
o	Merge -ac fixes for ALi and PCI bars		(me)
o	Add docs to PIIX and ALi			(me)

Linux 2.4.20-pre2-ac2
o	Updates to device mapper			(Joe Thornber)
o	Fix mempool corruption bug			(Christoph Hellwig)
*	Correct pci_alloc_consistent with 64bit mask	(Steffen Persvold)
*	Elevator accounting improvements		(Jens Axboe)
*	Clean up vt.c ioperm ifdef even more		(Milton Miller)
o	Fix PAGE_BUG usage problem			(Eyal Lebedinsky)
*	Tweak isdn to try and fix gcc 2.95 compile 	(Kai Germaschewski)
o	Make parameter variables on synclink* static	(me)
o	Add documentation to jbd layer			(Roger Gammans)
-	NFSD link fix					(Greg Louis)
*	Fix NFS oops on 64bit big endian		(Dave Miller)
*	Add another vaio to the dmi blacklist		(Marc Boucher)
*	Fix devfs enabled build				(Christoph Hellwig)
o	Fix resource assignment for cardbus behind	(H J Lu)
	pci transparent bridges
o	Fix makefile for speakup a bit			(O Sezer)
*	Update ftd_sio driver				(Greg Kroah-Hartmann)
*	Update usb serial Config.in			(Greg Kroah-Hartmann)
*	Fix error handling on ipaq usb serial		(Greg Kroah-Hartmann)
*	Update pl2303 usb serial			(Greg Kroah-Hartmann)
*	Fix usb serial warnings in gcc3			(Greg Kroah-Hartmann)
*	Fix gcc3 warnings in ir-usb			(Greg Kroah-Hartmann)
*	Fix DMA off stack in USB storage		(Roland Dreier)
*	Add SDDR-55 USB storage driver			(Greg Kroah-Hartmann)
*	Fix gcc3 warnings and other bugs in usb btooth	(Greg Kroah-Hartmann)
*	HP usb scanner driver			(Oliver Neukum, John Fremlin, 
							Matthew Dharm)
*	Update usb scanner driver			(Greg Kroah-Hartmann)

Linux 2.4.20-pre2-ac1
-	Merge 2.4.20-pre2
	-	drop change to apic error logging level
	-	drop bogus sign cast in spin_is_locked
o	Merge LVM2 device mapper			(Joe Thornber)
*	Clean up locking a little in ps2esdi		(me)
	| This driver needs much love and attention
*	Similar for xd.c (same comments too)		(me)
*	Allocate xd bounce buffer early (can deadlock	(me)
	during an I/O)
*	Fix partition table breakage			(me)

Linux 2.4.20-pre1-ac3
o	Report "unknown errror" not "on fire" for usblp	(Pete de Zwart)
*	Teach ac97_codec.c about 3rd/4th codecs		(Juergen Sawinksi)
o	Add MMIO support for i845 audio			(Juergen Sawinksi)
o	Tidy up error paths on i810_audio init		(me)
*	Use cpu_has_tsc macro in joystick/random too	(John Stultz)
*	Oliver Neukum becomes new HFS maintainer	(Oliver Neukum)
	| Treat him gently HFS is non trivial to fix
*	Merge synclink-mp driver			(Paul Fulghum)
*	Fix wavelan dev->trans_start handling		(Jean Tourrilhes)
*	Switch to newer wavelan_cs update		(Jean Tourrilhes)
*	Merge e100/e1000 docs				(Jeff Garzik)
*	Remove wrong use of set_bit in dl2k driver	(Matthew Wilcox)
*	Add another tulip PCI ident			(Antoine,
						 Aaron Baranoff, Owen Taylor)
*	Update 8139too PCI identifiers			(Wilson Chen)
*	Add another pl2303 identifier			(Lutz Rothhardt)
*	Remove confusing usb typedefs			(Greg Kroah-Hartmann)
*	Add ti edge port USB driver			(Greg Kroah-Hartmann)
*	Cypress sl811 USB controller driver
*	Driver for Aiptek 8000U USB			(Chris Atenasio)
*	ti silverlink cable driver		(Romain Li�vin, Julien Blache)
*	USB midi driver					(NAGANO Daisuke)
*	Fix up hci_usb for USB changes			(me)
*	Fix ub st5481_usb for USB changes		(me)
*	Fix sis DRM warnings				(me)
*	Fix bad ifdef in lvm-snap			(me)
*	Fix irda-usb compile error from USB changes	(me)
*	DECnet refcounting fix				(Steve Whitehouse)
*	Export 8253 lock for ftape etc			(me)
*	Fix undefined C in the dpt_i2o			(me)
*	Fix oops case in i810-tco			(me)
o	Config help updates				(Steven Cole)
o	Merge 2.5 mempool support (needed for LVM2)	(Ingo Molnar)
o	Add vcalloc, including overflow checking	(Joe Thornber)
o	Add mempool slab helpers			(Joe Thornber)
o	Make bh->b_inode a flag in b_state		(Andrew Morton)
o	Use a seperate b_journal_head instead of	(Andrew Morton)
	b_private

Linux 2.4.20-pre1-ac2
-	Fix compile failure for uniprocessor APM	(me)
o	Fix a compile warning and save 8K in do_mounts	(Niels Jensen)
o	Update x86 defconfig				(Niels Jensen)
*	Remove dead bits in dpt_i2o			(Eric Sandeen)
*	Configure.help cleanup				(Steven Cole)
*	EExpress can use I/O 0x240 on some cards	(Pavel Janik)
*	Update epic100 driver				(Jeff Garzik)
-	Fix compile of old hd.c				(me)
o	Add "badtsc" option based on John Stultz	(John Stultz, me)
	proposal
o	Rewrote the code a bit to allow automatic	(me)
	detection of notsc on Summit
	| When and if IBM document the other timers on the
	| Summit this will also make it easy to plug it in
	| (We can now handle detecting mixed multiplier PII
	| as well if someone wants to add the code)
o	Clean up timer stuff further based on comments	(me)
	by John Stultz.
*	Handle console_unblank failure from IRQ path	(Arnd Bergmann)
o	Rewrite NSC USB controller changes from parisc	(me)
	port into a general OHCI quirk
o	First set of i810 audio updates			(Doug Ledford)
*	AF_UNIX abstract addresses fix			(Alexey Kuznetsov)
*	Further mpt fusion updates			(Pam Delaney)
o	Rev 0xC4 of ALi apparently isnt LBA48		(me)
o	Add license tag to AF_UNIX			(Christian Kurz)
*	USB scanner endian fixes			(Frank Zago)
o	Update 2.4 to the 2.5 LDM driver		(Richard Russon)
*	Update 8193cp driver for 64bit DMA, checksum	(Jeff Garzik)
*	Update 8139too driver				(Jeff Garzik)
*	Natsemi updates					(Tim Hockin)
*	Remove unneeded net includes			(Brad Hards)
*	Spelling fixes in drivers/net
*	Fix use after kfree in au1000 ethernet		(Marcus Alanen)
*	Mark roadrunner driver as experimental		(Greg Banks)
*	Mark the FMV driver obsolete			(Greg Banks)
*	Tidy rcpci45					(Eric Sandeen)
*	Fix ppp compile warning				(Eric Sandeen)
*	Move 3c509 license tag outside of ifdefs	(Jeff Garzik)
*	Fix ALi irda warning				(Eric Sandeen)
*	Fix flags types in a few drivers		(Celso Gonz�lez)
*	E100 needs bitops.h				(Dave Miller)
-	Remove a debug line in the Makefiles		(Alex Riesen)
*	Back port 2.5 file lease code and race fixes	(Stephen Rothwell)
o	PnPBIOS ESCD reader fixes			(Thomas Hood)

Linux 2.4.20-pre1-ac1
-	Merge with 2.4.20pre1
	- Drop broken isicom change
	- Fix formatting errors in x86_64 char/Config.in
	- Fix formatting errors in x86_64 isdn/Config.in
	- Fix formatting errors in x86_64  radio card Config.in
	- Fix formatting errors in x86_64 drivers/net/Config.in
	- Drop broken atarilance change
	- Fix wrong ioctl return in e100_ethtool_test, e100_ethtool_gstrings
	- Fix security hole in e100 ioctl handler
	- Fix identical hole in e1000 ioctl handler
	- Remove mess where x86_64 sticks its arse in all sorts of
	  config files and makes a mess of it. Other ports don't because
	  the result sucks, x86_64 shouldnt either
	- Drop utterly bogus change to drivers/sound/Config.in
	- Revert uncompilable tg3 driver
*	Fix up the eepro100 mess from 20pre1		(Christoph Hellwig)
*	Switch to Namesys __FUNCTION__ reiserfs fixes	(Oleg Drokin)
*	Fix eepro formatting on register
o	Fix radeon build on PPC				(Ben Herrenschmidt)
o	PPC scheduler, bitups, rwsem bits		(Ben Herrenschmidt)
*	Rework JFS indoe locking			(David Kleikamp)
*	Dynamically allocate JFS metapages		(David Kleikamp)
*	JFS rmdir/unlink d_delete removal		(David Kleikamp)
*	Add resize support to JFS			(David Kleikamp)
*	Rmemove unused code in aacraid			(Christoph Hellwig)
*	Export the new pci_enable function to modules	(Tomas Szepe)
o	Handle APM on armada laptops			(Samuel Thibault)
*	Fix further errors in depca
*	Fix a harmless physical/logical cpu confusion	(me)
	in the APM code
-	Fix migration to CPU 0 before poweroff		(me)
o	Make the APM on CPU 0 locking cover all of APM	(me)
	| idle on SMP needs work, but this seems to work for the rest
	| with my SMP boxes

Linux 2.4.19-ac4
*	Fix pci_enable_device bug I added in ac3	(Jeremy Fitzhardinge)
o	Don't program the ALi ISA bits when using a	(Go Taniguchi, 
	Non ALi Northbridge				 Bruce Howards, me)
*	E1000 Gigabit ethernet driver
o	Fix build for I/O debug MULTIQUAD I hope	(me)
	| Found by Willy Tarreau
*	Bluetooth core update/hot plug support		(Maksim Krasnyanskiy)
*	L2CAP lock fixes, datagram and shutdown		(Maksim Krasnyanskiy)
*	Fix locking in SCO bluetooth layer		(Maksim Krasnyanskiy)
*	Update hci_usb driver, fix refcounting		(Maksim Krasnyanskiy)
*	Add BNEP support to bluetooth			(Maksim Krasnyanskiy)
*	Fix iee1394 build failure			(me)
+	Fix BUZ_G_STATUS in zr36067			(me)
*	Fix warning in fdomain.c			(me)
*	Fix warning in pas16 driver			(me)
*	Fix warning in bin2hex.c			(me)
*	Fix warning in xirc2ps_cs			(me)

Linux 2.4.19-ac3
o	Rethink number one on the IDE stuff		(me)
	We go back to the old pci setup, and
	add the ability to enable devices with
	some BAR's left unassigned

Linux 2.4.19-ac2
o	Disable LBA48 on ALi IDE			(Andre Hedrick,
	revisions below 0xC4				 Daniela Engert)
X	Fix __FUNCTION__ warnings in reiserfs		(me)
*	Fix __FUNCTION__ in rest of irda drivers	(me)
o/*	Fix __FUNCTION__ in some more net/irda bits	(me)
*	Add sem_getcount abstraction from parisc tree
o	Merge some of the minor pcnet32 changes from
	the parisc tree
X	Fix __FUNCTION__ in the ldm partition code	(me)
o	Fix __FUNCTION__ in cycx_wan driver		(me)
X	Add full IDE reassignment based on description	(me)
	from Petr Vandrovec
o	Update defconfig for the -ac tree		(Niels Jensen)
*	Fix AGP warnings				(Niels Jensen)
o	Make rwlock_t not waste space on gcc 2.95/2.96	(Niels Jensen)

Linux 2.4.19-ac1
-	Merge with 2.4.19
*	Add identifiers for the 3Com AirConnect PCI	(Ingo Rohifs)
*	Fix typo in sym2 comments			(Grant Grundler)
*	Fix cyclades resource bug			(Florian Lohoff)
*	Fix address reporting on segv and friends for	(Aneesh Kumar)
	Alpha
o	Merge APM fixes for crashes on ASUS board	(Willy Tarreau)
*	Add module tags to toshiba smm driver		(Jonathan Buzzard)
*	Fix extern for init_rootfs			(Christoph Hellwig)
*	Make vmalloc.h include highmem.h to fix 	(Keith Owens)
	build errors on some setups
*	More __FUNCTION__ clean up for gcc 3.1		(me)

Linux 2.4.19rc5-ac1
-	Merge with 2.4.19rc5
o	Flush the right thing in ramdisk		(HP merge)
*	Merge further small hppa bits			(HP merge)
o	Fix ide option breakage				(Mikael Petterson)
*	Fix a JFFS2 oops case				(David Woodhouse)
+	Switch 'processor id' to 'physical id'		(me)
	| Keeps glibc happy until we sort out cpu numbers longer term
o	Fix incorrect marking of phys_proc_id init	(David Luyer)
o	Update the experimental amd76x_pm code		(Johnathan Hicks)
*	EEPro10 update				(Aristeu Sergio Rozanski Filho)
*	Fix missing prototype				(Christoph Hellwig)
o	Make mount hash size more sensible		(Christoph Hellwig)
*	Make i386 semaphore implementation gcc3 safe	(Christoph Hellwig)
o	Remove dead code in alim15x3 IDE code		(me)
o	Make the i8x0 audio power up more conservative	(me)
o	Enable EAPD on i8x0 audio devices		(me)
	| Hopefully this will fix some of the 'silent laptop' problems
*	Fix misordering in drivers/net/Config		(Willy Tarreau)
*	Fix undefined C usage in ixj			(me)
*	Fix undefined C usage in se401			(me)
*	Kill __FUNCTION__ in some usb drivers		(me)

Linux 2.4.19rc3-ac5
o	Fix the SMP compile problem			(me)
	| Better solutions preferred - suggestions anyone ?
o/*	Exterminate more of the __FUNCTION__ warnings	(me)
*	Fix warning in stallion and real loading bug	(me)
*	Fix various random gcc 3.1 warnings		(me)
*	Hopefully fix the DRM compile for gcc 2.95	(me)
*	Tighten multiple length checks in intermezzo	(Silvio Cesare, me)
*	Fix upper limit on stradis cliprects		(Silvio Cesare, me)
*	Fix proc_file_lseek				(me)
*	Fix drivers/s390/dasd write limit		(Silvio Cesare, me)
*	Fix ewrk3 and natsemi driver lengthchecks	(Silvio Cesare, me)
*	Openprom fixes					(Dave Miller)
*	Network procfs fixes				(Dave Miller)
*	Fix a couple of license tags			(Carl-Daniel Hailfinger)
*	Don't pad empty initializers with gcc 2.95+	(Christoph Hellwig)
o	Make better use of dentry inline space		(Andi Kleen)
o	Fix ffs asm for gcc 3.x				(Christoph Hellwig)
*	Remove last gcc3 warnings on ext3		(Christoph Hellwig)
o	Warn when mounting ext3 as ext2			(Andrew Morton)
*	Make umem useadd_gendisk			(Christoph Hellwig)
*	Fix cpqarray I/O accountinmg			(Christoph Hellwig)
*	Fix for TCSBRK standards compliance
	| LSB patch with further bugs fixed
*	Fix lots more __FUNCTION__ stuff		(me)
*	Fix warnings in hamradio drivers with gcc3	(me)

Linux 2.4.19rc3-ac4
*	Support "help" button Vaio PCG-NV105		(Frank Schusdziarra)
*	Clear AC on int in vm86 emulation		(Stas Sergeev)
*	Clean up stack handling macros in vm86		(Stas Sergeev)
*	Handle multiple prefixes on vm86 traps		(Stas Sergeev)
*	Use FIXMAP for f00f fixups			(Andrea Arcangeli,
							 Christoph Hellwig)
o	Cacheline align tlb state			(Andrea Arcangeli)
*	cmpxchg8 needs lock prefix			(Andrea Arcangeli)
o	Make O1 scheduler hyperthreading aware		(Intel)
	| Plus some cleanup, performance fix
o	make xconfig fix up				(Pete Zaitcev)
+	Fix a misidentification of Tualatin		(Dave Jones)
o	Update SiS IDE driver for ATA133		(Lui-Chen Chang,
							 Lionel Bouton)
o	Update procfs for inode sysctl changes		(James Antill)
o	Final fixups for summit support			(James Cleverdon)
*	Fix missing sign check in se401 driver		(Silvio Cesare)
*	Fix missing wrap check in usbvideo		(Silvio Cesare)
o	Fix netsyms includes				(Martin Uecker)
o	Penguin logo frame buffer fix			(Geert Uytterhoeven)
*	sym53c8xx_2 fixes for bugs tickled on hppa	(Grant Grundler)
o	Remove vm_unacct_vma				(Hugh Dickins)
o	Handle do_mmap_pgoff mask properly		(Hugh Dickins)
o	Update to rmap-13b				(Rik van Riel,
						Arjan van de Ven, Hugh Dickins)
*	Fix trident audio suspend/resume crash		(Muli Ben-Yehuda)
o	Give panic info in morse code on graphic oops	(Andrew Rodland)
*	Add a new kaweth usb ident			(Harm Verhagen)
o	Fix warnings from init_task.c			(Alex Riesen)
o	IRQ balancing fix backport from 2.5		(Zwane Mwaikambo)
*	Clean up LDM support				(Richard Russon)
*	Fix lib/rbtree mismerge				(Christoph Hellwig)
*	Endian fixes for 8390 drivers			(from HPPA merge)
X	Support tulip on the parisc platform		(from HPPA merge)
*	Update parport_gsc				(Helge Deller)
o	Merge fault handling changes for upward		(from HPPA merge)
	growing stacks
o	Fix undefined C in speakup			(me)
*	Fix umem undefined C				(me)
*	Fix a few other warnings			(me)
*	Lots of gcc 3.1 __FUNCTION__ warning fixes	(me)

Linux 2.4.19rc3-ac3
o	Hopefully fix the smp boot/apic problem		(James Cleverdon)
o	Tidy various VM bits up				(Christoph Hellwig)
o	Further quota updates		(Jan Kara, Al Viro, Christoph Hellwig)
*	Fix incorrect tristate in Config.in		(Keith Owens)
o	amd76x_pm compile fix				(Erik Andersen)
 
Linux 2.4.19rc3-ac2
o	Fix escaped iconfig makefile line		(Greg Louis)
*	Fix a dcache locking error			(Al Viro)
o	AMD native powermanagement			(Tony Lindgren,
							 Johnathan Hicks)
	| Replaces amd768_pm as its already far better
-	Remove dead tq_bdflush				(Christoph Hellwig)
-	Remove dead pg_nosave bits			(Christoph Hellwig)
-	Remove dead 8253x build script			(Christoph Hellwig)
o	Clean up speakup Makefile			(Christoph Hellwig)
*	Fix typo in drivers/net/Config.in		(Hans-Joachim Baader)
o	Update to new quota code with dual format	(Jan Kara)
	support
o	Add the XFS framework for quota into it		(Nathan Scott)
*	Fix unaligned access on ewrk3			(Martin Brulisauer)
o	Fix config breakage from mips merge		(Christoph Hellwig)
*	Recognize GPLv2 as a valid license		(Keith Owens)
*	Update ACPI hotplug driver			(Takayoshi KOCHI)
	| And fix posted shortly after
o	Remove ksyms.c debugging junk			(Khromy)
o	Remove limits.h use in speakup			(Adrian Bunk)
o	NFS lock daemon fixes				(Olaf Kirch)
	| Sign errors, Openserver interoperability
*	Further trident sound cleanup and fixes		(Muli Ben-Yehuda)
X	Change tcp_diag.h fix to keep DaveM happy	(me)
o	Add via apic to expected apic versions		(me)
o	Next batch of summit tweaks			(James Cleverdon)
	| Won't fix the existing APIC problem
o	Add Vaio C1MV mode lines to radeonfb		(James Mayer)
*	Fix sloppy sign handling in apm and rio500	(Silvio Cesare)
*	Reformat depca.c ready for some bugfixes	(me)

Linux 2.4.19rc3-a1
-	Merge with 2.4.19rc3

Linux 2.4.19rc2-ac2
o	Fix ide probe crash stupid bug in ac1		(me)
	| I mismerged Kurt's change

Linux 2.4.19rc2-ac1
-	Merge with 2.4.19-rc2
*	Minor HP merge fixup
*	Orinoco build fix				(Adrian Bunk)
o	Vaio C1VE/N frame buffer console mode		(Marcel Wijlaars)
*	Fix an inverted test in sym53c8xx_2		(Grant Grundler)
*	Fix aic7xxx build without PCI enabled		(me)
*	Clear allocated gendisk in IDE			(Kurt Garloff)

Linux 2.4.19rc1-ac7
*	Merge more HPPA bits
X	tcp_diag alignment fixup			(Richard Henderson)
	| Pending DaveM making a nicer fix Im sure
o	Hopefully fix the SMP APIC problems rc6		(James Cleverdon)
	gave some people
*	Fix incorrect __init in PCI core		(Takayoshi KOCHI)
	| Caused hotplug bugs
*	Update IBM PCI hotplug driver			(Greg Kroah-Hartmann)
*	Add SCSI blacklist entries for Centristor	(Robert Sertic)
o	Update Documentation/sysctl/vm.txt		(Steven Cole)
*	Fix kdev_val macro				(Steven Cole)
*	Allow a user to force dma 0 to be allowed	(Gerald Teschl)
	for ISAPnP [be nice to autodetect this ?]
o	Hopefully fix bogus config question bug		(me)
*	Fix hang on some boxes if you unload
	maestro audio then hit the volume buttons	(Samuel Thibault)
*	Fix aha152x scsi				(Juergen Fischer)
*	Bluetooth pcmcia drivers			(Marcel Holtmann)

Linux 2.4.19rc1-ac6
o	Update merge using bits from newer summit diff	(James Cleverdon)
o	Fix problems with non SMP but io-apic build	(me)
*	Socket error path memory leak fix		(Robert Love)
o	Fix sd_varyio masks for higher drives		(Kurt Garloff)
o	Fix tmpfs double kunmap				(Hugh Dickins)
*	VIA rhine cleanup/fixes				(Roger Luethi)
*	Fix typos in ncr/seagate scsi			(James Mayer)
*	MPT fusion update				(Pam Delaney)
*	Trident audio code cleanups and lock fixes	(Muli Ben-Yehuda)
o	Fix irq balancing for summit boxes with Ingo's	(James Cleverdon)
	PIV balancer

Linux 2.4.19rc1-ac5
o	Add additional promise chip names provided by	(me)
	Hank Yang
o	Fix promise 20277 misreporting			(me)
o	Remove extra argument from vm_enough_memory	(me)
	| Suggested by Hugh Dickins
*/+	Initial merge of main chunk of parisc-55 tree
	- fix scheduling of disabled kbd tasklet

Linux 2.4.19rc1-ac4
o	Tweak pnpbios permissions on escd file		(me)
	| We only want root able to see it
o	Merge first bits of Summit stuff		(me)
	| Working from ugly ibm patch for 2.4.9
o	Fix casting warnings in i830 DRM		(me)
*	Fix atp870u warning				(me)
*	Fix APM hang on resume with SMP kernel on up	(me)
	laptop
o	Change added proc/cpuinfo entries to fit format(me)
o	Fix PIV clockmod				(Peter Osterlund)
o	Re-order scsi disk structure to save space	(Kurt Garloff)
o	Fix CPU_FREQ build problem			(Peter Osterlund)
o	Clean up speakup_acntpc			(Arnaldo Carvalho de Melo)
o	Clean up speakup_acntsa			(Arnaldo Carvalho de Melo)
o	Clean up speakup_apolo			(Arnaldo Carvalho de Melo)
o	Basic speakup core cleanups		(Arnaldo Carvalho de Melo)
*	Fix a mishandling of PCIBIOS boxes that	do not	(Mark Lisher)
	use CONF1/CONF2
*	Fix promise skip for new supertrak		(Jan Schmidt)
o	Allocate nocache ram based on mem size for	(Tomas Szepe)
	sparc32
*	Fix incorrect zlib includes			(David Woodhouse)
*	Fix duplicated scsi host idents			(Itai Nahshon)
*	Update ALi5451 audio				(Lei Hu)
	| Sorry this took so long - it got lost
o	Handle radeon cards that report zero RAM	(James Mayer)
*	Blacklist H.01.09 megaraid firmware		(Jan Koop)
*	Initial ALi5455 audio support			(Lei Hu)

Linux 2.4.19rc1-ac3
*	Remove SWSUSPEND
	| With the IDE backport option and other general 2.5 improvements
	| its now best worked on in 2.5
*	Remove duplicate config options			(Steven Cole)	
*	Newer SX6000 has PDC20276 chips. Handle this	(me)
o	Don't use LBA48 hack on Promise 20262/3		(Hank Yang)
*	Switch to Promise namings for chips		(Hank Yang)
*	Update promise drive quirks			(Hank Yang)
*	Fix missing sem up on error in usb printer	(Oliver Neukum)
*	Correct FPU stack fault signal flag bits	(Dave Richards)
*	Resync with base JFS tree			(Dave Kleikamp)
*	Make it clear CMD64x drives CMD680		(Adrian Bunk)

Linux 2.4.19rc1-ac2
*	Update eata and u14/34f drivers			(Dario Ballabio)
o	Handle 3c556 transmitter enable bit		(Andrew Morton)
*	Make the DRM layer use the pci mapping api	(Arjan van de Ven)
*	Set pci dma masks on the i2o devices		(Frank Davis)
*	JFFS2 bug fixes					(Dave Woodhouse)
*	Fix i815 APSIZE masking				(Nicolas Aspert)
*	Remove junk pcxxdelay function			(Sergey Kononenko)
*	EFI partition updates				(Matt Domsch)
	- I took out the MSDOS check - if both are
	  present we should favour MSDOS for now
*	Fix ipc/shm locking				(Hugh Dickins)
*	Update Configure.help				(Steven Cole)
*	USB updates - cleanups				(Greg Kroah-Hartmann)
*	USB fix for intuos tablet			(Christer Nilsson)
*	USB scanner updates		(David Nelson, Henning Meier-Geinitz, 
					 Sergey Vlasov, Karl Heinz Kremer)
	| Note - new maintainer for USB scanner - Brian Beattie
o	Re-merge the ramfs limits code			(David Gibson)
	| * This needs good testing
	| + TODO - make ramfs homour vm_accounting
*	eepro100 warning fix				(Pavel Machek)
*	Report ok for nfs directory fsync       	(Trond Myklebust)
*	Promise 20268 raid should be called 20270	(Hank Yang)
	| Trivial item pulled out of the pending promise patches
o	Speakup HZ != 100 cleanup part 1		(Arjan van de Ven)
o	Report HT info in /proc/cpuinfo			(Arjan van de Ven)
o	PIV IRQ balancing fix				(Ingo Molnar)
o	Allow a non PGE PII optimised build		(Arjan van de Ven)
X	Elevator performance fixes			(Andrea Arcangeli)
o	Update cpufreq, add PIV throttling		(Robert Schwebel,
			Padraig Brady, Zwane Mwaikambo, Arjan van de Ven,
			Tora Engstad)
o	O(1) scheduler updates				(Ingo Molnar)
*	Fix 64bit random panic with 
	"I refuse to corrupt memory/swap"		(Bill Nottingham)
*	Fix compile with floppy disabled		(Adrian Bunk)
*	Quirk handler for Dunord I-3000	  (Dave Close, David Mosberger)
	| Plus I added real PCI idents for neatness
o	Fix another vm accounting corner case		(Robert Love)
*	Patch up XFree 4.1 back compat problems		(Arjan van de Ven)
	in DRM 4.2+

Linux 2.4.19rc1-ac1
-	Merge with 2.4.19-rc1
	- Drop out mm fixes
*	Shmem fixes for -ac 				(Hugh Dickins)
o	Fix vm accounting corner cases			(Hugh Dickins)
*	Fix utimes permission check error		(Stephen Rothwell)
	| It was overstrong
*	Fix JFS error handling down_write_trylock	(David Kleikamp)
o	Module loader off by 1 fix			(Peter Oberparleiter)
o	Allow irda modem bits to be arch set		(Grant Grundler)
*	ALI M1671 GART support				(Arjan van de Ven)
o	IDE scsi off by one transformation fix		(Mark Lord)
*	Printk fixes
o	USBserial semaphore fix				(Pete Zaitcev)
o	Alpha updates for O(1) scheduler		(Robert Love)

Linux 2.4.19pre10-ac2
o	Merge speakup support for blind users
o	CSB6 cable detect for Dell			(Matt Domsch)
o	Update pci ids for Intel i8xx			(Wim Van Sebroeck)
*	Add AMD766 PCI irq router support		(Wayne Whitney)
*	ACARD scsi update				(Matthew Chang)
*	Fix idle-period bug in APM parser		(Laurent Latil)
*	Printk levels for 3c501 ethernet		(Felipe Damasio)
*	AMD768 TCO watchdog driver - * needs testing *	(Zwane Mwaikambo)
*	Fix IDE port offset for pdc202xx		(Hang Yang)
	| should fix LBA48 drives on primary channel
o	Fix incorrect speedstep multiplier detect	(Dominik Brodowski)
*	Add support for Aptiva with Bose subwoofer	(Toshio Spoor, 
							 John Rood)
*	Autodetect SiS 745 AGP 				(Carsten Rietzschel)
*	More scsi sparselun entries			(Arjan van de Ven)
*	Fix possible crash on shutdown with AF_ROSE	(Jean-Paul Roubelat)
*	Intel 845G IDE support				(Andre Hedrick)
*	Further CPiA driver updates			(Duncan Haldane)
*	Fix DAC960 diff that went astray		(Juan Quintela)
*	Add HP arrays to the sparselun list		(Andrew Patterson)

Linux 2.4.19pre10-ac1
-	Merge with Linux 2.4.19-pre10

Linux 2.4.19pre9-ac3
o	Cpufreq updates			(Dominik Brodowski, Dave Jones0
	| Now includes some reverse engineered speedstep support 
*	JFS updates			(David Kleikamp, Christoph Hellwig)
*	CPiA updates/Intel microscope support		(Duncan Haldane)
*	Fix vm86 locking errors on SMP			(Ben LaHaise)
*	Remove dead vm86mode field			(Ben LaHaise)
*	Fix make clean for cl2llc			(Keith Owens)
o	Fix loop errors with highmem			(Ben LaHaise)
*	Fix ipc/sem.c SuS/LSB compliance		(Christopher Yeoh)
X	Update swsuspend maintainer info		(Pavel Machek)
*	Add another drive quirk for the promise		(Hank Yang)
	drivers
*	Merge external journal support for jfs		(David Kleikamp)
o	Add documentation about O(1) scheduler		(Robert Love)
o	O(1) scheduler tidy ups				(Robert Love)
o/+	Fix remaining extern inline users		(Christoph Hellwig)
o	Cache alignment cleanups for SMP apic timers	(Ravikiran Thirumalai)
*	Ext3 file system updates			(Stephen Tweedie)
*	Fix 'dump corrupts live fs bug'			(Stephen Tweedie)
o	Add DAC960 devices to init table		(Oliver Pitzeier)
	| Lilo doesn't care but grub does ..

Linux 2.4.19pre9-ac2
*	Clean up after SIGURG properly			(David Weinehall)
	| Needed to match the other SuS compliance fix for it
*	Fixed wrong elf section in neofb		(Thomas Mirlacher,
							 Andrey Panin)
*	Don't write to reserved bits on 815 gart	(Nicolas Aspert)
*	Make fcntl locking POSIX 2001 compliant		(Andries Brouwer)
*	Fix an mmap corner case 			(Ra�l)
*	Merge 3c59x vlan support			(Paul Komkoff)
*	Update URLS for LDP documentation		(John Kacur)
*	Fix rmem setting for low memory			(J A Magallon)
*	Reparent scsi error thread to init		(J A Magallon)
*	Backport FPU init fixes				(J A Magallon)
*	Fix AGPgart crash on I830M/I845G when using
	8Mb/8Mb split					(Jeff Hartmann)
*	Fix phy masking on 8139too			(Jeff Garzik)
*	Fix link state reporting on generic phy code	(Jeff Garzik)
*	Tulip phy handling fix				(Jeff Garzik)
*	Update 8139too docs				(Jeff Garzik)
*	cs89x0 update					(Jeff Garzik)
*	VIA rhine fixes					(Jeff Garzik)
*	Hamachi quick fixup for 2.4.19			(Keith Underwood)
*	Revert escaped procfs debug code		(Todd Eigenschink)
*	Merge the 2.5 additions to ethtool		(Jeff Garzik)
*	Update dl2k driver				(Jeff Garzik)
*	Fix kernel api docs to reflect fb changes	(Juan Quintela)
*	Fix problems with pcnet32 workaround for x250	(Go Taniguchi)
*	De4x5 cleanups					(Jeff Garzik)


Linux 2.4.19pre9-ac1
-	Merge with 2.4.19pre9
*	Fix SuS violation on readv/writev		(me)
	| I believe this one is correct, please double check

Linux 2.4.19pre8-ac5
*	Fix various audio copy*user			(Rusty Russell)
o	Update to rmap 13		(Rik van Riel, Christoph Hellwig)
*	Fix joystick copy_user bugs			(Robert Johnson)
*	Document the i2o_pci module			(me)
*	Switch i2o_block back to direct pointers	(me)
	to avoid promise firmware bugs
*	Remove cache error paths from i2o_block		(me)
	| new code doesnt trip that bug
*	Reduce the i2o queue depth per device		(me)
	| pending tuning - might need more yet
*	Set i2o default limit at 48K a write		(me)
	| more firmware bug stuff
*	Clean up i2o cache strategy, add tuning ioctl	(me)
*	Allow users to force dpt cards to use base i2o	(me)
	| tested i2o_block on DPT with my cards
*	Remove duplicate ac97_codec inclusion		(Keith Owens)
X	Tidy up patch for swsuspend			(Pavel Machek)
*	Fix wrong __init in 3c509			(Kasper Dupont)
o	Fix mm/bootmem.c build on cris			(Johan Adolfsson)
*	Remove config tools for 8253x from kernel tree	(Keith Owens)
*	Rename files in aacraid ready for merge		(me)
	of updates
*	Merge bridge specific changes in aac code	(Deanna Bonds)
*	Merge most of the fixups/cleanups for aacraid	(Deanna Bonds)
*	Set PCI masks for the 64 and 32bit aacraids	(me)
*	Don't program up the ali secondary codec for	(me)
	6 channel if you don't have one fitted
*	Block layer copy*user fixups		(Arnaldo Carvalho de Melo)
*	Fix missing intermezzo include		(Marc-Christian Petersen)
o	Slab cache for iobufs		(Andrea Arcangeli, Chuck Lever,
						Christoph Hellwig)
*	Fix intermezzo copy*user		(Arnaldo Carvalho de Melo)
*	down_trylock					(Christoph Hellwig)
*	Fix video compile for split module		(Michal Jaegermann)
	and compiled in
*	Kill 3c59x debug bits				(Andrew Morton)
*	Char fixes for copy*user		(Arnaldo Carvalho de Melo)
*	Fix a few errors in the janitor copy* fixes	(me)

Linux 2.4.19pre8-ac4
o	Fix warnings in pc_keyb.c			(Christoph Hellwig)
*	Fix undefined C in rivafb			(Christoph Hellwig)
*	Fix dnotify warnings				(Christoph Hellwig)
*	Remove unused nfs label				(Christoph Hellwig)
o	Fix vm_validate_enough prototypes		(Christoph Hellwig)
*	Fix wrong comment in agpgart			(Nicolas Aspert)
*	JFFS2 fixes					(David Woodhouse)
o	Hopefully fix zisofs breakage			(David Woodhouse)
*	Remove a defunct soc_probe call			(Christoph Hellwig)
*	Update initrd documentation			(Mark Post)
-	Fix SMP build					(Robert Love)
o	Numa-Q apic timer update			(Martin Bligh)

Linux 2.4.19pre8-ac3
o	Kbuild fixes					(Keith Owens)
*	Fix eepro100 bug/typo				(Michael Rozhavsky)
*	Intel 845G GART support				(Graeme Fisher)
*	Fix tasklet disable/kill in pppoatm		(Luca Barbier)
*	Add another PCI ident to the acenic driver	(Eric Smith)
o	Major IDE updates				(Andre Hedrick)

Linux 2.4.19pre8-ac2
*	Fix more compile problems			(me)
*	Fix a possible hang on shutdown in 3270 tty	(Martin Schwidefsky)
*	Make "make rpm" sane for non x86		(Cesar Cardoso)
*	Two new AC97 codec entries			(Lei Hu)
*	Thread exit race fix				(Dave McCracken)
*	Further sg buffer clearing fix			(Douglas Gilbert)
*	Fix do_mounts printk				(Al Viro)
*	Umembp fixups					(Neil Brown)
*	Umembp shift bug fixup				(me)
o	Kbuild fixes and improvements			(Keith Owens)
*	Add a new tulip clone pci ident entry		(Ohta Kyuma)
*	Fix url on via pci fixups			(Erich Schubert)
*	koi8-ru handling fixes				(Petr Vandrovec)
*	Clean up remaining code to use yield		(Robert Love)
o	Clean up migration_init as per 2.5		(Erich Focht)
o	Clean up maximum real time priorities		(Robert Love)
*	Kill unused variable in bpck6			(Adrian Bunk)
*	Fix dnotify/process exit handling		(Stephen Rothwell)
*	Add another vaio bios to the table		(Yves Lafon)
*	Allow users to disable hyperthreading		(Hugh Dickins)

Linux 2.4.19pre8-ac1
-	Merge with Linux 2.4.19pre8
	-	Fix some compile problems

Linux 2.4.19pre7-ac4
*	Test AMD768 IRQ router support			(me)
*	Fix ext2 build error
*	Improve i810 audio documentation		(Johannes Feigl)
*	Ensure UTS data is in C locale			(Martin Dalecki)
*	Add the Intel ICH4 to the i810 audio driver	(Wang Jun)
*	Fix qlogicfc crash under load			(Dave Miller)
*	Fix snprintf return values in some cases	(Ben LaHaise)
*	Fix a bug that got into the iph5526 code when	(Vineet Abraham)
	networking
*	Add more scanners that respond to all LUNs	(Frank Zago)
*	Synclink PCMCIA wan driver			(Paul Fulghum)
*	Fix sparc64/ppc64 bluetooth ioctl build		(Martin Eriksson)
*	Change 5/6bit codec resolution detect for	(Wan Tat Chee)
	AC97 
*	Fix v4l compile bug in one option case		(Iain Stevenson)
o	Clean up powernow initcalls			("CaT")
o	Add PIO mode support for the Pacific Digital	(Mark Lord)
	ADMA-100i card

Linux 2.4.19pre7-ac3
*       Back merge some documentation fixes      	(Daniel Dickman)
*       Update sisfb driver                     	(Thomas Winischhofer)
o       Remove sync wakeups now O(1) handles it 	(Robert Love)
o       Abstract away need_resched              	(Robert Love)
o       Fix scheduler deadlock during switch_mm 	(Dave Miller)
        on sparc etc
o       Optimise sched_yield                    	(Robert Love)
o       Handle tasks becoming runnable during   	(Robert Love)
        schedule
o       Clean up assumptions about MAX_RT_PRIO  	(Robert Love)
o       Backport of migration fixes/irq off     	(Robert Love
        fixes and migration_init                	 William Irwin)
o       Cleanups from 2.5->2.4 O(1) backport    	(Robert Love)
        | The entire O(1) block above is a backport
        | of all the fixes from Ingo, Robert and others
X       Swsuspend fix crash on boot add cleanups       	(Pavel Machek)
*       Scsi generic buffer tidy up             	(Douglas Gilbert)
*       Correct kd.h definitions                	(Andrej Lajovic)
X       Fix missing include for swsuspend       	(Mauricio Zambrano)
*       Configure.help typo fixes               (Arnaldo Carvalho de Melo)
*       Identify PIV Xeon in mptable            	(James Bourne)
o       Fix "skip_ioapc_setup" compile problem  	(Mikael Pettersson)
o       Additional ext2/ext3 sanity checker     	(Andreas Dilger)
*       Handle very old misconfigured
        NCR53c810 on DECpc XL etc               	(Graham Cobb)
*       Core of support for jfs external log    	(Christoph Hellwig,
                                                	 Dave Kleikamp)
*       Clean up jfs_mknod a little             	(Christoph Hellwig)
*       Sync up 2.4/2.5 jfs changes             	(Christoph Hellwig)
*       PPC compile fixes                       	(Paul Mackerras)
*       Next stage of vm86 fixing               	(Kasper Dupont)
*       Clean up drivers to use vmalloc_to_page 	(Hugh Dickins)
*       Fix missing release in opl3sa2          	(Zwane Mwaikambo)
*       Fix flag type error in rtl8150          	(Rusty Russell)
*       Fix various missing CONFIG_PCI checks   	(me)

Linux 2.4.19pre7-ac2
*	Limit default i2o_block to 64K writes		(me)
	| Several controllers can't handle larger single requests
*	Add power management control to i2o_block	(me)
X	Use chained sg list for i2o_block		(me)
	| Need to load first 8 entries into message for performance still
*	Updated i2o documentation			(me)
*	Fix make xconfig
*	Fix bios reboot sequence			(Robert Hentosh)
*	Kees Cook changed email address			(Kees Cook)
*	Fix a minor SuSv3 violation in SIGURG		(Christopher Yeoh)
*	Make htmldocs fixups				(Erik van Konijnenburg)
o/*	Make all the slab caches use the "_" convention	(Ryan Mack)
*	Fix flow control problems with TCP over NFS	(Neil Brown)
o	Removepage hooks as per old -ac			(Christoph Rohland)
	| This lets shmfs/ramfs keep accounting straight
	| ramfs needs someone to drop in the other old -ac bits stil
*	Fix via-rhine PCI idents			(Shing Chuang)
*	Backport of 2.5 aha152x update by		(Juergen Fischer)
o	Loop fixups					(Arjan van de Ven)
o	Add HP tachyon idents to cpqfc driver		(Jes Sorensen)
*	Clean up mpu401 failure handling paths		(Zwane Mwaikambo)
*	Ad1848 pnp scanning fixes			(Zwane Mwaikambo)
o	Kill dead URL in maintainers			(Joe Perches)
-	Back out problem bridge update			(Mike Fedyk)
*	Fix sound on Compaq Presario 700		(Santiago Nullo)
o	Fix restore_flags handling in cmd640 probe	(Justin Gibbs)
o	Fix oops from mptable impaired bioses		(Arjan van de Ven)
*	Fix 8139cp/8139too big endian multicast setup	(Naoki Hamada)
*	Fix missing newline in i810 audio printk	(???)
*	Put syscall table back for now			(Steven Hirsch)
*	Fix ips build for some combinations		(Steven Hirsch)
*	NLS makefile tidy				(Urban Widmark)
o	Fix radeonfb build				(Peter Horton)
*	Update poll_out fixes on tty devices		(Sapan Bhatia)
o	32bit uids in acct data				(Chris Wing)

Linux 2.4.19pre7-ac1
o	Merge CPU speed control framework and support (Dave Jones, Russell King
	for VIA processors and AMD K6		Arjan van de Ven, Janne P�nk�l�)
-	Merge with 2.4.19pre7
	-	drop out keyb changes (breaks some setups)
*	Lots more i2o debugging work 			(me)
	| I2O now seems to be working again and works
	| for the first time on the AMI Megaraid

Linux 2.4.19pre5-ac3
X	Software suspend initial patch 		(Pavel Machek, Gabor Kuti,..)
	| Don't enable this idly. Its here to get exposure and so
	| people can bring the rest of the code up to meet its needs as
	| well as fix it.
	| Read the docs first!
*	Small fix for the radeonfb			(Peter Horton)
*	Fix highmem truncation on DMA mapping bug	(Dave Miller)
X	Modules are not supposed to hack the syscall	(Arjan van de Ven)
	table so remove the export
*	Add ite sound configuration help		(Steven Cole)

Linux 2.4.19pre5-ac2
*	Fix compile error when using initrd		(Jeff Nguyen)
*	Make the KL133 onboard video happy again	(Andre Pang)
	| and a lot of people working to figure out the right bits
*	Reparent jdb to init and drop lock on exit	(Ishan Jayawardena)
*	Fix radeon corner case				(Arjan van de Ven)
o	Cache more group descriptors on ext2/ext3	(Arjan van de Ven)
*	SAB8253 series wan drivers			(Joachim Martillo)
*	Add more idents for PIIX IDE controllers	(Arjan van de Ven)
*	Lock signals in procfs				(Andrea Arcangeli)
*	Backport of 2.5 BUG_ON() functionality		(Robert Love)
-	Drop -O1 on sched.c - turns out its a CPU
	microcode bug on early Xeon not Linux
*	Fix Radeon fb reset problems as X11 did		(Peter Horton)
*	Radeon acceleration/mtrr updates		(Peter Horton)
*	JFS flushpage updates				(Christoph Hellwig)
*	BeOS file system support			(Will Dyson)
	| original work by Makoto Kato
*	Fix w83877 watchdog SMP compile failure		(Paul Komkoff, me)
*	Fix pty/tty POLL_OUT reporting			(Sapan Bhatia)
*	Update berkshire watchdog driver	(Lindsay Harris, Rob Radez)
*	Clean up duplicated path_init and __user_walk	(Hanna Linder)
	code
*	Enable MMX extensions on Geode GXm		(Zwane Mwaikambo)
o	O(1) scsi free command block finder		(Mark Hemment)
*	Updated IBM serveraid driver			(Jack Hammer)
*	S/390 makefile cross compile fixups		(Pete Zaitcev)

Linux 2.4.19pre5-ac1
-	Merge with 2.4.19pre5

Linux 2.4.19pre4-ac4
*	Fix an additional vm86 case			(Stas Sergeev)
	| Check DOSemu again and this code wants some good review
o	Do sanity checking to avoid mispoking PCI on	(me)
	the CMD640 [noted by Justin Gibbs]
o	Fix promise IDE error recovery			(Manfred Spraul)
o	Ali IDE hang fixes				(Sen Dong)
	| Extracts from a bigger ALi update
*	Ext3 balloc locking fix 			(Andrew Morton)
*	Fix escaped MWAVE configuration			(Thomas Hood)
*	Fix nls_utf8 problems				(Liyang Hu)
*	Fix mmx_memcpy over-prefetching on Athlon	(me)
o	Fix an error return the vm accounting code broke(Andrew Morton)
*	Fix bpck6 build on the powerpc platform		(Jens Schmalzing)
*	Fix bpck6 64bit cleanness and other minor bits	(me)
*	Fix sound Configure.help thinko			(Per von Zweigbergk)
*	Backport the 2.5 wireless driver stuff		(Jean Tourrilhes)
	| So 2.5 driver fix back merging is sane

Linux 2.4.19pre4-ac3
*	Fix NFS pathconf problem			(Neil Brown)
o	IBM memory key ident for usb_storage		(Alexander Inyukhin)
*	Add byte counters to mkiss driver		(Ken Koster)
*	Add more entries to the scsi scan lists		(Arjan van de Ven)
*	More eepro100 variants				(Arjan van de Ven)
*	Update wolfson codec initialisers		(Randolph Bentson)
+	USB serial oops fixes				(Greg Kroah Hartmann)
*	Mad16 register gameport with input layer	(Michael Haardt)
*	Update specialix driver to handle SI v1.x board	(Ismo Salonen)
*	Fix a wdt285 EFAULT return, remove crud		(Ron Gage, me)
*	Fix ioctl return errors on several sound cards	(Ron Gage)

Linux 2.4.19pre4-ac2
*	Hopefully correctly fix the vm86 problems	(Stas Sergeev)
	| Please test wine 16bit/dosemu/XFree stuff
*	Fix panic when writing 0 length ucode chunk	(Tigran Aivazian)
*	Fix incorrect use of hwif->index in ALI IDE	(Martin Dalecki)
*	Fix mmap rbtree corruption bug			(Ben LaHaise)
o	Fix incorrect 10 to 6 byte scsi command switch	(Jens Axboe)
*	TCP correctness fix				(Dave Miller)
*	Correct mwi acronym in docs			(Geert Uytterhoeven)
*	Merge the rest of Promise 20271 support		(YAMAWAKI Teruo)
*	Fix open/close races in indydog			(Dave Hansen)
*	Fix compile problem with ibm hotplug		(Greg Kroah-Hartmann)
*	Save the .config file in make rpm		(Kelly French)
*	Add another vaio with swapped minutes		(Michael Piotrowski)
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
*	Fix msync SuS v3 compliance			(Chris Yeoh)
*	CS8900 fixes (need testing)			(Paul Komkoff)
*	Adapt HP100 driver to pci api			(Jeff Garzik)
*	Acenic updates - fix leak and Tigon1		(Jes Sorensen)
*	DE620 region handling fixes			(K Kasprzak)
*	DLink DL2K gige updates			(Edward Peng, Jeff Garzik)
*	pcnet32 leak fix				(Jeff Garzik)
*	pcnet32 types fixes for non x86			(Anton Blanchard)
*	pcnet32 assorted fixes				(Dave Engebretsen)
*	pcnet32 fixes					(Paul Mackerras)
*	Fix missing linux/delay.h from eepro100		(me)
*	Further pcnet32 cleanup and probe fixes		(Go Taniguchi)
*	Merge gcc3 warning fixes for copy/csum		(Jeff Garzik)
*	Fix bmac build					(Joshua Uziel)
*	DE4x5 slight tidy up				(Jeff Garzik)
*	More AC97 ident strings				(Peter Christy)

Linux 2.4.19pre4-ac1
-	Merge 2.4.19pre4
*	Add PCI idents for mobility parallel port	(me)
o	Fix crash on boot with LLC if no devices present(me)

Linux 2.4.19pre3-ac6
o	Fix the oops initialising the CD-ROM		(Andre Hedrick)
*	Add devexit_p() to the wdt_pci watchdog		(Adrian Bunk)
o	Fix lm_sensors compile				(Eyal Lebedinsky)
*	Remove some dead JFS oddments			(Christoph Hellwig)
*	SCSI generic update			(Doug Gilbert, Travers Carter)
*	VM86 exception fixups			(Kasper Dupont, Manfred Spraul)
*	Fix an fcntl error corner case to match SuS	(Christopher Yeoh)

Linux 2.4.19pre3-ac5
*	Further IDE updates				(Andre Hedrick)
*	Reduce ide tape debug noise			(Alfredo Sanju�n)
*	Sync devices on final close not each close	(Miquel van Smoorenburg)
+	Make max busses/irqs dynamic on x86		(James Cleverdon)
	| Needed for big IBM boxen
*	Remove exp_find in NFS (never used)		(Al Viro)
*	Fix read locking on NFS export_table		(Erik Habbinga)
*	Fix possible NFS error path mnt/dentry leak	(Al Viro)
*	Use MKDEV macro in NFS device create		(GOTO Masanori)
*	Clean up stale fh stats				(Neil Brown)
*	Tidy nfsd_lookup				(Al Viro)
*	nfsd_setattr fixes				(Neil Brown)
*	Tidy up nfsd vfs calls				(Neil Brown)
*	Clean up nfsd syscall interface			(Neil Brown)
*	Fix fat NFS handle interfaces			(Neil Brown)
*	Tidy up export list handling for NFS		(Al Viro)
*	Use seq_file for NFS exports proc file		(Al Viro)
o	Support for deviceless file system exports	(Steven Whitehouse)
*	Remove big kernel lock use for most of nfsd	(Neil Brown)
*	Convert sunrpc code to use generic linux lists	(Neil Brown)
*	Tidy up svc_sock NFS locking on SMP		(Neil Brown)
*	Improve tcp error/close handling		(Neil Brown)
*	Close down idle NFS tcp sockets			(Neil Brown)
*	NFS TCP fixes for buffer space tracking		(Neil Brown)
*	Handle TCP RPC service flooding			(Neil Brown)
*	Enable NFS over TCP via config options		(Neil Brown)

Linux 2.4.19pre3-ac4
*	Ensure jfs readdir doesn't spin on bad metadata	(Dave Kleikamp)
o	Fix iconfig with no modules			(Randy Dunlap)
*	Don't enfore rlimit on block device files	(Peter Hartley)
*	Add belkin wireless card idents			(Brendan McAdams)
*	Add HP VA7400 to the scsi blacklist quirks	(Alar Aun)
*	JFS race fix					(Dave Kleikamp)
*	Fix wafer5823 watchdog merge error I made	(Justin Cormack)
*	Fix Config rule for phonejack pcmcia card	(Eyal Lebedinsky)
o	Test improved OOM handler for rmap		(Rik van Riel)
*	Update defconfig/experimental bits		(Neils Jensen)
*	The incredible shrinking kernel patch		(Andrew Morton)
*	Clean up BUG() implementation			(Andrew Morton)

Linux 2.4.19pre3-ac3
*	Doh fixed the SYSVIPC build problem		(Everyone...)
o	Added 802.2LLC support			(Arnaldo Carvalho de Melo)
	| Based on 2.0 code contributed by Procom
*	Fix i2o build as module				(Mark Cooke)
*	Blacklist for machines where local apic fails	(Mikael Pettersson)
*	Clean up wdt_pci				(Zwane Mwaikambo)

Linux 2.4.19pre3-ac2
o	Hopefully fixed all the as accounting bugs	(me)
o	Bit more LS220 work (nothing useful yet)	(me)
o	Change should be long not int in shmem acct	(me)
o	Ignore MAP_NORESERVE in mode 2/3 accounting	(me)
*	Fix pci bar flag parsing			(Russell King)
*	Handle ELF setup_arg_pages failure		(Russell King)
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
*	Further printk level fixes			(Denis Vlasenko)
*	Revert epic100 changes - reports of problems	(me)
*	Wafer WDT watchdog driver			(Justin Cormack)
	| I did some cleanup - Justin please double check it
*	ITE8330G PIRQ map support			(Tobias Diedrich)
*	Trivial khttpd logging bug fix			(Rogier Wolff)
*	Stop module autoloader making user /proc/pid	(Andreas Ferber)
	dir root owned
*	Handle TF flag properly on debug trap		(Christoph Hellwig,
					Arjan van de Ven, Stephan Springl)
*	ALi M1701 watchdog driver			(Stve Hill)
	| I tidied/fixed this one too so please check
o	Add iconfig  (save/extract config from kernel	(Randy Dunlap)
	image file)
*	Add mk712 touchscreen driver			(Daniel Quinlan)
	| Fixed various bugs in it - Dan please check

Linux 2.4.19pre3-ac1
-	Merge with 2.4.19pre3
	-	Revert buggy bluesmoke change
	-	Add missing pppox header change
*	Next SIS ide update				(Lionel Bouton)
*	Only try the flush and recycle trick for 	(me)
	known buggy I2O controllers.
*	Clean up module junk and use new init style	(me)
	for I2O.
*	Don't use cache hints on dim i2o controllers	(me)
*	Add vmalloc_to_page to 2.4 from 2.5		(Gerd Knorr)
*	JFS updates			(Christoph Hellwig, Dave Kleikamp)
*	Fix boot_cpu_data corruption bug		(Mikael Pettersson)
*	Clean up ppp vfree paths			(David Woodhouse)
*	Emagic EMI usb driver				(Tapio Laxstr�m)
*	Edgeport fixes for multiple device case	 	(Greg Kroah-Hartmann)	
*	Ethtool support for catc usb			(Brad Hards)
*	Update to pegasus driver in base tree		(Petko Manolov)
*	Update USB maintainers				(Greg Kroah-Hartmann)
*	IPAQ usb driver fixup				(Ganesh Varadarajan)
*	Allow usbfs name for 2.5 compatibility		(Greg Kroah-Hartmann)
o	Committed_AS without a space in procfs		(Andy Dustman)
*	Fix an NFS file creation problem		(Trond Myklebust)
*	Fix a missing ksym				(Greg Kroah-Hartmann)
*	Increase init delay on ALI5451 audio setup	(Harald Jenny)
	| Needed for Acer Travelmate 521TE
*	Fix printk message levels in pci code		(Denis Vlasenko)
*	Add another laptop to the buggy APM tables	(Mihnea-Costin Grigore)
*	Fix an obscure acct race			(Bob Miller)
*	Sonypi driver update				(Stelian Pop)
*	Fix devfs glitch with namespace stuff		(Paul Komkoff, Al Viro)

Linux 2.4.19pre2-ac4
*	Initial Ricoh ZVbus support			(Marcus Metzler)
o	PnPBIOS fixes					(Brian Gerst)
*	Fix a case where sync_one might not start an	(Ben LaHaise)
	inode writeout
*	Corrected atm locking fix			(Maksim Krasnyanskiy)
*	mp table parsing corner case fix		(James Cleverdon)
*	NFS over JFS directory offset fix		(Christoph Hellwig)
*	Update reisefsprogs version			(Paul Komkoff)
*	RME Hammerfall driver update			(G�nter Geiger)
*	Fix an off by one in the bluesmoke reporting	(Dave Jones)
*	Make irnet disconnect hang up ppp		(Jean Tourrilhes)
*	Fix abuse of cli() in irda socket connect	(Jean Tourrilhes)
*	Add help text to patch-kernel script		(Damjan Lango)
*	USB irda updates				(Jean Tourrilhes)
*	IRDA link layer updates				(Jean Tourrilhes)
*	Add WD xd signature to 2.4 (from 2.2)		(Jim Freeman)
*	Update sc1200 watchdog				(Zwane Mwaikambo)
*	Switch wdt501 watchdog driver to bitops		(me)
*	Much updated LSI logic MPT fusion drivers	(Pam Delaney)
*	Wavelan driver updates				(Jean Tourrilhes)
*	Fix a race where we could hit init_idle after	(Kip Walker)
	freeing it (from rest_init)
*	Raylink driver bugfixes				(Jean Tourrilhes)
o	Switch 2.4 to using a shared zlib		(David Woodhouse)
*	Fix w83877 SMP deadlock, clean up locking	(me)
*	IBM lanstreamer update				(Kent Yoder)
*	Fix 32bitism in the PM code			(Pavel Machek)
*	Make irqsave use unsigned long for consistency	(Pavel Machek)
	| Just fixes a few exceptions
*	Make i2o_block fallback to blkpg for ioctls	(me)
*	All pids in use handling			(Paul Larson)
*	IDE code wasn't using ide_free_irq		(William Jhun)
*	Fix non procfs build				(Eric Sandeen)
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
*	Allow the max user frequency for the rtc to	(Mike Shaver)
	be configurable
*	HPT37x crash on init fixups			(Vojtech Pavlik)

Linux 2.4.19pre2-ac3
o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason)
*	MIPS config fix					(Ralf Baechle)
*	Update AGP config entry				(Daniele Venzano)
*	SMBfs NLS oops fix				(Urban Widmark)
*	Fix expand_stack locking hang on OOM		(Kevin Buhr)
*	Restore 10Mbit half duplex eepro100 fix		(me)
*	3c509 full duplex and documentation		(David Ruggiero)
*	3c509 power management				(Zwane Mwaikambo)
*	Remove more surplus llseek methods		(Robert Love)
X	ATM locking fix					(Frode Isaksen)
*	Merge extra sound help texts			(Steven Cole)
	| plus one typo fix
*	Add help for IXJ pcmcia configuration		(Steven Cole, me)
	| Rewrote the text somewhat

Linux 2.4.19pre2-ac2
-	Fix a mismerge (may explain the patch weirdo)
*	Fix highmem + sblive				(Daniel Bertrand)
*	Reiserfs updates				(Oleg Drokin)
*	Auto enable HT on HT capable systems		(Arjan van de Ven)
-	Fix init/do_mounts O(1) scheduler merge glitch	(Greg Louis)
*	Fix drm build problem on CPU=386		(Mark Cooke)
*	Fix incorrect sleep in ZR36067 driver		(me)
*	Add missing cpu_relax to iph5526 driver		(me)

Linux 2.4.19pre2-ac1
*	Merge aic7xxx update				(Justin Gibbs)
*	Fix handling of scsi 'medium error: recovered'	(Justin Gibbs)
*	Further request region fixups			(Marcus Alanen)
*	Add interlace/doublescan to voodoo1/2 fb driver	(Urs Ganse)
	| interlace is always handy with 3d glasses..
o	Merge O(1) scheduler				(Ingo Molnar)
	| Thanks to Martin Knoblauch for doing the merge work
	| Non x86 ports may need to clean up their mm/fault.c
*	Lseek usage cleanup				(Robert Love)
-	Merge with 2.4.19pre2
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
*	Fix wrong order in MAINTAINERS			(me)
*	Remove roadrunner reference from MAINTAINERS	(me)

Linux 2.4.19pre1-ac2
*	Fix chown/chmod on shmemfs			(me)
*	Fix accounting error in the shm code		(me)
o	Turn on mode2/mode3 overcommit protection	(me)
*	w83877f watchdog fix compile for SMP		(Mark Cooke)
*	Fix ide=nodma for serverworks			(Ken Brownfield)
*	USB2 controller support				(Greg Kroah-Hartmann)
*	Add more devices to the visor driver (m515,clie)(Greg Kroah-Hartmann)
*	IBM USB camera driver updates			(Greg Kroah-Hartmann)
*	USB auerswald driver				(Wolfgang Muees)
*	Trivial random match up with 2.2		(Marco Colombo)
*	Spelling fixes					(Jim Freeman)
*	Next batch of time_*() fixups			(Tim Schmielau)
*	Update video4linux API docs			(Gerd Knorr)
*	Merge some comment fixups			(John Kim)
*	ymfpci sync					(Pete Zaitcev)
*	Update maintainers to add pm3fb			(Romain DOLBEAU)
*	Hotplug updates (docs, fs, compaq driver)	(Greg Kroah-Hartmann)
*	IBM hotplug support	(Irene Zubarev, Tong Yu, Jyoti Shah, Chuck Cole)
*	ACPI hotplug driver support		(Hiroshi Aono, Takayoshi Kochi)
*	Blink keyboard lights on x86 panic		(Andi Kleen)
*	Further Configure.help changes			(Steven Cole)
*	Merge a version of the sard I/O accounting	(Stephen Tweedie,
							 Christoph Hellwig)
*	SC1200 watchdog driver				(Zwane Mwaikambo)
*	Fix address ordering for 36bit MCE on x86	(Dave Jones)

Linux 2.4.19pre1-ac1
-	Merge with 2.4.19-pre1

Linux 2.4.18-ac1
-	Merge with 2.4.18 proper
-	Add missing -rc4 diff
o	Use attribute notifiers to account shmemfs	(me)
o	Initial luxsonor LS220/LS240 driver code	(me)
	| This is just setup code and only in the tree because
	| its where I keep my hacks in progress

Linux 2.4.18rc2-ac2
*	Fix a corruption problem in the jfs dir table	(Dave Kleikamp)
*	Fix trap when extending a single extent of	(Dave Kleikamp)
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
X	Improve handling of psaux open with no mouse	(Christoph Hellwig)
	present
*	3COM 3c359 token ring driver			(Mike Phillips)
*	Fix a case where hpfs didnt set block size	(Chris Mason)
	early enough
*	Remove use of lock_kernel in softdog driver	(me)
*	Make olympic driver use spinlocks not 		(Mike Phillips)
	lock_kernel
*	Fix type of detected devices in md.c		(Jakob Kemi)
*	Changes and defconfig update			(Niels Jensen)
o	PNP BIOS driver updates				(Thomas Hood)
*	Turn off excess printks in pnp quirk reporting	(Andrey Panin)
*	Add documentation for ITE I2C			(Steven Cole)
*	Add documentation for other zoran cards		(Steven Cole)
*	Add an SC520 watchdog, and enable wd8387ff 	(Scott Jennings)
*	Cleaned up and fixed some SC520 watchdog bugs	(me)
	| Scott - can you double check these
*	Fix return on generic lib/string.c memcmp	(Georg Nikodym)
*	Further zoom video cleanups			(me)

Linux 2.4.18rc2-ac1
-	Merge with 2.4.18rc2
*	Ignore i810 modem codecs			(me)
o	Core of address space accounting code		(me)
	| Enforcement, ptrace and some shmem corner bits to do
*	Fix security hole in shmfs			(me)
*	Fix various bits of 64bit file I/O in shmem	(me)
o	Merge with rmap12f				(Rik van Riel and co)

Linux 2.4.18pre9-ac4
*	SIS IDE driver update (handle with care)	(Lionel Bouton)
*	First set of I2O endian cleanups		(me)
*	Make i2o_pci.c 64bit/BE clean			(me)
*	Maybe fix crash on i2o scsi abort/reset paths	(me)
*	Make i2o use the passed scsi direction flag	(me)
*	Fix awk failure path in menuconfig		(Andrew Church)
*	Merge varies doc updates			(Steven Cole)
*	Add serial support for the Lava Octopus-550	(Jim Treadway)
*	OPL3SA2 cleanup					(Zwane Mwaikambo)
o	Add missing blkdev_varyio export		(Todd Roy)
*	Update Changes file, config and experimental	(Niels Jensen)
	checks
*	Fix highmem warning in aacraid			(Andrew Morton)
*	Make tpqic02 use new style request region	(Marcus Alanen)
*	Only turn off mediagx/geode TSC on 5510/5520	(me)
	| From information provided by Hiroshi MIURA
*	Massively clean up the AGP enable and bugfix it	(Bjorn Helgaas)
*	Fix oops if you try to use the RW wq locks	(Bob Miller)
*	Remove FPU usage in neomagic fb			(Denis Kropp)
*	Merge IBM JFS			(Steve Best, Dave Kleikamp, 
					 Barry Arndt, Christoph Hellwig, ..)
*	Updated sis frame buffer driver			(Thomas Winischhofer)

Linux 2.4.18pre9-ac3
*	Clean up various macros and misuse of ;		(Timothy Ball)
*	Correct procfs locking fixup			(Al Viro)
*	Speed up ext2/ext3 synchronous mounts		(Andrew Morton)
*	Update IDE DMA blacklist			(Jonathan Kamens)
*	Update to XFree86 DRM 4.2 (compatible to 4.1)	(Rik Faith, 
	and adds I830 DRM				 Jeff Hartmann,
							 Keith Whitwell,
							 Abraham vd Merwe
							 and others)
*	IBM Lanstreamer updates				(Mike Phillips)
*	Fix acct rlimit problem (I hope)		(me)
	| Problem noted by Ian Allen
*	Automatically set file limits based on mem size	(Andi Kleen)
*	Correct scsi reservation conflict handling	(James Bottomley)
	and add the scsi reset api code
*	Add further kernel docs				(me)
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
*	Add AFAVLAB PCI serial support			(Harald Welte)
*	Fix incorrect resource free in eexpress		(Gianluca Anzolin)
o	Variable size rawio optimisations		(Badari Pulavarty)
*	Add AT's compatible 8139 cardbus chip		(Go Taniguchi)
*	Fix crash with newest hpt ide chips		(Arjan van de Ven)
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
*	Fix a wrong error return in the megaraid driver	(Arjan van de Ven)
*	FreeVXFS update					(Christoph Hellwig)
*	Qnxfs update					(Anders Larsen)
o	Fix non compile with PCI=n			(Adrian Bunk)
-	Fix DRM 4.0 non compile in i810			(me)
*	Drop out now dead CLONE thread/parent fixup	(Dave McCracken)
*	Make NetROM incoming frame check stricter	(Tomi Manninen)
*	Use sock_orphan in AX.25/NetROM			(Jeroen PE1RXQ)
*	Pegasus update					(Petko Manolov)
o	Make reparent_to_init and exec_usermodehelper	(Andrew Morton)
	use set_user, fix a tiny set_user SMP race
*	Mark framebuffer mappings VM_IO			(Andrew Morton)
*	Neomagic frame buffer driver			(Denis Kropp)
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
*	Fix io port type on the hpt366 driver		(Pete Popov)
*	Updated matrox drivers				(Petr Vandrovec)
*	IPchains fixes needed for 2.4.18pre7
*	IDE config text updates for the IDE patches	(Anton Altaparmakov)
*	Merge the first bits of ZV support		(Marcus Metzler)
*	Add initial ZV support to yenta socket driver	(me)
	for TI cards
*	Fix pirq routing on the CS5530 			(me)
	| Finally the palmax pcmcia/cardbus works properly

Linux 2.4.18pre7-ac1
-	Merge with 2.4.18pre7				(Arjan van de Ven)
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
*	Fix mishandling of file system size limiting	(Andrea Arcangeli)
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
*	ldm header fix					(Anton Altaparmakov)
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

