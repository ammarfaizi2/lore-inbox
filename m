Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293680AbSEALMB>; Wed, 1 May 2002 07:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSEALMA>; Wed, 1 May 2002 07:12:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:1008 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S293680AbSEALL7>; Wed, 1 May 2002 07:11:59 -0400
Date: Wed, 1 May 2002 13:07:46 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: linux-kernel@vger.kernel.org,
        Martin Dalecki <dalecki@evision-ventures.com>
Subject: 2.5.12: pdcadma.c:69: too few arguments to function `ide_dmaproc'
Message-ID: <Pine.NEB.4.44.0205011305370.12512-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just FYI:

The ide_dmaproc changes in 2.5.12 broke the compilation of pdcadma.c:

<--  snip  -->

...
gcc -D__KERNEL__ -I/home/bunk/linux/kernel-2.5/linux-2.5.12/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6   -DKBUILD_BASENAME=pdcadma  -c -o pdcadma.o pdcadma.c
pdcadma.c: In function `pdcadma_dmaproc':
pdcadma.c:69: too few arguments to function `ide_dmaproc'
make[3]: *** [pdcadma.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.12/drivers/ide'

<--  snip  -->

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


