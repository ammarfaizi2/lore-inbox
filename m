Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbRE0Loz>; Sun, 27 May 2001 07:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261741AbRE0Lof>; Sun, 27 May 2001 07:44:35 -0400
Received: from [213.97.199.90] ([213.97.199.90]:384 "HELO fargo")
	by vger.kernel.org with SMTP id <S261719AbRE0LoX> convert rfc822-to-8bit;
	Sun, 27 May 2001 07:44:23 -0400
From: "David =?ISO-8859-1?Q?G=F3mez" ?= <davidge@jazzfree.com>
Date: Sat, 26 May 2001 21:13:25 +0200 (CEST)
To: Hannu Mallat <hmallat@cc.hut.fi>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Some warnings at tdfxfb.c
Message-ID: <Pine.LNX.4.21.0105262052130.1572-100000@fargo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is on kernel 2.4.5. It's look like a long time has passed since this
driver was modified. Haven't tested if works, but things like using char
*name in tdfxb_init without initializing needs some fix. Is enough to do a
kmalloc to get some free space?

gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall -Wstrict-prototypes
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe
-mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o tdfxfb.o
tdfxfb.c
tdfxfb.c: In function `tdfxfb_init':
tdfxfb.c:1895: warning: `name' might be used uninitialized in this
function
tdfxfb.c: In function `tdfxfb_setcolreg':
tdfxfb.c:2215: warning: unused variable `rgbcol'
tdfxfb.c: At top level:
tdfxfb.c:1038: warning: `tdfx_cfb8_putc' defined but not used
tdfxfb.c:1067: warning: `tdfx_cfb8_putcs' defined but not used
tdfxfb.c:1097: warning: `tdfx_cfb8_clear' defined but not used



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


