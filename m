Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTK0Jxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 04:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264466AbTK0Jxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 04:53:41 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:3739 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S264464AbTK0Jxj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 04:53:39 -0500
Subject: [BUG 2.6.0-test11] Makefile problem
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1069926760.21737.10.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 27 Nov 2003 10:52:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I did compile a 2.6.0-test10 before and I patched the sources to
2.6.0-test11, then I did the commande line and got the following output:

[root@rade7 linux-2.6.0-test11]$ make clean && make -j 16 && make
modules_install && make install
  CLEAN   arch/i386/boot/compressed
  CLEAN   arch/i386/boot
  CLEAN   arch/i386/kernel
  CLEAN   drivers/char
  CLEAN   drivers/pci
  CLEAN   init
  CLEAN   usr
  CLEAN   scripts
  RM  $(CLEAN_FILES)
  CHK     include/linux/version.h
  HOSTCC  scripts/fixdep
  UPD     include/linux/version.h
  HOSTCC  scripts/fixdep
collect2: ld terminated with signal 11 [Segmentation fault]
make[2]: *** [scripts/fixdep] Error 1
make[1]: *** [scripts/fixdep] Error 2
make: *** [include/linux/autoconf.h] Error 2
make: *** Waiting for unfinished jobs....
  HOSTCC  scripts/split-include
  HOSTCC  scripts/conmakehash
  HOSTCC  scripts/docproc
  HOSTCC  scripts/kallsyms
  CC      scripts/empty.o
  HOSTCC  scripts/mk_elfconfig
  HOSTCC  scripts/pnmtologo
/bin/sh: line 1: scripts/fixdep: No such file or directory
make[1]: *** [scripts/empty.o] Error 1
make[1]: *** Waiting for unfinished jobs....
  HOSTCC  scripts/bin2c
/bin/sh: line 1: scripts/fixdep: No such file or directory
make[1]: *** [scripts/split-include] Error 1
/bin/sh: line 1: scripts/fixdep: No such file or directory
make[1]: *** [scripts/conmakehash] Error 1
make: *** [scripts] Error 2
[root@rade7 linux-2.6.0-test11]$ /bin/sh: line 1: scripts/fixdep: No
such file or directory
/bin/sh: line 1: scripts/fixdep: No such file or directory
/bin/sh: line 1: scripts/fixdep: No such file or directory
/bin/sh: line 1: scripts/fixdep: No such file or directory
/bin/sh: line 1: scripts/fixdep: No such file or directory

 
I got this problem, but just once. I was working when I did the command
line once again (might be some ghosts).

Regards
-- 
Emmanuel

Ford: You'd better be prepared for the jump into hyperspace.
It's unpleasently like being drunk.
Arthur: What's so unpleasent about being drunk?
Ford: You ask a glass of water.
  -- Arthur first jump into hyperspace (Douglas Adams)

