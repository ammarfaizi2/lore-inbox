Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266201AbUBDEE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 23:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBDEE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 23:04:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:18602 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266201AbUBDEEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 23:04:54 -0500
Date: Tue, 3 Feb 2004 20:04:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.2 aka "Feisty Dunnart"
Message-ID: <Pine.LNX.4.58.0402032001040.2131@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just pushed out the BK trees, and the tar-ball/patches are going out as
I write this, for Linux 2.6.2. The honor of naming it goes to Gernot
Heiser, for reasons that are largely alcoholic, I suspect. Good job!

The changelog from -rc3 mainly contains some ppc64 updates, see the 
summary for more details on some of the other changes.

		Linus

-----

Summary of changes from v2.6.2-rc3 to v2.6.2
============================================

Andrew Morton:
  o ppc32: watchdog definition fixes
  o ppc64: add missing include guards, from Nathan Lynch
  o ppc64: lparcfg_write
  o ppc64: fixes for compile with CONFIG_PROC_DEVICETREE=n, from Nathan
    Lynch
  o ppc64: missing set_fs(KERNEL_DS) in ppc32_timer_create, from Marcus
    Meissner
  o ppc64: defconfig update
  o ppc64: Use preferred_console to select a reasonable default console
  o ppc64: add/remove config.h
  o ppc64: export memchr and csum_partial
  o ppc64: fix && vs & bugs in lparcfg, from Julie DeWandel
  o ppc64: SLB rewrite
  o ppc64: use CONFIG_MAGIC_SYSRQ around xmon sysrq code
  o Trivial cleanups to hugepage support
  o s390: general update
  o s390: inline assembly constraints
  o s390: sclp bug fixes
  o RAID-6: x86-64 crash workaround
  o ppc32: MBX MAC address fix
  o fix the build for NR_CPUS > 4*BITS_PER_LONG

Bartlomiej Zolnierkiewicz:
  o fix issues with loading PCI IDE drivers as modules
  o fix/improve modular IDE

Ben Collins:
  o IEEE1394(r1112): Adds a "ieee1394_guid" attribute to the scsi
    device for sbp2
  o IEEE1394(r1116): Make sure to unregister addr space when a driver
    is removed

David S. Miller:
  o [SPARC64]: Fix wakeup races in power.c, with help from Andrew Morton
  o [COMPAT]: Fix TUNSETIFF ioctl compat, it takes an ifreq ptr not an int
  o [TG3]: Bump version and reldate

Grant Grundler:
  o [TG3]: Fix DMA test failures
  o [TG3]: Only fetch NVRAM_CMD reg if TG3_FLAG_NVRAM

Jozsef Kadlecsik:
  o [NETFILTER]: Fix NAT leak with fragmented packets, missing
    conntrack put in ip_copy_metadata()

Keith M. Wesolowski:
  o [SPARC32]: Align pkmap properly
  o [SPARC32]: Copy full soft PMD in vmalloc fault handler
  o [SPARC32]: Kill spurious newline in dmesg output

Len Brown:
  o [ACPI] proposed fix for AML parameter passing from Bob Moore
    http://bugzilla.kernel.org/show_bug.cgi?id=1766

Linus Torvalds:
  o Upgrade x86 defconfig to something less ancient
  o Make EHCI have a 20ms power-on to power-good timeout
  o Warn loudly if somebody passes a negative value as the size to
    "vsnprintf()".
  o Linux 2.6.2 aka "Feisty Dunnart"

Mirko Lindner:
  o sk98lin: Reset Xmac when stopping the port

