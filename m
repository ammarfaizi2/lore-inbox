Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRIUE0k>; Fri, 21 Sep 2001 00:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274754AbRIUE0b>; Fri, 21 Sep 2001 00:26:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44556 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274722AbRIUE0R>; Fri, 21 Sep 2001 00:26:17 -0400
Date: Thu, 20 Sep 2001 21:25:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-2.4.10-pre13
Message-ID: <Pine.LNX.4.33.0109202113430.8684-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


More merging..

Btw, my mailbox is overflowing - for some reason I'm now on the cc list of
what appears to be a few hundred independent small diskcussions (but I'm
sure it's just a dozen or so), and if your patch is missing from pre13,
please don't send it again immediately. I'm trying to catch up with the
mail flood, and while you can _almost_ assume that if your patch isn't in
pre13 it's gone (and should be re-sent), please wait with the re-send for
a few days.

I'm concentrating on trying to merge existing patches (ie mainly -ac), and
on getting the VM issues sorted out, anything else pretty much got dropped
the last few days (and expect them to get dropped for a few more days at
least).

		Linus

----
pre13:
 - Manfred Spraul: /proc/pid/maps cleanup (and bugfix for non-x86)
 - Al Viro: "block device fs" - cleanup of page cache handling
 - Hugh Dickins: VM/shmem cleanups and swap search speedup
 - Andrea Arkangeli, Andrew Morton etc: various VM fixes
 - David Miller: sparc updates, soc driver typo fix, net updates
 - Jeff Garzik: network driver updates (dl2k, yellowfin and tulip)
 - Neil Brown: knfsd cleanups and fixues
 - Ben LaHaise: zap_page_range merge from -ac

pre12:
 - Alan Cox: much more merging
 - Pete Zaitcev: ymfpci race fixes
 - Andrea Arkangeli: VM race fix and OOM tweak.
 - Arjan Van de Ven: merge RH kernel fixes
 - Andi Kleen: use more readable 'likely()/unlikely()' instead of __builtin_expect()
 - Keith Owens: fix 64-bit ELF types
 - Gerd Knorr: mark more broken PCI bridges, update btaudio driver
 - Paul Mackerras: powermac driver update
 - me: clean up PTRACE_DETACH to use common infrastructure

pre11:
 - Neil Brown: md cleanups/fixes
 - Andrew Morton: console locking merge
 - Andrea Arkangeli: major VM merge

pre10:
 - Alan Cox: continued merging
 - Mingming Cao: make msgrcv/shmat check the queue/segment ID's properly
 - Greg KH: USB serial init failure fix, Xircom serial converter driver
 - Neil Brown: nsfd/raid/md/lockd cleanups
 - Ingo Molnar: multipath RAID personality, raid xor update
 - Hugh Dickins/Marcelo Tosatti: swapin read-ahead race fix
 - Vojtech Pavlik: fix up some of the infrastructure for x86-64
 - Robert Love: AMD 761 AGP GART support
 - Jens Axboe: fix SCSI-generic queue handling race
 - me: be sane about page reference bits

pre9:
 - Greg KH: start migration to new "min()/max()"
 - Roman Zippel: move affs over to "min()/max()".
 - Vojtech Pavlik: VIA update (make sure not to IRQ-unmask a vt82c576)
 - Jan Kara: quota bug-fix (don't decrement quota for non-counted inode)
 - Anton Altaparmakov: more NTFS updates
 - Al Viro: make nosuid/noexec/nodev be per-mount flags, not per-filesystem
 - Alan Cox: merge input/joystick layer differences, driver and alpha merge
 - Keith Owens: scsi Makefile cleanup
 - Trond Myklebust: fix oopsable race in locking code
 - Jean Tourrilhes: IrDA update

pre8:
 - Christoph Hellwig: clean up personality handling a bit
 - Robert Love: update sysctl/vm documentation
 - make the three-argument (that everybody hates) "min()" be "min_t()",
   and introduce a type-anal "min()" that complains about arguments of
   different types.

pre7:
 - Alan Cox: big driver/mips sync
 - Andries Brouwer, Christoph Hellwig: more gendisk fixups
 - Tobias Ringstrom: tulip driver workaround for DC21143 erratum

pre6:
 - Jens Axboe: remove trivially dead io_request_lock usage
 - Andrea Arcangeli: softirq cleanup and ARM fixes. Slab cleanups
 - Christoph Hellwig: gendisk handling helper functions/cleanups
 - Nikita Danilov: reiserfs dead code pruning
 - Anton Altaparmakov: NTFS update to 1.1.18
 - firestream network driver: patch reverted on authors request
 - NIIBE Yutaka: SH architecture update
 - Paul Mackerras: PPC cleanups, PPC8xx update.
 - me: reverse broken bootdata allocation patch that went into pre5

pre5:
 - Merge with Alan
 - Trond Myklebust: NFS fixes - kmap and root inode special case
 - Al Viro: more superblock cleanups, inode leak in rd.c, minix
   directories in page cache
 - Paul Mackerras: clean up rubbish from sl82c105.c
 - Neil Brown: md/raid cleanups, NFS filehandles
 - Johannes Erdfelt: USB update (usb-2.0 support, visor fix, Clie fix,
   pl2303 driver update)
 - David Miller: sparc and net update
 - Eric Biederman: simplify and correct bootdata allocation - don't
   overwrite ramdisks
 - Tim Waugh: support multiple SuperIO devices, parport doc updates

pre4:
 - Hugh Dickins: swapoff cleanups and speedups
 - Matthew Dharm: USB storage update
 - Keith Owens: Makefile fixes
 - Tom Rini: MPC8xx build fix
 - Nikita Danilov: reiserfs update
 - Jakub Jelinek: ELF loader fix for ET_DYN
 - Andrew Morton: reparent_to_init() for kernel threads
 - Christoph Hellwig: VxFS and SysV updates, vfs_permission fix

pre3:
 - Johannes Erdfelt, Oliver Neukum: USB printer driver race fix
 - John Byrne: fix stupid i386-SMP irq stack layout bug
 - Andreas Bombe, me: yenta IO window fix
 - Neil Brown: raid1 buffer state fix
 - David Miller, Paul Mackerras: fix up sparc and ppc respectively for kmap/kbd_rate
 - Matija Nalis: umsdos fixes, and make it possible to boot up with umsdos
 - Francois Romieu: fix bugs in dscc4 driver
 - Andy Grover: new PCI config space access functions (eventually for ACPI)
 - Albert Cranford: fix incorrect e2fsprog data from ver_linux script
 - Dave Jones: re-sync x86 setup code, fix macsonic kmalloc use
 - Johannes Erdfelt: remove obsolete plusb USB driver
 - Andries Brouwer: fix USB compact flash version info, add blksize ioctls

pre2:
 - Al Viro: block device cleanups
 - Marcelo Tosatti: make bounce buffer allocations more robust (it's ok
   for them to do IO, just not cause recursive bounce IO. So allow them)
 - Anton Altaparmakov: NTFS update (1.1.17)
 - Paul Mackerras: PPC update (big re-org)
 - Petko Manolov: USB pegasus driver fixes
 - David Miller: networking and sparc updates
 - Trond Myklebust: Export atomic_dec_and_lock
 - OGAWA Hirofumi: find and fix umsdos "filldir" users that were broken
   by the 64-bit-cleanups. Fix msdos warnings.
 - Al Viro: superblock handling cleanups and race fixes
 - Johannes Erdfelt++: USB updates

pre1:
 - Jeff Hartmann: DRM AGP/alpha cleanups
 - Ben LaHaise: highmem user pagecopy/clear optimization
 - Vojtech Pavlik: VIA IDE driver update
 - Herbert Xu: make cramfs work with HIGHMEM pages
 - David Fennell: awe32 ram size detection improvement
 - Istvan Varadi: umsdos EMD filename bug fix
 - Keith Owens: make min/max work for pointers too
 - Jan Kara: quota initialization fix
 - Brad Hards: Kaweth USB driver update (enable, and fix endianness)
 - Ralf Baechle: MIPS updates
 - David Gibson: airport driver update
 - Rogier Wolff: firestream ATM driver multi-phy support
 - Daniel Phillips: swap read page referenced set - avoid swap thrashing

