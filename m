Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277341AbRKDBrt>; Sat, 3 Nov 2001 20:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277347AbRKDBrk>; Sat, 3 Nov 2001 20:47:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54281 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277341AbRKDBrZ> convert rfc822-to-8bit; Sat, 3 Nov 2001 20:47:25 -0500
Date: Sat, 3 Nov 2001 17:44:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.14-pre8..
Message-ID: <Pine.LNX.4.33.0111031740330.9962-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id RAA27166
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, this is hopefully the last 2.4.14 pre-kernel, and per popular demand I
hope to avoid any major changes between "last pre" and final. So give it a
whirl, and don't whine if the final doesn't act in a way you like it to.

Special thanks to Andrea - we spent too much time tracking down a subtle
sigsegv problem, but we got it in the end.

Also, I was able to reproduce the total lack of interactivity that the
google people complained about, and while I didn't run the google tests
themselves, at least the load I had is fixed.

But most of the changes are actually trying to catch up with some of the
emails that I ignored while working on the VM issues. I hope the VM is
good to go, along with a real 2.4.14.

		Linus

----
pre8:
 - Andrea: fix races in do_wp_page, free_swap_and_cache
 - me: clena up page dirty handling
 - Tim Waugh: parport IRQ probing and documentation fixes
 - Greg KH: USB updates
 - Michael Warfield: computone driver update
 - Randy Dunlap: add knowledge about some new io-apics
 - Richard Henderson: alpha updates
 - Trond Myklebust: make readdir xdr verify the reply packet
 - Paul Mackerras: PPC update
 - Jens Axboe: make cpqarray and cciss play nice with the request layer
 - Massimo Dal Zotto: SMM driver for Dell Inspiron 8000
 - Richard Gooch: devfs symlink deadlock fix
 - Anton Altaparmakov: make NTFS compile on sparc

pre7:
 - me: reinstate "delete swap cache on low swap" code
 - David Miller: ksoftirqd startup race fix
 - Hugh Dickins: make tmpfs free swap cache entries proactively

pre6:
 - me: remember to bump the version number ;)
 - Hugh Dickins: export "free_lru_page()" for modules
 - Jeff Garzik: don't change nopage arguments, just make the last a dummy one
 - David Miller: sparc and net updates (netfilter, VLAN etc)
 - Nikita Danilov: reiserfs cleanups
 - Jan Kara: quota initialization race
 - Tigran Aivazian: make the x86 microcode update driver happy about
   hyperthreaded P4's
 - me: shrink dcache/icache more aggressively
 - me: fix up oom-killer so that it actually works

pre5:
 - Andrew Morton: remove stale UnlockPage
 - me: swap cache page locking update

pre4:
 - Mikael Pettersson: fix P4 boot with APIC enabled
 - me: fix device queuing thinko, clean up VM locking

pre3:
 - René Scharfe: random bugfix
 - me: block device queuing low-water-marks, VM mapped tweaking.

pre2:
 - Alan Cox: more merging
 - Alexander Viro: block device module race fixes
 - Richard Henderson: mmap for 32-bit alpha personality
 - Jeff Garzik: 8139 and natsemi update

pre1:
 - Michael Warfield: computone serial driver update
 - Alexander Viro: cdrom module race fixes
 - David Miller: Acenic driver fix
 - Andrew Grover: ACPI update
 - Kai Germaschewski: ISDN update
 - Tim Waugh: parport update
 - David Woodhouse: JFFS garbage collect sleep

