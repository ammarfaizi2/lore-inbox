Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVBFRJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVBFRJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVBFRJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:09:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:16282 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261214AbVBFRHd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:07:33 -0500
Subject: Linux 2.6.10-ac12
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107695728.14782.170.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Feb 2005 16:02:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven is now building RPMS of the kernel and those can be found
in the RPM subdirectory and should be yum-able. Expect the RPMS to lag the
diff a little as the RPM builds and tests do take time.

Nothing terribly exciting here security wise but various bugs for problems
people have been hitting that are now fixed upstream, and also the ULi
tulip variant should now work. If you are running IPv6 you may well want
the networking fixes.


Key:	o	- only in -ac
	*	- already fixed upstream
	X	- discarded later as wrong
	+	- ac specific (fix not relevant to non -ac)

2.6.10-ac12
+	Fix a bug in the new vma checks			(Rik van Riel)
*	Several small 64bit sign/cleanness fixes	(George Guninski)
*	tty layer typo fix				(Al Viro)
o	Fix a further ULI ethernet detail		(Clear Zhang)
o	Fix a problem with mxser.c on SMP boxes		(Alan Cox)
X	Pull problematic TLB patch

2.6.10-ac11
o	First phase of HPT driver cleanups		(Alan Cox)
	| This is just clean ups: the actual changes to make HPT372N
	| work well will happen elsewhere first for obvious reasons
o	ACARD scsi driver updates
o	netpoll fixes					(Matt Mackall)
*	Fix a bug that could cause corruption of large	(Petr Vandrovec)
	x86-64 apps when run mixed with x86-32 apps
*	Fix oops with md over dm			(Jens Axboe)
*	Fix a tlb race that could machine check	x86-64	(Andi Kleen)
*	Fix the "can only burn one DVD" bug		(Michal Schmidt)
*	Fix a whole pile of pegasus driver bugs		(David Brownell)
*	Don't collapse multi-packet skb's		(David Miller)
o	Samsung SN-124 should not be on DMA blacklist	(Alan Cox)
	| Reported/tested by Amit Bhutani
*	Fix an ipv6 "badness" 				(Herbert Xu)
	| (Split out for -ac by Pekka Pietikanien)
*	Fix a couple of small merge errors I made in	(Clear Zhang)
	the ULi ethernet support patch

2.6.10-ac10
*	acpi video fix reapply 				(Dave Jones)
	| How it escaped is a bit of a mystery
*	Fix an x86 64 crash on vsyscall page		(Roland McGrath)
o	Fix AF_NETROM locking				(Alan Cox)
*	32bit compatibility for some socket options	(David Miller)
	could be wrong due to a missing SOL_SOCKET check
*	Fix stack leakage in ipv6 netfilter		(Patrick McHardy)
	| not serious
o	Add ICH7 to the audio idents			(Jason Gaston)
*	Fix bio free before reuse case for clones	(Jens Axboe)
	| Fixes assorted raid oops/crashes
*	Fix a /proc/ide locking bug			(Alan Cox)
*	Further small OOM fix				(Rik van Riel)

2.6.10-ac9
*	2.6.10 variant of the stack race fix		(Alan Cox)
	| Found by Paul Staretz
*	Stronger ELF validity checks			(Solar Designer)
*	Add ATI SATA identifiers			(Frederick Li)
*	Update ATI PATA/SATA support			(Frederick Li)
*	Audit fixups				(Steve Grubb, Roger Luethi)
*	FPU/signal handling fix				(Bodo Stroesser)
*	nForce2 APIC/LAPIC errata fixup			(Prakash Punnoor)
*	Swap aacraid fix in -ac with 2.6.11rc base fix	(Tom Coughlan)
*	Connnection track/rst fix			(Martin Josefsson)
*	Format ide printk's more nicely			(Gunther Mayer)
o	Stallion serial resurrection (part one)		(Wayne Meissner)
*	Fix nls_ascii					(Ogawa Hirofumi)
*	Count writeback pages in nr_scanned		(Rik van Riel)
	| OOM fixing
o	Revert ac97_patch changes			(Jules Villard)
	| with this change many users get no sound out
*	Correct handling of some module parameter	(Rusty Russell)
	errors

2.6.10-ac8
*	I2O init/exit call fix				(Randy Dunlap)
o	More build ia-32 on x86-64 bits			(Arjan van de Ven)
*	NFS error path fixup				(Bill Rugolsky)
*	Swap the coda fix in ac7 with the official	(Jan Harkes)
	authors fix
