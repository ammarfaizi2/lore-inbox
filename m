Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTELSJL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbTELSIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 14:08:19 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:56590 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262434AbTELSHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 14:07:09 -0400
Date: Mon, 12 May 2003 20:19:49 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Linux v2.4.21-rc2 changelog (was: Linux 2.4.21-rc2)
Message-ID: <20030512181949.GA23171@merlin.emma.line.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305082213420.9139@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 May 2003, Marcelo Tosatti wrote:

> Here goes release canditate 2. The aic7xxx problems should be fixed.

It's late, but here goes the changelog summary with changes since
2.4.21-rc1 (the usual bk set -d -rv2.4.21-rc1, listing the first lines
of the changesets that make up 2.4.21-rc2 but aren't in 2.4.21-rc1, IOW,
the rc1 -> rc2 changes, grouped by author and sorted by surname:

<lucy:innosys.com>:
  o USB: keyspan driver fixes

Muli Ben-Yehuda:
  o [NETFILTER]: ip_queue memory leaks

Neil Brown:
  o Update umem driver for newer cards
  o Return correct result for ACCESS(READ) on eXecute-only

Ben Collins:
  o Fix highmem_io for sbp2
  o More firewire/IEEE1394 fixes
  o Fix IEEE1394 locking problems + cleanups

Alan Cox:
  o update hptraid
  o fix x.25 parsing
  o xdr warning (0 - any)
  o fix wrong type
  o maintainer updates
  o fix base handling in lib stuff
  o kill unneeded ifdefs, add rd/ and root=nbd
  o headers for sisfb update
  o put the ide idents back in working order
  o fix wrong types in if_shaper
  o sisfb ipdate
  o new sis fb idents
  o header for arcnet fixes
  o remove dead functions
  o fix the d_path error cases in umsdos
  o more /proc error cases
  o fix error cases in procfs
  o copy kernel not user object in ncpfs
  o handle error case in fs/namespace.c
  o fix lots of tdfxfb bugs
  o make sstfb work bigendian
  o Fix copy_to_user handling in vicam
  o make pegasus work on big endian
  o mdc800 copy_to_user handling fix
  o fix a race and a comment in via_audio
  o mpu401 copy_to_user handling fix
  o small fix for pcm alloc on i810
  o Fix get_user handling in cmpci
  o Fix copy_to_user handling in awe_wave
  o fix build with newer binutils
  o add another card id
  o fix qlogicisp leaks
  o fix nsp32 build with newer binutils
  o fix ide-scsi retry oops
  o fix cpqfc leak
  o fix time type in aha152x
  o fix 82092 crash cases
  o Fix copy_user handling in cosa
  o sis900 needs to know another PHY
  o fix roadrunner memory leak
  o fix compile of r8169 with newer binutils
  o Fix arcnet crashes with raw socket
  o Fix copy_user handling in z36120
  o /proc stuff for zoran
  o Fix copy_to_user handling in eicon
  o add blacklist for barracuda ata iv with CSB5
  o IDE: if 0 garbage removal
  o fix ide smp deadlock on settings sem
  o fix memory leak on rio
  o fix overrun in cdu31a

Oleg Drokin:
  o Memleak fix for DIGITAL EtherWORKS 3 ethernet driver

Jeff Garzik:
  o fix fealnx build on ia64 and other non-x86
  o tg3 fix

Christoph Hellwig:
  o add intelfb to Config.in

Stephen Hemminger:
  o [BRIDGE]: New maintainership

Benjamin Herrenschmidt:
  o Fix PPC build

Marcel Holtmann:
  o [Bluetooth] Fix L2CAP binding to local address
  o [Bluetooth] Respond correctly to RLS packets

Bernhard Kaindl:
  o Fixup 2.4 ptrace fix

Andi Kleen:
  o Another x86-64 build fix for gcc-3.3-hammer
  o Fix SMP x86-64 kernels on simics
  o Fix gcc 3.3 build for reverted aic7xxx driver
  o Critical fix for x86-64

Dave Kleikamp:
  o JFS: Avoid rare deadlock
  o JFS: jfs_lookup should check for bad inode returned from iget
  o JFS: Performance improvement

Maksim Krasnyanskiy:
  o [Bluetooth] Fix race condition in RFCOMM session and dlc scheduler
  o [Bluetooth] Improved RFCOMM TTY buffer management. Don't buffer
    more data than we have credits for.

Greg Kroah-Hartman:
  o IBM PCI Hotplug: fix up a number of memory leaks on the error path
  o IBM PCI Hotplug: fix up a lot of memory allocations and leaks just
    to figure out a slot name
  o i2c: bug fix for 2.4.21-rc1

Paul Mackerras:
  o Fix drivers/video/Config.in
  o update CREDITS
  o PPC32: Compile fix for ppc_ksyms.c - it needs the declaration of
    __div64_32
  o PPC32: Update the defconfigs

Torben Mathiasen:
  o PCI Hotplug: cpqphp 66/100/133MHz PCI-X support

Patrick McHardy:
  o [NETFILTER]: Multiple ipt_REJECT fixes

Adam Mercer:
  o Fix vesafb with large memory

David S. Miller:
  o [NET]: Fix hashing exploits in ipv4 routing, IP conntrack, and TCP
    synq
  o [NET]: SG without checksum support is illegal

James Morris:
  o [IPV4]: Choose new rt_hash_rnd every rt_run_flush
  o [NET]: Cosmetic cleanups of jhash code

Paulo Ornati:
  o explicit support for nVidia nForce

Ernie Petrides:
  o Orphan recovery error path fix

Stelian Pop:
  o sonypi fixes

Tom Rini:
  o PPC32: Export a missing symbol (__div64_32)

Nivedita Singhvi:
  o [AF_UNIX]: Fix max_dgram_qlen procfs permissions

Alan Stern:
  o USB: usb-storage fixes
  o USB: usb storage async unlink error code fix

Jun Sun:
  o kiobuf flush dcache properly

Marcelo Tosatti:
  o Changed EXTRAVERSION to -rc2 TAG: v2.4.21-rc2
  o aic7xxx PCI posting flush fix from Arjan
  o aic7xxx: Go back to old aic7xxx (pre3) since the new one lockups
    some cards on initialization. The new driver (aic79xx) is now a new
    directory. I know Justin will hate this, but I can't update the
    aic7xxx to a fully new driver in -rc stage.
  o Avoid is_dumpable() NULL pointer reference

Harald Welte:
  o [NETFILTER]: Trivial but important state fix for ipt_conntrack
  o [NETFILTER]: Makefile and build fixes

David Woodhouse:
  o JFFS2: Fix for_each_inode()

-- 
Matthias Andree
