Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSIKCdO>; Tue, 10 Sep 2002 22:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSIKCdO>; Tue, 10 Sep 2002 22:33:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31238 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318290AbSIKCdN>;
	Tue, 10 Sep 2002 22:33:13 -0400
Message-ID: <3D7EAC65.8030101@mandrakesoft.com>
Date: Tue, 10 Sep 2002 22:37:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Mickeler <steve@neptune.ca>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre6 tg3 compile errors
References: <Pine.LNX.4.44.0209102218460.3875-100000@triton.neptune.on.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Mickeler wrote:
> Ok, I applied the entire 2.4.20-pre6 and still get compile errors:
> 
> gcc -D__KERNEL__ -I/usr/src/test/linux-2.4.20-pre6/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=tg3  -c -o tg3.o tg3.c
> 
> tg3.c: In function `__tg3_set_rx_mode':
> tg3.c:4881: structure has no member named `vlgrp'


Wrap this line of code inside a

#if TG3_VLAN_TAG_USED
...line 4881 here...
#endif

