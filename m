Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293728AbSCKXVw>; Mon, 11 Mar 2002 18:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293627AbSCKXVg>; Mon, 11 Mar 2002 18:21:36 -0500
Received: from CPE-203-51-27-33.nsw.bigpond.net.au ([203.51.27.33]:46575 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S293728AbSCKXV1>; Mon, 11 Mar 2002 18:21:27 -0500
Message-ID: <3C8D3BF5.67A497C8@eyal.emu.id.au>
Date: Tue, 12 Mar 2002 10:21:25 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre3, with the new IDE code. It has been stable enough time in
> the -ac tree, in my and Alan's opinion.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=pppoe  -c -o pppoe.o pppoe.c
pppoe.c: In function `pppoe_flush_dev':
pppoe.c:282: `PPPOX_ZOMBIE' undeclared (first use in this function)
pppoe.c:282: (Each undeclared identifier is reported only once
pppoe.c:282: for each function it appears in.)
pppoe.c: In function `pppoe_disc_rcv':
pppoe.c:446: `PPPOX_ZOMBIE' undeclared (first use in this function)
pppoe.c: In function `pppoe_ioctl':
pppoe.c:730: `PPPOX_ZOMBIE' undeclared (first use in this function)
make[2]: *** [pppoe.o] Error 1
make[2]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/net'

For me this makes it the third strike, so pre3 is out :-) Got to go
to work now.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
