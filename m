Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130557AbQKJBxL>; Thu, 9 Nov 2000 20:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130601AbQKJBxB>; Thu, 9 Nov 2000 20:53:01 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:29454 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130557AbQKJBw7> convert rfc822-to-8bit; Thu, 9 Nov 2000 20:52:59 -0500
Date: Thu, 9 Nov 2000 17:52:29 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: test11-pre2
Message-ID: <Pine.LNX.4.10.10011091748300.2316-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id RAA19935
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing stands out as affecting most people here. Security fix for /proc,
and various cleanups. Alpha and sparc fixes. If you use RAID or ramdisk,
upgrade. 

		Linus

-----

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
