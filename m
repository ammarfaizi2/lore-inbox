Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317486AbSFIAfe>; Sat, 8 Jun 2002 20:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317487AbSFIAfd>; Sat, 8 Jun 2002 20:35:33 -0400
Received: from revdns.flarg.info ([213.152.47.19]:24709 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S317486AbSFIAfc>;
	Sat, 8 Jun 2002 20:35:32 -0400
Date: Sun, 9 Jun 2002 01:37:11 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.20-dj4
Message-ID: <20020609003711.GA9870@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sync up with some small bits from latest 2.4pre, a few pending
items, and the initial merge of the CPU frequency scaling code.
This should also fix the problems that various people saw with
capabilities.

There's quite a bit in this diff since -dj3, despite the small
changelog. I want to make sure this stuff is ok before moving on
to the other interesting bits in the queue.

As usual,..

Patch against 2.5.20 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.20-dj4
o   Various bits from 2.4.19-pre10.
o   unbreak sys_capset()				(Me)
o   Merge CPU frequency scaling.			(Russell King,
    | Handle with care, still experimental.		 Arjan van de Ven,
							 Dominik Brodowski,
							 Robert Schwebel,
							 Padraig Brady, Me) 


2.5.20-dj3
o   Uptime >497 days wrap fixes.			(Tim Schmielau)
o   Remove some bogus whitespace diffs.			(Thierry Vignaud, Me)
o   Updated ALSA VIA driver.				(Thierry Vignaud,
							 ALSA folks)
o   Make multiple shared file leases more stable.	(Stephen Rothwell)
o   Fix compilation of bluetooth when compiled in.	(Maksim Krasnyanskiy)
o   Make i2c sysctls dependant upon CONFIG_SYSCTL	(Albert Cranford)
o   Add i2c proc entries to read smbus block data.	(Albert Cranford)
o   Fix quota format config.in entry.			(Alex Riesen)
o   IDE updates up to -84				(Martin Dalecki)
o   Fix make tags to descend into $arch dirs.		(Rusty Russell)
o   Add missing __KERNEL__ guard to byteorder/generic.h	(Dan Kegel)
o   Merge selected bits of kbuild2.5		(Sam Ravnborg, Keith Owens)
    - Dynamic symbol limit for tkparse.
    - depmod & split-include warning fixes.
    - Escape double quotes in config.in files.
    - Add new test targets: allyes, allno, randconfig
o   Make suspend to RAM work again.			(Pavel Machek)
o   Software suspend cleanups.				(Pavel Machek)
o   airo driver janitor work.				(Martin Dalecki)
o   Remove redundant Make rule.				(Adam J. Richter)
o   Add some missing printk levels to fatfs.		(Andrey Panin)
o   Fix oops on writing to floppy.			(Jens Axboe)
o   Fix compilation of kernel-api docbook.		(Juan Quintela)
o   Further floppy driver fixes.			(Mikael Pettersson)
o   Remove bogus casts in ide-cd			(Peter Chubb)
o   eicon driver was kfree'ing wrong skb.		(Adar Dembo)
o   Death of (f)suser()					(Robert Love)
    | And there was much rejoicing in kernel janitor land.
o   postcore_initcall changes for PCI & sys_bus.	(Patrick Mochel)


2.5.20-dj2
o   Use page_to_pfn in BIO code.			(Anton Blanchard)
o   Fix framebuffer oops.				(A Guy Called Tyketto)
o   PCI device matching fixes.				(Patrick Mochel,
							 Andrew Morton)
o   SIS 745 AGPGART support.				(Carsten Rietzschel)
o   64bit fixes for swap ops.				(Anton Blanchard)
o   Add i8253 spinlocks where needed.			(Vojtech Pavlik)
o   Region handling cleanup for UMC 8672 IDE driver.	(William Stinson)
o   Region handling cleanup for hd.c			(William Stinson)
o   fcntl() POSIX correctness fix.			(Andries Brouwer)
o   Region handling cleanup for eexpress		(William Stinson)
o   PCI pool 64 bit warning fix.			(Frank Davis)
o   Trivial PCI quirk cleanup.				(Ghozlane Toumi)
o   Update URLs to Linux documentation project.		(Gianni Tedesco)
o   Plug scsi_scan memory leak.				(Patrick Mansfield)
o   Region handling cleanup for inia100.		(William Stinson)
o   Make daemonize() do reparent_to_init() for caller.	(Rusty Russell)
    | same done for hvc_console & cpqphp_ctlr		(Me)
o   copy_siginfo_to_user() cleanup.			(Stephen Rothwell)
o   Clean up capability locking.			(Robert Love)
o   Check dcache allocation success before using.	(Dan Aloni)

2.5.20-dj1
o   Drop some more bogus bits found whilst patch-splitting.
o   emu10k1 compile fix.				(Alistair Strachan)
o   Framebuffer updates.				(James Simmons)
o   Drop some bogus kbuild bits.			(Kai Germaschewski)
o   Unobsolete egcs kernel builds.			(Me)
    | This can be worked around, and this is compiler 
    | of choice on sparc and other archs.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
