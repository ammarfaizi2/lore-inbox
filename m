Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129319AbQK2H25>; Wed, 29 Nov 2000 02:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129348AbQK2H2s>; Wed, 29 Nov 2000 02:28:48 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:777 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129319AbQK2H2b>; Wed, 29 Nov 2000 02:28:31 -0500
Date: Tue, 28 Nov 2000 22:57:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@redhat.com>
Subject: test12-pre3
Message-ID: <Pine.LNX.4.10.10011282248530.6275-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The bulk of this is architecture updates (most lately mips64). The most
interesting (but fairly small) part is the VM cleanups. Any day now
kiobuf's can just use PageDirty on everything, and we won't have any nasty
races any more.

		Linus

----

 - pre3:
    - me: more PageDirty / swapcache handling
    - Neil Brown: raid and md init fixes
    - David Brownell: pci hotplug sanitization.
    - Kanoj Sarcar: mips64 update
    - Kai Germaschewski: ISDN sync
    - Andreas Bombe: ieee1394 cleanups and fixes
    - Johannes Erdfelt: USB update
    - David Miller: Sparc and net update
    - Trond Myklebust: RPC layer SMP fixes
    - Thomas Sailer: mixed sound driver fixes
    - Tigran Aivazian: use atomic_dec_and_lock() for free_uid()

 - pre2:
    - Peter Anvin: more P4 configuration parsing
    - Stephen Tweedie: O_SYNC patches. Make O_SYNC/fsync/fdatasync
      do the right thing.
    - Keith Owens: make mdule loading use the right struct module size
    - Boszormenyi Zoltan: get MTRR's right for the >32-bit case
    - Alan Cox: various random documentation etc
    - Dario Ballabio: EATA and u14-34f update
    - Ivan Kokshaysky: unbreak alpha ruffian
    - Richard Henderson: PCI bridge initialization on alpha
    - Zach Brown: correct locking in Maestro driver
    - Geert Uytterhoeven: more m68k updates
    - Andrey Savochkin: eepro100 update
    - Dag Brattli: irda update
    - Johannes Erdfelt: USB update

 - pre1: (for ISDN synchronization _ONLY_! Not complete!)
    - Byron Stanoszek: correct decimal precision for CPU MHz in
      /proc/cpuinfo
    - Ollie Lho: SiS pirq routing.
    - Andries Brouwer: isofs cleanups
    - Matt Kraai: /proc read() on directories should return EISDIR, not EINVAL
    - me: be stricter about what we accept as a PCI bridge setup.
    - me: always set PCI interrupts to be level-triggered when we enable them.
    - me: updated PageDirty and swap cache handling
    - Peter Anvin: update A20 code to work without keyboard controller
    - Kai Germaschewski: ISDN updates
    - Russell King: ARM updates
    - Geert Uytterhoeven: m68k updates

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
