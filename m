Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130916AbQLaU4C>; Sun, 31 Dec 2000 15:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbQLaUzm>; Sun, 31 Dec 2000 15:55:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2058 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130882AbQLaUzf>; Sun, 31 Dec 2000 15:55:35 -0500
Date: Sun, 31 Dec 2000 12:24:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Happy new year^H^H^H^Hkernel..
Message-ID: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok. I didn't make 2.4.0 in 2000. Tough. I tried, but we had some
last-minute stuff that needed fixing (ie the dirty page lists etc), and
the best I can do is make a prerelease.

There's a 2.4.0-prerelease out there, and this is basically it. I want
people to test it for a while, and I want to give other architectures the
chance to catch up with some of the changes, but read my lips: no more
recounts. There is no "prerelease1", to become "prerelease2" and so on.

One thing other architectures will want to catch up with is the changes to
handle 2GHz+ machines, which due to overflow issues caused "loops_per_sec"
to become "loops_per_jiffy". And some architectures have not had much
chance to synchronize with me due to other fires to put out.

Give it your worst. After you recover from being hung-over, of course.

			Linus

-----
prerelease:
   - Alan Cox: more synchronizations
   - Manfred Spraul: ptrace/suid-exec race fix

 - pre7:
   - x86 LDT handling fixes: revert some cleanups (the LDT really
     doesn't act like a TLB context)
   - Richard Henderson: alpha update (working memmove() from Ivan
     Kokshaysky etc)
   - Manfred: winbond-840.c net driver update (fix oops on module unload etc)
   - Alan Cox: more synchronizations (with some fixes from Andrew Morton)

 - pre6:
   - Marc Joosen: BIOS int15/e820 memory query: don't assume %edx
     unchanged by the BIOS. Fixes at least some IBM ThinkPads.
   - Alan Cox: synchronize
   - Marcelo Tosatti & me: properly sync dirty pages
   - Andreas Dilger: proper ext2 compat flag checking

 - pre5:
   - NIIBE Yutaka: SuperH update
   - Geert Uytterhoeven: m68k update
   - David Miller: TCP RTO calc fix, UDP multicast fix etc
   - Duncan Laurie: ServerWorks PIRQ routing definition.
   - mm PageDirty cleanups, added sanity checks, and don't lose the bit. 

 - pre4:
   - Christoph Rohland: shmfs cleanup
   - Nicolas Pitre: don't forget loop.c flags
   - Geert Uytterhoeven: new-style m68k Makefiles
   - Neil Brown: knfsd cleanups, raid5 re-org
   - Andrea Arkangeli: update to LVM-0.9
   - LC Chang: sis900 driver doc update
   - David Miller: netfilter oops fix
   - Andrew Grover: acpi update

 - pre3:
   - Christian Jullien: smc9194: proper dev_kfree_skb_irq
   - Cort Dougan: new-style PowerPC Makefiles
   - Andrew Morton, Petr Vandrovec: fix run_task_queue
   - Christoph Rohland: shmfs for shared memory handling

 - pre2:
   - Kai Germaschewski: ISDN update (including Makefiles)
   - Jens Axboe: cdrom updates
   - Petr Vandrovec; Matrox G450 support
   - Bill Nottingham: fix FAT32 filesystems on 64-bit platforms
   - David Miller: sparc (and other) Makefile fixup
   - Andrea Arkangeli: alpha SMP TLB context fix (and cleanups)
   - Niels Kristian Bech Jensen: checkconfig, USB warnings
   - Andrew Grover: large ACPI update

 - pre1:
   - me: drop support for old-style Makefiles entirely. Big.
   - me: check b_end_io at the IO submission path
   - me: fix "ptep_mkdirty()" (so that swapoff() works correctly)
   - fix fault case in copy_from_user() with a constant size, where
     ((size & 3) == 3)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
