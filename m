Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315355AbSEBTBa>; Thu, 2 May 2002 15:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315357AbSEBTB3>; Thu, 2 May 2002 15:01:29 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:35061 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315355AbSEBTBY>; Thu, 2 May 2002 15:01:24 -0400
Date: Thu, 2 May 2002 20:57:03 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: 2.5.12: hpt34x.c:259: too few arguments to function `ide_dmaproc'
Message-ID: <Pine.NEB.4.44.0205022054460.21679-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just FYI:

The ide_dmaproc changes in 2.5.12 broke the compilation of hpt34x.c (I
tried 2.5.12-dj1 but this shouldn't make a difference):

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe
-mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linux/2.95.4
/include -DKBUILD_BASENAME=hpt34x  -c -o hpt34x.o hpt34x.c
hpt34x.c: In function `config_drive_xfer_rate':
hpt34x.c:259: too few arguments to function `ide_dmaproc'
hpt34x.c:281: too few arguments to function `ide_dmaproc'
hpt34x.c:304: structure has no member named `dmaproc'
hpt34x.c:305: warning: control reaches end of non-void function
hpt34x.c: In function `hpt34x_dmaproc':
hpt34x.c:350: too few arguments to function `ide_dmaproc'
hpt34x.c: In function `ide_init_hpt34x':
hpt34x.c:426: structure has no member named `dmaproc'
make[3]: *** [hpt34x.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.12/drivers/ide
'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



