Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSFSCV5>; Tue, 18 Jun 2002 22:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317746AbSFSCV4>; Tue, 18 Jun 2002 22:21:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49933 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317743AbSFSCVy> convert rfc822-to-8bit; Tue, 18 Jun 2002 22:21:54 -0400
Date: Tue, 18 Jun 2002 19:18:40 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux 2.5.23
Message-ID: <Pine.LNX.4.33.0206181915001.1773-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g5J2LSj15755
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I asked "what more can you ask for" for 2.5.22, and somebody immediately 
piped up with raid5 working again.

Well, here you have a big MD merge from Neil Brown, which may or may not 
get you there. Good luck.

Other stuff: s390/x86-64/network/usb updates. Nonlinear CPU's. Build
updates: module versioning should work again. Various stuff.

			Linus

-----
Summary of changes from v2.5.22 to v2.5.23
============================================

<makisara@abies.metla.fi>:
  o 2.5.22 SCSI tape buffering changes

<martin.schwidefsky@debitel.net>:
  o 2.5.22: s390 fixes
  o 2.5.22: common code changes for s/390
  o 2.5.22: dasd patches
  o 2.5.22: elevator exports
  o 2.5.22: new xpram driver
  o 2.5.22: ibm partition support

<michaelw@foldr.org>:
  o sparc64: Use SUNW,power-off to power off some Ultra systems

<sam@mars.ravnborg.org>:
  o ip_gre.c: Use named struct initializers

<willy@debian.org>:
  o Remove SCSI_BH
  o remove tqueue.h from sched.h
  o Remove sync_timers

<zwane@linux.realnet.co.sz>:
  o Make SMP/APIC config option earlier

Adrian Bunk <bunk@fs.tum.de>:
  o drivers/char/rio/func.h needs linux/kdev_t.h

Andi Kleen <ak@muc.de>:
  o x86-64 merge
  o Move jiffies_64 down into architectures
  o Fix incorrect inline assembly in RAID-5
  o change_page_attr and AGP update

Andrew Morton <akpm@zip.com.au>:
  o writeback tunables
  o ext3 corruption fix
  o update_atime cleanup
  o grab_cache_page_nowait deadlock fix
  o mark_buffer_dirty() speedup
  o go back to 256 requests per queue
  o mark_buffer_dirty_inode() speedup
  o leave swapcache pages unlocked during writeout
  o direct-to-BIO I/O for swapcache pages
  o fix loop driver for large BIOs
  o kmap_atomic fix in bio_copy()
  o ext3: clean up journal_try_to_free_buffers()
  o clean up alloc_buffer_head()
  o take bio.h out of highmem.h
  o remove set_page_buffers() and clear_page_buffers()
  o allow GFP_NOFS allocators to perform swapcache writeout
  o rename get_hash_table() to find_get_block()
  o Reduce the radix tree nodes to 64 slots
  o msync(bad address) should return -ENOMEM

Andries E. Brouwer <Andries.Brouwer@cwi.nl>:
  o small makefile correction
  o remove path_init

