Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276751AbRJPVsN>; Tue, 16 Oct 2001 17:48:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276745AbRJPVsD>; Tue, 16 Oct 2001 17:48:03 -0400
Received: from pop.gmx.net ([213.165.64.20]:33508 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S276755AbRJPVrx>;
	Tue, 16 Oct 2001 17:47:53 -0400
Message-ID: <3BCCAAE3.5070409@gmx.de>
Date: Tue, 16 Oct 2001 23:47:15 +0200
From: Markus =?ISO-8859-1?Q?Br=FCckner?= <mb1611@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: de, en-us
MIME-Version: 1.0
To: Herbert Rosmanith <herp@wildsau.idv-edu.uni-linz.ac.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12 compilation fails ieee1284
In-Reply-To: <200110160055.f9G0tXs00314@wildsau.idv-edu.uni-linz.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Rosmanith wrote:

>gcc -D__KERNEL__ -I/data/root/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -DMODULE -DMODVERSIONS -include /data/root/linux/include/linux/modversions.h   -c -o ieee1284_ops.o ieee1284_ops.c
>ieee1284_ops.c: In function `ecp_forward_to_reverse':
>ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
>ieee1284_ops.c:365: (Each undeclared identifier is reported only once
>ieee1284_ops.c:365: for each function it appears in.)
>ieee1284_ops.c: In function `ecp_reverse_to_forward':
>ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
>make[2]: *** [ieee1284_ops.o] Error 1
>make[2]: Leaving directory `/data/root/linux/drivers/parport'
>make[1]: *** [_modsubdir_parport] Error 2
>make[1]: Leaving directory `/data/root/linux/drivers'
>make: *** [_mod_drivers] Error 2
>
I simply changed this to IEE1284_PH_ECP_DIR_UNKNOWN. It compiles right 
and doesn't seem to screw up the operation of the module.

HTH
Markus


