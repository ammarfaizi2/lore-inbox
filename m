Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbSJPMTm>; Wed, 16 Oct 2002 08:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262476AbSJPMTl>; Wed, 16 Oct 2002 08:19:41 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:2688 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S262478AbSJPMTi>;
	Wed, 16 Oct 2002 08:19:38 -0400
Date: Tue, 15 Oct 2002 17:19:04 -0400 (EDT)
From: davidsen <root@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.41 - Netfiler will not work as a module
Message-ID: <Pine.LNX.4.44.0210151718120.5413-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the apm, reported separately.

make -f net/netlink/Makefile 
make -f net/packet/Makefile 
make -f net/sched/Makefile 
make -f net/sunrpc/Makefile 
make -f net/unix/Makefile 
make -f lib/Makefile 
make -f lib/zlib_inflate/Makefile 
make -f arch/i386/lib/Makefile 
make -f arch/i386/boot/Makefile BOOTIMAGE=arch/i386/boot/bzImage install
make -f arch/i386/boot/compressed/Makefile IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
make[2]: `arch/i386/boot/compressed/vmlinux' is up to date.
sh arch/i386/boot/install.sh 2.5.41 arch/i386/boot/bzImage System.map ""
depmod: *** Unresolved symbols in /lib/modules/2.5.41/kernel/arch/i386/kernel/apm.o
depmod: 	xtime_lock
depmod: *** Unresolved symbols in /lib/modules/2.5.41/kernel/net/ipv4/netfilter/ipt_owner.o
depmod: 	next_thread
depmod: 	find_task_by_pid
bilbo:root> exit

Script done on Tue Oct 15 10:57:06 2002

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


