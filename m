Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263450AbREXXk1>; Thu, 24 May 2001 19:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263451AbREXXkS>; Thu, 24 May 2001 19:40:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26889 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263450AbREXXkD>; Thu, 24 May 2001 19:40:03 -0400
Date: Fri, 25 May 2001 00:37:31 +0100
From: Alan Cox <laughing@shared-source.org>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.4-ac17
Message-ID: <20010525003731.A22387@lightning.swansea.linux.org.uk>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

This one just fixes the first chunk of stuff the Stanford checker found and
a couple of other small bits.

2.4.4-ac17
o	Fix double free in new cciss			(me)
o	Fix i2o_pci double free on error		(me)
o	Fix use after free in iphase (two of)		(me)
o	Fix use after free in cs4281			(me)
o	Fix use after free in lapbether			(me)
o	Fix use after free in bpqether			(me)
o	Fix use after free in edgeport			(me)
o	Fix memory leak in cciss			(me)
o	Fix memory leak in failed vxfs mounts		(me)
o	Fix memory leak in failed cmsfs mounts		(me)
o	Fix memory leak on error in ixj			(me)
o	Fix memory leak in lmc				(me)
o	Fix memory leak in isdnppp			(me)
o	Fix memory leak in wanrouter			(me)
o	Fix memory leak on error in jffs		(me)
o	Fix reference to invalid memory in rio		(me)
o	Fix leaks in xircom driver (and update)		(Arjan van de Ven)
	| All of the above found by the stanford checking team
	| who [or whose tools] effectively did the work for us
o	Fix maestro bug from merge			(Marcus Meissner)

2.4.4-ac16
o	Fix FAT crashes with 2K media			(OGAWA Hirofumi)
o	Fix scsi trace messages				(Khalid Aziz)
o	Fix hga module laod problem			(Juan Quintela)
o	Fix leak in wanproc				(Akash Jain)
o	ESS solo clean ups				(Marcus Meissner)
o	Update address for Jonathan Woithe		(Jonathan Woithe)
o	Fix the mess I made of the stradis driver	(Francois Romieu)
o	Port maestro to 2.4 PCI API			(Marcus Meissner)
o	Report shmem pages in /proc			(Christoph Rohland)
	| Im not sure this is the right approach - opinions ?
o	Port toshoboe driver to 2.4 PCI api		(Marcus Meissner)
o	Update 3ware ide raid driver			(Adam Radford)
o	Update ncr/symbios drivers 			(Gerhard Roudier)
o	Fix fealnx build on some non x86 platforms	(Jeff Garzik)

2.4.4-ac15
o	Merge Linus 2.4.5pre5
	| Also fixes a dumb bug in my mmx fixups I 
	| managed to forget to test and spot
o	Dump the ACPI changes - new ones are pending	(me)
	and the old ones are better than this lot
o	Revert serial incompatibility pending nice fix	(me)
o	Move a few other oddments to match Linus
o	Rip format conversion out of the pwc driver	(me)
	| It belongs in user space..

2.4.4-ac14
o	Fix error corner case on max file size check	(Andrew Morton)
o	Do first bits of applicom.c cleanup		(me)
	| This needs a lot of cleaning yet
o	Fix open/close locking on dsp56k		(me)
o	Clean up the obvious namespace mess in h8.c	(me)
	| Wants verifying by Alpha folks
o	Fix locking errors in machzwd watchdog		(me)
o	Fix printk levels on nwflush , someone with a 	(me)
	netwindup needs to see the FIXME cases still
o	Fix out of memory oops in pcwd.c		(me)
o	Add more Dell raid devices to sparselun table	(Matt Domsch)
o	Add hotplug table entry for aic7xxx		(Marcus Meissner)
o	Drop deceased APA1480 driver to match Linus tree(me)
o	Fix ali15x3 nodma behaviour			(Jeff Garzik)
o	Further quota fixups				(Jan Kara)
o	Update a2232 to current version 		(Geert Uytterhoeven)
	| Older one got merged in error..
o	Clean up sonicvibes pci handling		(Marcus Meissner)
o	Remove dead radio miscdevice bits		(Al Viro)
o	Merge ATI Rage XL console support		(Geert Uytterhoeven)
o	Fix problems with pyxis iommu on Alpha		(Ivan Kokshaysky)
o	Fix compile errors when built without /proc   (Andrzej Krzysztofowicz)
o	Encapsulate shmem inode info using macros	(Christoph Rohland)
	| So Al can attack the inode struct..
