Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTF1J4z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 05:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbTF1J4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 05:56:55 -0400
Received: from hydra.colinet.de ([194.231.113.36]:21509 "EHLO hydra.colinet.de")
	by vger.kernel.org with ESMTP id S265136AbTF1J4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 05:56:54 -0400
Subject: 2.5.73 on alpha/smp build failure
To: linux-kernel@vger.kernel.org
Cc: kirk@colinet.de
Message-Id: <kirk-1030628112813.A0111034@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
From: "T. Weyergraf" <kirk@colinet.de>
Date: Sat, 28 Jun 2003 11:28:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I  tried to build 2.5.73 on my SMP alpha, but get the following
compile-time failure:

[...]
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
ld: arch/alpha/kernel/built-in.o: !samegp reloc against symbol without .prologue: memset
make[1]: *** [vmlinux] Error 1
make: *** [vmlinux] Error 1

I tried gcc-3.3 and 2.95.4, binutils is 2.14.90.0.4

This problem has been introduced with the __kernel_execve 
reimplementation. 

Any ideas ?  ( what puzzles me, is that i am apparently the only
alpha user with that problem... )

Regards,
Thomas Weyergraf



-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


