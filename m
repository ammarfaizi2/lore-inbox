Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSFTXZ3>; Thu, 20 Jun 2002 19:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315870AbSFTXZ2>; Thu, 20 Jun 2002 19:25:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41732 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315862AbSFTXZ0>; Thu, 20 Jun 2002 19:25:26 -0400
Date: Thu, 20 Jun 2002 16:22:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.24
Message-ID: <Pine.LNX.4.33.0206201614450.1316-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm. I'm making ready to leave for the kernel summit and OLS, and so are
apparently other people - since I was mailbombed by various patches in the
last few days.

However, now it's too late - I'm leaving early tomorrow morning, and
anybody who left their pre-OLS sync this late is just _too_ late.  
Phththhthh..

Big sound merges, NTFS merge, IrDA, IPv6, SCSI drivers, you name it. Rusty
"it's two l's, dammit!" Russell sent in about a million of his trivial
patches, hopefully they got somewhat correctly attributed and merged.

Oh, and IDE 93 should undo the damage of IDE 92.

See you in a week,

			Linus

-----

Summary of changes from v2.5.23 to v2.5.24
============================================

<ac9410@bellsouth.net>:
  o 2.5.23 i2c updates 1-4

<arnd@bergmann-dalldorf.de>:
  o fix lots of warnings about 'struct tty_driver'

<asl@launay.org>:
  o ACPI warning fix
  o Re: nbd.c warning fix

<bombe@informatik.tu-muenchen.de>:
  o Fix bashisms in scripts_patch-kernel

<cananian@lesser-magoo.lcs.mit.edu>:
  o 2.5.23: missing tqueue.h in cpia_pp.c

<gnb@alphalink.com.au>:
  o tons of small patches through Rusty 'TRIVIAL' Russell

<james@cobaltmountain.com>:
  o typo in jazz_esp.c
  o typo in smt.h
  o Typo in radeonfb.c printk()

<lm@work.bitmover.com>:
  o Make the find command ignore BitKeeper files throughout

<manik@cisco.com>:
  o More __builtin_expect() cleanup in favour

<pdelaney@lsil.com>:
  o Fusion driver update

<willy@debian.org>:
  o Convert cm206 to a tasklet

<wli@holomorphy.com>:
  o buddy system comment
  o convert BAD_RANGE() to an inline function
  o beautify nr_free_pages()
  o remove unnecessary headers from mm_page_alloc.c
  o remove unnecessary parentheses from expand()

Adrian Bunk <bunk@fs.tum.de>:
  o Patch to fix all known linux/tqueue.h compile errors

Andi Kleen <ak@muc.de>:
  o Another RAID-5 XOR assembly fix

Andreas Dilger <adilger@clusterfs.com>:
  o TRIVIAL EPERM -> EACCESS

Andrey Panin <pazke@orbita1.ru>:
  o add unlikely() into add_timer()

Anton Altaparmakov <aia21@cantab.net>:
  o NTFS: 2.0.9 release. Decompression engine now uses a single buffer
    and other cleanups
  o NTFS: Fix typo
  o NTFS: 2.0.10 - There can only be 2^32 - 1 inodes on an NTFS volume

Benjamin LaHaise <bcrl@redhat.com>:
  o export default_wake_function

Dave Jones <davej@suse.de>:
  o udpated 3ware driver from vendor

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o Fix races in JFS threads
  o JFS: Yet another truncation fix
  o JFS does not need to set i_version.  It is never used
  o Exclusive access to JFS journal devices
  o JFS: recalc_sigpending has no argument
  o JFS: fix fsync
  o JFS: Use new list_move function

David Mosberger <davidm@napali.hpl.hp.com>:
  o nasty bug in free_pgtables() (for ia64)

David S. Miller <davem@nuts.ninka.net>:
  o Sparc64: Update for CPU hotplugging changes
  o drivers/net/sungem.c: Include linux/tqueue.h
  o drivers/md/md.c: Fix typo, struct dname --> dev_name_t

Edward Peng <edward_peng@dlink.com.tw>:
  o dl2k gige net driver update

Greg Kroah-Hartman <greg@kroah.com>:
  o drivers/hotplug/cpqphp.h must include tqueue.h

Ingo Molnar <mingo@elte.hu>:
  o this patch fixes the migration init to correctly work with the new
    hot-pluggable CPU enumeration method, and the possibility to not
    boot on CPU#0.
  o small UP optimisation from Mikael Pettersson and James Bottomley,
    modified

Jaroslav Kysela <perex@suse.cz>:
  o ALSA update

Jean Tourrilhes <jt@hpl.hp.com>:
  o IrDA update 1/2: cache-wait-data fixes
  o IrDA update 2/2: big header and initcall cleanup

Jeff Garzik <jgarzik@mandrakesoft.com>:
  o Update 8139cp net driver to support NIC-specific statistic dumps
  o Update 8139 net drivers for the following fixes
  o Add extended attribute syscall numbers to alpha port
  o Add NIC-specific stats and register dumping to 8139too net driver

Jens Axboe <axboe@suse.de>:
  o uninline elv_next_request()

Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>:
  o kbuild: Link netfilter from parent dirs
  o kbuild: clean up net/802/Makefile
  o kbuild: clean up generated files in net/802
  o kbuild: improve net/khttpd file generation
  o Make net_dev_init() an __initcall
  o kbuild: clean up drivers/scsi firmware generation, part 1
  o kbuild: cleanup drivers/scsi firmware generation, part 2
  o kbuild: cleanup drivers/scsi firmware generation, part 3
  o kbuild: Introduce $(obj), $(src)
  o kbuild: Shipped file fixes
  o kbuild: Revert automatically building modules
  o ISDN: Make ISA-only drivers depend on CONFIG_ISA
  o kbuild: Fix net/llc/Makefile
  o kbuild: Add $(obj), $(src) for generated files
  o ISDN: Small fixes from -dj
  o ISDN: Add #include <linux/tqueue.h>
  o ISDN: Add drivers/isdn/hisax/avma1_cs.c from 2.4
  o ISDN: Add #include <linux/init.h> to drivers/isdn/hisax/avma1_cs.c
  o ISDN: s/ioremap_nocache/ioremap/g

Linus Torvalds <torvalds@home.transmeta.com>:
  o Fix UP compile by having the trivial cpu_online_map
  o Don't remove zero-sized files. Some of them might be real
  o Fix up various odds and ends after big merges
  o Linux version 2.5.24

Martin Dalecki <dalecki@evision-ventures.com>:
  o IDE 93

Neil Brown <neilb@cse.unsw.edu.au>:
  o Don't lock array for START_ARRAY
  o Md sync: Remove compiler warning that revealed a bug
  o Make ITERATE_MDDEV work on non-SMP

Robert Kuebel <kuebelr@email.uc.edu>:
  o 3c509.c - 2_2
  o namespace.c - compiler warning

Robert Love <rml@tech9.net>:
  o preempt-safe do_softirq
  o mark 3 variables as __initdata

Rusty Russell <rusty@rustcorp.com.au>:
  o Futex bugfixes
  o Async Futex
  o Fix SMP compilation with 'multiquad' driver
  o trivial: reiserfs whitespace
  o Trivial TAP_TUN patch to remove minmax macros

Stelian Pop <stelian.pop@fr.alcove.com>:
  o include <linux/tqueue.h> in pcmcia drivers
  o export ioremap_nocache to modules

Stephen Rothwell <sfr@canb.auug.org.au>:
  o make kstack_depth_to_print and some APM stuff static
  o dup_task_struct can be static
  o ext2 statics
  o ipv6 statics
  o Consolidate sys_pause