o	Move small symlinks into shmem_inode_info	(Christoph Rohland)
o	Count shmemfs pages and put them in /proc	(Christoph Rohland)
o	Put back accidentally reverted PnPBIOS parport	(Marcelo Jimenez)

2.4.4-ac13
o	Fix binfmt_misc compile bug			(me)
o	Add missing locking to pms driver		(me)
o	Fix planb locking/rt deadlock			(me)
o	Add missing locking to saa5249 driver		(me)
o	Add missing locking to stradis driver		(me)
o	Add missing locking to zr36067 driver		(me)
o	Fix locking on trident sound driver		(me)
	| Probably all the other PCI sound drivers need doing too...
o	Fix wrong ioctl return on trident sound driver	(me)
o	Clean up NCR53c406 compile warnings		(me)
o	Fix dmx3191 compile warnings, printk levels	(me)
o	Fix coda cache compile warnings			(me)
o	Fix a warning in jffs2				(me)
o	Fix nautilus SRM poweroff			(Richard Henderson)
o	Fix Alpha build bug				(Richard Henderson)
o	Fix a hang in the maestro dock support		(Ben Pfaff)
o	Fix memory leak in ACPI drivers			(Philip Wang)
o	Eliminate popping in cs46xx, fix powerdown	(Tom Woller)
o	Fix ps2esdi SMP build 				(Rasmus Andersen)
o	Fix a hang on NFS write				(Trond Myklebust)
o	Cleaned up assorted random warnings		(me)

2.4.4-ac12
o	Just tracking Linus 2.4.5pre4			
	- A chunk more merged with Linus
	- dropped out some oddments that are now
	  obsolete

2.4.4-ac11
o	Fix hang after "Freeing unused.." on S/390	(Dick Hitt)
o	Fix ramfs accounting bug			(Christoph Rohland)
o	Raw HID access interface for USB		(Brad Hards)
o	Fix missing release_region on QlogicFAS		(Marcus Meissner)
o	Fix missing release region in NCR53c406 code	(Marcus Meissner)
o	Make trident use the new pm callbacks		(Pavel Roskin)
o	Fix dmi ident handling				(Arjan van de Ven)
o	dc2xx locking fixes				(Greg Kroah-Hartmann)
o	Fix overrun on the acm driver			(Greg Kroah-Hartmann)
o	Sitecom workarounds for mct-u232		(Stelian Pop)
o	Makefile fixes					(Al Viro)
o	Make hgafb show logo if non modular only like	(me)
	the rest
o	Merge back the invalidate_device changes into	(me)
	the new cciss/cpqarray
o	Rio and sx serial driver updates		(Rogier Wolff)
o	Add another SB AWE 32 variant to the tables	(Jeremy Manson)
o	Fix serial.c warning				(Jesper Juhl)
o	Basic maestro dock support			(Ben Pfaff)
o	Add defines for testing prefetch		(Arjan van de Ven)
o	Protect nls.h from repeat include		(Anton Altaparmakov)
o	Clean up resource handling in esssolo1		(Marcus Meissner)
o	Fix mysnc on /dev/fb				(Andrea Arcangeli)
o	Further IBM token ring updates			(Mike Phillips)
o	Fix usermode Linux makefile problem		(Andrew Morton)
o	Merge first block of LVM changes		(Heinz & others)
o	Forward port 2.2 syncppp flags features		(Paul Fulghum)
o	Merge lp486e driver for 2.4			(Andries Brouwer)
	| Experimental...
o	Merge new cmpci driver 				(ChenLi Tien)
o	& remove 2.2 back compat gunge, modem gunge	(me)
o	Update frame buffer project/mailing list data	(Geert Uytterhoeven)
o	Fix m68k bitops					(Roman Zippel)
o	Add w83877f watchdog driver			(Scott Jennings)
o	Merge A2232 serial driver			(Enver Haase)
o	Fix wrong memory free in isdn_ppp		(Christopher Kanaan)

