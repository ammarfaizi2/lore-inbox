Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbUKKQXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbUKKQXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 11:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbUKKQXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 11:23:52 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:41171 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262274AbUKKQWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 11:22:03 -0500
Subject: Linux 2.6.9-ac8
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100186344.22254.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 11 Nov 2004 15:19:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This just adds the binfmt fixes from Chris Wright. The other pending
changes have been bumped to ac9

Various chunks of new IDE stuff and related cleanups. Most users probably
don't want to upgrade to this kernel

ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.6/2.6.9/

2.6.9-ac8
o	Fix binfmt_exec partial read problem		(Chris Wright)
o	Fix E820 overflow on x86-64 as per x86-32	(Andi Kleen)

2.6.9-ac7
o	Redo the fixups in siimage/it8212 so they	(Alan Cox)
	always actually work
o	Fix up both drives on an IT8212 raid		(Alan Cox)
o	Remove a debug printk/2 sec wait from CS5520	(Alan Cox)
o	Move partial decode test to ide-cs/delkin only	(Alan Cox)
o	Fix partial decode test for no serial number	(Alan Cox)
o	Add support for disks on early rev IT821x	(Alan Cox)
o	Allow ide-disk to be modular again		(Tomas Szepe)
o	Further fixup fixes			(Bartlomiej Zolnierkiewicz)
o	Apple Ipod-mini size reporting fix		(Avi Kivity)
o	Initial (non SMP) cdu31a driver rescue		(Ondrej Zary)
o	Allow READ_BUFFER_CAPACITY to SG_IO users	(Daniel Drake)

2.6.9-ac6
o	Fix problem with -ac5 msdos changes		(Vojtech Pavlik)

2.6.9-ac5
o	Fix oops in and enable IT8212 driver		(Alan Cox)
o	Minor delkin driver fix				(Mark Lord)
o	Fix NFS mount hangs with long FQDN		(Jan Kasprzak)
	| I've used this version as its clearly correct for 2.6.9 
	| although it might not be the right future solution
o	Fix overstrict FAT checks stopping reading of	(Vojtech Pavlik)
	some devices like Nokia phones
o	Fix misdetection of some drives as MRW capable	(Peter Osterlund)
o	Fix promise 20267 hang with very long I/O's	(Krzysztof Chmielewski)
o	Fix a case where serial break was not sent for	(Paul Fulghum)
	the right time.
o	Fix S/390 specific SACF hole			(Martin Schwidefsky)
o	NVidia ACPI timer override			(Andi Kleen)
o	Correct VIA PT880 PCI ident (and AGP ident)	(Dave Jones)
o	Fix EDID/E820 corruption 			(Venkatesh Pallipadi)
o	Tighten security on TIOCCONS			(od@suse.de)
o	Fix incorrect __init s that could cause crash	(Randy Dunlap)

2.6.9-ac4
o	Fix minor DoS bug in visor USB driver		(Greg Kroah-Hartmann)
o	Delkin cardbus IDE support			(Mark Lord)
o	Fix SMP hang with IDE unregister		(Mark Lord)
o	Fix proc file removal with IDE unregister	(Mark Lord)
o	Fix aic7xxx sleep with locks held and debug	(Luben Tuikov)
	spew
o	First take at HPT372N problem fixing		(Alan Cox)

2.6.9-ac3
o	Fix syncppp/async ppp problems with new hangup	(Paul Fulghum)
o	Fix broken parport_pc unload			(Andrea Arcangeli)
o	Security fix for smbfs leak/overrun		(Urban Widmark)
o	Stop i8xx_tco making some boxes reboot on load	(wim@iguana)
o	Fix cpia/module tools deadlock			(Peter Pregler)
o	Fix missing suid_dumpable export		(Alan Cox)

2.6.9-ac2
o	Fix invalid kernel version stupidity		(Adrian Bunk)
o	Compiler ICE workaround/fixup			(Linus Torvalds)
o	Fix network DoS bug in 2.6.9			(Herbert Xu)
	| Suggested by Sami Farin
o	Flash lights on panic as in 2.4			(Andi Kleen)

2.6.9-ac1

Security Fixes
o	Set VM_IO on areas that are temporarily		(Alan Cox)
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
o	Support for drives that don't report geometry
o	IT8212 support (raid and passthrough)		(Alan Cox)
o	Allow IDE to grab all unknown generic IDE	(Alan Cox)
	devices (boot with "all-generic-ide")
o	Restore PWC driver				(Luc Saillard)

Other
o	Small pending tty clean-up to moxa		(Alan Cox)
o	Put VIA Velocity (tm) adapters under gigabit	(VIA)

