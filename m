Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263814AbSIQHaA>; Tue, 17 Sep 2002 03:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263866AbSIQHaA>; Tue, 17 Sep 2002 03:30:00 -0400
Received: from dp.samba.org ([66.70.73.150]:50599 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S263814AbSIQH37>;
	Tue, 17 Sep 2002 03:29:59 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.35 make race?
Date: Tue, 17 Sep 2002 17:33:45 +1000
Message-Id: <20020917073459.C07F72C1F1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai,

	First make -j3 on a 2-way SMP box fails.  The second one
succeeds.  I think a dependency is missing?

cd ~/working-2.5.35-modbase-try/
make -j3
  Making asm->asm-i386 symlink
  Generating include/linux/version.h  CPP     
  HOSTCC  scripts/fixdep
/bin/sh: /usr/home/rusty/working-2.5.35-modbase-try/scripts/fixdep: No such file or directory
 (updated)
make: *** [arch/i386/vmlinux.lds.s] Error 1
make: *** Waiting for unfinished jobs....
  HOSTCC  scripts/split-include
  HOSTCC  scripts/docproc
  HOSTCC  scripts/conmakehash

Compilation exited abnormally with code 2 at Tue Sep 17 17:38:27

Thanks,
Rusty
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
