Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130571AbQKTDKU>; Sun, 19 Nov 2000 22:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130873AbQKTDKK>; Sun, 19 Nov 2000 22:10:10 -0500
Received: from [139.102.15.16] ([139.102.15.16]:18678 "EHLO
	emerald.indstate.edu") by vger.kernel.org with ESMTP
	id <S130571AbQKTDJ4> convert rfc822-to-8bit; Sun, 19 Nov 2000 22:09:56 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Sun, 19 Nov 2000 21:39:09 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Subject: Re: Linux 2.4.0-test11
Reply-to: richbaum@acm.org
CC: linux-kernel@vger.kernel.org
Message-ID: <3A18487D.13811.23B17C@localhost>
In-Reply-To: <Pine.LNX.4.10.10011191815160.850-100000@penguin.transmeta.com>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch is in the v2.3 directory.  You may want to move it to the 
v2.4 directory so people can find it easier.

On 19 Nov 2000, at 18:19, Linus Torvalds wrote:

> 
> Ok, test11 is out there. The most noticeable fixes since pre7 are the
> Athlon lockup fix, the PCI routing handling, and getting the Joliet stuff
> right for iso9660.
> 
> 		Linus
> 
> ----
> 
>  - final:
>     - Patrick Mochel: export the ACPI facs table in /proc too
>     - Brian Gerst: Video4Linux cleanup (named initializers)
>     - me: only use irq13 for FP errors for external FPU's. This
>       fixes the Atlon FP exception lockups.
>     - me: add a new intel signature to the PIRQ table matching logic.
>       Make the matching match both reported and actual device ID (with a
>       preference for the reported). Fixes PCMCIA on NEC Versa laptops.
>     - iso9660: fix Joliet filename argument order bug introduced in pre7
>     - Highmem: p_page -> b_page typo.
>     - me: don't allow pending FPU exceptions without an FPU context..
> 
>  - pre7:
>     - Kai Germaschewski: more ISDN cleanups and small fixes.
>     - Al Viro: fix ntfs_new_inode() that he broke. Cleanups.
>     - various: handle !CONFIG_HOTPLUG properly
>     - David Miller: sparc and networking
>     - me: more iso9660 fixes. 
>     - Neil Brown: fix rd and RAID on highmem machines
>     - Vojtech Pavlik: input driver fixes
>     - David Woodhouse: module unload races - up_and_exit()
> 
>  - pre6:
>     - Intel: start to add Pentium IV specific stuff (128-byte cacheline
>       etc)
>     - David Miller: search-and-destroy places that forget to mark us
>       running after removing us from a wait-queue.
>     - me: NFS client write-back ref-counting SMP instability.
>     - me: fix up non-exclusive waiters
>     - Trond Myklebust: Be more careful about SMP in NFS and RPC code
>     - Trond Myklebust: inode attribute update race fix
>     - Charles White: don't do unaligned accesses in cpqarray driver.
>     - Jeff Garzik: continued driver cleanup and fixes
>     - Peter Anvin: integrate more of the Intel patches.
>     - Robert Love: add i815 signature to the intel AGP support
>     - Rik Faith: DRM update to make it easier to sync up 2.2.x
>     - David Woodhouse: make old 16-bit pcmcia controllers work
>       again (ie i82365 and TCIC)
> 
>  - pre5:
>     - Rasmus Andersen: add proper "<linux/init.h>" for sound drivers
>     - David Miller: sparc64 and networking updates
>     - David Trcka: MOXA numbering starts from 0, not 1.
>     - Jeff Garzik: sysctl.h standalone
>     - Dag Brattli: IrDA finishing touches
>     - Randy Dunlap: USB fixes
>     - Gerd Knorr: big bttv update
>     - Peter Anvin: x86 capabilities cleanup
>     - Stephen Rothwell: apm initcall fix - smp poweroff should work
>     - Andrew Morton: setscheduler() spinlock ordering fix
>     - Stephen Rothwell: directory notification documentation
>     - Petr Vandrovec: ncpfs capabilities check cleanup
>     - David Woodhouse: fix jffs to use generic isxxxx() library
>     - Chris Swiedler: oom_kill selection fix
>     - Jens Axboe: re-merge after sleeping in ll_rw_block.
>     - Randy Dunlap: USB updates (pegasus and ftdi_sio)
>     - Kai Germaschewski: ISDN ppp header compression fixed
> 
>  - pre4:
>     - Andrea Arcangeli: SMP scheduler memory barrier fixup
>     - Richard Henderson: fix alpha semaphores and spinlock bugs.
>     - Richard Henderson: clean up the file from hell: "xor.c" 
> 
>  - pre3:
>     - James Simmons: vgacon "printk()" deadlock with global irq lock.
>     - don't poke blanked console on console output
>     - Ching-Ling: get channels right on ALI audio driver
>     - Dag Brattli and Jean Tourrilhes: big IrDA update
>     - Paul Mackerras: PPC updates
>     - Randy Dunlap: USB ID table support, LEDs with usbkbd, belkin
>       serial converter. 
>     - Jeff Garzik: pcnet32 and lance net driver fix/cleanup
>     - Mikael Pettersson: clean up x86 ELF_PLATFORM
>     - Bartlomiej Zolnierkiewicz: sound and drm driver init fixes and
>       cleanups
>     - Al Viro: Jeff missed some kmap()'s. sysctl cleanup
>     - Kai Germaschewski: ISDN updates
>     - Alan Cox: SCSI driver NULL ptr checks
>     - David Miller: networking updates, exclusive waitqueues nest properly,
>       SMP i_shared_lock/page_table_lock lock order fix.
> 
>  - pre2:
>     - Stephen Rothwell: directory notify could return with the lock held
>     - Richard Henderson: CLOCKS_PER_SEC on alpha.
>     - Jeff Garzik: ramfs and highmem: kmap() the page to clear it
>     - Asit Mallick: enable the APIC in the official order
>     - Neil Brown: avoid rd deadlock on io_request_lock by using a
>       private rd-request function. This also avoids unnecessary
>       request merging at this level.
>     - Ben LaHaise: vmalloc threadign and overflow fix
>     - Randy Dunlap: USB updates (plusb driver). PCI cacheline size.
>     - Neil Brown: fix a raid1 on top of lvm bug that crept in in pre1
>     - Alan Cox: various (Athlon mmx copy, NULL ptr checks for
>       scsi_register etc). 
>     - Al Viro: fix /proc permission check security hole.
>     - Can-Ru Yeou: SiS301 fbcon driver
>     - Andrew Morton: NMI oopser and kernel page fault punch through
>       both console_lock and timerlist_lock to make sure it prints out..
>     - Jeff Garzik: clean up "kmap()" return type (it returns a kernel
>       virtual address, ie a "void *").
>     - Jeff Garzik: network driver docs, various one-liners.
>     - David Miller: add generic "special" flag to page flags, to be
>       used by architectures as they see fit. Like keeping track of
>       cache coherency issues.
>     - David Miller: sparc64 updates, make sparc32 boot again
>     - Davdi Millner: spel "synchronous" correctly
>     - David Miller: networking - fix some bridge issues, and correct
>       IPv6 sysctl entries.
>     - Dan Aloni: make fork.c use proper macro rather than doing
>       get_exec_domain() by hand. 
> 
>  - pre1:
>     - me: make PCMCIA work even in the absense of PCI irq's
>     - me: add irq mapping capabilities for Cyrix southbridges
>     - me: make IBMMCA compile right as a module
>     - me: uhhuh. Major atomic-PTE SMP race boo-boo. Fixed.
>     - Andrea Arkangeli: don't allow people to set security-conscious
>       bits in mxcsr through ptrace SETFPXREGS.
>     - Jürgen Fischer: aha152x update
>     - Andrew Morton, Trond Myklebust: file locking fixes
>     - me: TLB invalidate race with highmem
>     - Paul Fulghum: synclink/n_hdlc driver updates
>     - David Miller: export sysctl_jiffies, and have the proper no-sysctl
>       version handy
>     - Neil Brown: RAID driver deadlock and nsfd read access to
>       execute-only files fix
>     - Keith Owens: clean up module information passing, remove
>       "get_module_symbol()".
>     - Jeff Garzik: network (and other) driver fixes and cleanups
>     - Andrea Arkangeli: scheduler cleanup.
>     - Ching-Ling Li: fix ALi sound driver memory leak
>     - Anton Altaparmakov: upcase fix for NTFS
>     - Thomas Woller: CS4281 audio update
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
