Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUK0EEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUK0EEz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 23:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUK0EEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 23:04:32 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262338AbUKZTVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:21:04 -0500
Subject: Linux 2.6.9-ac12
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101480210.23210.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 26 Nov 2004 14:43:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This -ac is a little different. It's an experimental -ac to test the 
accumulated patches it would be nice to have in -ac but which might break
something and seemed too risky. As such please test it but in general wait
for the next -ac before planning to update production systems.

Arjan van de Ven is now building RPMS of the kernel and those can be found
in the RPM subdirectory and should be yum-able. Expect the RPMS to lag the
diff a little as the RPM builds and tests do take time.

The it8212 still doesn't default to DMA on - that is on the TODO list. The
HPT366 rework project is also not ready (its gone back to the drawing
board for a few days if you are a volunteer and wondered what is up).

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

Key:	o	- only in -ac
	*	- already fixed upstream
	X	- discarded later as wrong
	+	- ac specific (fix not relevant to non -ac)

2.6.9-ac12
o	Configurable 100/1Khz clock for x86		(James Bottomley)
	| 100Hz is great for battery life
o	Fixup subordinate bus plumbing for boxes like
	the HP zv5000z (somewhat experimental)
+	Fix ACPI=n build				(Chuck Ehbert)
*	EDD boot options				(Matt Domsch)
*	Fix proc reporting of ppid		(Dinakar Guniguntula)
	| Backport c/o Ingo
o	Improved smbfs fixes				(Chuck Ebhert)
o	Fix reset problems with older 3c59x/3c90x	(John Linville)
o	Fix oops if aic79xx is loaded with no hardware	(Adam Manthei)
	present
o	Token ring locking fix
*	Fix smc9192					(Russell King)
*	Refcount scsi command queue properly		(James Bottomley)
*	Fix CD-ROM returns from new TUR code		(James Bottomley)
*	Fix scribble after close on Nvidia ethernet	(Manfred Spraul)
*	Fix queuecommand() behaviour for USB disk	(Alan Stern)
	after unplug
*	Fix xtime adjustment error that could cause	(Andrew Morton)
	clock slew
*	Fix IPv6 fragmentation problems			(Herbert Xu)
*	Fix mm ref leak in proc/cmdline			(Prasanna Meda)
*	Fix a tiny race in the timer code		(Ben Herrenschmidt)
*	Fix crash if security_load_policy fails		(Jeff Mahoney)
*	Fix scsi queue return error in ide-scsi		(Jens Axboe)
	and 3w-9xxx
*	Avoid overflow in sg timeouts with large user	(James Bottomley)
	provided timeout
*	Fix statm accounting				(Hugh Dickins)
	| Backported by Jason Baron
*	Fix mlock v VM_IO hang				(Hugh Dickins)
*	Fix Intel i8x0 PCM audio with ALSA		(Takashi Iwai)
*	Fix further visor fix problems			(Roger Luethi)
o	New ATI IXP PCI identifier			(Pascal Lengard)
o	Fix URL for lanana				(Alexander Stohr)
*	Fix via_irqpic to not be __devinit		(Andi Kleen)
*	PPP multilink fixes				(Paul Mackerras)
*	Backport OSS emulation fixes			(Marcel Sebek)

2.6.9-ac11
o	Allow users to force it8212 out of raid mode	(David Howells)
o	On some platforms the flashing keylights	(Alan Cox)
	riggers bogus keyboard warnings. The error
	appears from other stuff too like keyboard
	switches so kill it
o	Add support for ALi 5228 PATA IDE		(Clear Zhang)
o	Add support for newer ALi AGP			(Clear Zhang)
*	Seqpacket and SELinux fix			(James Morris)
o	Fix ide /proc and legacy devices problem	(Alan Cox)

2.6.9-ac10
o	Fix tiny ide-cd race				(Alan Cox)
*	Remove an apparently bogus IDE CD blacklist   (Srihari Vijayaraghavan)
	for a drive confirmed to work
o	Correct vendor of some Cyrix chipsets in docs
*	Error path locking fix for appletalk		(Andries Brouwer)
*	Remove a suspicious __initdata			(Andries Brouwer)
*	Further binfmt_elf work				(Jakub Jelinek)
o	SMBfs overflow fixes				(Stefan Esser)
	| Collated together by Juan Quintela
*	Don't spew debug on bioses with ACPI		(Len Brown)
	breakpoints left in them.
*	Further NFS disconnected dentry fix		(Neil Brown)
*	tmpfs inode accounting leak fix			(Hugh Dickins)
*	x86-64: Fix user triggerable oops on debugger	(Andi Kleen)
	vsyscall page access	
*	Serialize datagram read on AF_UNIX		(Dave Miller)
*	Disable PnP BIOS when using ACPI		(Adam Belay)
*	Fix oops in visor driver caused by DoS fixes	(Roger Luethi)
o	Fix several IDE drivers that assumed > 0 was	(Alan Cox)
	also an error return for pci probe functions
*	Backport netlink updates/fixes from 10rc2	(Herbert Xu,
							 Dave Miller)
*	Backport multihop routing oops fix		(Christian Ehrhardt)
*	Backport TSO fixes				(Herbert Xu)

2.6.9-ac9
*	Linus moved the remap_page_range flag fixes 	(Linus Torvalds)
	into the function. Now this has had some 
	testing do the same in -ac and shrink the
	diff a lot
