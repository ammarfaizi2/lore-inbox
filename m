Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261309AbSJCPpL>; Thu, 3 Oct 2002 11:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSJCPpK>; Thu, 3 Oct 2002 11:45:10 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:62366 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261309AbSJCPpJ>; Thu, 3 Oct 2002 11:45:09 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210031550.g93FoeP32003@devserv.devel.redhat.com>
Subject: Linux 2.5.40-ac2
To: linux-kernel@vger.kernel.org
Date: Thu, 3 Oct 2002 11:50:40 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This merges a lot of the small fixes, and its mostly aimed at getting
more stuff building and working, as well as fixing some of the oopses 
people reported that aren't fixed in a Linus release tree yet.

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

--
  "In the same way it might be interesting to see what happens if you put
 		  cigarette into gasoline tank?"
			  --  Pavel Machek
