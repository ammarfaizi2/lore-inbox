Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288748AbSERH6E>; Sat, 18 May 2002 03:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSERH6E>; Sat, 18 May 2002 03:58:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12305 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288748AbSERH6C>; Sat, 18 May 2002 03:58:02 -0400
Date: Sat, 18 May 2002 00:57:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.5.16
Message-ID: <Pine.LNX.4.33.0205180051100.3170-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Testing the shortlog format, full changelogs on the kernel site ]

Well, I dunno if the short changelog format is wonderfully readable, but 
at least it's small enough that I don't feel bad about mailbombing the 
kernel list with it.

USB and architecture updates, IDE driver updates etc. The one that kept me
personally somewhat busy was the interesting Intel SMP-P4 TLB corruption
bug, which ends up being due to some very funky asynchronous speculative
TLB fill logic, which made the page table invalidation "exciting".

The TLB invalidate rewrite will likely have broken all other architectures 
(at least performance-wise, if not in any other way), so architecture 
maintainers look out!

		Linus

-----

Summary of changes from v2.5.15 to v2.5.16
============================================

<acher@in.tum.de>
	o USB-UHCI-HCD

Anton Altaparmakov <aia21@cantab.net>
	o NTFS 2.0.7: minor cleanup, remove NULL struct initializers
	o NTFS 2.0.7 release: pure cleanups.

Jens Axboe <axboe@suse.de>
	o fix scsi oops on failed sg table allocation

<bunk@fs.tum.de>
	o Include linux/slab.h not linux/malloc.h in pc300 wan driver.

Martin Dalecki <dalecki@evision-ventures.com>
	o 2.5.15 IDE 60
	o 2.5.15 IDE 61
	o 2.5.15 IDE 62a
	o 2.5.15 IDE 63
	o 2.5.15 IDE 64

<davem@nuts.ninka.net>
	o Sparc64 fixes:
	o Sparc64: Delete AOFF_task_fpregs define.
	o tcp_ipv4.c: Do not increment TcpAttemptFails twice.
	o Sparc64: Make pcibios_init return an int.
	o Ingress packet scheduler: Fix compiler error when CONFIG_NET_CLS_POLICE is disabled.
	o Sparc64: Bitops take unsigned long pointer.
	o Sparc64: Fix typos in bitops changes.
	o Sparc64: Missing parts of previous math-emu fixes.

<david-b@pacbell.net>
	o -- ehci misc FIXMEs
	o -- hub/tt error recovery

<david@gibson.dropbear.id.au>
	o Update orinoco driver to 0.11b

<dirk.uffmann@nokia.com>
	o 1127/1: static PCI memory mapping for ARM Integrator reduced
	o 1126/1: Kernel decompression in head.S does not work for ARM 9xx architectures
	o 1130/1: Remove support for prefetchable PCI memory on ARM Integrator

<dwmw2@infradead.org>
	o zlib_inflate return code fix. Again.

<george@mvista.com>
	o 64-bit jiffies, a better solution

<greg@kroah.com>
	o USB storage
	o USB storage
	o USB storage drivers
	o USB storage
	o usb_submit_urb fix for broken usb devices
	o USB device reference counting api cleanup changes
	o USB sddr55 minor to enable a MDSM-B reader
	o Change to the USB core to retry failed devices on startup.
	o USB Config.in and Makefile fixups
	o USB - fix a compiler warning in the core code
	o USB - Host controller Config.in changes

Christoph Hellwig <hch@infradead.org>
	o IPv4 Syncookies: Remove pointless CONFIG_SYN_COOKIES ifdef.

<henrique@cyclades.com>
	o Change maintainer info of PC300 WAN driver.

<hirofumi@mail.parknet.co.jp>
	o Fixed the handling of file name containing 0x05 on vfat

<jdavid@farfalle.com>
	o Add full duplex support to 3c509 net driver.

Jeff Garzik <jgarzik@mandrakesoft.com>
	o Add new pci id to tulip net driver.
	o Merge 2.4.x changes for old OSS ac97_codec driver:
	o via-rhine net driver minor fixes and cleanups:
	o Update MII generic phy driver to properly report link status.
	o Fix phy id masking in 8139too net driver.

<johannes@erdfelt.com>
	o uhci.c FSBR timeout
	o USB device reference counting fix for uhci.c and usb core
	o 2.4.19-pre8 uhci.c incorrect bit operations
	o 2.4.19-pre8 uhci.c incorrect bit operations
	o uhci-hcd for 2.5.15

<jt@hpl.hp.com>
	o Fix four similar off-by-one errors in wireless net drvr core.
	o IrDA update 1/3:
	o IrDA update 2/3, set_bit updates:
	o IrDA update 3/3:

<kai@tp1.ruhr-uni-bochum.de>
	o ISDN: maintain outstanding CAPI messages in the drivers
	o Use standard AS rule.
	o ISDN: AVM CAPI drivers: Common revision parsing
	o ISDN: Usage count for CAPI controllers
	o ISDN: Init ISA AVM CAPI drivers at module load time
	o ISDN: Release AVM CAPI controllers at module unload time

<kasperd@daimi.au.dk>
	o Fix oops-able situation in 3c509 net driver

Manfred Spraul <manfred@colorfullife.com>
	o usb-storage locking fixes

Neil Brown <neilb@cse.unsw.edu.au>
	o - kNFSd in 2.5.15 - Require export operations for exporting a filesystem
	o - kNFSd in 2.5.15 - export_operations support for isofs
	o Micro Memory battery backed RAM card driver

<nico@cam.org>
	o [ARM 1110/1: fixes to the ARM checksum code

<os@emlix.com>
	o cs89x0 net driver minor fixes, SH4 support, and cmd line media support

<paulus@nanango.paulus.ozlabs.org>
	o PPC32: This changeset updates several of the powermac-specific

<quintela@mandrakesoft.com>
	o tulip net driver 2114x phy init fix

<rgooch@atnf.csiro.au>
	o misc.c:
	o Fixed race when devfs lookup()/readdir() triggers partition rescanning.
	o Minor cleanup of fs/devfs/base.c:scan_dir_for_removable().

<rl@hellgate.ch>
	o Cosmetic cleanups, remove unused struct members from via-rhine net driver

Russell King <rmk@flint.arm.linux.org.uk>
	o [ARM] Localise old param_struct to arch/arm/kernel/compat.c.
	o [ARM] Fix signedness of address comparisons, causing boots on some
	o Pass a physical address from the boot loader for the location of the
	o Always allow CONFIG_CMDLINE to be set or edited by the user.
	o Clean up do_undefinstr - it only needs to take the pt_regs pointer
	o A pile of missed kernel stack accessing functions were still using
	o [ARM] Don't write to read-only registers.
	o [ARM] SA1100 cleanups:
	o [ARM] Couple of small fixes:
	o [ARM] ADFS updates/fixes.
	o 2.5.14 updates - for the new memory management pfn() macros.  Also,

<rml@tech9.net>
	o clean up maximum priorities

<rusty@rustcorp.com.au>
	o Hotplug CPU prep

<shaggy@austin.ibm.com>
	o Prevent deadlock in JFS when flushing data during commit

<skyrelighten@yahoo.co.kr>
	o Add to list of supported 8139 net boards.

<tcallawa@redhat.com>
	o Sparc64: Export batten_down_hatches
	o Sparc: Use proper sys_{read,write} prototypes in SunOS
	o drivers/video/aty/mach64_gx.c: Include sched.h

Linus Torvalds <torvalds@transmeta.com>
	o Fix 'export-objs' usage in Makefiles. 
	o Make arm default to little-endian jiffies.
	o This improves on the page table TLB shootdown. Almost there.
	o Fix up some more TLB shootdown issues.
	o Update kernel version
	o Cleanup munmap a lot. Fix Intel P4 TLB corruptions on SMP.
	o Make setresuid/setresgid be more consistent wrt fsuid handling
	o First cut at proper TLB shootdown for page directory entries.

<wstinson@infonie.fr>
	o request_region janitor cleanup for rtc char driver


