Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262375AbRENSlO>; Mon, 14 May 2001 14:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262374AbRENSlE>; Mon, 14 May 2001 14:41:04 -0400
Received: from www.topmail.de ([212.255.16.226]:39107 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S262371AbRENSkr>;
	Mon, 14 May 2001 14:40:47 -0400
From: mirabilos <eccesys@topmail.de>
To: linux-kernel@vger.kernel.org
Subject: latest-ac9 compile error (gcc3)
Message-Id: <20010514183849.6D6BBA5A608@www.topmail.de>
Date: Mon, 14 May 2001 20:38:49 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have removed the "inline" in rwsem.h as suggested, and now
can't compile -ac9 with the following error (seems to be a
problem in the part that loads the compressed image):

gcc -D__ASSEMBLY__ -D__KERNEL__ -I/glc/build/linux-2.4.4-ac9/include -traditional -c head.S
gcc -D__KERNEL__ -I/glc/build/linux-2.4.4-ac9/include -O2 -DSTDC_HEADERS -c misc.c
ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
misc.o(.text.lock+0xa): undefined reference to `rwsem_wake'
make[2]: *** [bvmlinux] Error 1
make[2]: Leaving directory `/glc/build/linux-2.4.4-ac9/arch/i386/boot/compressed'
make[1]: *** [compressed/bvmlinux] Error 2
make[1]: Leaving directory `/glc/build/linux-2.4.4-ac9/arch/i386/boot'
make: *** [bzImage] Error 2
ecce:/usr/src/linux #

Can anyone think why this is?
More info (config etc.) on request.
Compiler: gcc3-snapshot 14.5.2001

-mirabilos
-- 
by telnet
