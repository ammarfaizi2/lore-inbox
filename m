Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132313AbQLQW0S>; Sun, 17 Dec 2000 17:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132497AbQLQW0I>; Sun, 17 Dec 2000 17:26:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:49935 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132313AbQLQWZ4>; Sun, 17 Dec 2000 17:25:56 -0500
Date: Sun, 17 Dec 2000 13:55:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test13-pre3
Message-ID: <Pine.LNX.4.10.10012171353270.2052-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The most noticeable part of this is that the run_task_queue fix should
cure the lockup that some people have seen.

The shmfs cleanup should be unnoticeable except to users who use SAP with
huge shared memory segments, where Christoph Rohlands work not only
makes the code much more readable, it should also make it dependable..

		Linus

----

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