Arnaldo Carvalho de Melo <acme@conectiva.com.br>:
  o net/core/neighbour.c
  o net/llc/*.c
  o # net/core/datagram.c
  o net/core/skbuff.c include/linux/skbuff.h

Benjamin LaHaise <bcrl@redhat.com>:
  o add wait queue function callback support
  o add __fput for aio

David Brownell <david-b@pacbell.net>:
  o ohci misc fixes

David S. Miller <davem@nuts.ninka.net>:
  o skbuff.c: Fix preempt fix lossage from acme cleanups
  o tg3.c: Fix typo in GA302T board ID
  o Tigon3: Make fibre PHY support work
  o ip-sysctl.txt fixes
  o Tigon3: More fiber PHY tweaks
  o MAINTAINERS: Remove Andi from networking as per his request
  o LLC: Hand merge in of toplevel Makefile bits
  o Sparc64: Update for scheduler changes
  o arch/sparc64/defconfig: Update

Frank Davis <fdavis@si.rr.com>:
  o 2.5.22 : include/linux/intermezzo_psdev.h
  o 2.5.22 : fs/intermezzo/vfs.c

Greg Kroah-Hartman <greg@kroah.com>:
  o USB usb-midi driver: remove check for kernel version, as it's not
    needed

Ingo Molnar <mingo@elte.hu>:
  o sched_yield() is misbehaving
  o comment and coding style fixes
  o sync wakeup affinity fix: do not fast-migrate threads without
    making sure that the target CPU is allowed.
  o fix preemption bug in cli()
  o sti() preemption fix

Jan Kara <jack@suse.cz>:
  o Rename of xqm.h

Jens Axboe <axboe@suse.de>:
  o ide locking botch
  o missing tag blkdev.h stuff

Jes Degn Sørensen <jes@wildopensource.com>:
  o Tigon3: Use unsigned type for dest_idx_unmasked in tg3_recycle_rx
  o Tigon3: MAX_WAIT_CNT is too large

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: asm offset generation for x86_64
  o kbuild: asm offset generation for ARM
  o kbuild: Remove remaining references to mkdep
  o kbuild: Add support for alpha asm offset generation
  o kbuild: Remove dead "make dep" commands
  o kbuild: Remove archdep
  o kbuild: modversions fix
  o kbuild: Handle removed headers
  o kbuild: Improve error message
  o kbuild: Fix "make dep clean bzImage" and the like
  o kbuild: Remove all .*.cmd files on make mrproper
  o kbuild: Improve output and error behavior when making modversions

Linus Torvalds <torvalds@home.transmeta.com>:
  o More IDE locking fixes. Found by Nick Piggin
  o Missed parts of patch from Andries
  o Missing tqueue.h includes from sched.h cleanup
  o Compiler warning - unused variable
  o Missing include file
  o Physical address 0 is normal for ACPI - don't complain
  o Linux version 2.5.23

Matthew Dharm <mdharm-usb@one-eyed-alien.net>:
  o USB storage: cleanup storage_probe()
  o USB storage: change atomic_t to bitfield, consolidate #defines

Mikael Pettersson <mikpe@csd.uu.se>:
  o fix x86 initrd breakage

Neil Brown <neilb@cse.unsw.edu.au>:
  o plugging initialisation
  o Umem 1 of 2 - Fix compile warning in umem.c
  o Umem 2 of 2 - Make device plugging work for umem
  o md 1 of 22 - Fix three little compile problem when md or raid5
    compiled with debugging
  o md 2 of 22 - Make device plugging work for md/raid5
  o md 3 of 22 - Remove md_maxreadahead
  o md 4 of 22 - Make raid5 work for big bios
  o md 5 of 22 - Fix various list.h list related problems in md.c
  o md 6 of 22 - Discard "param" from mddev structure
  o md 7 of 22 - Use wait_event_interuptible in md_thread
  o md 8 of 22 - Discard md_make_request in favour of per-personality
    make_request functions
  o md 9 of 22 - Discard functions that have been "not yet" for a long
    time
  o md 10 of 22 - Remove nb_dev from mddev_s
  o md 11 of 22 - Get rid of "OUT" macro in md.c
  o md 12 of 22 - Remove "data" from dev_mapping and tidy up
  o md 13 of 22 - First step to tidying mddev recounting and locking
  o md 14 of 22 - Second step to tidying mddev refcounts and locking
  o md 15 of 22 - Get rid of kdev_to_mddev
  o md 16 of 22 - Next small step to improved mddev management
  o md 17 of 22 - Strengthen the locking of mddev
  o md 18 of 22 - More mddev tidyup - remove recovery_sem and
    resync_sem
  o md 19 of 22 - Improve serialisation of md syncing
  o md 20 of 22 - Provide SMP safe locking for all_mddevs list
  o md 21 of 22 - Improve handling of MD super blocks
  o md 22 of 22 - Generalise md sync threads

Oliver Neukum <oliver@neukum.name>:
  o make kaweth use the sk_buff directly on tx

Paul Menage <pmenage@ensim.com>:
  o Push BKL into ->permission() calls

Russell King <rmk@arm.linux.org.uk>:
  o net/ipv6/tcp_ipv6.c: Fix new socket creation

Rusty Russell <rusty@rustcorp.com.au>:
  o ipv4/route.c: Cleanup ip_rt_acct_read
  o Latest nonlinear CPU patches
  o Make NTFS use a single uncompression-buffer
  o Net updates / CPU hotplug infrastructure missed merge

Stelian Pop <stelian.pop@fr.alcove.com>:
  o export pci_bus_type to modules

Stephen Rothwell <sfr@canb.auug.org.au>:
  o remove getname32
  o 2.5.22 compile fixes
  o Make copy_siginfo_to_user mode explicit
  o make file leases work as they should


