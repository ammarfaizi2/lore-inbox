Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTL2H65 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 02:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263125AbTL2H64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 02:58:56 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:16768 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263101AbTL2H6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 02:58:52 -0500
Date: Mon, 29 Dec 2003 00:58:50 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.23-uv3 patch set released
Message-ID: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Update Version patchset is a set of patches which include only fatal
compile/runtime bug fixes and security updates for the current kernel
version.  This patch set can be used in production environments for those
who wish to run 2.4.23, but do not use vendor kernels and at the same time
require patches which add to the stability of the current release kernel
version.  This is a patch set only, it does not include kernel source.

Current version is 2.4.23-uv3 which contains many patches pulled from the
2.4-bk mailing list and adds the last 5 patches in the list below.

The complete URL to the patch set is
http://www.hardrock.org/kernel/current-updates/linux-2.4.23-updates.patch

Individual patches can be viewed and downloaded from
http://www.hardrock.org/kernel/current-updates/

This patch set only contains and will only contain security updates and
fixes for the latest kernel version.  Each individual patch contains text
WRT the patch itself and the creator of the patch, I will try to keep doing
that as standard reference for the complete collection.

Please send bug reports to jbourne@hardrock.org and CC
linux-kernel@vger.kernel.org.

Patch specifics are:
linux-2.4.23-updates.patch: Contains all the patches below.         

linux-2.4.23-extraversion.patch: Updated the extraversion in the Makefile

linux-2.4.23-file_lock_acct.patch: Remove broken file lock accounting

linux-2.4.23-ht-detect.patch: Fixup smb_boot_cpus(): Fix HT detection bug

linux-2.4.23-ipfw_compat_oops.patch: fix for a known bug in the netfilter

linux-2.4.23-ll_rw_blk_race_fix.patch: from -aa tree: Fix potential fsync()
	race condition

linux-2.4.23-lockd_reclaim.patch: Drop module count if lockd reclaimer
	thread failed to start

linux-2.4.23-no_idt.patch: fix reboot/no_idt bug

linux-2.4.23-oom_kill.patch: out_of_memory() locking issue

linux-2.4.23-rbs_clobber.patch: ia64: Fix a bug in sigtramp() which
	corrupted ar.rnat when unwinding across a signal trampoline
	(in user space).  Reported by Laurent Morichetti.

linux-2.4.23-root_rlim.patch: Make root a special case for per-user process
	limits.

linux-2.4.23-rtc-compile.patch: Patch to allow RTC to compile properly on
	some systems, see http://lkml.org/lkml/2003/12/1/150

duplicate-pid-fix-2.4.23.patch: Without this, duplicate pids can be
	allocated, which will make one of them unkillable (signals are
	deliverd to only one of them), and this can be exploitable (I don't
	know for sure, but maybe, like brk()).

irda-log-buster-2.4.23.patch: I just ran 2.4.23, and after a few min the
	disk reached 100% capacity. A quick check lead to to oversized
	kernel log, and to the following changeset.

iseries-saverestore-flags-2.4.23.patch: [PPC64] Fix save_flags/restore_flags
	on iSeries.

mct_u232-baudratefix-2.4.23.patch: Fix a problem in the 'mct_u232' driver
	whereby output data gets held up in the USB/RS-232 adapter for RS-232
	devices which don't assert the 'CTS' signal.

odirect-offset-2.4.23.patch: here's an obvious mistake i made in the NFS
	O_DIRECT implementation.  A missing type cast causes the offset of direct
	read and write requests to wrap at 4GB.

ppc64-pmc-compile-fix-2.4.23.patch: [PPC64] Fix compile error in
	arch/ppc64/kernel/pmc.c

ppc64-smp_call_function_late_ipi-2.4.23.patch: [PPC64] Fix smp_call_function
	so we don't crash if an IPI is very late.

rtc-leak-2.4.23.patch: [PATCH] Fix rtc leak

sparc32-build-fix-2.4.23.patch: [SPARC32]: Fix build after asm/system.h
	include was added to linux/spinlock.h

usb-serial-edgeport-counter-and-alignment-2.4.23.patch: [PATCH] USB: fix bug
	when errors happen in ioedgeport driver

linux-2.4.23-airo-oops-fix.patch: [wireless airo] Delay MIC activation to
	prevent Oops

linux-2.4.23-fix-airo-pci-registration.patch: [wireless airo] Fix PCI
	registration

linux-2.4.23-ide-busy-race-fix.patch: Daniel Lux: Fix IDE busy-wait race

linux-2.4.23-init-ioc3-timer.patch: [PATCH] Initialize ioc3_timer before use

linux-2.4.23-raid1-blocksize.patch: [PATCH] Fix RAID1 blocksize check


Regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