2.4.4-ac10
o	Move cs46xx docs into the right spot		(Arjan van de Ven)
o	Merge Linus 2.4.5pre3
	- switch to Linus page fault race fixes
	- switch to Linus arch/ppc
	- merged serial driver cli fixes but also
	  added an extra missing moxa check
	- used -ac better version of comx fix
	- used -ac better version of scsi fix
	- now 2.4.5pre vm seems sane dump other vmscan
	  experiments
	[not merged; rage-xl code]
o	

2.4.4-ac9
o	Clean up x86isms from the UML code		(Chris Emerson)
o	Remove un-needed UML flag,fix hang under load	(Jeff Dike)
o	Fix attach race	in UML				(Jeff Dike)
o	Fix warnings, clean up cpp abuses in UML	(Roman Zippel)
o	Remove -D__KERNEL__ from user space of UML	(Roman Zippel)
o	Add NCR53c700 and 53c700/66 driver		(James Bottomley)
	|For NCR Dual 700 microchannel card
o	Alpha semaphore updates				(Ivan Kokshaysky)
p	Fix ibmtr build a bit			(Andrzej Krzysztofowicz)
o	Tidy sysrq-t output				(Russell King)
o	Fix miata halt to SRM				(Tom Vier)
o	Fix aging on buffer cache pages			(Marcelo Tosatti)
o	Fix looping behaviour on failing memory 	(Marcelo Tosatti)
	allocations
o	Handle the PIIX4 on the new intel 82801BAM	(Tim Raymond)
o	Fix user visible -ENOIOCTLCMD returns		(Shane Wegner)
o	Fix startech uart detection problem		(Val Henson)
o	Further tulip updates				(Jeff Garzik)
o	Revert hpt366 patch

2.4.4-ac8
o	Prefetch constant copy_to_user data		(Arjan van de Ven)
o	Update cpqarray driver - use pci dma api	(Charles White)
o	Update cciss driver - use pci dma api		(Charles White)
o	Enable compiled in synclink driver		(Paul Fulghum)
o	Fix plip section conflict			(Keith Owens)
o	Tulip driver updates				(Jeff Garzik)
o	Frame buffer logo updates			(Geert Uytterhoeven)
o	Update __initdata documentation			(Ingo Oeser)
o	Linearize sunrpc buffers using GFP_KERNEL	(Trond Myklebust)
o	C Scott Ananian has moved			(C Scott Ananian)
o	Update get_unaligned docs			(John Levon)
o	Fix pci pool handling on boxes that have non	(Pete Zaitcev)
	irq safe map create/destroy
o	Update m68k semaphores				(Geert Uytterhoeven)
o	Update NLS Configure.help			(Nerijus Baliunas)
o	Clean up cyclom driver			(Arnaldo Carvalho de Melo)
o	Further serial driver update			(Jeff Garzik)
o	Fix typo in sched.c				(Jim Freeman)
o	Do prefetches on wake_up_common walk		(Arjan van de Ven)
o	Fix bootmem init problems			(Andrea Arcangeli)
o	Fix pops on cs46xx power management		(Thomas Woller)
o	Fix reference of freed memory in cs46xx		(Christopher Kanaan)
o	Hopefully fix i2o scsi reset crash		(me)

2.4.4-ac7
o	Fix dasd off by one found by Al Viro		(me)
o	Fix copy under cli in
	moxa,mxser,pcxx,riscom8
o	Cleaned up serial167 formatting (no code	(me)
	changes this patch set)
o	Fix missing length check in AGPgart		(me)
	| Found by Al Viro
o	Fix wrong kmalloc sizes in ixj/emu10k1		(David Chan)
o	Fix make distclean on ramfs/tmpfs		(Ingo Oeser)
o	Update checkconfig, Changes			(Niels Jensen)
o	NFS mmap consistency on close fix		(Andrea Arcangeli)
o	Fix 10 bit decode causing APM hang on a laptop	(Pete Zaitcev)
	when using ymfpci
o	Reserve failure on vesa video ram is not fatal	(Jordan Crouse)
o	Update athlon mmx copier to not prefetch off	(Arjan van de Ven)
	the end
o	Fix scsi.c procfs zero termination checks	(Al Viro)
o	And fix -EFAULT returns from it			(me)
o	Update ibm token ring driver			(Mike Phillips)
o	Fix sockfilter maths overflow			(Al Viro)
o	Make dev name lookup robust to nonterminated	(Al Viro)
	buffers
