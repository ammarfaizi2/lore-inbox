Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287685AbRLaXGg>; Mon, 31 Dec 2001 18:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287683AbRLaXG1>; Mon, 31 Dec 2001 18:06:27 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:53400 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S287682AbRLaXGP>; Mon, 31 Dec 2001 18:06:15 -0500
Date: Mon, 31 Dec 2001 23:08:28 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.1-dj10
Message-ID: <20011231230828.A32184@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Next bunch of pending fixes and the likes. Now that the merging has
started, some bits are also getting dropped. 

Patch against 2.5.1 vanilla is available from:
http://www.codemonkey.org.uk/patches/2.5/patch-2.5.1-dj10.diff.bz2

Enjoy, and happy new year,
  -- Davej.

2.5.1-dj10
o   Sync against 2.5.2-pre5
o   Remove one of the NFS changes. Better fix in mainline.	(Me)
o   Add switch to enable 486 string copies.			(Me)
    | 486 users please try this out, and give feedback
    | so we can see how broken this actually is.
    | It's in the 'kernel hacking' menu.
o   JFFS2 corruption fix.			(David Woodhouse)
o   Bridging CONFIG_INET cleanup.		(Lennert Buytenhek)
o   Briding recursion bugfix.			(Lennert Buytenhek)
o   Fix up port state handling.			(Lennert Buytenhek)
o   Improved fbdev init.			(James Simmons)
o   PNPOS simple bootflag fix.			(Thomas Hood)
o   Drop most of the USB changes on Greg's request.
    | Newer versions should appear in -linus soon.
    | Some bits still remain, but if I've broke it, blame
	| me and not Greg.
o   Experimental preload_cache() function.	(Me)
o   Ugly hack to file_read_actor() to use the above	(Me)
    | Just playing, this needs more work.


2.5.1-dj9
o   Merge up to 2.5.2pre4.
    | Also fix up a bunch of build errors.
o   Add support for Sony DSC-P5 to USB unusual devs.	(Gregor Jasny)
o   First part of new console locking infrastructure.	(James Simmons)
o   Cleaner/Lighter fbdev api.				(James Simmons,
							 Geert Uytterhoeven)
o   Don't coredump framebuffer contents.		(Andrew Morton)
o   Fix hang on close of serial tty.			(Russell King)
o   Remove the set_current_state() patch, needs work.	(Me)
o   Drop ICH2 addition to ioapic Whitelist. 		(Me)
o   Do the asm/segment.h crapectomy properly.		(David Woodhouse)
o   Reactivate the PNPBIOS Configure.help entry.


2.5.1-dj8
o   Remove leftover EISA cruft in x86 ksyms.		(Me)
o   Add a missing part of the split visws support.	(Me)
o   Make reiserfs partitions mountable again.		(Al Viro,
							 Andrew Morton, Me)
o   Make x86 math emulation work with dynamic LDT.	(Manfred Spraul)
o   Fix problems with tdfxfb & high pixelclocks.	(Jurriaan)
    | Only tested on PCI 4500, feedback to thunder7@xs4all.nl
o   Replace text.lock with .subsection			(Keith Owens)
o   Remove Cyrix SLOP workaround.			(Me)
    | Can be done in userspace/initramfs.
o   Merge pnpbios support.				(Thomas Hood)
    | Should work, but may be nice to bend into shape
    | to fit the new driverfs model at some point.


2.5.1-dj7
o   Merge 2.5.2pre3
    | Drop some of the reiserfs changes. Looks like -dj has
    | a more complete set of fixes from 2.4. This is getting
    | a little hairy, so handle with care.
o   Make rootfs compile.				(Me)
o   Dynamically grow LDT.				(Manfred Spraul)
o   Randomness for ext2 generation numbers.		(Manfred Spraul)
o   Give Manfreds threaded coredump a retry.		(Manfred Spraul)
o   Add missing ad1848 formats.				(Alan Cox)
o   Make ide-floppy compile without PROC_FS.		(Robert Love)
o   generic_serial, rio_linux, serial_tx3912,		(Rasmus Andersen)
    sh-sci and sx drivers janitor work.
o   opl3sa2 Power management support & update.		(Zwane Mwaikambo)
    | Add Zwane to MAINTAINERS for this too.
