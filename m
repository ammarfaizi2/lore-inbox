Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLPDRX>; Fri, 15 Dec 2000 22:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129319AbQLPDRO>; Fri, 15 Dec 2000 22:17:14 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:53000 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129228AbQLPDRH>; Fri, 15 Dec 2000 22:17:07 -0500
Date: Fri, 15 Dec 2000 18:46:33 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test13-pre2
Message-ID: <Pine.LNX.4.10.10012151837250.4067-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is mostly still Makefile updates. Right now there are still
architecture-specific Makefiles that haven't been updated, but x86 and
sparc are done, along with the drivers you can enable for those
architectures. Expect the other architectures to follow soonish.

The other large part is the ACPI update: this folds in 3 months worth of
ACPI work. It's marked experimental to make sure people still realize that
there is work to be done..

One more note about the makefiles: doing the conversion to new-style
makefiles is not exactly rocket science, but it _is_ boring. The kernel
tree has 310 (really!) Makefiles, and while most of them had been
converted long ago, going through them to check that the last pieces had
been done was not what anybody would call "super fun".

And the boredom factor might easily have caused something to be glossed
over or overlooked. As a result I'd ask any developer to please take a
look that your driver/filesystem/whatnot Makefile rule is up-to-date and
working (with both modules and compiled in).

	Thanks,

		Linus

-----
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