o	Update config.h use				(Niels Jensen)
o	Fix xircom cardbus ethernet/modem support	(Bill Nottingham)
o	Fix off by one buffer checks in atm_poa and	(Al Viro)
	dasd
o	Clean up printks in zr36067.c			(me)

2.4.4-ac6
o	Revert dead swap patch pending fixes		(Dave Miller)
o	Allow arch specific writeproc/DMA for IDE	(Bjorn Wesen)
o	Move to aic7xxx 6.1.13				(Justin Gibbs)
o	Use pci_set_master on eni.c			(Jeff Garzik)
o	Update wireless drivers, add airport		(Jean Tourrihles,
							Benjamin Herrenschmidt)
o	Add new pci ids, clean up dup defines in eicon	(Jeff Garzik)
o	Add module loader to kernel docs		(Erik Mouw)
o	Fix wanrouter makefile bug		(Arnaldo Carvalho de Melo)
o	Add another pair of idents to the yenta driver  (Alexandr Kanevskiy)
o	Parport fixes for 1284 mode			(Fred Barnes)
o	Update 8139too driver to handle wakeup bug	(Jeff Garzik)
o	Add koi8-ru locale              		(Andrzej Krzysztofowicz)
o       Add ICH3 to the i810 audio driver		(Tom Woller)
o	Improve (hopefully) the confusing I82365 help   (me)
o	Fix a bug in koi8-u tables			(Andrzej Krzysztofowicz)
o	Fix a bug in UTF8->CP1255			(Andrzej Krzysztofowicz)
o	Fix a bug in iso8859-13 tables			(Andrzej Krzysztofowicz)
o	Update gdth driver to current vendor release    (Achim Leubner)
o	Kill cpia_write_proc (its insecure)		(Al Viro, me)
o	Fix unterminated array strtoul() in comx	(Al Viro)
o	Fix TCP send path leak				(Dave Miller)
o	Restore older skb_cow() headroom behaviour	(Dave Miller)
o	Fix ipv6 oops					(Dave Miller)
o	Small ipx tidy up			(Arnaldo Carvalho de Melo)
o	Fix unprotected userspace reference in trident  (Al Viro)
	audio
o	Fix expand stack locking			(Manfred Spraul)
o	Fix offslab_limit calculation			(Manfred Spraul)
o	EATA and U14F updates				(Dario Ballabio)
o	Update scsi generic to 3.1.18			(Doug Gilbert)
o	Clean up abs() 					(Kai Germaschewski)
	| This needs further checking
o	ymfpci update					(Pete Zaitcev)
o	Quota code updates				(Jan Kara)
o	Clean up eicon include abuse			(me)

2.4.4-ac5
o	Fix DMA setup on hpt366/370			(Tim Hockin)
o	DRM memory alloc failure checks			(Akash Jain)
o	Remove bogus fs/buffer.c diff			(Ben LaHaise)
o	cs46xx update - adds Hercules Game Theatre XP	(Thomas Woller)
o	Fix menuconfig breakage with ()		(Andrzej Krzysztofowicz)
o	Updated multithreaded core dump support		(Don Dugger)
o	Remove dead ibmtr.h include			(Mike Phillips)
o	Fix misplaced letters in koi8-u			(Andriy Rysin)
o	Further alpha module locking fix		(Andrea Arcangeli)
o	Keyspan bitwidth fixes				(Hugh Blemings)
o	usb-uhci oops fix				(Pete Zaitcev)
o	Add ability to specify preferred minor on 	(Gerd Knorr)
	video/radio4linux devices
o	Further IPX updates			(Arnaldo Carvalho de Melo)
o	Further IRDA updates				(Dag Brattli)
o	Make x86 ptrace framesize a define (code clean)	(Pavel Machek)
o	Moxa serial tidy				(Tim Hockin)
o	Fix tiny select race				(Rusty Russell)
o	Update aic7xxx to 6.1.12			(Justin Gibbs)
o	Alpha was missing rwlock_init			(Reto Baettig)
o	Alpha SCHED_YIELD was broken on UP		(Andrea Arcangeli)
o	Allow IRQ sharingon more PCI ide		(Pete Zaitcev)
o	Fix capable checks found by Stanford analyser	(me)
	for cciss/cpqarray
