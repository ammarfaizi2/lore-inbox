Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTAYXM7>; Sat, 25 Jan 2003 18:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTAYXM7>; Sat, 25 Jan 2003 18:12:59 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1664 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S264699AbTAYXM6>;
	Sat, 25 Jan 2003 18:12:58 -0500
Date: Sat, 25 Jan 2003 18:26:29 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
X-X-Sender: root@bilbo.tmr.com
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.59 Same problems as 55..58
Message-ID: <Pine.LNX.4.44.0301251819570.20871-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same old, I said I'd try kernels newer than 2.5.57 and I did. Still 
doesn't work.
================================================================
make -j2 -f scripts/Makefile.build obj=lib
make -j2 -f scripts/Makefile.build obj=lib/zlib_inflate
make[2]: warning: -jN forced in submake: disabling jobserver mode.
make -j2 -f scripts/Makefile.build obj=arch/i386/lib
make -j2 -f scripts/Makefile.build obj=arch/i386/boot BOOTIMAGE=arch/i386/boot/bzImage install
make -j2 -f scripts/Makefile.build obj=arch/i386/boot/compressed \
				IMAGE_OFFSET=0x100000 arch/i386/boot/compressed/vmlinux
make[2]: warning: -jN forced in submake: disabling jobserver mode.
Kernel: arch/i386/boot/bzImage is ready
sh arch/i386/boot/install.sh 2.5.59 arch/i386/boot/bzImage System.map ""
No module sym53c8xx found for kernel 2.5.59
  .
  . Okay, we know mkinitrd still doesn't work
  .
WARNING: /lib/modules/2.5.59/kernel/drivers/net/8390.ko needs unknown symbol crc32_le
WARNING: /lib/modules/2.5.59/kernel/drivers/net/8390.ko needs unknown symbol bitreverse
  .
  . And this problem I've noted since 2.5.55
  .
================================================================
-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


