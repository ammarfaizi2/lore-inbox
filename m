Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbSIPLsB>; Mon, 16 Sep 2002 07:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbSIPLsA>; Mon, 16 Sep 2002 07:48:00 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3835 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261637AbSIPLsA>; Mon, 16 Sep 2002 07:48:00 -0400
Date: Mon, 16 Sep 2002 13:52:53 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: fokkensr@fokkensr.vertis.nl
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.35
In-Reply-To: <Pine.LNX.4.33.0209151926330.10806-100000@penguin.transmeta.com>
Message-ID: <Pine.NEB.4.44.0209161347591.14886-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Linus Torvalds wrote:

>...
> <fokkensr@fokkensr.vertis.nl>:
>   o USER_HZ & NTP problems
>...

This change results in a compile error in the ATM drivers:

<--  snip  -->

...
  gcc -Wp,-MD,./.eni.o.d -D__KERNEL__
-I/home/bunk/linux/kernel-2.5/linux-2.5.35/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=k6 -nostdinc -iwithprefix include  -g  -DKBUILD_BASENAME=eni   -c
-o eni.o eni.c
eni.c: In function `get_service':
eni.c:705: incompatible types in assignment
make[2]: *** [eni.o] Error 1
make[2]: Leaving directory `/home/bunk/linux/kernel-2.5/linux-2.5.35/drivers/atm'

<--  snip  -->


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

