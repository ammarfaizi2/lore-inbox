Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280101AbRJaICI>; Wed, 31 Oct 2001 03:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280102AbRJaIB7>; Wed, 31 Oct 2001 03:01:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280101AbRJaIBy> convert rfc822-to-8bit; Wed, 31 Oct 2001 03:01:54 -0500
Date: Wed, 31 Oct 2001 00:00:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.14-pre6
Message-ID: <Pine.LNX.4.33.0110302349550.31996-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id AAA00331
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Incredibly, I didn't get a _single_ bugreport about the fact that I had
forgotten to change the version number in pre5. Usually that's everybody's
favourite bug.. Is everybody asleep on the lists?

Anyway, pre6 is out, and now it's too late. I updated the version number.

Other changes:

Bulk of pre5->pre6 differences: the sparc and net updates from David.

Oh, and the first funny patches for the upcoming SMT P4 cores are starting
to show up. More to come.

The MM has calmed down, but the OOM killer didn't use to work. Now it
does, with heurstics that are so incredibly simple that it's almost
embarrassing.

And I dare anybody to break those OOM heuristics - either by not
triggering when they should, or by triggering too early. You'll get an
honourable mention if you can break them and tell me how ("Honourable
mention"? Yeah, I'm cheap. What else is new?)

In fact, I'd _really_ like to know of any VM loads that show bad
behaviour. If you have a pet peeve about the VM, now is the time to speak
up. Because otherwise I think I'm done.

Anybody out there with cerberus?

		Linus "128MB of RAM and 1GB into swap, and happy" Torvalds

----

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

