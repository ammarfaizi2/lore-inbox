Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314239AbSEDPs3>; Sat, 4 May 2002 11:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314281AbSEDPs2>; Sat, 4 May 2002 11:48:28 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:28122 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S314239AbSEDPs1>; Sat, 4 May 2002 11:48:27 -0400
Date: Sat, 4 May 2002 17:43:56 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Regina Kodato <reginak@cyclades.com>
cc: linux-kernel@vger.kernel.org, <akpm@zip.com.au>,
        <jgarzik@mandrakesoft.com>
Subject: [2.5 patch] s|linux/malloc.h|linux/slab.h| in drivers/net/wan/pc300_tty.c
Message-ID: <Pine.NEB.4.44.0205041738540.283-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Regina,

the patch below fixes the compilation of pc300_tty.c in 2.5.13 and
2.5.13-dj2:

<--  snip  -->

gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.13/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4/include -DKBUILD_BASENAME=pc300_tty  -c -o pc300_tty.o pc300_tty.c
pc300_tty.c:52: linux/malloc.h: No such file or directory
pc300_tty.c: In function `cpc_tty_rx_task':
pc300_tty.c:738: warning: passing arg 2 of pointer to function discards
qualifie
rs from pointer target type
make[4]: *** [pc300_tty.o] Error 1
make[4]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.13/drivers/net
/wan'

<--  snip  -->

--- drivers/net/wan/pc300_tty.c.old	Sat May  4 17:34:14 2002
+++ drivers/net/wan/pc300_tty.c	Sat May  4 17:34:34 2002
@@ -49,7 +49,7 @@
 #include <linux/init.h>
 #include <linux/netdevice.h>
 #include <linux/spinlock.h>
-#include <linux/malloc.h>
+#include <linux/slab.h>
 #include <linux/if.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

