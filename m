Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313189AbSEYCDi>; Fri, 24 May 2002 22:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSEYCDh>; Fri, 24 May 2002 22:03:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15628 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313189AbSEYCDg>; Fri, 24 May 2002 22:03:36 -0400
Date: Fri, 24 May 2002 19:02:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.18
Message-ID: <Pine.LNX.4.33.0205241902001.1537-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Various bits here and there. 

		Linus

----

Summary of changes from v2.5.17 to v2.5.18
============================================

<Andries.Brouwer@cwi.nl>
	o usb-storage

<acme@conectiva.com.br>
	o drivers/char/rio/*.c

<beattie@beattie-home.net>
	o change USB scanner maintainer

Brian Gerst <bgerst@didntduck.org>
	o cpu_has_tsc
	o cpu_has_mmx
	o remaining cpu_has cleanups

<borisitk@fortunet.com>
	o [ARM 1146/1: Fix complilation bug in 2.5.10-rmk1 for jffs

<ccaputo@alt.net>
	o net/core/sock.c: Fix typo in sysctl_{w,m}mem_default init.

<ch@hpl.hp.com>
	o [ARM 1136/1: missing include in badge4.c
	o [ARM 1133/1: Small fixes for BadgePAD 4 pcmcia support.
	o [ARM 1137/1: additional defines for SA-1111 OHCI

<colin@gibbs.dhs.org>
	o Sparc: Do not BUG in srmmu_pte_alloc_one.
	o include/asm-sparc/pgalloc.h: In pmd_alloc_one, dont BUG just return NULL

Martin Dalecki <dalecki@evision-ventures.com>
	o 2.5.17 dquota punishment
	o 2.5.17 IDE 65-70

<davem@nuts.ninka.net>
	o Sparc: Use dma_addr_t and size_t in sparc32 DMA function args.
	o IPv4: Make pkt_too_big debug msg more informative.
	o drivers/net/sunlance.c: Make init_block_dvma a dma_addr_t
	o Tigon3: Fix typo in netgear ga320t support changes.
	o Sparc64 updates
	o Fix build fallout from namei.h/jiffies.h changes.
	o Sparc64 build fixes:

<david-b@pacbell.net>
	o cpia_usb, remove urb->next
	o usbcore, remove urb->next
	o hcds, remove urb->next
	o audio, set urb->interval

<dhowells@redhat.com>
	o rwsem update

<greg@kroah.com>
	o USB Makefile bug fix
	o USB build changes
	o USB se401, remove urb->next usage
	o USB stv680, remove urb->next usage
	o usb.h #include dependancies and whitespace cleanup
	o USB cdc-ether driver compile time fix
	o USB storage #include fixup
	o USB driver #include cleanups

Christoph Hellwig <hch@infradead.org>
	o fix bitop warnings in parallel port generic driver
	o buffermem_pages removal (1/5)
	o fix sr compile warnings
	o bfs header move around + warning fix
	o split namei.h out of fs.h
	o include buffer_head.h in actual users instead of fs.h (1/10)

<jbglaw@lug-owl.de>
	o Update to srm_env.c driver (for Alpha arch.)

<kai@tp1.ruhr-uni-bochum.de>
	o kbuild: Make USE_STANDARD_AS_RULE default
	o Fix UTS_MACHINE
	o Fix building .i / .s files for testing
	o kbuild: Stop immediately on error
	o kbuild: aic7xxx firmware build should not overwrite shipped files
	o kbuild: Regenerate include/linux/version.h only if necessary
	o kbuild: Restore build nr, improve vmlinux link
	o drivers/net: Simplify linking of subdirs
	o Simplify linking/building objects in subdirectories
	o drivers/pnp/pnpbios_core.c: Warning fix
	o kbuild: Fix command line printing
	o kbuild: Fix warning when .version doesn't exist yet
	o kbuild: Rearrange Rules.make
	o kbuild: Consistent use of [AC]FLAGS_KERNEL and MODFLAGS
	o EXPORT_SYMBOL: Remove EXPORT_NO_SYMBOLS from arch/*
	o EXPORT_SYMBOL: Remove EXPORT_NO_SYMBOLS from drivers/*
	o EXPORT_SYMBOL: Remove the option of implicitly exporting symbols
	o EXPORT_SYMBOL: Remove EXPORT_NO_SYMBOLS from fs/*
	o EXPORT_SYMBOL: Remove EXPORT_NO_SYMBOLS from net/*
	o EXPORT_SYMBOL: Remove EXPORT_NO_SYMBOLS from sound/*
	o kbuild: Use standard multi-part object declaration in drivers/char/*
	o ISDN: Fix compiler warnings
	o kbuild: Use standard multi-part object declaration in drivers/video/*
	o kbuild: Small cleanups
	o ISDN: Use 'built-in.o' instead of 'vmlinux-obj.o' as O_TARGET
	o ISDN: Move AVM Config.help entries to right dir
	o kbuild: Assorted small cleanups
	o Fix dummy gameport_{,un}register_port
	o Compiler warning fixes
	o kbuild: Clean up sound/*/Makefile
	o Add missing includes
	o kbuild: Remove now redundant 'O_TARGET := built-in.o' lines
	o kbuild: Make O_TARGET default to 'built-in.o'
	o kbuild: Beautify ACPI Makefiles
	o kbuild: Remove usage of L_TARGET in drivers/*
	o kbuild: Correct dependencies for generated soundmodem tables
	o kbuild: Use standard multi-part object declaration in lib/*
	o kbuild: Simplify linking subdirs in drivers/*/Makefile
	o kbuild: Use standard multi-part object declaration in fs/*
	o kbuild: Use standard multi-part object declaration in net/*
	o kbuild: Fix some issues I missed before

<kuznet@ms2.inr.ac.ru>
	o tcp_input.c: Really make sure rto = 3*rtt, found by Pasi Sarolahti
	o tcp_recvmsg: Fix application bug induced races with MSG_PEEK and copied_seq.

<mason@suse.com>
	o reiserfs 64 bit bug in get_virtual_node_size

<mikpe@csd.uu.se>
	o possible fix for broken floppy driver, take 2

<pavel@ucw.cz>
	o suspend-to-{RAM,disk} fixup
	o suspend-to-{RAM,disk}
	o more suspend-to-{RAM,disk} fixes
	o One more fix for swsusp
	o swsusp cleanups
	o swsusp: making myself maintainer
	o swsusp fixes

<petkan@mastika.lnxw.com>
	o USB pegasus driver, new vendor and device id.

<rmk@flint.arm.linux.org.uk>
	o [ARM] 2.5.15 PCI cleanups/fixups
	o [ARM] 2.5.15 random fixups:
	o [ARM] Make etherh.c build again - combine struct ei_device inside our
	o [ARM] Fix build errors caused by fb changes
	o [ARM] Fixups for GCC 3.x:
	o [ARM] Miscellaneous
	o [ARM] Remove old NetWinder uncompressed kernel image compatibility code.
	o [ARM] Acorn DMA/Expansion card fixups
	o [ARM] Make Acorn SCSI drivers build again.

<rml@tech9.net>
	o remove preempt_disable from pdflush
	o get/put_cpu methods

<rusty@rustcorp.com.au>
	o Tasklet cleanup
	o Futex update.
	o DMA-mapping.txt typo fix
	o printk() cleanup in ide-pnp.c
	o drivers/net/epic100.c: missing __devinit
	o drivers_net_sundance.c: missing __devinit
	o declance.c
	o Remove warning in fs/nfs/nfsroot.c
	o Fix order of #includes in init_version.c
	o check_region elimination
	o serial typo
	o MIPS min/max replacement
	o MIPS min/max replacement II
	o min/max elimination in netfilter.h
	o cris signal fix
	o sigio delivery fix
	o check_region elimination
	o MIPS/MIPS64  signal fix
	o jiffies.h
	o arch/arm/kernel/via82c505.c
	o smp_call_function doco fix
	o check_region elimination
	o check_region elimination

<shaggy@austin.ibm.com>
	o jfs_readdir does not need to grab BKL
	o JFS external journal support

<simonb@lipsyncpost.co.uk>
	o Tigon3: Add Netgear GA320T support.

<torvalds@transmeta.com>
	o Make the pte unmapping atomic wrt other threads.
	o Fix over-eager header file cleanup
	o Merge DRI CVS tree into standard kernel
	o Fix up more headers to make the drm merge compile more cleanly
	o Undo block devices changes from floppy fix: incorrect.
	o Update kernel version
	o Move check_pgt_cache() to tlb_finish_mmu().
	o Make sw-suspend compile even without ACPI sleep support.
	o Clean up tlb_start/end_vma.
	o Fix up header file

Alexander Viro <viro@math.psu.edu>
	o add proper ->getattr()
	o remove s390 procfs abuses
	o kill ->i_op->revalidate()
	o clean up readdir() for in-memory
	o new helpers for /proc
	o rd.c blocksize handling
	o removal of BKL from d_move()
	o md.c cleanup
	o kdev_t -> bdev cleanups

<zippel@linux-m68k.org>
	o m68k mmu update