*	Fix some problematic ptrace/kill interactions	(Roland McGrath)
*	Fix ptrace/coredump problems with threaded	(Roland McGrath)
	apps

2.6.10-ac7
+	Fix failure at boot with some setups and ac6	(Alan Cox)
	| Dumb bug indeed
o	Fix random poolsize sysctl			(Brad Spengler)
*	Fix scsi_ioctl leak				(Brad Spengler)
*	Fix rlimit memlock				(Brad Spengler)
o	Fix Moxa serial					(Alan Cox)
	| While moxa won't actually even build on 2.6 the grsecurity fix
	| is wrong (for 2.2, 2.4 as well). Without it being CAP_SYS_RAWIO
	| a user can insert alternative bios firmware into the card.

2.6.10-ac6
+	Fix ide-pnp build				(Alan Cox)
*	do_brk security fixes				(Marcelo Tosatti)
	| slightly reworked
o	Fixes for Coverity Inc reported bugs		(Alan Cox)
	- coda_pioctl
	- xfs_attrmulti_by_handle
	- br_ioctl
	- rose_rt_ioctl
	- sdla_xfer 
*	Improve the no-overcommit behaviour		(Andries Brouwer)

2.6.10-ac5
+	Remove obsolete usb_unlink_urb in pwc		(Alan Cox)
	| From instructions by Dwaine Garden
*	Subset of ALSA updates to fix sound bugs in .10	(Takashi Iwai)
	| This is the set Takashi kindly identified as being
	| worth applying for 10-ac.
*	First run at merging ISI and base isicom driver	(Alan Cox)
	into a working 2.6 driver
+	IDE mode selection fixes for IT821x PIO		(Alan Cox)
	| Bug noted by Bartlomiej
*	Fix a 32bit compatibility error in the cmsg	(Olaf Kirch)
	check logic
*	Hopefully fix CD-ROM autoclose			(Stas Sergeev)
o	Disable sidewinder debugging spew		(Michael Marineau)
o	Openprom fixes					(Al Viro)
o	Fix cosa module crash on load			(Jan Kasprzak)
o	Add the build environment bits to kernel	(Kevin Fenzi)
	make rpm output
*	Fix megaraid unload oops			(Al Viro)
*	Make gconfig work with current gtk 2.4		(J Magallon)
*	Fix harmless parport overflow by one		(Alexander Nyberg)
*	Fix drivers that put a '/' in /proc/irq/..	(Olaf Hering)

2.6.10-ac4
*	Initial fixes for /dev/tty v setsid() crash	(Alan Cox)
	[/dev/tty v vhangup needs more work]
+	Fixed AGP compile on ia-32			(Arjan van de Ven)
+	PPC fixes 					(Dave Jones)
o	Document irqpoll/irqfixup			(Alan Cox)
o	IBM ACPI reference __exit unsafely		(Arjan van de Ven)
o	Allow pwc to be compiled into the kernel	(Christian Hesse)

2.6.10-ac3
*	Fix a pile of mmc warnings/errors		(Russell King)
*	Fix acpi video memory corruption		(Linus Torvalds)
*	Fix module param breakage in parport_pc		(Randy Dunlap)
*	Intel ICH7 IDE support and $PIR support		(Jason Gaston)
*	Intel ICH7 SATA support				(Jason Gaston)
o	Intel ICH7 I2C support				(Jason Gaston)
o	Fix an IDE CD-ROM crash/BUG case		(Prarit Bhargava)
*	Swap -ac AGP annotations for head AGP fixes	(Dave Jones,
							 Bjorn Helgaas,
							 Masao Takahashi)
o	Add proper delaying/sleeping ide_pci_unregister	(Alan Cox)
o	Do the same for PCMCIA (ide_cs)	and ISA PnP	(Alan Cox)
o	Use msleep for ide-cd and ide-cs		(Nishanth Aravamudan)
o	Fix missing type in lapic_shutdown		(Miael Pettersson)
*	Fix some missing build dependancies for CX88	(Adrian Bunk)
o	Move pwc to use remap_pfn_range			(Arjan van de Ven)

2.6.10-ac2
o	Fix printk fixes for geometry free drives	(Alan Cox)
	| Found by Bartlomiej
o	Bartlomiej's requested cleanups for IT8212	(Alan Cox)
X	Drop unneeded i810 audio patch
X	Drop useless kmalloc size patch
+	Fix proposed ide ISA v PIO change to work	(Alan Cox)
	| Bug noted by .. everyone
*	Backport mxser compile fix			(Al Viro)
*	Backport via acpi irq routing fixes		(Len Brown, Shaohua Li)
	| Replaces the old -ac fix
