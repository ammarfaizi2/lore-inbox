Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266512AbSKORkS>; Fri, 15 Nov 2002 12:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbSKORkR>; Fri, 15 Nov 2002 12:40:17 -0500
Received: from mail.broadpark.no ([217.13.4.2]:6346 "HELO mail.broadpark.no")
	by vger.kernel.org with SMTP id <S266512AbSKORkP>;
	Fri, 15 Nov 2002 12:40:15 -0500
Message-ID: <3DD53234.B0F1C9C8@broadpark.no>
Date: Fri, 15 Nov 2002 18:43:16 +0100
From: Helge Hafting <helge.hafting@broadpark.no>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.47 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.47-bk4 compile failure, due to crypto
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this, even if I de-selects all the crypto stuff.
Helge Hafting

make -f scripts/Makefile.build obj=net/core
  gcc -Wp,-MD,net/core/.skbuff.o.d -D__KERNEL__ -Iinclude -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include   
-DKBUILD_BASENAME=skbuff -DKBUILD_MODNAME=skbuff   -c -o
net/core/skbuff.o net/core/skbuff.c
In file included from include/net/xfrm.h:6,
                 from net/core/skbuff.c:61:
include/linux/crypto.h: In function `crypto_tfm_alg_modname':
include/linux/crypto.h:202: dereferencing pointer to incomplete type
include/linux/crypto.h:205: warning: control reaches end of non-void
function
make[2]: *** [net/core/skbuff.o] Error 1
make[1]: *** [net/core] Error 2
make: *** [net] Error 2
