Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291450AbSBTBu3>; Tue, 19 Feb 2002 20:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291533AbSBTBuQ>; Tue, 19 Feb 2002 20:50:16 -0500
Received: from noodles.codemonkey.org.uk ([62.49.180.5]:41910 "EHLO
	noodles.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id <S291450AbSBTBt4>; Tue, 19 Feb 2002 20:49:56 -0500
Date: Wed, 20 Feb 2002 01:53:58 +0000
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.4-dj3
Message-ID: <20020220015358.A26765@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Back in sync with Marcelo, fix up some merge errors, add some more
janitor bits, and attempt to dig my way through pending backlog
of patches.

By popular request, the curious can now find most of what
was merged in each release at http://www.codemonkey.org.uk/patches/merged/

Patch against 2.5.4 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.4/
Due to the large size of 2.5.5pre, incremental patch from -dj2 also
available in the incr subdir.


 -- Davej.

2.5.4-dj3
o   Merge up to 2.4.18rc2
o   Change <linux/malloc.h> -> <linux/slab.h>	(Me)
o   Fix borken locking in nfs ->lookup.		(Jarno Paananen)
o   Fix ext2 freeing blocks not in datazone.	(Randy Hron, Chris Wright)
o   Fix ext2/ext3 revision level checks.	(Andreas Dilger)
o   Fix ramdisk compilation failure.		(Me, Rudmer van Dijk)
o   More include dependancy tweaks.		(Me)
o   BSS janitor work.				(Craig Christophel)
o   Replace all strtok users with strsep.	(Matthew Hawkins, Jason Thomas)
o   scsi_debug ->address & other fixes.		(Douglas Gilbert)
o   Silence isapnp debug messages.		(Andrey Panin)
o   Clear passcred in sock_alloc()		(OGAWA Hirofumi)
    | Fixes slow sunrpc/portmap, and various
    | gnome-terminal weirdness.
o   Console reentrancy work.			(James Simmons)
o   ALSA Config.in fixes.			(René Scharfe)
o   Fix Oxford Semiconductor PCI id.		(Ed Vance)
o   Power Management for es18xx.		(Zwane Mwaikambo)
o   Remove duplicate PCI ids.			(Wim Van Sebroeck)
o   Change Olympic driver to use spinlocks.	(Mike Phillips)
o   Fix pcilynx locking.			(Manfred Spraul)
o   Fix cris eeprom driver locking.		(Robert Love)
o   PPP/BSD Compression vfree in interrupt fix.	(Paul Mackerras,
						 Dominik Brodowski)
o   cli->spinlocks for aha1542 driver.		(Douglas Gilbert)
o   ALSA ISAPNP fixes.				(Andrey Panin)
o   /proc/net/udp signedness fix.		(Arnaud Giersch)
o   fcntl_[gs]etlk* cleanup.			(Chris Wright)


2.5.4-dj2
o   Merge 2.5.5pre1
    | Includes OSS changes from -dj1 moved to new
    | sound/oss/ directory. These need checking to see
    | if its worth to keep any of them.
o   Backout __free_pages_ok check.			(Hugh Dickins)
o   Improve bad inode handling in open_namei().		(Daniel Mack)
o   Intermezzo module macros cleanup.			(Craig Christophel)
o   fbdev accel wrapper.				(James Simmons)
o   Remove dead code from device.h			(Pavel Machek)
o   Kill BKL in NFS r/w & SunRPC.			(Trond Myklebust)
o   NFSv3 READDIRPLUS support.				(Trond Myklebust)
o   Various pcnet32 cleanups.				(Go Taniguchi)
o   ftape virt_to_bus fixes.				(Mikael Pettersson)
o   Numerous define syntax fixes.			(Timothy Ball)
o   Fix scheduler oops with rw waitqueue spinlocks.	(Bob Miller)
o   Various region/resource cleanups.			(Marcus Alanen)
o   mdacon janitor cleanups.				(Boris Bezlaj)
o   USB OHCI powerbook fix.				(Paul Mackerras)
o   Various config.help updates.			(Steven Cole)
o   Amiga drivers for new input-core layer.		(James Simmons)
o   Split up console.c & vt.c.				(James Simmons)
o   Remove unneeded reiserfs check.			(Oleg Drokin)
o   Make miro radio compile again.			(Gerd Knorr)
o   Vesafb bus_to_virt fix.				(Steven Cole)
o   Advansys virt_to_bus & scatterlist::address fixes.	(Douglas Gilbert)
o   Fix last_pid smp race.				(J.A. Magallon)
o   Various fs list_for_each cleanups.			(Martin Hicks)
o   Display source/dest IP in short UDP packet log.	(David Ford)
    | Modified by me to fit style of similar warnings.
o   Fix up OSS ymfpci.				(Pete Zaitcev, John Weber)
o   Remove FPU usage from neofb.		(Denis Oliver Kropp)


2.5.4-dj1
o   Merge 2.5.4
o   Fix inverted parameters in NCR5380			(Rasmus Andersen)
o   NSC Geode Companion chip workaround.		(Hiroshi MIURA)
    | TODO: Nuke the CONFIG option, replace with
    | PCI detection.
o   Improve kiobuf_init performance.			(Various Intel folks)
o   uidhash cleanup.					(William Lee Irwin III)
o   Fix /proc 'read past end of buffer' bug.		(Thomas Hood)
    | See http://home.t-online.de/home/gunther.mayer/lsescd
o   PnPBIOS updates (ESCD support).			(Thomas Hood)
o   signal.c missing binfmt include compile fix.	(Udo A. Steinberg)
o   thread_saved_pc compile fix.			(Andrew Morton)
o   Various reiserfs updates.				(Oleg Drokin, Namesys)
o   Fix UP Preempt compilation.				(Mikael Pettersson)
o   Kill sleep_on in Olympic TR driver.			(Mike Phillips)
o   Drop 64bit DRM fixes.
o   Fix zftape compile.					(Me)
o   Hack around synclink non-compile.			(Me)


2.5.3-dj5
o   Merge 2.5.4pre5
o   Add some missing MODULE_LICENSE tags	(Hubert Mantel)
o   Fix ptrace PEEKUSR oops.			(Manfred Spraul, others)
o   Drop some bogus bits from USB & netdrivers.	(Me)
o   sbpcd bio fixes.				(Paul Gortmaker)
o   pci id trigraph warning fixes.		(Steven J. Hill)
o   Tridentfb resource management fixes.	(Geert Uytterhoeven)
o   53c700 locking cleanup.			(James Bottomley)
o   Workaround ext2 trying to free block -1	(Andreas Dilger)
o   Fix up deviceio Docbook generation.		(Jason Ferguson)
o   removal of isa_read/writes from ibmtr.	(Mike Phillips)
o   kthread abstraction.			(Christoph Hellwig)




-- 
Dave Jones.                    http://www.codemonkey.org.uk
SuSE Labs.
