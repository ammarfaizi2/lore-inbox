Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312287AbSCTXgV>; Wed, 20 Mar 2002 18:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312288AbSCTXgL>; Wed, 20 Mar 2002 18:36:11 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:8177 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312287AbSCTXfy>; Wed, 20 Mar 2002 18:35:54 -0500
Message-ID: <3C991CD7.304631FC@eyal.emu.id.au>
Date: Thu, 21 Mar 2002 10:35:51 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre4: zr36067.c needs update?
In-Reply-To: <Pine.LNX.4.21.0203201757560.9129-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> So here goes pre4, now with a much more detailed changelog...
> 

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=zr36067  -c -o zr36067.o zr36067.c
zr36067.c: In function `zoran_open':
zr36067.c:3268: structure has no member named `busy'
zr36067.c: At top level:
zr36067.c:4405: warning: initialization makes integer from pointer
without a cast
zr36067.c:4406: warning: initialization makes integer from pointer
without a cast
zr36067.c:4407: warning: initialization from incompatible pointer type
zr36067.c:4408: warning: initialization from incompatible pointer type
zr36067.c:4410: warning: initialization from incompatible pointer type
zr36067.c:4411: warning: initialization from incompatible pointer type
zr36067.c:4412: warning: initialization from incompatible pointer type
make[3]: *** [zr36067.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/media/video'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
