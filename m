Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316514AbSEUFQe>; Tue, 21 May 2002 01:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316518AbSEUFQe>; Tue, 21 May 2002 01:16:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27404 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316514AbSEUFQc>; Tue, 21 May 2002 01:16:32 -0400
Date: Mon, 20 May 2002 22:16:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.17
Message-ID: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various FS updates (including merges of quota and iget_locked), and
Makefile cleanups from Kai.

And yet more TLB shootdown stuff.

		Linus

-----

Summary of changes from v2.5.16 to v2.5.17
============================================

<acme@conectiva.com.br>
	copy_from/to_user checking in
	 o drivers/sound/*.c
	 o fs/intermezzo/ext_attr.c
	 o drivers/isdn/*.c
	 o drivers/usr/*.c
	 o sound/{core,pci}/*.c
	 o drivers/char/*
	 o drivers/block/*.c

Andrew Morton <akpm@zip.com.au>
	o check for dirtying of non-uptodate buffers
	o reduce lock contention in do_pagecache_readahead
	o larger b_size, and misc fixlets
	o fix dirty page management
	o reiserfs locking fix
	o pdflush exclusion infrastructure
	o dirty inode management
	o i_dirty_buffers locking fix
	o ext2: preread inode backing blocks
	o pdflush exclusion
	o fix ext3 race with writeback
	o fix ext3 buffer-stealing
	o writeback tuning
	o remove PG_launder
	o improved I/O scheduling for indirect blocks

<david@gibson.dropbear.id.au>
	o Missing init.h in drivers/pci/power.c

<dmccr@us.ibm.com>
	o Thread group exit problem reappeared

Christoph Hellwig <hch@infradead.org>
	o cleanup read/write
	o Small cleanup of nfsd export checks
	o kNFSd cleanup of nfsd_open
	o get rid of <linux/locks.h>

<jack@suse.cz>
	o quota-1-newlocks
	o quota-2-formats
	o quota-3-register
	o quota-4-getstats
	o quota-5-space
	o quota-6-bytes
	o quota-7-quotactl
	o quota-8-format1
	o quota-9-format2
	o quota-10-inttype
	o quota-11-sync
	o quota-12-compat
	o quota-13-ioctl

<jaharkes@cs.cmu.edu>
	o iget_locked  [1-6]

<jhammer@us.ibm.com>
	o ips for 2.5

<kai@tp1.ruhr-uni-bochum.de>
	o Rules.make cleanup: introduce c_flags, a_flags
	o Remuve some cruft from top-level Makefile
	o Move DocBook stuff out of top-level Makefile
	o Move arch specific options to their Makefile
	o Don't implicitly export all symbols
	o top-level Makefile cleanup
	o Remove assembler rules from top-level Makefile
	o Add scripts to generate include/linux/{version,compile}.h
	o Rules.make: Use variables for commands
	o Small Rules.make cleanup
	o Rules.make: check for changed command line
	o Makefile cleanup: Don't rebuild init/version.o on each build
	o IA64: Use standard AS rule
	o x86_64: Use standard AS rule
	o Rules.make: Remove special rule for $(export-objs)
	o Fix a typo in drivers/pcmcia/Makefile
	o Fix arch/alpha/boot AS rule
	o Makefile: fix merge
	o ISDN: Export CAPI user interface directly
	o ISDN: Remove remaining MOD_{INC,DEC}_USE_COUNT from CAPI drivers
	o Make AFLAGS_KERNEL use consistent with CFLAGS_KERNEL
	o ISDN: CAPI: Remove duplicate statistics
	o ISDN: CAPI: Remove capi_interface_user etc.
	o ISDN: CAPI: Move the notification callback
	o ISDN: Have the CAPI application alloc struct capi_appl
	o ISDN: CAPI: Pass struct capi_appl * instead of index
	o ISDN: CAPI use struct capi20_appl * in signal callback
	o ISDN: CAPI: Get rid of capi_signal mechanism
	o ISDN: AVM T1 ISA CAPI controller fix
	o Update /BitKeeper/etc/ignore
	o kbuild: Use $(CURDIR)
	o kbuild: Suppress printing of '$(MAKE) -C command' line
	o kbuild: Fix object-specific CFLAGS_foo.o
	o Small fix for net/irda/Makefile
	o Fix ext2 compilation
	o Fix some compiler warnings
	o kbuild: Remove generated .<object>.cmd files on 'make clean'
	o kbuild: Standardize building of init/*
	o kbuild: Speed up vmlinux build

<mason@suse.com>
	o reiserfs bitops warnings
	o reiserfs iput deadlock fix

Neil Brown <neilb@cse.unsw.edu.au>
	o Increase snd buffer size for UDP
	o Change MD Superblock IO to go straight to submit_bio
	o Tidy up raid5 code
	o Initial md/raid5 support for 2.5 (with bio)

<torvalds@transmeta.com>
	o Clean up %cr3 loading on x86, fix lazy TLB problem
	o Fix double i_writecount handling (Tony Luck)
	o Make generic TLB shootdown friendlier to non-x86 architectures
	o Fix OSS API emulation when sound is compiled as a module
	o Update kernel version to 2.5.17
	o New makefiles generate .*.cmd files, not .*.flags files


