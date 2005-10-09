Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbVJIVNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbVJIVNf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 17:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVJIVNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 17:13:35 -0400
Received: from anchor-post-36.mail.demon.net ([194.217.242.86]:18450 "EHLO
	anchor-post-36.mail.demon.net") by vger.kernel.org with ESMTP
	id S932288AbVJIVNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 17:13:34 -0400
From: Felix Oxley <lkml@oxley.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.14-rc3-rt13: Build Problem
Date: Sun, 9 Oct 2005 22:13:24 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510092213.25530.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I built a clean 2.6.14-rc3-rt13, and then did

	make allyesconfig
	make bzImage > BUILD_MESSAGES 2>&1

After about 5 hours (!) I got the following message:

  CC      lib/prio_tree.o
  CC      lib/radix-tree.o
  CC      lib/rbtree.o
  CC      lib/rwsem-spinlock.o
  CC      lib/semaphore-sleepers.o
  CC      lib/sha1.o
  CC      lib/string.o
  CC      lib/vsprintf.o
  AR      lib/lib.a
  LD      arch/i386/lib/built-in.o
  CC      arch/i386/lib/bitops.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  AS      arch/i386/lib/putuser.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `mkiss_open':
: undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
drivers/built-in.o: In function `sixpack_open':
: undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
drivers/built-in.o: In function `gameport_measure_speed':
: undefined reference to `local_irq_save_nort'
drivers/built-in.o: In function `gameport_measure_speed':
: undefined reference to `local_irq_restore_nort'
drivers/built-in.o: In function `mc32_probe1':
: undefined reference to `there_is_no_init_MUTEX_LOCKED_for_RT_semaphores'
make: *** [.tmp_vmlinux1] Error 1

regards,
Felix
