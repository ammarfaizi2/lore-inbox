Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284940AbRLQAMm>; Sun, 16 Dec 2001 19:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284942AbRLQAMc>; Sun, 16 Dec 2001 19:12:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13832 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284940AbRLQAMS>; Sun, 16 Dec 2001 19:12:18 -0500
Date: Sun, 16 Dec 2001 16:11:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.1 - intermediate bio stuff..
Message-ID: <Pine.LNX.4.33.0112161604030.11129-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just made a 2.5.1, but I'm still concentrating on bio stuff, so don't
bother sending me other patches unless they are serious bug-fixes to
something else.

2.5.1 is hopefully a good interim stage - many block drivers should work
fine, but many more do not.  However, the pre-patches were getting
largish, so I'd rather do a 2.5.1 than wait for all the details.

As to other stuff - note the separation of drivers for new and old tulip
chips: if you have an old 2104x tulip chip (as opposed to the newer 2114x
chips) the regular tulip driver doesn't work any more for you. Don't be
surprised, select CONFIG_DE2104X.

		Linus

-----
final:
 - Al Viro: floppy_eject cleanup, mount cleanups
 - Jens Axboe: bio updates
 - Ingo Molnar: mempool fixes
 - GOTO Masanori: Fix O_DIRECT error handling

pre11:
 - Jeff Garzik: no longer support old cards in tulip driver
   (see separate driver for old tulip chips)
 - Pat Mochel: driverfs/device model documentation
 - Ballabio Dario: update eata driver to new IO locking
 - Ingo Molnar: raid resync with new bio structures (much more efficient)
   and mempool_resize()
 - Jens Axboe: bio queue locking

pre10:
 - Jens Axboe: more bio stuff
 - Ingo Molnar: mempool for bio
 - Niibe Yutaka: Super-H update

pre9:
 - Jeff Garzik: separate out handling of older tulip chips
 - Jens Axboe: more bio stuff
 - Anton Altaparmakov: NTFS 1.1.21 update

pre8:
 - Greg KH: USB updates
 - Jens Axboe: more bio updates
 - Christoph Rohland: fix up proper shmat semantics

pre7:
 - Jens Axboe: more bio fixes/cleanups/breakage ;)
 - Al Viro: superblock cleanups, boot/root mounting.

pre6:
 - Jens Axboe: more bio stuff
 - Coda compile fixes
 - Nathan Laredo: stradis driver update

pre5:
 - Patrick Mochel: driver model infrastructure, part 1
 - Jens Axboe: more bio fixes, cleanups
 - Andrew Morton: release locking fixes
 - Al Viro: superblock/mount handling
 - Kai Germaschewski: AVM Fritz!Card ISDN driver
 - Christoph Hellwig: make cramfs SMP-safe.

pre4:
 - Jens Axboe: fix up bio highmem breakage, more cleanups
 - Greg KH: USB update

pre3:
 - Al Viro: more superblock cleanups
 - Jens Axboe: more patches for new block IO layer
 - Christoph Hellwig: get rid of the old, long- deprecated SCSI error
   handling

pre2:
 - Greg KH: USB update
 - Richard Gooch: refcounting for devfs
 - Jens Axboe: start of new block IO layer

pre1:
 - me: README references to 2.4.x -> 2.5.x
 - Alexander Viro: fix unmount inode breakage, show_vfsmnt cleanup
 - Jeff Garzik: fix 8139too initialization

