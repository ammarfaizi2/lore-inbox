Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130744AbQKNWST>; Tue, 14 Nov 2000 17:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130878AbQKNWSJ>; Tue, 14 Nov 2000 17:18:09 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:16401 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130744AbQKNWR4> convert rfc822-to-8bit; Tue, 14 Nov 2000 17:17:56 -0500
Date: Tue, 14 Nov 2000 13:47:24 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test11-pre5
Message-ID: <Pine.LNX.4.10.10011141346480.15149-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id NAA23191
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More drivers.

The x86 capabilities cleanup is here.

		Linus

----

 - pre5:
    - Rasmus Andersen: add proper "<linux/init.h>" for sound drivers
    - David Miller: sparc64 and networking updates
    - David Trcka: MOXA numbering starts from 0, not 1.
    - Jeff Garzik: sysctl.h standalone
    - Dag Brattli: IrDA finishing touches
    - Randy Dunlap: USB fixes
    - Gerd Knorr: big bttv update
    - Peter Anvin: x86 capabilities cleanup
    - Stephen Rothwell: apm initcall fix - smp poweroff should work
    - Andrew Morton: setscheduler() spinlock ordering fix
    - Stephen Rothwell: directory notification documentation
    - Petr Vandrovec: ncpfs capabilities check cleanup
    - David Woodhouse: fix jffs to use generic isxxxx() library
    - Chris Swiedler: oom_kill selection fix
    - Jens Axboe: re-merge after sleeping in ll_rw_block.
    - Randy Dunlap: USB updates (pegasus and ftdi_sio)
    - Kai Germaschewski: ISDN ppp header compression fixed

 - pre4:
    - Andrea Arcangeli: SMP scheduler memory barrier fixup
    - Richard Henderson: fix alpha semaphores and spinlock bugs.
    - Richard Henderson: clean up the file from hell: "xor.c" 

 - pre3:
    - James Simmons: vgacon "printk()" deadlock with global irq lock.
    - don't poke blanked console on console output
    - Ching-Ling: get channels right on ALI audio driver
    - Dag Brattli and Jean Tourrilhes: big IrDA update
    - Paul Mackerras: PPC updates
    - Randy Dunlap: USB ID table support, LEDs with usbkbd, belkin
      serial converter. 
    - Jeff Garzik: pcnet32 and lance net driver fix/cleanup
    - Mikael Pettersson: clean up x86 ELF_PLATFORM
    - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
      cleanups
    - Al Viro: Jeff missed some kmap()'s. sysctl cleanup
    - Kai Germaschewski: ISDN updates
    - Alan Cox: SCSI driver NULL ptr checks
    - David Miller: networking updates, exclusive waitqueues nest properly,
      SMP i_shared_lock/page_table_lock lock order fix.

 - pre2:
    - Stephen Rothwell: directory notify could return with the lock held
    - Richard Henderson: CLOCKS_PER_SEC on alpha.
    - Jeff Garzik: ramfs and highmem: kmap() the page to clear it
    - Asit Mallick: enable the APIC in the official order
    - Neil Brown: avoid rd deadlock on io_request_lock by using a
      private rd-request function. This also avoids unnecessary
      request merging at this level.
    - Ben LaHaise: vmalloc threadign and overflow fix
    - Randy Dunlap: USB updates (plusb driver). PCI cacheline size.
    - Neil Brown: fix a raid1 on top of lvm bug that crept in in pre1
    - Alan Cox: various (Athlon mmx copy, NULL ptr checks for
      scsi_register etc). 
    - Al Viro: fix /proc permission check security hole.
    - Can-Ru Yeou: SiS301 fbcon driver
    - Andrew Morton: NMI oopser and kernel page fault punch through
      both console_lock and timerlist_lock to make sure it prints out..
    - Jeff Garzik: clean up "kmap()" return type (it returns a kernel
      virtual address, ie a "void *").
    - Jeff Garzik: network driver docs, various one-liners.
    - David Miller: add generic "special" flag to page flags, to be
      used by architectures as they see fit. Like keeping track of
      cache coherency issues.
    - David Miller: sparc64 updates, make sparc32 boot again
    - Davdi Millner: spel "synchronous" correctly
    - David Miller: networking - fix some bridge issues, and correct
      IPv6 sysctl entries.
    - Dan Aloni: make fork.c use proper macro rather than doing
      get_exec_domain() by hand. 

 - pre1:
    - me: make PCMCIA work even in the absense of PCI irq's
    - me: add irq mapping capabilities for Cyrix southbridges
    - me: make IBMMCA compile right as a module
    - me: uhhuh. Major atomic-PTE SMP race boo-boo. Fixed.
    - Andrea Arkangeli: don't allow people to set security-conscious
      bits in mxcsr through ptrace SETFPXREGS.
    - Jürgen Fischer: aha152x update
    - Andrew Morton, Trond Myklebust: file locking fixes
    - me: TLB invalidate race with highmem
    - Paul Fulghum: synclink/n_hdlc driver updates
    - David Miller: export sysctl_jiffies, and have the proper no-sysctl
      version handy
    - Neil Brown: RAID driver deadlock and nsfd read access to
      execute-only files fix
    - Keith Owens: clean up module information passing, remove
      "get_module_symbol()".
    - Jeff Garzik: network (and other) driver fixes and cleanups
    - Andrea Arkangeli: scheduler cleanup.
    - Ching-Ling Li: fix ALi sound driver memory leak
    - Anton Altaparmakov: upcase fix for NTFS
    - Thomas Woller: CS4281 audio update

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
