Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSFVRga>; Sat, 22 Jun 2002 13:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316797AbSFVRg3>; Sat, 22 Jun 2002 13:36:29 -0400
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.45]:22473 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S316795AbSFVRg2>; Sat, 22 Jun 2002 13:36:28 -0400
Date: Sat, 22 Jun 2002 13:41:46 -0400
From: sean darcy <seandarcy@hotmail.com>
Subject: piggy broken in 2.5.24 build
To: linux kernel <linux-kernel@vger.kernel.org>
Message-id: <3D14B6DA.7090609@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of make bzImage I get:

> make[2]: Entering directory `/opt/kernel/linux-2.5.24/arch/i386/boot/compressed'
> tmppiggy=_tmp_$$piggy; \
> rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk; \
> objcopy -O binary -R .note -R .comment -S /opt/kernel/linux-2.5.24/vmlinux $tmppiggy; \
> gzip -f -9 < $tmppiggy > $tmppiggy.gz; \
> echo "SECTIONS { .data : { input_len = .; LONG(input_data_end - input_data) input_data = .; *(.data) input_data_end = .; }}" > $tmppiggy.lnk; \
> ld -m elf_i386 -r -o piggy.o -b binary $tmppiggy.gz -b elf32-i386 -T $tmppiggy.lnk; \
> rm -f $tmppiggy $tmppiggy.gz $tmppiggy.lnk
> /bin/sh: _tmp_18313piggy: No such file or directory
> ld: cannot open _tmp_18313piggy.gz: No such file or directory
> gcc -D__ASSEMBLY__ -D__KERNEL__ -I/opt/kernel/linux-2.5.24/include -traditional -c head.S
> gcc -D__KERNEL__ -I/opt/kernel/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DKBUILD_BASENAME=misc -c misc.c
> ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
> ld: cannot open piggy.o: No such file or directory
> make[2]: *** [bvmlinux] Error 1
> make[2]: Leaving directory `/opt/kernel/linux-2.5.24/arch/i386/boot/compressed'
> make[1]: *** [compressed/bvmlinux] Error 2
> make[1]: Leaving directory `/opt/kernel/linux-2.5.24/arch/i386/boot'
> make: *** [bzImage] Error 2

I tried zImage, with the same result.

Can I boot with just vmlinux?

jay

