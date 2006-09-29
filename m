Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbWI2Xzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbWI2Xzf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWI2Xzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:55:35 -0400
Received: from ns.suse.de ([195.135.220.2]:31443 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932299AbWI2Xze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:55:34 -0400
From: Andi Kleen <ak@suse.de>
To: torvalds@osdl.org
Subject: Please pull x86 update
Date: Sat, 30 Sep 2006 01:55:26 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609300155.26250.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,  please pull from

	git://one.firstfloor.org/home/andi/git/linux-2.6 for-linus

to get

Andi Kleen:
      Update defconfig
      i386: Update defconfig
      Add proper sparse __user casts to __copy_to_user_inatomic
      Allow disabling DAC using command line options
      Fix broken indentation in iommu_setup
      Document iommu=panic
      Refactor some duplicated code in mpparse.c
      x86: Clean up x86 NMI sysctls
      Use ARRAY_SIZE in setup.c
      Define vsyscall cache as blob to make clearer that user space shouldn't use it
      Use early clobber in semaphores

Bjorn Helgaas:
      i386: replace intermediate array-size definitions with ARRAY_SIZE()

Vivek Goyal:
      Re-positioning the bss segment

 Documentation/x86_64/boot-options.txt |    5 +
 arch/i386/defconfig                   |    7 +-
 arch/i386/kernel/nmi.c                |    3 +
 arch/i386/kernel/setup.c              |   10 ---
 arch/i386/kernel/traps.c              |    2 
 arch/x86_64/defconfig                 |    8 ++
 arch/x86_64/kernel/mpparse.c          |   37 ++++++------
 arch/x86_64/kernel/nmi.c              |    4 +
 arch/x86_64/kernel/pci-dma.c          |  101 ++++++++++++++++++++--------------
 arch/x86_64/kernel/setup.c            |   11 +--
 arch/x86_64/kernel/vmlinux.lds.S      |   14 ++--
 arch/x86_64/kernel/vsyscall.c         |    8 +-
 include/asm-i386/nmi.h                |    6 ++
 include/asm-x86_64/nmi.h              |    7 ++
 include/asm-x86_64/semaphore.h        |    4 -
 include/asm-x86_64/uaccess.h          |    7 ++
 include/linux/getcpu.h                |   12 ++--
 kernel/panic.c                        |    1 
 kernel/sys.c                          |    8 +-
 kernel/sysctl.c                       |   11 +--
 20 files changed, 156 insertions(+), 110 deletions(-)
