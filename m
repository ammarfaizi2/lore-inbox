Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbQL3VKh>; Sat, 30 Dec 2000 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135535AbQL3VK2>; Sat, 30 Dec 2000 16:10:28 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:62219 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135170AbQL3VKT>; Sat, 30 Dec 2000 16:10:19 -0500
Date: Sat, 30 Dec 2000 12:39:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test13-pre7...
Message-ID: <Pine.LNX.4.10.10012301237570.1300-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The LDT fixes in particular fix some potentially random strange behaviour.
And the alpha memmove() thing was a showstopper bug on alphas.

		Linus

----

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
