Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVBXEr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVBXEr1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 23:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVBXEqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 23:46:03 -0500
Received: from fire.osdl.org ([65.172.181.4]:23480 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261777AbVBXER0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 23:17:26 -0500
Date: Wed, 23 Feb 2005 20:18:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc5
Message-ID: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hey, I hoped -rc4 was the last one, but we had some laptop resource
conflicts, various ppc TLB flush issues, some possible stack overflows in
networking and a number of other details warranting a quick -rc5 before
the final 2.6.11.

This time it's really supposed to be a quickie, so people who can, please 
check it out, and we'll make the real 2.6.11 asap.

Mostly pretty small changes (the largest is a new SATA driver that crept
in, our bad). But worth another quick round.

		Linus

----

Summary of changes from v2.6.11-rc4 to v2.6.11-rc5
============================================

<benh:au1.ibm.com>:
  o ppc32: Wrong vaddr in flush_hash_one_pte()

<mat.loikkanen:synopsys.com>:
  o [libata] add ->bmdma_{stop,status} hooks

Alan Stern:
  o USB Hub driver: Add reset recovery-time delay

Andrew Morton:
  o mca resource layout fix
  o end_buffer_async_read printk ratelimiting
  o strip.c build fix
  o alpha: struct resource fix
  o ppc32: resource layout fixes
  o sparc64 rusage build fix
  o sparc64 usb build fix
  o x86_64: resource layout fix

Anton Blanchard:
  o ppc64: Fix 32bit largepage issue

Antonino Daplas:
  o fbdev: Fix gcc 4.0 compile failure

Arjan van de Ven:
  o Allow heap to be marked executable too

Arnaldo Carvalho de Melo:
  o [TCP]: Fix excessive stack usage resulting in OOPS with 4KSTACKS

Art Haas:
  o [SPARC]:Check prom_getproperty() return value in prom_nodematch()

Bartlomiej Zolnierkiewicz:
  o [ide] fix ide_get_error_location() for LBA28

Ben Dooks:
  o [ARM PATCH] 2480/1: IXP4XX - cleanup resource for i2c controller
  o [ARM PATCH] 2481/1: IXP2000 - replace sti/cli with
    local_irq{save,restore}
  o [ide] Kconfig for VR1000 machine driver selection

Benjamin Herrenschmidt:
  o radeonfb: typos fixes
  o radeonfb: Fix hang on boot with some laptops
  o Fix possible race with 4level-fixup.h
  o Check for wraps in copy_page_range
  o Fix buf in zeromap_pud_range() losing virtual address
  o radeonfb: Workaround memory corruption accel problem
  o ppc32: fix ptep_test_and_clear_young
  o ppc32: kernel mapping breakage

Bjorn Helgaas:
  o de214x.c uses uninitialized pci_dev->irq

Bob Breuer:
  o [SPARC]: Check prom_getproperty return value

Brian Murphy:
  o USB: ehci requeue revisit

Christoph Hellwig:
  o block new writers on frozen filesystems

Corey Minyard:
  o IPMI: Fix LAN bridging

Daniel Ritz:
  o PCI: support PCI_PM_CAP version 1

David Brownell:
  o USB: ehci patch for NF4 port miscounting

David S. Miller:
  o [COMPAT]: TUNSETIFF needs to copy back data after ioctl
  o [SPARC]: Fix cg3 fb blanking
  o [SPARC]: Fix video mode probing in atyfb driver
  o [TG3]: Always check tg3_readphy() return value
  o [TG3]: Update driver version and reldate
  o [SPARC64]: auxio_register is pointer not integer
  o [SPARC64]: Put PROM trampolines into asm file
  o [SPARC64]: Fix access_ok() and friends warnings
  o [SPARC64]: Fix access_ok() args in sys_sparc32.c:get_tv32()
  o [SPARC64]: Use common sys_ipc() compat code
  o [SPARC64]: BUG on rediculious memcpy lengths

Dmitry Torokhov:
  o ALPS: do not activate on unsupported models

François Romieu:
  o dscc4: use of uncompletely initialized struct
  o dscc4: code factorisation
  o dscc4: error status checking and pci janitoring
  o dscc4: removal of unneeded casts
  o dscc4: removal of unneeded variable
  o r8169: endianness fixes
  o r8169: merge of Realtek's code
  o r8169: typo in debugging code
  o r8169: screaming irq when the device is closed
  o r8169: synchronization and balancing when the device is closed
  o r8169: fix rx skb allocation error logging
  o r8169: skb alignment nitpicking
  o r8169: removal of unused #define
  o r8169: uniformize comments
  o r8169: IRQ races during change of mtu
  o r8169: factor out some code

Gary N. Spiess:
  o natsemi long cable fix

Herbert Xu:
  o ISDN locking fix
  o [IPSEC]: Move dst->child loop from dst_ifdown to xfrm_dst_ifdown
  o [NET]: Add netdev argument to dst ifdown

Hideaki Yoshifuji:
  o [IPV6]: Fix IPV6_PKTINFO et al. handling in udpv6_recvmsg()

Hirokazu Takata:
  o m32r: build fix for SMP kernel
  o m32r: fix sys_clone()
  o m32r: defconfig updates
  o m32r: warning fix

Jeff Garzik:
  o [libata sata_via] minor cleanups
  o [libata sata_via] add support for VT6421 SATA
  o [libata] do not call pci_disable_device() for certain errors
  o libata kfree fix
  o [libata] Add missing hooks, to avoid oops in advanced SATA drivers

Joe Korty:
  o memset argument order misuses

John W. Linville:
  o libata: fix command queue leak when xlat_func fails

Krzysztof Helt:
  o [SPARC32]: Need to clear PSR_EF in psr of childregs on fork() on
    SMP

Len Brown:
  o [ACPI] ACPICA 20050211 from Bob Moore

Lennert Buytenhek:
  o [ARM PATCH] 2485/1: fix enp2611 coexistence with other machine
    types
  o [ARM PATCH] 2486/1: fix incorrect comment in
    arch/arm/kernel/debug.S
  o [ARM PATCH] 2487/1: minor IRQ routing tweaks for ENP-2611
  o [ARM PATCH] 2493/1: put IXP2000 slowport in 8-bit mode after boot
  o [ARM PATCH] 2494/1: fix 'CONFGI_' -> 'CONFIG_' in
    mach-ixp2000/ixdp2x00.c

Linus Torvalds:
  o Eicon driver: remove ^M for real this time
  o Limit tty IO chunking to 2kB
  o Fix bogus opost buffer size check
  o Input: fix ALPS protocol validation rules
  o Use e820 memory map to determine PCI allocation area
  o Be more careful about looking for gaps in the e820 table
  o x86: when choosing PCI starting address, print out gap information
  o agp: aper_base is unsigned
  o Linux 2.6.11-rc5

Marcel Holtmann:
  o [Bluetooth] The new Microsoft dongle needs HCI_Reset

Mark Lord:
  o sata_qstor: new basic driver for Pacific Digital

Matt Porter:
  o emac: fix jumbo frame support
  o emac: fix mdio delay

Mika Kukkonen:
  o [ide] small compile fix to ide.c with !CONFIG_PCI
  o Build failure with !CONFIG_PCI and with CONFIG_ISAPNP=y &&
    CONFIG_PNPBIOS=y

Nathan Scott:
  o [XFS] Reinstate missing frozen check on write, fixes snapshots and
    xfs_freeze.
  o [XFS] Prevent releasepage from releasing pages early, while they
    still have delayed allocate buffers.  Affects filesystem blocksizes
    smaller than the pagesize only.
  o [XFS] Fix problems with synchronous writes returning EAGAIN
    incorrectly for pinned inodes.

Nathan T. Lynch:
  o kthread_bind new worker threads when onlining cpu

Nick Piggin:
  o optimise copy page range

Olaf Hering:
  o ppc64: remove extra whitespace before preprocessor token
  o [NET]: Fix socket.h comment typo

Olof Johansson:
  o Fix possible futex mmap_sem deadlock

Paul Mackerras:
  o ppc64: fix compilation for Maple board

Pete Zaitcev:
  o USB: Add ioctls to ub
  o ub: fix Add ioctls to ub patch

Ralf Bächle:
  o [NETROM/ROSE]: Use netdev_priv()

Randy Dunlap:
  o sis: fix sparse warnings
  o au1100: fix io_remap_page_range() arg. list

Ravinandan Arakali:
  o S2io: Multicast fix

Robert Olsson:
  o [PKTGEN]: Bug fixes, bump to version 2.56

Rolf Eike Beer:
  o make ACPI_BLACKLIST_YEAR depend on ACPI_INTERPRETER

Russell King:
  o [ARM] Add missing __user annotations to sys_clone()
  o [ARM] Fix SA1111 and PXA iomem sparse warnings
  o [ARM] Fix sparse warnings for Integrator builds
  o [ARM] Take account of vm_pgoff for DMA mmap

Stephen Hemminger:
  o [TCP]: Fix BIC max_cwnd calculation error

Thomas Gleixner:
  o [ARM PATCH] 2474/1: Fix compile for badge4
  o [ARM PATCH] 2476/1: Fix compile for shannon
  o [ARM PATCH] 2478/1: Remove NULL initializers

Tim Burgess:
  o device-mapper: dm-raid1 deadlock fix

Tom Rini:
  o ppc32: fixup of previous PCI9 patch
  o Re-order <linux/fs.h> includes to fix userland breakage
  o Fix NR_OPEN header order dependency

Trond Myklebust:
  o NFS: Further fixes for the -onolock case

