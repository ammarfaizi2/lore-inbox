Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267662AbUJRWpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267662AbUJRWpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUJRWpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 18:45:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:8667 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267662AbUJRWpW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 18:45:22 -0400
Date: Mon, 18 Oct 2004 15:45:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux v2.6.9...
Message-ID: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 despite some naming confusion (expanation: I'm a retard), I did end up
doing the 2.6.9 release today. And it wasn't the same as the "-final" test
release (see explanation above).

Excuses aside, not a lot of changes since -rc4 (which was the last
announced test-kernel), mainly some UML updates that don't affect anybody
else. And a number of one-liners or compiler fixes. Full list appended.

		Linus

----

Summary of changes from v2.6.9-rc4 to v2.6.9
============================================

<mgoodman:csua.berkeley.edu>:
  o Fix NFS3 krb5 clients on x86-64

Al Borchers:
  o USB: corrected digi_acceleport 2.6.9-rc1 fix for hang on disconnect

Andrea Arcangeli:
  o ptep_establish smp race x86 PAE >4G

Andrew Morton:
  o revert writeback threshold changes
  o ext3 direct io assert fix

Anton Blanchard:
  o ppc64: fix some issues with mem_reserve

Benjamin Herrenschmidt:
  o ppc64: Split iomap implementation & eeh !
  o ppc32: Add "native" iomap interfaces
  o ppc64: more issues with mem_reserve

Chris Wright:
  o uml: fix ubd deadlock on SMP

Christoph Hellwig:
  o [XFS] fix a freeze/thaw deadlock

Christoph Lameter:
  o time interpolator fixes

David Brownell:
  o USB: EHCI SMP fix
  o USB: net2280 updates

David Woodhouse:
  o ppc64: one more explicit cmp instruction sizing

Dmitry Torokhov:
  o Fix oops in parkbd

Greg Kroah-Hartman:
  o USB: handle NAK packets in input devices

Herbert Xu:
  o USB: Fix hiddev devfs oops

Hirokazu Takata:
  o m32r: fix syscall table
  o m32r: remove obsolete system calls

Ingo Molnar:
  o tailcall prevention in sys_wait4() and sys_waitid()

James Morris:
  o SELinux: fix bugs in mprotect hook

John L. Byrne:
  o fix oops in fork() cleanup path

John Rose:
  o PCI Hotplug: rpaphp safe list traversal

Lars Ellenberg:
  o uml: fix critical IP checksum corruption

Linus Torvalds:
  o Fix threaded user page write memory ordering
  o Take the whole PCI bus range into account when scanning PCI bridges

Nathan Lynch:
  o ppc64:  fix smp_startup_cpu for cpu hotplug

Nathan Scott:
  o [XFS] Fix up write_inode return type to use the right signedness
  o [XFS] Fix regression when running in laptop mode, causes hangs on
    sync

Nick Piggin:
  o ACPI: check parameter for NULL
  o kswapd lockup fix

Nicolas Pitre:
  o Fix MTD build error for Lubbock map driver
  o unbalanced locking in MTD Intel chip driver
  o Duh. _Really_ unbalanced locking in MTD Intel chip driver

Olaf Hering:
  o joydump needs gameport

Olaf Kirch:
  o auth_domain_lookup fix

Oliver Neukum:
  o security issue in firmware system

Paolo 'Blaisorblade' Giarrusso:
  o uml: don't declare cpu_online - fix compilation error
  o uml: fix wrong type for rb_entry call
  o uml: fix warning for unused var
  o uml: finish update for 2.6.8 API changes
  o uml: fix an "unused" warnings
  o uml: export more Symbols
  o uml: Set cflags before including arch Makefile
  o uml: force using /bin/bash for building
  o uml: no extraversion in arch/um/Makefile for mainline
  o uml: Single Linking Step for vmlinux
  o uml: make -j fix
  o uml: update makefile to new kbuild API names
  o uml: kbuild - add even more cleaning
  o uml: mark broken configs
  o uml: use always a separate io thread for UBD

Pavel Machek:
  o swsusp: fix x86-64 - do not use memory in copy loop

Randy Dunlap:
  o cyber2000: fix init/exit section confusion
  o intel_agp: dangling devexit reference

Sreenivas Bagalkote:
  o megaraid 2.20.4: fix a data corruption bug

Stephen D. Smalley:
  o SELinux: retain ptracer SID across fork

Tim Schmielau:
  o Fix reporting of process start times

Vojtech Pavlik:
  o USB: Fix oops in usblp driver

Yoshinori Sato:
  o H8/300 some error/warning fix