*	Fix low memory oops in device mapper		(N Cunningham)
*	Fix duplicate kfree in dm-target error path	(Alasdair Kergon)
*	Use a new bio on a md retry			(Neil Brown)
+	Fix mediabay compile				(Alan Cox)
*	Increase EDD array size				(Matt Domsch)
*	Fix locking error/DoS in k15kusb105		(Greg Kroah-Hartmann)
*	Fix locking hang on error path of whiteheat	(Greg Kroah-Hartmann)
*	Use sector_t for md (fixes some large raids)	(Neil Brown)
*	Fix further USB locking errors			(Greg Kroah-Hartmann)
*	Report the right thing on a pnpbios fault	(Andy Whitcroft)
*	Add PCI quirk for VIA audio			(David Shaohua Li)
*	Fix neighbour table counter atomicity		(Herbert Xu)
*	Error out on early exec before rootfs		(Chris Wright)
*	Fix a.out crash with junk binary and 		(Chris Wright)
	virtual memory limits disabled
*	Import atomic_int_return for the neighbour fix	(KaiKai Kohei)

2.6.9-ac8
*	Fix binfmt_exec partial read problem		(Chris Wright)
*	Fix E820 overflow on x86-64 as per x86-32	(Andi Kleen)

2.6.9-ac7
o	Redo the fixups in siimage/it8212 so they	(Alan Cox)
	always actually work
o	Fix up both drives on an IT8212 raid		(Alan Cox)
*	Remove a debug printk/2 sec wait from CS5520	(Alan Cox)
*	Move partial decode test to ide-cs/delkin only	(Alan Cox)
*	Fix partial decode test for no serial number	(Alan Cox)
o	Add support for disks on early rev IT821x	(Alan Cox)
+	Allow ide-disk to be modular again		(Tomas Szepe)
*	Further fixup fixes			(Bartlomiej Zolnierkiewicz)
*	Apple Ipod-mini size reporting fix		(Avi Kivity)
*	Initial (non SMP) cdu31a driver rescue		(Ondrej Zary)
o	Allow READ_BUFFER_CAPACITY to SG_IO users	(Daniel Drake)

2.6.9-ac6
+	Fix problem with -ac5 msdos changes		(Vojtech Pavlik)

2.6.9-ac5
o	Fix oops in and enable IT8212 driver		(Alan Cox)
o	Minor delkin driver fix				(Mark Lord)
*	Fix NFS mount hangs with long FQDN		(Jan Kasprzak)
	| I've used this version as its clearly correct for 2.6.9 
	| although it might not be the right future solution
o	Fix overstrict FAT checks stopping reading of	(Vojtech Pavlik)
	some devices like Nokia phones
*	Fix misdetection of some drives as MRW capable	(Peter Osterlund)
*	Fix promise 20267 hang with very long I/O's	(Krzysztof Chmielewski)
*	Fix a case where serial break was not sent for	(Paul Fulghum)
	the right time.
*	Fix S/390 specific SACF hole			(Martin Schwidefsky)
*	NVidia ACPI timer override			(Andi Kleen)
o	Correct VIA PT880 PCI ident (and AGP ident)	(Dave Jones)
*	Fix EDID/E820 corruption 			(Venkatesh Pallipadi)
*	Tighten security on TIOCCONS			(od@suse.de)
*	Fix incorrect __init s that could cause crash	(Randy Dunlap)

2.6.9-ac4
*	Fix minor DoS bug in visor USB driver		(Greg Kroah-Hartmann)
o	Delkin cardbus IDE support			(Mark Lord)
+	Fix SMP hang with IDE unregister		(Mark Lord)
*	Fix proc file removal with IDE unregister	(Mark Lord)
*	Fix aic7xxx sleep with locks held and debug	(Luben Tuikov)
	spew
o	First take at HPT372N problem fixing		(Alan Cox)

2.6.9-ac3
*	Fix syncppp/async ppp problems with new hangup	(Paul Fulghum)
*	Fix broken parport_pc unload			(Andrea Arcangeli)
*	Security fix for smbfs leak/overrun		(Urban Widmark)
*	Stop i8xx_tco making some boxes reboot on load	(wim@iguana)
*	Fix cpia/module tools deadlock			(Peter Pregler)
+	Fix missing suid_dumpable export		(Alan Cox)

2.6.9-ac2
+	Fix invalid kernel version stupidity		(Adrian Bunk)
*	Compiler ICE workaround/fixup			(Linus Torvalds)
*	Fix network DoS bug in 2.6.9			(Herbert Xu)
	| Suggested by Sami Farin
o	Flash lights on panic as in 2.4			(Andi Kleen)

2.6.9-ac1

Security Fixes
*	Set VM_IO on areas that are temporarily		(Alan Cox)
	marked PageReserved (Serious bug)
o	Lock ide-proc against driver unload		(Alan Cox)
	(very low severity)

Bug Fixes
o	Working IDE locking				(Alan Cox)
	| And a great deal of review by Bartlomiej
o	Handle E7xxx boxes with USB legacy flaws	(Alan Cox)
	
Functionality
o	Allow booting with "irqpoll" or "irqfixup"	(Alan Cox)
	on systems with broken IRQ tables.
o	Support for setuid core dumping in some		(Alan Cox)
	environments (off by default)
*	Support for drives that don't report geometry
o	IT8212 support (raid and passthrough)		(Alan Cox)
o	Allow IDE to grab all unknown generic IDE	(Alan Cox)
	devices (boot with "all-generic-ide")
o	Restore PWC driver				(Luc Saillard)

Other
o	Small pending tty clean-up to moxa		(Alan Cox)
o	Put VIA Velocity (tm) adapters under gigabit	(VIA)

