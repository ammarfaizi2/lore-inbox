Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966138AbWKNQG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966138AbWKNQG7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966139AbWKNQG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:06:59 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2189 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S966138AbWKNQG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:06:58 -0500
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: Please pull x86-64 updates
Date: Tue, 14 Nov 2006 17:06:52 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141706.52368.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, 

please pull from 

  git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus

to get the current critical x86-64 bug fixes for 2.6.19

Aaron Durbin:
      x86-64: Fix partial page check to ensure unusable memory is not being marked usable.

Andi Kleen:
      x86-64: Fix PTRACE_[SG]ET_THREAD_AREA regression with ia32 emulation.
      x86-64: Handle reserve_bootmem_generic beyond end_pfn
      x86: Add acpi_user_timer_override option for Asus boards
      x86-64: Fix vgetcpu when CONFIG_HOTPLUG_CPU is disabled
      x86-64: Fix race in exit_idle
      Revert "MMCONFIG and new Intel motherboards"	

Magnus Damm:
      x86-64: setup saved_max_pfn correctly (kdump)

Steven Rostedt:
      x86-64: shorten the x86_64 boot setup GDT to what the comment says

 Documentation/kernel-parameters.txt |    4 +++
 arch/i386/kernel/acpi/boot.c        |    8 ++++++
 arch/i386/kernel/acpi/earlyquirk.c  |    8 +++++-
 arch/x86_64/boot/setup.S            |    5 ++--
 arch/x86_64/ia32/ptrace32.c         |    2 ++
 arch/x86_64/kernel/e820.c           |    4 ++-
 arch/x86_64/kernel/early-quirks.c   |    8 ++++++
 arch/x86_64/kernel/process.c        |    3 +-
 arch/x86_64/kernel/smp.c            |    3 +-
 arch/x86_64/kernel/time.c           |   11 ---------
 arch/x86_64/kernel/vsyscall.c       |   45 +++++++++++++++++++----------------
 arch/x86_64/mm/init.c               |   15 +++++++++++-
 include/asm-i386/acpi.h             |    1 +
 include/asm-x86_64/acpi.h           |    1 +
 include/asm-x86_64/pda.h            |    9 +++++++
 include/asm-x86_64/vsyscall.h       |    2 --
 16 files changed, 86 insertions(+), 43 deletions(-)
