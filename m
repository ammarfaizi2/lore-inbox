Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSJDQAy>; Fri, 4 Oct 2002 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSJDQAy>; Fri, 4 Oct 2002 12:00:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:471 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261572AbSJDQAw>; Fri, 4 Oct 2002 12:00:52 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210041606.g94G6La28943@devserv.devel.redhat.com>
Subject: Linux 2.5.40-ac3
To: linux-kernel@vger.kernel.org
Date: Fri, 4 Oct 2002 12:06:20 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This merges a lot of the small fixes, and its mostly aimed at getting
more stuff building and working, as well as fixing some of the oopses 
people reported that aren't fixed in a Linus release tree yet.

Linux 2.5.40-ac3
o	Resync telephony drivers with 2.4		(me)
	| Forward port security and other minor fixes
o	Fix aironet4500 build for tq changes		(me)
o	Fix keyspan USB warnings with gcc 3		(me)
o	Switch to the newer 2.4 depca driver		(me)
o	Re-merge depca fixes from 2.5.0->2.5.40]
o	Fix depca spinning waiting for irq probe	(me)
o	Fix depca copy with interrupts off		(me)
o	Fix depca clash with other ALIGN macros		(me)
o	Initial port of NCR5380/g_NCR5380 to new locks	(me)
	| This still needs new_eh, further clean up
	| and possibly making NCR5380_main a thread
o	Initial locking rework for the wd7000 scsi	(me)
	| Still needs new_eh
o	Update jffs to the dequeue_signal changes	(me)
o	Update jffs2 to the dequeue_signal changes	(me)
o	Fix shpnt misuse in NCR53c406a, wrong free_irq	(me)
o	Update NCR53c406a to new style sglist		(me)
	| Still needs new_eh
o	Architecture updates for S/390			(Martin Schwidefsky)
o	Include updates for S/390			(Martin Schwidefsky)
o	Base S/390 driver updates			(Martin Schwidefsky)
o	Add the new syscalls to S/390			(Martin Schwidefsky)
o	Fix sleeping with locks in sound_core		(Jaroslav Kysela)
o	Fix oops on shutdown of cs4281			(Suresh Siddha)
o	Fix cdrom paths in devfs			(Jordan Breeding)
o	Fix missing cache tag entry in intel cpu table	(Jean Delvare)
o	Remove old 2.2 compatibility pci functions	(Greg Kroah-Hartmann)
o	Clean up some dead devfs bits			(Greg Kroah-Hartmann)
o	Fix an oops in the hugetblpage stuff		(Andrew Morton)
	| Its still a stupid idea but now it doesnt oops
o	Handle read only BARs with type bits set	(Ivan Kokshaysky)

Linux 2.5.40-ac2
o	Fix a cut and paste error in the amd rng docs	(Troels Hansen)
o	Forward port OSS maestro3 fixes for toughbook
o	Forward port ramdisk cache coherency
o	RTL8150 USB updates				(Petko Manalov)
o	Fix corega USB ident				(Petko Manalov)
o	USB keyboard driver fix				(Dave Miller)
o	USB prototype fix				(Luc Vanoostenryck)
o	USB string fixes		(cip307@cip.physik.uni-wuerzburg.de)
o	USB test driver					(David Brownell)
o	Speedtouch USB driver fixes			(Greg Kroah-Hartmann)
o	Clean environment for hotplug			(Greg Kroah-Hartmann)
o	Fix mprotect oops				(Hugh Dickins)
o	NUMA-Q cleanups					(Martin Dobson)
o	Split timers into one x86 timer type per file	(John Stultz)
o	Cyclone timer support for x440 etc		(John Stultz)
o	Fix sleeping from illegal context for ioperm	(Andrew Morton)
o	Fix imm compile				(bonganilinux@mweb.co.za)
o	Fix irda for tq changes				(Carlos Gorges)
o	Fix xjack telephony build			(Carlos Gorges)
o	Fix ppa compile					(Carlos Gorges)
o	Fix aha152x compile for tq changes		(Carlos Gorges)
o	Fix hamradio drivers for tq changes		(Carlos Gorges)
o	Fix plip driver for tq changes			(Carlos Gorges)
o	Fix mpt fusion for tq changes			(Carlos Gorges)
o	Fix isdn for tq changes				(Carlos Gorges)
o	Fix ieee1394 for tq changes			(Carlos Gorges)
o	Fix new timer code to build with cpufreq on	(me)
o	Fix capi build for new tq_ code			(me)
	| ISDN still needs moving to real locks
	| this just cleans up one item
o	Fix missing header in mtdblock_ro		(Carlos Gorges)
o	Fix a typo and other header			(me)
o	Fix up ixj_pcmcia for 2.5			(me)
	| Note for janitors - it looks like a lot of the pcmcia release
	| code people "fixed" should be using del_timer_sync not del_timer
o	Fix missing header in longhaul cpu speed driver	(me)
o	Pipe read/write cleanup				(Manfred Spraul)
o	Make IDE PCI config text clearer	(Andrzej Krzysztofowicz)

Linux 2.5.40-ac1
+	Initial port of aacraid driver to 2.5		(me)
+	vfat corruption fix				(Petr Vandrovec)
+	Clean up firestream warnings			(Francois Romieu)
+	Voyager support					(James Bottomley)
+	Fix split_vma					(Hugh Dickins)
+	Fix config in video subdirectory		(John Levon)
+	Update olympic driver to 2.5			(Mike Phillips)
+	Fix sg init error				(Mike Anderson)
+	Fix Rules.make
o	Merge most of ucLinux stuff			(Greg Ungerer)
	| It needs putting somewhere so we can pick over the
	| hard bits left
	| Q: Wouldn't drivers/char/mem-nommu.c be better
	| Q: How to do the procfs stuff tidily
	| Q: Wouldn't it be nicer to move all mm or mmnommu specific ksyms
	|    int the relevant mm/*.c file area instead of kernel/ksyms
	| Q: Why ifdef out overcommit -  its even easier to account on 
	|    MMUless and useful info
+	Stick tulip back under 10/100 ethernet		(me)
+	Correct docs for IBM touchpad back to how	(me)
	they were before
o	Fix abuse of set_bit in winbond-840		(me)
+	Fix abuse of set_bit in atp			(me)
