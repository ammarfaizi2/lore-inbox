Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbTCJV1W>; Mon, 10 Mar 2003 16:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261484AbTCJV1W>; Mon, 10 Mar 2003 16:27:22 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:10131 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S261452AbTCJV1V>; Mon, 10 Mar 2003 16:27:21 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Linus BK: change to asm-i386/thread_info.h causes build failure: no TIF_USEDFPU
From: Derek Atkins <warlord@MIT.EDU>
Date: 10 Mar 2003 16:37:58 -0500
Message-ID: <sjmbs0iaond.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Your change to includes/asm-i386/thread_info.h today causes the following
build failure.  I think more people were using the USEDFPU flag than you
thought (or the Changeset isn't complete).

-derek

  gcc -Wp,-MD,drivers/md/.xor.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   -DKBUILD_BASENAME=xor -DKBUILD_MODNAME=xor -c -o drivers/md/xor.o drivers/md/xor.c
In file included from drivers/md/xor.c:23:
include/asm/xor.h: In function `xor_pII_mmx_2':
include/asm/xor.h:51: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h:51: (Each undeclared identifier is reported only once
include/asm/xor.h:51: for each function it appears in.)
include/asm/xor.h: In function `xor_pII_mmx_3':
include/asm/xor.h:96: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h: In function `xor_pII_mmx_4':
include/asm/xor.h:146: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h: In function `xor_pII_mmx_5':
include/asm/xor.h:202: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h: In function `xor_p5_mmx_2':
include/asm/xor.h:275: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h: In function `xor_p5_mmx_3':
include/asm/xor.h:324: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h: In function `xor_p5_mmx_4':
include/asm/xor.h:382: `TIF_USEDFPU' undeclared (first use in this function)
include/asm/xor.h: In function `xor_p5_mmx_5':
include/asm/xor.h:449: `TIF_USEDFPU' undeclared (first use in this function)
make[2]: *** [drivers/md/xor.o] Error 1
make[1]: *** [drivers/md] Error 2

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available
