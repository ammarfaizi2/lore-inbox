Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQLLDYH>; Mon, 11 Dec 2000 22:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130635AbQLLDX6>; Mon, 11 Dec 2000 22:23:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:32517 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129873AbQLLDXs>; Mon, 11 Dec 2000 22:23:48 -0500
Date: Mon, 11 Dec 2000 18:52:55 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.0-test12
Message-ID: <Pine.LNX.4.10.10012111850320.976-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, there it is. Noticeable changes from pre8 are mainly (a) new tq list
compile fixes and (b) the NetApp snapshot thing.

Dave's merge_segments thing could in theory be a deadlock on SMP.

		Linus


----
 - final:
    - David Miller: sparc and net updates. Fix merge_segments.
    - Dan Aloni: ISA PnP name parsing cleanup
    - Mohammad Haque and others: hunt down tq initializations.
    - Petr Vandrovec: ncpfs config changes
    - Neil Brown: raid and md cleanups
    - Pete Zaitcev: ymfpci update
    - Alan Cox: sync (network driver MODULE_OWNER and cleanups)
    - Martin Diehl: pirq router for VLSI 82C534 (HP OmniBook and others)
    - Tigran Aivazian: ia32 microcode driver update
    - Tim Waugh: parport fixes (ECP write, documentation)
    - Richard Henderson: alpha update
    - David Woodhouse: MTD update
    - Trond Myklebust: index the NFS inode cache using the file handle.
      This makes NetApp snapshot directories do the right thing.

 - test8:
    - Stephen Rothwell: APM updates
    - Johannes Erdfelt: USB updates
    - me: call_usermodehelper(/sbin/hotplug) cleanup and deadlock fix
    - Leonard Zubkoff: DAC960 Driver Update
    - Martin Diehl: fix PCI PM callback ordering
    - Andrew Morton: call_usermodehelper() fixes
    - Urban Widmark: clean up and enable shared mmap on smbfs.
    - Trond Myklebust: fix NFS path revalidation.

 - test7:
    - Kai Germaschewski: ymfpci cleanups and resource leak fixes
    - me: UHCI drivers really need to enable bus mastering.
    - Trond Myklebust: fix up nfs_writepage_sync() to not require "filp".
    - Andrew Morton: "tq_scheduler" is no more. We have keventd.
    - Nils Faerber: cs46xx sounddriver update

 - pre6:
    - Alan Cox: synch. PA-RISC arch and bitops cleanups
    - Maciej Rozycki: even more proper apic setup order.
    - Andrew Morton: exec_usermodehelper fixes
    - Adam Richter, Kai Germaschewski, me: PCI irq routing.
    - revert A20 code changes. We really need to use the keyboard
      controller if one exists.
    - Johannes Erdfelt: USB updates
    - Ralf Baechle: MIPS memmove() fix.

 - pre5:
    - Jaroslav Kysela: ymfpci driver
    - me: get rid of bogus MS_INVALIDATE semantics
    - me: final part of the PageDirty() saga
    - Rusty Russell: 4-way SMP iptables fix
    - Al Viro: oops - bad ext2 inode dirty block bug

 - pre4:
    - Andries Brouwer: final isofs pieces.
    - Kai Germaschewski: ISDN
    - play CD audio correctly, don't stop after 12 minutes.
    - Anton Altaparmakov: disable NTFS mmap for now, as it doesn't work. 
    - Stephen Tweedie: fix inode dirty block handling
    - Bill Hartner: reschedule_idle - prefer right cpu
    - Johannes Erdfelt: USB updates
    - Alan Cox: synchronize
    - Richard Henderson: alpha updates and optimizations
    - Geert Uytterhoeven: fbdev could be fooled into crashing fix
    - Trond Myklebust: NFS filehandles in inode rather than dentry

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
