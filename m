Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290321AbSAPKeK>; Wed, 16 Jan 2002 05:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290323AbSAPKeA>; Wed, 16 Jan 2002 05:34:00 -0500
Received: from CPE-203-51-24-110.nsw.bigpond.net.au ([203.51.24.110]:41966
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S290321AbSAPKdw>; Wed, 16 Jan 2002 05:33:52 -0500
Message-ID: <3C45570A.14B9E639@eyal.emu.id.au>
Date: Wed, 16 Jan 2002 21:33:46 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre3-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
CC: Marcelo Tosatti l <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.18-pre4: missing cs4281_wrapper.h
In-Reply-To: <Pine.LNX.4.21.0201151955460.27118-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> So here goes pre4.

gcc -D__KERNEL__ -I/data2/usr/local/src/linux-2.4-pre/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686 -malign-functions=4  -DMODULE -DMODVERSIONS -include
/data2/usr/local/src/linux-2.4-pre/include/linux/modversions.h 
-DKBUILD_BASENAME=cs4281m  -c -o cs4281m.o cs4281m.c
cs4281m.c:100: cs4281_wrapper.h: No such file or directory
make[3]: *** [cs4281m.o] Error 1
make[3]: Leaving directory
`/data2/usr/local/src/linux-2.4-pre/drivers/sound/cs4281'

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
