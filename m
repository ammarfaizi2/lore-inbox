Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSIJSvi>; Tue, 10 Sep 2002 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSIJSvi>; Tue, 10 Sep 2002 14:51:38 -0400
Received: from zeus.kernel.org ([204.152.189.113]:14823 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318017AbSIJSve>;
	Tue, 10 Sep 2002 14:51:34 -0400
Date: Tue, 10 Sep 2002 15:04:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.20-pre6
Message-ID: <Pine.LNX.4.44.0209101501200.16518-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So here goes -pre6.


Summary of changes from v2.4.20-pre5 to v2.4.20-pre6
============================================

<bheilbrun@paypal.com>:
  o Fix e100 driver compilation

<bmatheny@purdue.edu>:
  o Lexar USB CF Reader

<cel@citi.umich.edu>:
  o prevent oops in xprt_lock_write, against 2.4.20

<green@angband.namesys.com>:
  o Turn on blocks preallocation by default for reiserfs
  o reiserfs: Mistakenly forgotten inode attributes option was added back
  o reiserfs: Take into account file information even when not doing preallocation. Fixes a bug with displacing_large_files option
  o reiserfs: Fix a problem with delayed unlinks and remounting RW filesystem RW
  o reiserfs: Allow to insert more than one unformatted pointer into the tree at a time. Use that to speed up hole creation/filling
  o Implemented reiserfs_file_write(), to write large amount of data at once into files on reiserfs volumes which should boost write speed somewhat and also should be somewhat more SMP friendly
  o Export generic_osync_inode,block_commit_write, remove_suid

<hch@lst.de>:
  o list.h update (resent again)

<hpa@zytor.com>:
  o Patch: Make Transmeta Crusoe processors report "i686"
  o tmpfs: return a nonzero size for directories
  o Make framebuffer work on ATI Rage Mobility P/M

<kkeil@suse.de>:
  o Fixup Eicon Diva support

<pekon@informatics.muni.cz>:
  o Patch to include support for Minolta Dimage 7i

<petkan@users.sourceforge.net>:
  o USB: pegasus.h
  o USB: pegasus driver patch

<sct@redhat.com>:
  o 2.4.20-pre4/ext3: Fix O_SYNC for non-data-journaled

Adrian Bunk <bunk@fs.tum.de>:
  o Fix .text.exit error with static compile of synclinkmp.c

Alan Cox <alan@lxorguk.ukuu.org.uk>:
  o forte sound
  o old Acorn error handling paths
  o remove bogoprintk, add LBA28 to paride
  o L make i845 gart recover after suspend
  o enable amd watchdog in config.in
  o makefile for amd tco
  o fix missing checks in video1394
  o more irda __FUNCTION__ stuff
  o fix sisfb errors
  o IRDA function stuff
  o further khttpd updates
  o i845G fixes

Alexander Viro <viro@math.psu.edu>:
  o handle_initrd() and request_module()

Christoph Hellwig <hch@sb.bsdonline.org>:
  o JFS: cosmetical changes to reduces the diff to 2.5
  o JFS: remove jfs_get_volume_size
  o JFS: backport lmLogWait from 2.5
  o JFS: Remove unused file jfs_extendfs.h
  o JFS: use buffer_heads to access the superblock
  o JFS: use block device inode/mapping instead of direct_inode/direct_mapping
  o JFS: ifdef out unused functions related to partial blocks
  o JFS: sync the block device on umount or r/o remount
  o JFS: we still need extHint
  o [VFS] Add support for extended attributes
  o JFS: backport xattr support from 2.5
  o JFS: remove superflous includes

Dave Kleikamp <shaggy@kleikamp.austin.ibm.com>:
  o Move 24-bit byte-swapping code out of JFS-specific code
  o JFS: rework extent invalidation
  o JFS: Add write_super_lockfs() and unlock_fs() for snapshot
  o JFS: extended attribute fixes

David Brownell <david-b@pacbell.net>:
  o USB: ohci completion of unlinked urbs patch

David S. Miller <davem@nuts.ninka.net>:
  o [SPARC64]: Ultra-III+ updates and better error trap logging
  o arch/sparc64/kernel/cpu.c: Fix typo in printk
  o arch/sparc64/kernel/traps.c: Add spitfire_ prefix to clean_and_reenable_l1_caches, BUG on non-spitfire cpus
  o include/asm-sparc64/rwsem.h: Add __down_{read,write}_trylock
  o [TIGON3]: PHY reset fixes
  o [TIGON3]: Make sure to always enable AS_MASTER bits when necessary
  o [TIGON3]: PCI write posting fixes
  o [TIGON3]: tr32_mailbox does not exist, use tr32 :-)
  o [TIGON3]: Low power, wake-on-lan, and DMA test fixes
  o drivers/md/raid1.c:raid1_read_balance workaround gcc miscompile on sparc64
  o drivers/usb/rtl8150.c: Include linux/init.h
  o [IGMP]: Make ip_mc_dec_group return void
  o net/core/dst.c: asm/bitops.h --> linux/bitops.h
  o net/ipv4/netfilter/ipchains_core.c: Fix MODULE_LICENSE
  o drivers/net/ppp_generic.c: Fix byte-aligned packets, nearly every arch csum_partial cannot handle this
  o arch/sparc64/kernel/ioctl32.c: Handle SIOCDEVPRIVATE transparently
  o net/core/pktgen.c: Access userspace properly
  o drivers/net/ppp_generic.c: Fix skb_put len arg when copying unaligned skb
  o arch/sparc64/defconfig: Update
  o arch/sparc64/defconfig: Turn rtl8150 back on
  o drivers/net/ppp_generic.c: Allocate right length in unaligned SKB fix
  o arch/sparc64/kernel/ioctl32.c: Translate PPPIOCS{PASS,ACTIVE}
  o [TIGON3]: When not low-power, only set GPIO enables in lclctrl on 5700 chips
  o arch/sparc64/lib/VIScsum.S: Do not use VIS on oddly aligned buffer
  o drivers/net/ppp_generic.c: Revert my idiotic unaligned SKB changes
  o arch/sparc64/lib/VIScsum.S: Fix endianness bugs in previous change
  o arch/sparc64/kernel/ioctl32.c: Frob cmd in PPPIOCS{PASS,ACTIVE}
  o [TIGON3]: Merge TSO code from 2.5.x driver, disabled in 2.4.x
  o [TCP]: Delay tstamp state commit in input fast path until we verify csum

Geert Uytterhoeven <geert@linux-m68k.org>:
  o HP300 I/O updates
  o Wrong fbcon_mac dependency
  o Mac/m68k debug fixes
  o M68k core I/O fixes
  o HP300 updates
  o Spelling fixes
  o Mac/m68k Sonic fix
  o Mac/m68k Nubus updates
  o Amiga serial driver fix
  o Atari STRAM fixes
  o Mac/m68k I/O updates
  o Zorro bus ID updates
  o M68k IRQ configuration fix
  o M68k VT updates
  o Parport fixes
  o Sun-3/3x initialization fix
  o Mac/m68k build fix
  o 16550 serial fix
  o HP300 LANCE driver updates
  o M68k dump_stack() update
  o Amiga Clgenfb hack
  o Atari ATI Mach64 fixes
  o Apollo mouse driver update
  o HP300 DIO bus updates
  o Apollo keyboard driver update
  o M68k configuration updates
  o BVME6000 RTC driver update
  o M68k compile fixes
  o Misc Mac/m68k updates

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: added LCD driver
  o USB: updated the bluetooth driver to the latest version
  o USB: usbserial core synced up with the 2.5 version
  o belkin_sa update due to usbserial core changes
  o USB: cyberjack update due to usbserial core changes
  o USB: digi_acceleport update due to usbserial core changes
  o USB: empeg update due to usbserial core changes
  o USB: ftdi_sio update due to usbserial core changes
  o USB: io_edgeport update due to usbserial core changes
  o USB: io_ti update due to usbserial core changes
  o USB: ipaq update due to usbserial core changes
  o USB: ir-usb update due to usbserial core changes
  o USB: keyspan_pda update due to usbserial core changes
  o USB: keyspan update due to usbserial core changes
  o USB: kl5kusb105 update due to usbserial core changes
  o USB: mct_u232 update due to usbserial core changes
  o USB: omninet update due to usbserial core changes
  o USB: pl2303 update due to usbserial core changes
  o USB: visor update due to usbserial core changes
  o USB: whiteheat update due to usbserial core changes

Harald Welte <laforge@gnumonks.org>:
  o MAINTAINERS: Update NETFILTER entry
  o [NETFILTER]: Fix OOPS in ipt_ULOG

Itai Nahshon <nahshon@actcom.co.il>:
  o USB keyboards (patch)

Marcelo Tosatti <marcelo@plucky.distro.conectiva>:
  o scsi_scan.c
  o Makefile
  o xattr.h

Neil Brown <neilb@cse.unsw.edu.au>:
  o kNFSd - More small fixes for TCP nfsd

Oliver Neukum <oliver@neukum.name>:
  o USB: backport of kaweth driver

Paul Fulghum <paulkf@microgate.com>:
  o Configure.help (synclinkmp/_cs)

Paul Mackerras <paulus@samba.org>:
  o PPC32: ensure that sys_[rt_]sigsuspend give the correct error code
  o PPC32: minor boot wrapper fixes
  o PPC32: Ensure the MMU hash table gets set up correctly on POWER3
  o PPC32: Add some new PPC config options and update the defconfigs
  o PPC32: Updates for the MPC8xx embedded PowerPC machines
  o PPC32: Improved support for the CHRP platform
  o PPC32: Updates for the APUS platform
  o PPC32: Move some openfirmware-specific code
  o PPC32: a bunch of minor fixes (spinlock debug, comments, etc.)
  o PPC32: Minor updates to the restart/halt functions for PReP
  o PPC32: Implement __down_read/write_trylock for PPC32

Pete Zaitcev <zaitcev@redhat.com>:
  o Patch for urb->status abuse in usb-storage in 2.4

Petr Vandrovec <vandrove@vc.cvut.cz>:
  o ncpfs misc fixes

Tomas Szepe <szepe@pinerecords.com>:
  o warnkill trivia 1/2