*	Backport further aacraid chipset support	(Mark Haverkamp)
*	ULi 5281 support				(Peer Chen)
*	Backport several libata fixes notably problems	(Albert Lee)
	with PDC20275
*	FW_LOADER is needed by several dvb devices	(Michal Feix)
o	Add IT8211 PCI identifiers to IT8212 and	(Alan Cox)
	rename driver and functions it iT821x
	| Thanks to Philipp Imhof for the IT8211 idents
*	Clean up and merge LAN M526X support		(Clear Zhang)
	| 2.6 port/slight tidy done on the original

2.6.10-ac1
*	Revert AX.25 protocol breakage			(Alan Cox)
o	Remove bogus obsolete option junk from 2.6.10	(Alan Cox)
	ide changes
	| Options are often useful, so should be kept.
	| Especially stuff like serialize
o	Fix bogus dma_ naming in the 2.6.10 patch	(Alan Cox)
o	Initial CS5520 fixups for VDMA and 2.6.10
	| Must set vdma flag before command issue
	| ?? could we just set it at boot and leave it - probably (check)

Forward ported from 2.6.9-ac
*	Smbfs improved parsing fixes			(Chuck Ebbert)
*	Fix several IDE drivers that assumed > 0 was	(Alan Cox)
	also an error return for pci probe functions
*	Fix sys5 semaphore wakeups			(Manfred Spraul)
o	Suggest irqpoll when we get screaming irqs	(Alan Cox)
*	Fix reset problems with older 3c59x/3c90x	(John Linville)
o	Configurable 100/1Khz clock for x86		(James Bottomley)
	| 100Hz is great for battery life
o	Delkin cardbus IDE support			(Mark Lord)
o	IT8212 IDE support				(Alan Cox)
X	Add more AC97 table data
o	Token ring locking fix
o	Fix URL for lanana				(Alexander Stohr)
X	Add a 1620 byte slab cache for ethernet frames	(Arjan van de Ven)
*	EDD boot options				(Matt Domsch)
o	Don't probe legacy ISA ide2,3,4,5 on PCI boxes	(Alan Cox)
o	Restore PWC driver				(Luc Saillard)
	| Please port away from remap_page_range
o	Fix AT2701FX AMD PCnet32 on fibre		(Guido Guenther)
*	Fix build of CS461x gameport			(Adrian Bunk)
*	Fix crash with aacraid double complete	(Mark Salyzyn, Tom Coughlan,
						 Alan Cox)
*	Fix getblk_slow hang				(Chris Mason)
+	Fix SMP hang with IDE unregister		(Mark Lord)
o	Working IDE locking				(Alan Cox)
	| And a great deal of review by Bartlomiej
o	Allow IDE to grab all unknown generic IDE	(Alan Cox)
	devices (boot with "all-generic-ide")
*	More ATI IDE PCI identifiers			(Enrico Scholz)
o	Initial patch for ide_abort hang		(Alan Cox)
*	Fix serveral ide timing violations on reset	(Alan Cox)
*	Support CSB6-R Serverworks raid			(Alan Cox)
o	Teach ide-cd to use sense data for file system	(Alan Cox)
	requests
	- This means you get better diagonstics on CD errors
	- It means a partial I/O failure will get you back the ok sectors
	- It may fix the problem some users have with ISO copying and ide-cd
o	Lock ide-proc against driver unload		(Alan Cox)
	(very low severity)
o	Fix ide /proc and legacy devices problem	(Alan Cox)
*	Watchdog support for early cobalt ALi hardware	(Mike Waychison)
*	Make sx8 naming follow LANANA			(Jeremy Katz)
*	Don't warn on scsi ioctl kmalloc fail		(Arjan van de Ven)
*	Fix Paul Laufer's email address			(Paul Laufer)
*	Fix misleading microcode message		(Arjan van de Ven)
o	Allow cross compile of x86_32 kernel on x86_64	(Arjan van de Ven)
o	Kill "open failed" cdrom message.		(Alan Cox)
	| This is a natural event from code poking around
	| doing CD detection etc
*	Minor typo fix in cdrom driver			(efalk@google)
*	Add support for newer ALi AGP			(Clear Zhang)
o	Handle E7xxx boxes with USB legacy flaws	(Alan Cox)

Cleanups in porting
o	Drop ->taskfile hooks in the IDE layer 		(Alan Cox)
	(->fixup replaces)
o	Fix up IT8212 for 2.6.10 ide_use_dma cleanups	(Alan Cox)
	and other 2.6.10 cleaning

Dropped for now
o	VIA extra quirk
o	HP Cardbus routing fixup