o	List more devices in sysrq table	(Andrzej Krzysztofowicz)
o	Run uml exit callbacks reverse to init		(Andrew Morton)
o	Fix SMP resched_idle pre-emption bug		(Nigel Gamble)
o	Work around config problem with menuconfig
	and USB					(Andrzej Krzysztofowicz)
o	Fix nasty bug in Alpha PCI mapping		(Hyung Min SEO)
	| Nautilus specific stuff not applied yet
o	SBLive endianness fixes	(output only so far)	(Ira Weiny)
o	Move sblive pci_enable earlier			(Marcus Meissner)
o	Merge IBM ServeRAID 4.72 driver			(Keith Mitchell)
o	Fix affs races					(Roman Zippel)
o	Fix cdrom unload crash			(Andrzej Krzysztofowicz)

2.4.4-ac4
o	Fix future domain scsi				(Carlo Prelz)
o	Merge Linux 2.4.5pre1
o	Fix ipx without sysctl compile			(Pavel Roskin)
o	Revert fork changes to match Linus 2.4.5pre1
o	Drop the threaded core dump code
	| It can go back in when it works
o	Drop pa-risc work - it'll be easier to resync
	just once as pa has moved on a lot
o	Add spin_lock_prefetch to get_empty_inode	(me)
	| Experimenting
o	Kbuild has moved				(Keith Owens)
o	Update kernel docs on memory barriers		(Rusty Russell)
o	Move es1370 pci_enable and do some cleanup	(Marcus Meissner)
o	Fix netfilter overuse of __exit			(Rusty Russell)
o	Fix alpha build bug				(Michal Jaegermann)
o	Fix tigon1 build				(Olivier Galibert)
o	Fix tmpfs deadlocks writing into a file from	(Christoph Rohland)
	an mmap of itself
o	Fix missing (but harmless) return in vmtruncate	(Al Viro)

2.4.4-ac3
o	Fix hang on boot with SMP			(Andrea Arcangeli)
	| and fixes a few more uglies too
o	freevxfs module name was wrong (should be	(me)
	freevxfs.o)