o   Fix buggy MODINC i2o_config macro.			(Andreas Dilger)
o   Cyclades driver /proc/ioports oops fix.		(Andrew Morton)
    | Untested afaik, but looks sane.
    | rmmod cyclades.o ; cat /proc/ioports to see if this works.
o   SX driver, DCD-HylaFAX problem solved.		(Heinz-Ado Arnolds)
o   Only look in 1KB of EBDA for MP table.		(Zwane Mwaikambo) 
    | Follows the MP1.4 Spec closer, let me know of any
    | SMP problems if any with this change.
o   Better fix for the sunrpc 'missing include'.	(David Woodhouse)
o   Remove bogus <asm/segment.h> includes.		(David Woodhouse)
o   ps2esdi spinlock typo.				(Me)


2.5.1-dj6
o   Merge 2.5.2pre2
    | Includes updated for 2.5 SCSI debug driver.	(Douglas Gilbert)
o   Merge 2.4.18pre1
o   Missing include in sunrpc sched.c			(David S. Miller)
o   Remove incorrect devinit's from bttv & USB.		(Andrew Morton)
o   Remove redundant EISA_bus__is_a_macro macro.	(Me)
o   Split visws support to setup-visws.c		(Me)
    | Can someone with one of these beasts test this, and maybe
    | even *gulp* maintain it ?
o   pc110pad spinlock thinko				(Peter T. Breuer)
o   Fix reiserfs + highmem possible oops.		(Oleg Drokin)
o   Fix reiserfs fsx breakage.				(Oleg Drokin)
o   Make IPV6 accept timestamps in response to SYNs.	(Alexey Kuznetsov)
o   NCR5380_timer_fn needs to be static.		(Rasmus Andersen)
o   CONFIG_SERIAL_ACPI is IA64 only.			(Me)


2.5.1-dj5
o   Sync up to 2.5.2pre1
o   Merge 2.4.17final.
o   Gravis ultrasound PnP update		(Andrey Panin)


2.5.1-dj4
o   Merge with 2.4.17-rc2
    | Most was already here, more or less just fixes for
    | reiserfs & netfilter, and some VM changes.


2.5.1-dj3
o   Drop Manfreds multithread coredump changes		(Me)
    | They caused ltp waitpid05 regression on 2.5
    | (Same patch is fine for 2.4)
o   Intermezzo compile fix.				(Chris Wright)
o   Fix ymfpci & hisax merge errors.			(Me)
o   Drop ad1848 sound driver changes in favour of 2.5	(Me)
o   Make hpfs work again.				(Al Viro)
o   Alpha Jensen compile fixes.				(Ronald Lembcke)
o   Make NCR5380 compile non modularly.			(Erik Andersen)


2.5.1-dj2
o   bio fixes for qlogicfas.			(brett@bad-sports.com)
o   Correct x86 CPU helptext.			(Me)
o   Fix serial.c __ISAPNP__ usage.		(Andrey Panin)
o   Use better ide-floppy fixes.		(Jens Axboe)
o   Make NFS 'fsx' proof.			(Trond Mykelbust)
    | 2 races & 4 bugs, hopefully this is all.
o   devfs update				(Richard Gooch)
o   Backout early CPU init, needs more work.	(Me)
    | This should fix several strange reports.
o   drop new POSIX kill semantics for now	(Me)


2.5.1-dj1
o   Resync with 2.5.1
    | drop reiserfs changes. 2.4's look to be more complete.
o   Fix potential sysvfs oops.				(Christoph Hellwig)
o   Loopback driver deadlock fix.			(Andrea Arcangeli)
o   __devexit cleanups in drivers/net/			(Daniel Chen,
    synclink, wdt_pci & via82cxxx_audio 		 John Tapsell)
o   Configure.help updates				(Eric S. Raymond)
o   Make reiserfs compile again.				(Me)
o   bio changes for ide floppy					(Me)
    | handle with care, compiles, but is unfinished.
o   Make x86 identify_cpu() happen earlier			(Me)
    | PPro errata workaround & APIC setup got a little
    | cleaner as a result.
o   Blink keyboard LEDs on panic				(From 2.4.13-ac)
o   Change current->state frobbing to set_current_state()	(From 2.4.13-ac)
o   Add MODULE_LICENSE tags for acpi,md.c,fmvj18x,		(From 2.4.13-ac)
    atyfb & fbmem.


-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
