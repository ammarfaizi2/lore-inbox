Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291843AbSBNTu6>; Thu, 14 Feb 2002 14:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291851AbSBNTul>; Thu, 14 Feb 2002 14:50:41 -0500
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:13856 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S291843AbSBNTu0>; Thu, 14 Feb 2002 14:50:26 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C01101EF7@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'ultralinux@vger.kernel.org'" <ultralinux@vger.kernel.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: 2.5.5pre1 Sparc64 build problem
Date: Thu, 14 Feb 2002 14:50:20 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am running into a problem building 2.5.5pre1 on a Ultra5 platform.  I get
the following error when doing: make vmlinux

gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -o
scripts/split-include 
scripts/split-include.c

scripts/split-include include/linux/autoconf.h include/config

sparc64-linux-gcc -D__KERNEL__ -I/usr/src/linux-2.5.4/include -Wall
-Wstrict-pro
totypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
-fno-common
 -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow -ffixed-g4
-fcall-used-g5 
-fcall-used-g7 -Wno-sign-compare -Wa,--undeclared-regs
-DKBUILD_BASENAME=main 
-c -o init/main.o init/main.c

In file included from /usr/src/linux-2.5.4/include/asm/pgtable.h:17,

                 from /usr/src/linux-2.5.4/include/linux/mm.h:27,

                 from /usr/src/linux-2.5.4/include/linux/pagemap.h:10,

                 from /usr/src/linux-2.5.4/include/linux/blkdev.h:9,

                 from /usr/src/linux-2.5.4/include/linux/blk.h:4,

                 from init/main.c:25:

/usr/src/linux-2.5.4/include/asm/mmu_context.h:37: #error update this
function. 
make: *** [init/main.o] Error 1  

If I am reading this correctly (and I doubt that I am :O) ) this is from the
include file mmu_context.h correct?  I diff'ed against 2.5.4 and they are
the same, and 2.5.4 compiled.  (Though I couldn't get 2.5.4 to boot on the
system.. but that's another story....)

Thoughts on were I am going wrong here?


Thanks,
Bruce H.

