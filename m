Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSFPLFK>; Sun, 16 Jun 2002 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316158AbSFPLFJ>; Sun, 16 Jun 2002 07:05:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:10221 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316135AbSFPLFG>; Sun, 16 Jun 2002 07:05:06 -0400
Date: Sun, 16 Jun 2002 13:05:02 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 6/19
In-Reply-To: <3D048F0C.6060904@evision-ventures.com>
Message-ID: <Pine.NEB.4.44.0206161302570.11043-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jun 2002, Martin Dalecki wrote:

>...
> - Fix improper __FUNCTION__ usage in smb_debug.h.
>...


Was it intended that this change breaks the compilation of
fs/smbfs/proc.c?


<--  snip  -->

...
  gcc -Wp,-MD,./.proc.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.21-full/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fomit-frame-pointer
 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include  -DSMBFS_PARANOIA  -DKBUILD_BASENAME=proc
-c -o proc.o proc.c
proc.c: In function `smb_request_ok':
proc.c:875: parse error before `)'
make[2]: *** [proc.o] Error 1
make[2]: Leaving directory
`/home/bunk/linux/kernel-2.5/linux-2.5.21-full/fs/smbfs'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


