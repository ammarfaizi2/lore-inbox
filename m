Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266139AbUAGGkl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 01:40:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266141AbUAGGkl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 01:40:41 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:10626 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S266139AbUAGGkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 01:40:33 -0500
Date: Tue, 6 Jan 2004 23:40:31 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.24-uv1 patch set released
Message-ID: <Pine.LNX.4.51.0401062334230.5370@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The Update Version patchset is a set of patches which include only fatal
compile/runtime bug fixes and security updates for the current kernel
version.  This patch set can be used in production environments for those
who wish to run 2.4.24, but do not use vendor kernels and at the same time
require patches which add to the stability of the current release kernel
version.  This is a patch set only, it does not include kernel source.

Current version is 2.4.24-uv1 which contains many patches pulled from the
2.4-bk mailing list which did not make it into the release of 2.4.24.

The complete URL to the patch set is
http://www.hardrock.org/kernel/current-updates/linux-2.4.24-updates.patch

Individual patches can be viewed and downloaded from
http://www.hardrock.org/kernel/current-updates/

This patch set only contains and will only contain security updates and
fixes for the latest kernel version.  Each individual patch contains text
WRT the patch itself and the creator of the patch, I will try to keep doing
that as standard reference for the complete collection.

Please send bug reports to jbourne@hardrock.org and CC
linux-kernel@vger.kernel.org.

Patch specifics are:
linux-2.4.24-updates.patch: Contains all the patches below.

linux-2.4.24-extraversion.patch: Updated the extraversion in the Makefile

linux-2.4.24-file_lock_acct.patch: Remove broken file lock accounting

linux-2.4.24-ht-detect.patch: Fixup smb_boot_cpus(): Fix HT detection bug

linux-2.4.24-ll_rw_blk_race_fix.patch: from -aa tree: Fix potential fsync()
        race condition

linux-2.4.24-lockd_reclaim.patch: Drop module count if lockd reclaimer
        thread failed to start

linux-2.4.24-no_idt.patch: fix reboot/no_idt bug

linux-2.4.24-oom_kill.patch: out_of_memory() locking issue

linux-2.4.24-rbs_clobber.patch: ia64: Fix a bug in sigtramp() which
        corrupted ar.rnat when unwinding across a signal trampoline
        (in user space).  Reported by Laurent Morichetti.

linux-2.4.24-root_rlim.patch: Make root a special case for per-user process
        limits.

linux-2.4.24-rtc-compile.patch: Patch to allow RTC to compile properly on
        some systems, see http://lkml.org/lkml/2003/12/1/150

linux-2.4.24-duplicate-pid-fix.patch: Without this, duplicate pids can be
	allocated, which will make one of them unkillable (signals are
	deliverd to only one of them), and this can be exploitable (I don't
	know for sure, but maybe, like brk()).

linux-2.4.24-iseries-saverestore-flags.patch: [PPC64] Fix save_flags/restore_flags
	on iSeries.

linux-2.4.24-mct_u232-baudratefix.patch: Fix a problem in the 'mct_u232' driver
	whereby output data gets held up in the USB/RS-232 adapter for RS-232
	devices which don't assert the 'CTS' signal.

linux-2.4.24-odirect-offset.patch: here's an obvious mistake i made in the NFS
	O_DIRECT implementation.  A missing type cast causes the offset of direct
	read and write requests to wrap at 4GB.

linux-2.4.24-ppc64-pmc-compile-fix.patch: [PPC64] Fix compile error in
	arch/ppc64/kernel/pmc.c

linux-2.4.24-ppc64-smp_call_function_late_ipi.patch: [PPC64] Fix smp_call_function
	so we don't crash if an IPI is very late.

linux-2.4.24-sparc32-build-fix.patch: [SPARC32]: Fix build after asm/system.h
	include was added to linux/spinlock.h

linux-2.4.24-usb-serial-edgeport-counter-and-alignment.patch: [PATCH] USB: fix bug
	when errors happen in ioedgeport driver

linux-2.4.24-airo-oops-fix.patch: [wireless airo] Delay MIC activation to
	prevent Oops

linux-2.4.24-fix-airo-pci-registration.patch: [wireless airo] Fix PCI
	registration

linux-2.4.24-ide-busy-race-fix.patch: Daniel Lux: Fix IDE busy-wait race

linux-2.4.24-init-ioc3-timer.patch: [PATCH] Initialize ioc3_timer before use

linux-2.4.24-raid1-blocksize.patch: [PATCH] Fix RAID1 blocksize check

linux-2.4.24-megaraid-fix.patch: Latest update to megaraid driver in 2.4
	tree revived already fixed possible memleak.  Simple patch below
	should fix it again.

linux-2.4.24-sch_htb-oops-fix.patch: [PATCH] Fixes two oops with htb

linux-2.4.24-st-buffext.patch: The problem was noticed by a user who also
	provided excellent analysis why the corruption occurred. A small
	test program was able to prove the analysis. After this the fix was
	trivial.

linux-2.4.24-tg3_init_one-retfix.patch: [TG3]: Fix bogus return value in
	tg3_init_one().

linux-2.4.24-iSeries-periodic-interrupts-shared-proc.patch: [PPC64] Fix for
	periodic interrupts on iSeries with shared processors

linux-2.4.24-laptopmode-j_commit_interval-0.patch: After the laptop mode
	patch was merged, it is now possible for j_commit_interval to be
	zero.  Unfortunately jbd doesn't handle this situation very well.

linux-2.4.24-rt_sigprocmask-error-handling.patch: [PATCH] fix broken 2.4.x
	rt_sigprocmask error handling


Regards
James Bourne


-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