o	Update alloc_etherdev docs			(Erik Mouw)
o	Remove dead funcs, put back ip_set_manually	(David Miller,
	in the ipconfig code			(Arnaldo Carvalho de Melo)
o	Fix SA_ONSTACK standards violation (for x86)	(Christian Ehrhardt)
	| Other arch maintainers should check..
o	Add another species of SB AWE 32		(Bill Nottingham)
o	SE401 USB camera driver				(Jeroen Vreeken)
o	Correct MAX_HD and make stuff static in ps2esdi	(Hal Duston)
o	Fix inode-nr corruption				(Al Viro)
o	Fix pgd_alloc for user mode linux		(Jeff Dike)
o	Fix UML hostfs for get_hardsect_size		(Jeff Dike)
o	Tidy up APM options setting, add module opts	(Stephen Rothwell)
o	Fix acm open race				(Oliver Neukum)
o	Further bounce buffer fixes			(Arjan van de Ven)
o	ACPI updates					(Andrew Grover)
o	Move pci_enable_device earlier on via audio	(Arjan van de Ven)

2.4.4-ac2
o	Remove some spurious whitespace differences 	(me)
	between trees
o	Make the VIA timer reload check test avoid 	(me)
	tripping on a timer as it rolls back to zero
o	Drop dasdfmt man page changes (dos ^M noise)	(me)
o	Drop experimental iee1284 pnp module loading	(me)
o	Revert pcnet32 chance causing compile errors	(me)
o	Remove wrong __init in sunhme			(Dave Miller)
o	Fix overlarge udely in aironet4500		(Arjan van de Ven)
o	Remove non existant parameter from aironet4500	(Keith Owens)
o	Kill duplicate aic7xxx include		(Andrzej Krzysztofowicz)
o	Fix pci2220i scsi compile bug			(Matt Domsch)
o	Fix module exception race on Alpha		(Andrea Arcangeli)
o	Disable broken large vmalloc support on Alpha	(Andrea Arcangeli)
o	Remove dead ia64 config entries			(Steven Cole)
o	Add kbuild list info to MAINTAINERS		(Steven Cole)
o	linux appletalk list has moved		(Arnaldo Carvalho de Melo)
o	Revert wrong mount changes in 2.4.4		(Andries Brouwer)
o	Revert drivers/scsi/scsi.c change in 2.4.4	(me)
	that subtly broke about 15 drivers
o	Fix typo in slab.h				(Pavel Machek)
o	More correct child favouring fork behaviour	(Peter Österlund)
o	Only apply pci fixups if there is a VIA 686B	(Charl Botha)
o	Fix GDT padding error introduced by PnPBIOS	(Brian Gerst)
	support
o	Fix UML build without CONFIG_PT_PROXY		(Jeff Dike)
o	dmfe wasnt calling dev_alloc_skb		(Tobias Ringstrom)
o	Further Configure.help fixups			(Steven Cole)
o	Move pci_enable_device earlier in trident	(Marcus Meissner)

2.4.4-ac1
o	Merge with Linus 2.4.4
	| This wasnt entirely trivial so this is the only
	| stuff in this patch
	| The following stuff has been switched to the Linus branch
	| in the merge: uhci, dcache atomicity, raw I/O

2.4.3-ac14
o	Merge read-only vxfs reading support		(Christoph Hellwig)
o	Fix missing return in broken_apm_power		(Alex Riesen)
o	Remove bogus rwsem hacks from usbdevice_fs.h	(Alex Riesen)
o	Fix umount/sync_inodes race			(Al Viro)
o	Make new xircom driver report when promisc used	(Arjan van de Ven)
o	Fix acenic PCI flag set up			(Phil Copeland)
o	Make nfs smart about passing max file sizes	(Trond Myklebust)
o	Add initrd support to User Mode Linux		(Jeff Dike)
o	Fix timer irq race in User Mode Linux		(Jeff Dike)
o	Fix UML for semaphore changes			(Jeff Dike)
o	Update thw W9966 parallel port camera driver	(Jakob Kemi)
o	Further dmfe SMP fixups				(Tobias Ringstrom)
o	Kernel manual pages in man9			(Tim Waugh)
o	Work around BIOSes that implement E801 sizing
	but don't implement the CX/DX values part	(Michael Miller)
o	Fix atp driver build				(Arjan van de Ven)
o	Fix irda poll handling				(Dag Brattli)
o	Remove unused buggy pdc202xx code		(Arjan van de Ven)
o	Clean up iphase ATM				(Arnaldo Carvalho
								de Melo)
o	Setup slave PDC20265 controller on fasttrak	(Arjan van de Ven)
	as normal IDE
o	Add __init/__initdata to most net driver   (Andrzej Krzysztofowicz)
	version info
o	SDDR09 config entry was missing			(Phil Stracchino)
o	Configure.help NFS updates		   (Andrzej Krzysztofowicz)
o	Netfilter updates				(Rusty Russell and co)
o	Update 2.4 ipconfig to support dhcp		(Eric Biederman)
o	es1371 setup updates/error check/pci bits	(Marcus Meissner)
o	Fix buzzing ymfpci				(Nick Brown)
o	Update nm256 audio driver			(Marcus Meissner)
o	Blacklist updates				(Arjan van de Ven)

2.4.3-ac13
o	Switch to NOVERS symbols for rwsem		(me)
	| Called from asm blocks so they can't be versioned
o	Fix gcc 2.95 building on rwsem			(Niels Jensen)
o	Fix cmsfs build				    (Andrzej Krzysztofowicz)
o	Fix rio build/HZ setup			    (Andrzej Krzysztofowicz)
o	Fix PPP filtering dependancy in config      (Andrzej Krzysztofowicz)

2.4.3-ac12
o	Rewrite the i2o post handling code to fix 	(me)
	DMA memory scribbles
o	Handle IOP constipation in the i2o_block layer	(me)
o	Fix bugs in the i2o table query causing reboots	(me)
	in i2o_proc on the DPT card
o	Add quirks for i2o cards that handle large I/O	(me)
	queues badly [Promise supertrak100]
o	Add cache heuristics to the I2O block driver	(me)
	| We don't cache large writes (assume seq)
	| We writeback small writes (random, metadata)
o	Disable use of writeback caching if there is	(me)
	no battery backup
o	Merge Linus 2.4.4pre6
o	Further semaphore fixes				(David Howells)
o	Correct 'void main' to 'int main' in rtc doc	(Jesper Juhl)
o	Hopefully fix bugtraq reported netfilter ftp
	flaw
o	Fix unistd.h for ARM				(Russell King)
o	Fix pre-emption of rt tasks			(Nigel Gamble)
o	Fix revalidation bugs in cciss/cpqarray		(Charles White)
	when rereading partitions
o	Acenic updates					(Jes Sorensen)
o	Fix MAINTAINERS sort order			(David Woodhouse)
o	Restore DVDRAM fix with cdrom init fix too	(Jens Axboe)
o	Fix irda disconnect timeout bug			(Dag Brattli)
o	Experimentally reap dead swap harder		(Dave Miller)
o	Remove dead low mtu checks from drivers		(Arnaldo Carvalho de
							 Melo)
o	Add missing sk_chk_filter export		(Byeong-ryeol Kim)
o	Quieten pci printks, send them to log		(Arjan van de Ven)
o	Hopefully fix fastrak oops			(me)

2.4.3-ac11
o	Merge Linus 2.4.4pre5
o	Back out problem dvdram changes
o	Make reiserfs use daemonize			(Chris Mason)
o	Fix lvm map buglet				(Jens Axboe)
o	tms380 driver fixes				(Adam Fritzler)
o	Fix up duplicate configs and other glitches	(Steven Cole)
o	Fix pcnet32 printk format bug			(me)
o	ISDN driver further small update/fixes		(me)
o	Fix bounce buffer deadlock on bh allocs		(Arjan van de Ven)
o	Fix fbmem merge glitch				(Geert Uytterhoeven)
o	Version string cleanups on net devices		(Jeff Garzik)
o	Update ext2 documentation			(Andreas Dilger)
o	Add MCE support for AMD Athlon/Duron		(Dave Jones)
o	Further SDLA tidying				(me)
o	Update Configure.help maintainers		(Steven Cole, Eric
							 Raymond)
o	Tulip update					(Jeff Garzik)
o	Fix sound config to use right symnames		(Eric Raymond)
o	Further dmfe fixes				(Tobias Ringstrom,
							 Frank Davis
							 Jeff Garzik)
o	Parport probe cleanups				(Tim Waugh)
o	Fix a few configure items			(Eric Raymond)
o	Fix cmsfs nonbuild				(me)


2.4.3-ac10
o	Merge Linus 2.4.4pre4
o	Apply the i960 quirk to the DPT I2O controllers	(me)
o	Etrax100 updates				(Bjorn Wesen)
o	Fix skge memory leak				(Jes Sorensen)
o	Handle reiserfs log overflow error		(Chris Mason)
o	Merge JFFS2 (compressing log flash file system)	(David Woodhouse)
o	Merge contributed help texts for options	(Eric Raymond,
							 Steven Cole)
o	Further screen blanking fixes			(Mikael Pettersson)
o	Further binfmt elf DLINFO fixes/alignment      (Benjamin Herrenschmidt)
o	Fix reboot notifier unregister in aic7xxx	(Arjan van de Ven)
o	Fix orinoco_cs build on powerpc			(David Gibson)
o	Neomagic audio didn't call pci_enable_device	(Marcus Meissner)
o	Remove superblock file size setting for 2Gb	(Al Viro)
	default size file systems
o	Merge UML gprof support				(Jeff Dike)
o	Clean up UML slip code				(Jeff Dike)
o	Allow UML attach to already running debuggers	(Jeff Dike)
o	Reorder frame buffer probes			(Geert Uytterhoeven)
o	Add __init calls to bluesmoke.c			(Dave Jones)
o	Add missing pci_enable_device to toshoboe	(Marcus Meissner)
o	Updated AFFS file system			(Roman Zippel)
o	DVD-RAM fixes					(Jens Axboe)
o	Further sundance driver fixes			(Jeff Garzik)
o	Fix qlogicfc warning				(Dave Miller)
o	Fix sign handling error in scsi_ioctl		(me)
	| Found by the Stanford validator
o	Fix sign handling error in af_decnet		(me)
	| Found by the Stanford validator
o	Fixed I2O posts to be uninterruptible		(me)
o	Stop IDE layer eating Supertrak slave PDC20265	(me)
o	Work around the DPT I2O controller exploding 
	when asked to quiesce.				(me)


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

---
Alan Cox <alan@lxorguk.ukuu.org.uk>
Red Hat Kernel Hacker
& Linux 2.2 Maintainer                        Brainbench MVP for TCP/IP
http://www.linux.org.uk/diary                 http://www.brainbench.com
