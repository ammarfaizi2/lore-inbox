Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWJERKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWJERKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWJERKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:10:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:18403 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932183AbWJERK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:10:29 -0400
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: Please pull x86-64 bug fixes
Date: Thu, 5 Oct 2006 19:10:25 +0200
User-Agent: KMail/1.9.3
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610051910.25418.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull 'for-linus' from 

  git://one.firstfloor.org/home/andi/git/linux-2.6

Andi Kleen:
      x86-64: Update defconfig
      i386: Update defconfig
      i386: Fix PCI BIOS config space access
      x86: Terminate the kernel stacks for the unwinder
      x86-64: Fix FPU corruption
      x86-64: Annotate interrupt frame backlink in interrupt handlers
      x86-64: Ignore alignment checks in kernel
      i386: Ignore alignment checks in kernel

Ingo Molnar:
      i386: fix rwsem build bug on CONFIG_M386=y

Jon Mason:
      x86-64: Calgary IOMMU: deobfuscate calgary_init
      x86-64: Calgary IOMMU: Fix off by one when calculating register space location
      x86-64: Calgary IOMMU: Update Jon's contact info
      x86-64: Calgary IOMMU: print PCI bus numbers in hex

Randy Dunlap:
      x86-64: Fix compilation without CONFIG_KALLSYMS

 MAINTAINERS                      |    2 +-
 arch/i386/defconfig              |   41 +++++++++++++++++++++++++++++-------
 arch/i386/kernel/process.c       |    6 ++++-
 arch/i386/kernel/traps.c         |   19 ++++++++++++++++-
 arch/i386/lib/semaphore.S        |    3 +++
 arch/i386/pci/direct.c           |    2 ++
 arch/i386/pci/init.c             |    4 ++++
 arch/x86_64/defconfig            |   43 +++++++++++++++++++++++++++++++-------
 arch/x86_64/kernel/entry.S       |    8 +++++++
 arch/x86_64/kernel/pci-calgary.c |   36 +++++++++++++++++++++-----------
 arch/x86_64/kernel/process.c     |    7 +++---
 arch/x86_64/kernel/setup64.c     |    2 +-
 arch/x86_64/kernel/traps.c       |   24 +++++++++++++++++++--
 13 files changed, 159 insertions(+), 38 deletions(-)
