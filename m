Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289973AbSBFDDl>; Tue, 5 Feb 2002 22:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289982AbSBFDDb>; Tue, 5 Feb 2002 22:03:31 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:42684 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S289973AbSBFDDO>; Tue, 5 Feb 2002 22:03:14 -0500
Date: Wed, 6 Feb 2002 03:02:53 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.3-dj3
Message-ID: <20020206030252.A15192@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sync up some of the bits done in the 2.4 branch, fix up more build problems,
and merge some bits that were hanging around. Biggest change here is the
addition of the radix-tree patch. It looks that Linus has merged it, so
jumping the gun is no big deal on this one.
(Early adopters get to shake out the bugs before -pre1 appears 8-)

Patch against 2.5.3 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

 -- Davej.

2.5.3-dj3
o   Merge 2.4.17-pre8
o   Merge some small bits from 2.4.18-pre7-ac3
o   Drop sd-many patch.
    | Not relevant for 2.5, + a better alternative
    | is in the works from Christoph Hellwig.
o   Merge radix tree page cache.		(Momchil Velikov)
o   inflatefs doesn't need its own zconf.h	(Me)
o   Add missing includes to ymfpci & opl3sa2.	(Michal Jaegermann)
o   Fix DRM warnings on 64bit compiles.		(Michal Jaegermann)
o   Fix highmem compile.			(Me)
    | Ugly, needs fs.h untangling.
o   NSC Geode recognition/support.		(Hiroshi MIURA)
o   Hack around ZISOFS link order problem.	(Todor Todorov)
o   Increase inline name length for the dcache.	(Andi Kleen)
o   Reduce mount hash table size.		(Andi Kleen)
o   cosa.c compile error fix.			(Adrian Bunk)
o   initcall initialisation off by one fix.	(Bjorn Wesen)
o   Unbreak compilation of iptables userspace.	(Harald Welte, Rusty Russell)
o   Yet more reiserfs updates.			(Oleg Drokin & Namesys folks)
o   Fix large LUNs breakage.			(Kurt Garloff)
o   Clean up simple_strtol exports.		(Russell King)


2.5.3-dj2
o   More include file shake-ups.		(Me)
    | Break binfmt out of sched.h
    | Divorce fs.h from linux/capability.h
    | fs.h fathers err.h
o   Fix some include breakage from -dj1.	(Jarno Paananen)
o   Fix LVM compile.				(Dave Gilbert)
o   Numerous Lanstreamer fixes.			(Kent Yoder)
o   Support large numbers of SCSI devices.	(Richard Gooch)
o   CRC32 late initialisation fix.		(Petr Vandrovec)
o   qnx4fs update.				(Anders Larsen)
o   Iforce joystick compile fix.		(Vojtech Pavlik)
o   Numerous NFS fixes.				(Trond Myklebust)
o   No CONFIG_PCI compile fix.			(Adrian Bunk)
o   NBD request size limit fix.			(Petr Vandrovec)
o   Selectable port/irq for i8042.		(James Simmons)
o   Improved free page accounting.		(Ed Tomlinson)
o   Convert various strtok --> strsep.		(René Scharfe)


2.5.3-dj1
o   Merge 2.5.3final
    | Drop NCR5380 changes for now. For reasons why, read
    | http://kt.zork.net/kernel-traffic/kt20020121_151.html#4
o   MAINTAINERS updates.				(Me, Ingo Molnar)
o   Move IA64 perfmon init out of init/main.c		(Me)
o   Several #include linux/malloc.h -> linux/slab.h	(Me)
o   Remove bogus duplicate dmi_scan()			(Me)
o   Remove duplicate code in bootsect.S			(Rob Landley)
o   ScanLogic USB-ATAPI adapter support.		(Leif Sawyer)
o   Shrink dqcache by priority.				(Josh MacDonald)
o   Fix up BKL removal breakage in HFS & UFS.		(Robert Love, Me)
o   Config.help updates for GUID partition support.	(Matt Domsch)
o   Updated USB driverfs support.			(Greg KH)
o   Fix modular USB build.				(Jim McDonald)
o   Handle error case in sys_swapon()			(Andrey Panin)
o   i810_audio build fix.				(Martin Bahlinger)
o   text.lock->subsection improvements.			(Keith Owens)
o   Support an extra mystery rocketport card.		(Andi Kleen)
o   zlib_inflate build fix.				(Andi Kleen)
o   Remove inclusion of sched.h for most of fs/		(Me)
    | pushes CURRENT_TIME into wait.h
    | There's still work to do here.
o   Debug trap for vfree.				(Arjan van de Ven)
o   Make xconfig find help texts again.			(Olaf Dietsche)
o   Fix nbd breakage.					(Petr Vandrovec)
o   IBM partition compile fix.				(Sergey S. Kostyliov)
o   More reiserfs fixes.				(Oleg Drokin)


2.5.2-dj7
o   Merge 2.5.3pre6
o   Remove fs.h inclusion from sched.h again.		(Christoph Hellwig)
o   Remove some segment.h inclusions that reappeared.	(Me)
o   Unmangle dl2k crc fix from -dj6			(Jim McDonald)
o   Fix tsdev compile.					(Me)
o   aty128fb & radeonfb compile fixes.			(James Simmons)
o   Updated Config.help entries for input layer.	(Vojtech Pavlik)
o   Input layer tweak for old IBM keyboards.		(Vojtech Pavlik)
o   Fix USB HID feature report output.			(Vojtech Pavlik)
o   Workaround some broken PS/2 mice.			(Vojtech Pavlik)
o   Don't filter outgoing fields to HID defined ranges.	(Vojtech Pavlik)
o   Disable address in scatterlist for sg.		(Douglas Gilbert)
o   Limit NR_IRQS in no IO-APIC case.			(Brian Gerst)
o   Sonypi driver update (C1MRX Vaio).			(Stelian Pop)
o   Remove bogus release_region in eexpress.		(Gianluca Anzolin)
o   Neofb compile fixes.				(James Simmons)
o   Reiserfs update.					(all@namesys)
o   Further reiserfs fixes.				(Oleg Drokin)
o   Fix keyboard not working with nothing in AUX port.	(Vojtech Pavlik)
o   Small devfs changes.				(Richard Gooch)
o   Rage128 Pro TF identification to aty128fb.		(James Simmons)




-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
