Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTEFVum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTEFVum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:50:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:63635 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S262016AbTEFVue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:50:34 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200305062203.h46M37g25953@devserv.devel.redhat.com>
Subject: Linux 2.5.69
To: linux-kernel@vger.kernel.org
Date: Tue, 6 May 2003 18:03:07 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This should be treated as handle with care - the IDE taskfile stuff is
important but the earlier revision did tickle some PIO problems. The
fixes aren't known to be 100% so drive carefully

2.5.69-ac1
	- Rebuilt from 2.5.69 base adding -ac stuff on top
o	Fix linking errors				(Andi Kleen)
o	Make mwave compile again			(me)
o	Fix PIO IDE corruption (hopefully)	(Bartlomiej Zolnierkiewicz)
o	Update Quadrics pci.ids to those requested by	(Daniel Blueman)
	Quadrics
o	Fix ibmtr_cs build				(Jochen Hein)
o	Wolfson codec updates				(Liam Girdwood)
o	Fix iphase stack usage				(Chas Williams)
o	Fix dc395 oops					(Oliver Neukum)
o	C99 initialisers for random			(Art Haas)
o	C99 initialiser for libfs			(Art Haas)
o	Fix up pcmcia drivers for IRQ changes		(Zwane Mwaikambo)
o	Use mod_timer in PC98 floppy			(Vinay Nallamothu)
o	Use mod_timer in sdla drivers			(Vinay Nallamothu)
o	Use mod_timer for AF_WANPIPE			(Vinay Nallamothu)
o	Use mod_timer for mpt fusion			(Vinay Nallamothu)
o	Use request_region in sbc_gxx			(Bob Miller)
o	Use request_region in octagon-5066		(Bob Miller)
o	Use request_region in elan-104nc		(Bob Miller)
o	Use request_region in ipmi			(Bob Miller)
o	Update H8/300 ucLinux support			(Yoshinori Sato)
o	Add base ICH5 audio support			(Martin Schlemmer)
o	Fix debug/return order in cpia_pp		(Gabriel Devenyi)
o	Fix return before gameport_close 		(Gabriel Devenyi)
o	Fix debug after return in arlan			(Gabriel Devenyi)
o	Fix atm svc race with sigd			(Chas Williams)
o	Put syscall table in R/O section		(David Howells)
o	PCMCIA rework to fix plug/unplug deadlock	(Russell King)
o	C99 initialisers for drivers/media dvb code	(Art Haas)
o	More C99 initialisers for audio			(Art Haas)
o	Set data direction properly on sync cache	(Heiko Carstens)
o	Nuke various dead scsi externs			(Christoph Hellwig)
o	Handle Seagate ATA IV errata on CSB5		(Duncan Laurie)
o	Fix con2fb crash with unallocated VT		(Petr Vandrovec)
o	Initial SH3 resync				(Paul Mundt)
o	Update aha1740 to new DMA etc			(Marc Zyngier)
o	Update meye drivers				(Stelian Pop)
o	Update SH maintainers				(Paul Mundt)
o	Fix ISA audio requirements for PC9800		(Osamu Tomita)
o	Large numbers of ia64 typo fixes		(Steven Cole)
o	Remove duplicate include in mpu401.h		(Art Haas)
o	C99 initialisers for amd8111e			(Art Haas)
o	C99 initialisers for MTD			(Art Haas)
o	FAT search speedups for MSDOS fs		(Björn Stenberg)
o	Rewrite i386 user space access to fix races	(Manfred Spraul)
o	Ressurrect dmasound driver			(Geert Uytterhoeven)
o	S/390 typo fixes				(Steven Cole)
o	Some of the v850 update queue			(Miles Bader)
o	Fix ps2esdi build				(Michael Buesch)
o	Fix lba48 issue to check end sector/num sector	(Jens Axboe)
o	Fix get/sethostname error paths			(Stephan Maciej)
o	x86-64 build fixes				(Mikael)
o	Fix ACPI IRQ returns				(Andrew Morton)
o	Use mod_timer in synclink driver		(Vinay Nallamothu)
o	Remove bogus return in bpck6			(Gabriel Devenyi)
o	Add i855PM AGP					(Bill Nottingham)
o	Netlink hooks for using netlink to report	(Dave Miller)
	error messages
	| Not useful in itself but a kick off point
o	Make videodev_proc_destroy __exit		(Tom Rini)

The following -ac changes are present

X86_HAL support for Linux in BOCHS
Unisys ES7000 support
Various config doc fixes
APM handling for more broken setups
APM handling for PC9800
Updated Unexpected I/O APIC detection
Support for rejecting/pinning tasks on iopl/ioperm (for NUMA)
PC9800 SMP parsing
Short jump for lock loops
PC9800 GDC console
Corrected K7 checks for SMP
Alternative Athlon fast copy
Always write PCI_INTERRUPT_LINE for pseudo PCI
sys_sched_affinity 32/64 fixes
Stack use on sh
BIO updates
Taskfile I/O for IDE
Fix iforce doc formatting
Console blank key for laptops
Morse code errors
PC9800 console
Newer Sony PI driver
Fix IDE attachment list corruptions
Fix ide /proc identify 
Cleaned up ide-cs
Synaptics mouse enable fix
Warning fixes for mtd
Updated drivers for 3c523/7
EISA framewaork aware depca
PC9800 parport
PCI quirks for smbus hiding
First bits of work on dpt_i2o for 2.5 DMA
AFFS updates
Stack limits for parisc
ipc bits (need review)
ikconfig (Config in /proc etc)
SIGCHLD for kmod
Definitions for PRIO ranges
Streams bits
vsscanf fixes
RPMBUILD not RPM for macro name
Kconfig help fixes
Fix pnp_card_register_driver/unload stuff for ALSA (needs review)
