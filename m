Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSIKCPq>; Tue, 10 Sep 2002 22:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318285AbSIKCPp>; Tue, 10 Sep 2002 22:15:45 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:42180 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S318283AbSIKCPo>; Tue, 10 Sep 2002 22:15:44 -0400
Date: Tue, 10 Sep 2002 22:20:34 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
In-Reply-To: <20020910.142646.97775138.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209102218460.3875-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I applied the entire 2.4.20-pre6 and still get compile errors:

gcc -D__KERNEL__ -I/usr/src/test/linux-2.4.20-pre6/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
-nostdinc -iwithprefix include -DKBUILD_BASENAME=tg3  -c -o tg3.o tg3.c

tg3.c: In function `__tg3_set_rx_mode':
tg3.c:4881: structure has no member named `vlgrp'
make[3]: *** [tg3.o] Error 1
make[3]: Leaving directory `/usr/src/test/linux-2.4.20-pre6/drivers/net'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/test/linux-2.4.20-pre6/drivers/net'
make[1]: *** [_subdir_net] Error 2
make[1]: Leaving directory `/usr/src/test/linux-2.4.20-pre6/drivers'
make: *** [_dir_drivers] Error 2


On Tue, 10 Sep 2002, David S. Miller wrote:

>    From: Steve Mickeler <steve@neptune.ca>
>    Date: Tue, 10 Sep 2002 17:33:15 -0400 (EDT)
>
>    Yes, all I patched was tg3.c and tg3.h
>
> That isn't going to work, the current driver uses NAPI
> which means you need the rest of the 2.4.20-X networking
> bits too.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF

