Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265953AbUBQDvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 22:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBQDvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 22:51:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:62666 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265953AbUBQDvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 22:51:10 -0500
Date: Mon, 16 Feb 2004 19:51:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.3-rc4
Message-ID: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 I'm planning on doing the final 2.6.3 tomorrow, so please test this 
final -rc.

Most notably, this should support ppc/ppc64 out-of-the-box, complete with
G5 support (64-bit). Special thanks to BenH who made sure the new radeonfb
driver works on a wide variety of hardware (a number of the fixes here
relative to -rc3 was making sure the driver works on regular x86 laptops).

Apart from the radeon updates, there's some IDE oops fixes (and cleanups), 
and a SELinux update.

And yes, document the fact that sparc is no longer f*cked up (both atomics 
and irq save/restore now work the way they always did everywhere else).

		Linus

----

Summary of changes from v2.6.3-rc3 to v2.6.3-rc4
============================================

Andrew Morton:
  o SELinux: context mount support - LSM/FS
  o SELinux: context mount support - NFS
  o SELinux: context mount support - SELinux changes
  o devfs do_mount fix
  o selinux: Allow non-root processes to read selinuxfs enforce node
  o selinux: mark avc_init with __init
  o SELinux: Fix error handling bug
  o ppc32: Fix MPC82xx thinko
  o ppc32: Fix MPC82xx UARTs

Anton Blanchard:
  o fix ppc64 LPAR

Bartlomiej Zolnierkiewicz:
  o fix OOPS on non-DMA IDE hosts with CONFIG_BLK_DEV_IDEDMA=y
  o ide-tape: fix "sleeping function called from invalid context"
  o ide-tape: warn about soon to be removed OnStream support
  o remove ide_dma_{good,bad}_drive from ide_hwif_t
  o remove __ide_dma_count() and ide_hwif_t->ide_dma_count
  o make __ide_dma_off() generic and remove ide_hwif_t->ide_dma_off

Benjamin Herrenschmidt:
  o Remove debug cruft from via-pmu.c driver
  o Fix Oops & warning on PPC in rivafb
  o shield fbdev operations with console semaphore
  o Fix fbdev pixmap locking
  o Update aty128fb video driver
  o fbdev state management
  o fbcon notified of suspend/resume
  o fix radeonfb "noaccel" command line
  o radeonfb: limit ioremap size & debug output
  o Update platinumfb driver
  o Small typo in aty128fb
  o Fix rtasd zombie on PowerMac G5
  o Fix building both old & new radeonfb's
  o Fix ppc compile problem with gcc 3.4

Jeff Garzik:
  o Update mac network drivers

Linus Torvalds:
  o Fix new radeon clock calculation
  o Fix user-visible typo in printk
  o Fix radeonfb to use the proper BIOS reference divider for
    flat-panel displays.
  o Fix link error with RADEON_DEBUG and !RADEON_I2C
  o Revert the dodgy ia64 serial console changeset by Bjorn Helgaas
  o Linux 2.6.3-rc4

Marcel Holtmann:
  o [Bluetooth] Revert reference counting fixes

Peter Osterlund:
  o Missing initialization code for old radeon driver

Rusty Russell:
  o Sparc no longer F*cked Up

