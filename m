Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265740AbSKFPox>; Wed, 6 Nov 2002 10:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265741AbSKFPox>; Wed, 6 Nov 2002 10:44:53 -0500
Received: from isp247n.hispeed.ch ([62.2.95.247]:13796 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id <S265740AbSKFPox>;
	Wed, 6 Nov 2002 10:44:53 -0500
Date: Wed, 06 Nov 2002 16:51:27 +0100
From: xmb <xmb@kick.sytes.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: initramfs in 2.5.46 wont compile
Message-ID: <2147483647.1036601487@[192.168.1.2]>
X-Mailer: Mulberry/3.0.0b8 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yo,

was trying to compile 2.5.46 fresh from source on my ppc machine, and 
initramfs gives me an err (in make bzImage):

make -f scripts/Makefile.build obj=arch/ppc/kernel 
arch/ppc/kernel/asm-offsets.s
make[1]: `arch/ppc/kernel/asm-offsets.s' is up to date.
  Generating include/asm-ppc/offsets.h (unchanged)
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make -f scripts/Makefile.build obj=init
  Generating include/linux/compile.h (unchanged)
make -f scripts/Makefile.build obj=usr
objcopy  \
        --rename-section .data=.init.initramfs \
        usr/initramfs_data.cpio.gz usr/initramfs_data.o
objcopy: usr/initramfs_data.cpio.gz: File format not recognized
make[1]: *** [usr/initramfs_data.o] Error 1
make: *** [usr] Error 2

./xmb
