Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264648AbSJPLPw>; Wed, 16 Oct 2002 07:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264746AbSJPLPw>; Wed, 16 Oct 2002 07:15:52 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:23768 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S264648AbSJPLPv>;
	Wed, 16 Oct 2002 07:15:51 -0400
Date: Wed, 16 Oct 2002 13:21:39 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: linux-xfs@oss.sgi.com
Subject: XFS build error on m68k in 2.5.43
Message-ID: <Pine.GSO.4.21.0210161319210.9988-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When compiling a kernel for m68k (with CONFIG_XFS_FS=m), I get this error:

| make -f fs/xfs/Makefile 
|    rm -f fs/xfs/built-in.o; m68k-linux-ar rcs fs/xfs/built-in.o
|   m68k-linux-gcc -Wp,-MD,fs/xfs/linux/.xfs_stats.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -fno-strength-reduce -ffixed-a2 -nostdinc -iwithprefix include -DMODULE -Ifs/xfs -funsigned-char  -DKBUILD_BASENAME=xfs_stats   -c -o fs/xfs/linux/xfs_stats.o fs/xfs/linux/xfs_stats.c
| In file included from fs/xfs/xfs.h:70,
|                  from fs/xfs/linux/xfs_stats.c:33:
| fs/xfs/xfs_bmap_btree.h:662: badly punctuated parameter list in `#define'
| fs/xfs/xfs_log.h:62: warning: `_lsn_cmp' defined but not used
| make[2]: *** [fs/xfs/linux/xfs_stats.o] Error 1
| make[1]: *** [fs/xfs] Error 2
| make: *** [fs] Error 2

Since it's not obvious to me what's wrong with that define, I'm asking here.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

