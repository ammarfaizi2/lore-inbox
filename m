Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130767AbRA2VwO>; Mon, 29 Jan 2001 16:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130922AbRA2VwE>; Mon, 29 Jan 2001 16:52:04 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40207 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130767AbRA2Vvv>; Mon, 29 Jan 2001 16:51:51 -0500
Date: Mon, 29 Jan 2001 13:51:41 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12: SiS pirq handling..
Message-ID: <Pine.LNX.4.10.10101291348330.9791-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Could people that had problems with SiS interrupt handling before please
give 2.4.0-test12 a final whirl before I release it as 2.4.1? We got a lot
of pirq tables from people, and Martin Diehl put them together with the
hardware specs to come up with what looks to be the "final and correct"
SiS pirq routing, but as always it would be good to have this verified by
as many people as possible.

The other changes in pre12 aren't likely to be all that noticeable, unless
you happen to be hit by just that detail.. As always, fedback is
appreciated.

		Linus


----
pre12:
 - Get non-cpuid Cyrix probing right (it's not a NexGen)
 - Jens Axboe: cdrom tray status and queing cleanups
 - AGP GART: don't disable VIA, and allow i815 with external AGP
 - Coda: use iget4() in order to have big inode numbers without clashes.
 - Fix UDF writepage() page locking
 - NIIBE Yutaka: SuperH update
 - Martin Diehl and others: SiS pirq routing fixes
 - Andy Grover: ACPI update
 - Andrea Arkangeli: LVM update
 - Ingo Molnar: RAID cleanups
 - David Miller: sparc and networking updates
 - Make NFS really be able to handle large files

pre11:
 - Trond Myklebust: NFS/RPC client SMP fixes
 - rth: alpha pyxis and cabriolet fixes
 - remove broken sys_wait4() declarations
 - disable radeon debugging code
 - VIA IDE driver should not enable autodma unless asked for
 - Andrey Savochkin: eepro100 update. Should fix the resource timing problems.
 - Jeff Garzik: via82cxxx_audio update
 - YMF7xx PCI audio update: get rid of old broken driver, make new
   driver handle legacy control too. 
 - fix missed wakeup on block device request list
 - hpt366 controller doesn't play nice with some IBM harddisks
 - remove inode pages from the page cache only after having removed them
   from the page tables.
 - shared memory out-of-swap writepage() fixup (no more magic return)

pre10:
 - got a few too-new R128 #defines in the Radeon merge. Fix.
 - tulip driver update from Jeff Garzik
 - more cpq and DAC elevator fixes from Jens. Looks good.
 - Petr Vandrovec: nicer ncpfs behaviour
 - Andy Grover: APCI update
 - Cort Dougan: PPC update
 - David Miller: sparc updates
 - David Miller: networking updates
 - Neil Brown: RAID5 fixes

pre9:
 - cpq array driver elevator fixes 
 - merge radeon driver from X CVS tree
 - ispnp cleanups
 - emu10k unlock on error fixes
 - hpfs doesn't allow truncate to larger

pre8:
 - Don't drop a megabyte off the old-style memory size detection
 - remember to UnlockPage() in ramfs_writepage()
 - 3c59x driver update from Andrew Morton
 - egcs-1.1.2 miscompiles depca: workaround by Andrew Morton
 - dmfe.c module init fix: Andrew Morton
 - dynamic XMM support. Andrea Arkangeli.
 - ReiserFS merge
 - USB hotplug updates/fixes
 - boots on real i386 machines
 - blk-14 from Jens Axboe
 - fix DRM R128/AGP dependency
 - fix n_tty "canon" mode SMP race
 - ISDN fixes
 - ppp UP deadlock attack fix
 - FAT fat_cache SMP race fix
 - VM balancing tuning
 - Locked SHM segment deadlock fix
 - fork() page table copy race fix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
