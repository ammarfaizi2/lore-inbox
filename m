Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSAVBgS>; Mon, 21 Jan 2002 20:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSAVBgF>; Mon, 21 Jan 2002 20:36:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43786 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289135AbSAVBfr> convert rfc822-to-8bit; Mon, 21 Jan 2002 20:35:47 -0500
Date: Mon, 21 Jan 2002 17:34:54 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Linux 2.5.3-pre3
Message-ID: <Pine.LNX.4.33.0201211728170.1263-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g0M1ZES04875
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lots of patches from people, and some that were dropped because of clashes
(Trond: your NFS directory cache cleanup clashes badly with Al's inode
allocations patches, and I decided to do the more fundamental inode alloc
change first, so ..).

Ingo is waiting for more feedback on the "J4 scheduler", so if people want
to test that out, please do send him feedback. In the meantime, J2 with
all the runqueue fixes is in the standard pre3 kernel.

Basically, the biggest change in pre3 is the one that a lot of people have
been discussing and working on, namely splitting up the inodes so that we
don't need to have the union of every possible filesystem type in "struct
inode" and waste memory.

The inode thing has left umsdos broken, but Al promises to have that fixed
soonish.

		Linus

----

pre3:
 - Al Viro: VFS inode allocation moved down to filesystem, trim inodes
 - Greg KH: USB update, hotplug documentation
 - Kai Germaschewski: ISDN update
 - Ingo Molnar: scheduler tweaking ("J2")
 - Arnaldo: emu10k kdev_t updates
 - Ben Collins: firewire updates
 - Björn Wesen: cris arch update
 - Hal Duston: ps2esdi driver bio/kdev_t fixes
 - Jean Tourrilhes: move wireless drivers into drivers/net/wireless,
   update wireless API #1
 - Richard Gooch: devfs race fix
 - OGAWA Hirofumi: FATFS update

pre2:
 - David Howells: abtract out "current->need_resched" as "need_resched()"
 - Frank Davis: ide-tape update for bio
 - various: header file fixups
 - Jens Axboe: fix up bio/ide/highmem issues
 - Kai Germaschewski: ISDN update
 - Greg KH: USB and Compaq PCI hotplug updates
 - Tim Waugh: parport update

pre1:
 - Al Viro: fix up silly problem in swapfile filp cleanups in 2.5.2
 - Tachino Nobuhiro: fix another error return for swapfile filp code
 - Robert Love: merge some of Ingo's scheduler fixes
 - David Miller: networking, sparc and some scsi driver fixes
 - Tim Waugh: parport update
 - OGAWA Hirofumi: fatfs cleanups and bugfixes
 - Roland Dreier: fix vsscanf buglets.
 - Ben LaHaise: include file cleanup
 - Andre Hedrick: IDE taskfile update

