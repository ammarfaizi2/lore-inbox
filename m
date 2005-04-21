Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVDUJAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVDUJAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVDUJAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:00:23 -0400
Received: from mail.portrix.net ([212.202.157.208]:55506 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S261509AbVDUI7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 04:59:42 -0400
Message-ID: <42676B76.4010903@ppp0.net>
Date: Thu, 21 Apr 2005 10:59:34 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: geert@linux-m68k.org
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Geert Uytterhoeven:
>     [PATCH] M68k: Update defconfigs for 2.6.11
>     [PATCH] M68k: Update defconfigs for 2.6.12-rc2

Why do I still get this error when trying to cross-compile for m68k?

toolchain:

Reading specs from /usr/local/m68k-uclinux-tools/lib/gcc/m68k-uclinux/3.4.0/specs
Configured with: /usr/local/src/uclinux-tools/gcc-3.4.0/configure --target=m68k-uclinux --prefix=/usr/local/m68k-uclinux-tools
--enable-languages=c,c++ --enable-multilib --enable-target-optspace --with-gnu-ld --disable-nls --disable-__cxa_atexit --disable-c99 --disable-clocale
--disable-c-mbchar --disable-long-long --enable-threads=posix --enable-cxx-flags=-D_ISOC99_SOURCE -D_BSD_SOURCE
Thread model: posix
gcc version 3.4.0
GNU ld version 2.14.90.0.8 20040114

(I tried an alternative toolchain with gcc 3.3.3 as well)

$ make mrproper
$ make ARCH=m68k CROSS_COMPILE=m68k-elf- mrproper
$ make ARCH=m68k CROSS_COMPILE=m68k-elf- defconfig
$ make ARCH=m68k CROSS_COMPILE=m68k-elf-
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-m68k
  SPLIT   include/linux/autoconf.h -> include/config/*
  HOSTCC  scripts/kallsyms
  HOSTCC  scripts/conmakehash
  CC      arch/m68k/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/m68k/kernel/asm-offsets.c:12:
include/linux/thread_info.h:30: error: parse error before '{' token
include/linux/thread_info.h:35: error: parse error before '{' token
include/linux/thread_info.h: In function `test_and_set_thread_flag':
include/linux/thread_info.h:42: error: `current' undeclared (first use in this function)
include/linux/thread_info.h:42: error: (Each undeclared identifier is reported only once
include/linux/thread_info.h:42: error: for each function it appears in.)
include/linux/thread_info.h: In function `test_and_clear_thread_flag':
include/linux/thread_info.h:47: error: `current' undeclared (first use in this function)
include/linux/thread_info.h: At top level:
include/linux/thread_info.h:50: error: parse error before '{' token
include/linux/thread_info.h:50: warning: type defaults to `int' in declaration of `___res'
include/linux/thread_info.h:50: warning: data definition has no type or storage class
include/linux/thread_info.h:50: error: parse error before '}' token
include/linux/thread_info.h: In function `set_ti_thread_flag':
include/linux/thread_info.h:57: error: structure has no member named `flags'
include/linux/thread_info.h:57: error: structure has no member named `flags'
include/linux/thread_info.h: In function `clear_ti_thread_flag':
include/linux/thread_info.h:62: error: structure has no member named `flags'
include/linux/thread_info.h:62: error: structure has no member named `flags'
include/linux/thread_info.h: In function `test_and_set_ti_thread_flag':
include/linux/thread_info.h:67: error: structure has no member named `flags'
include/linux/thread_info.h:67: error: structure has no member named `flags'
include/linux/thread_info.h: In function `test_and_clear_ti_thread_flag':
include/linux/thread_info.h:72: error: structure has no member named `flags'
include/linux/thread_info.h:72: error: structure has no member named `flags'
include/linux/thread_info.h: In function `test_ti_thread_flag':
include/linux/thread_info.h:77: error: structure has no member named `flags'
In file included from include/linux/spinlock.h:12,
                 from include/linux/capability.h:45,
                 from include/linux/sched.h:7,
                 from arch/m68k/kernel/asm-offsets.c:12:
include/linux/thread_info.h:80:41: macro "set_need_resched" passed 1 arguments, but takes just 0
include/linux/thread_info.h: At top level:
include/linux/thread_info.h:81: error: syntax error before '{' token
include/linux/thread_info.h:85:43: macro "clear_need_resched" passed 1 arguments, but takes just 0
include/linux/thread_info.h:86: error: syntax error before '{' token
In file included from arch/m68k/kernel/asm-offsets.c:12:
include/linux/sched.h:1108: error: parse error before '{' token
include/linux/sched.h:1113: error: parse error before '{' token
include/linux/sched.h:1118: error: parse error before '{' token
include/linux/sched.h:1118: warning: type defaults to `int' in declaration of `___res'
include/linux/sched.h:1118: warning: data definition has no type or storage class
include/linux/sched.h:1118: error: parse error before '}' token
include/linux/sched.h:1118: warning: type defaults to `int' in declaration of `__res'
include/linux/sched.h:1118: warning: data definition has no type or storage class
include/linux/sched.h:1118: error: parse error before '}' token
include/linux/sched.h:1128: error: parse error before '{' token
include/linux/sched.h:1128: warning: type defaults to `int' in declaration of `___res'
include/linux/sched.h:1128: warning: data definition has no type or storage class
include/linux/sched.h:1128: error: parse error before '}' token
make[1]: *** [arch/m68k/kernel/asm-offsets.s] Error 1
make: *** [arch/m68k/kernel/asm-offsets.s] Error 2
Thu, 21 Apr 2005 09:05:23 +0200

Thanks,

Jan
