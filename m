Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318538AbSHQIzJ>; Sat, 17 Aug 2002 04:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318539AbSHQIzJ>; Sat, 17 Aug 2002 04:55:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:32737 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S318538AbSHQIzI>; Sat, 17 Aug 2002 04:55:08 -0400
Date: Sat, 17 Aug 2002 10:59:04 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>, <Matt_Domsch@dell.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre3
In-Reply-To: <Pine.LNX.4.44.0208162231060.8044-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0208171048590.10312-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The compile error in efi.c is still present in -pre3:

<--  snip  -->

...
gcc -D__KERNEL__
-I/home/bunk/linux/kernel-2.4/linux-2.4.19-modular/include -Wal
l -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=k6   -nostdinc -I
/usr/lib/gcc-lib/i386-linu
x/2.95.4/include -DKBUILD_BASENAME=efi  -c -o efi.o efi.c
efi.c: In function `add_gpt_partitions':
efi.c:728: `NULL_GUID' undeclared (first use in this function)
efi.c:728: (Each undeclared identifier is reported only once
efi.c:728: for each function it appears in.)
make[3]: *** [efi.o] Error 1
make[3]: Leaving directory
`/home/bunk/linux/kernel-2.4/linux-2.4.19-modular/fs/partitions'

<--  snip  -->

Matt suggested to move include/asm-ia64/efi.h to include/linux/efi.h. Is
it possible to do this before 2.4.20-final?


TIA
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox



