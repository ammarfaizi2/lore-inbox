Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270713AbRHKESP>; Sat, 11 Aug 2001 00:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270715AbRHKESG>; Sat, 11 Aug 2001 00:18:06 -0400
Received: from neon-gw.transmeta.com ([63.209.4.196]:30471 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270713AbRHKERq>; Sat, 11 Aug 2001 00:17:46 -0400
Date: Fri, 10 Aug 2001 21:17:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.8
Message-ID: <Pine.LNX.4.33.0108102111080.8771-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this one has various VM niceness tweaks that have made some people
much happier. It also does a upgrade to the XFree86-4.1.x style DRM code,
which means that people with XFree86-4.0.x can no longer use the built-in
kernel DRM by default.

However, never fear. It's actually very easy to get the old DRM code too:
if you used to use the standard kernel DRM and do not want to upgrade to a
new XFree86 setup, just get the "drm-4.0.x" package from the same place
you get the kernel from, and do

 - unpack the kernel
 - cd linux/drivers/char
 - unpack the "drm-4.0.x" package here
 - mv drm new-drm
 - mv drm-4.0.x drm

and you should be all set.

More detailed ChangeLog appended,

		Linus

-----

final:
 - Rik van Riel: free up swap cache on swapin when swap is full..
 - Robert Love: merge emu10k sound driver.  This one is better ("Yeah,
   you actually get sound out of it")
 - Jeremy Linton: swapin/swapoff race condition fix

pre8:
 - Jeff Hartmann: serverworks AGP gart unload memory leak fix
 - Marcelo Tosatti: make zone_inactive_shortage() return how big the shortage is.
 - Hugh Dickins: tidy up age_page_down()
 - Al Viro: super block handling cleanups

pre7-pre6:
 - me: better dirty balancing
 - me: sane and nice VM balancing
 - David Miller: sparc and network updates
 - Jeff Hartmann: upgrade DRM to XF86 4.1.x, drop support for 4.0.x

pre5:
 - Alan Cox: more merging
 - L.C. Chang: new SiS IDE PCI id's.
 - Maciej Rozycki: make MP table parsing more anal. Should fix broken P4 MP tables.
 - Leonard Zubkoff: merge DAC960 completion changes
 - Christoph Rohland: saner tmpfs mount-time limit behaviour (and remount)
 - me: buffer.c logic update - faster and hopefully livelock-free

pre4:
 - David Mosberger: IA64 update
 - Geert Uytterhoeven: cleanup, new atyfb
 - Marcelo Tosatti: zone aging fixes
 - me, others: limit IO requests sanely

pre3:
 - Ben Collins: 1394 updates
 - Matthew Dharm: USB storage update
 - Ion Badulescu: starfire driver update
 - VM aging cleanups

pre2:
 - Kai Germaschewski: ISDN updates
 - David Miller: sparc and network updates
 - Andrea Arcangeli, Maksim Krasnyanskiy: tasklet fixes
 - Stelian Pop: Motion Eye camera driver update
 - Jens Axboe: DAC960 update

pre1:
 - Anton Altaparmakov: NTFS error checking
 - Johannes Erdfelt: USB updates
 - OGAWA Hirofumi: FAT update
 - Alan Cox: driver + s390 update merge
 - Richard Henderson: fix alpha sigsuspend error return value
 - Marcelo Tosatti: per-zone VM shortage
 - Daniel Phillips: generic use-once optimization instead of drop-behind
 - Bjorn Wesen: Cris architecture update
 - Anton Altaparmakov: support for Windows Dynamic Disks
 - James Washer: LDT loading SMP bug fix

