Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275852AbRJULhP>; Sun, 21 Oct 2001 07:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275856AbRJULhF>; Sun, 21 Oct 2001 07:37:05 -0400
Received: from hopi.hostsharing.net ([66.70.34.150]:4278 "HELO
	hopi.hostsharing.net") by vger.kernel.org with SMTP
	id <S275852AbRJULgq>; Sun, 21 Oct 2001 07:36:46 -0400
Date: Sun, 21 Oct 2001 13:37:20 +0200
From: Noel Koethe <noel@koethe.net>
To: linux-kernel@vger.kernel.org
Subject: ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
Message-ID: <20011021133720.E7406@hopi.hostsharing.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello kernel masters,:)

I wanted to build 2.4.12 on i386 but got an error:

#make dep bzImage
works without an error
then
#make modules

gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.12/include/linux/modversions.h   -c -o ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2


#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_1284=y

I get the same problem if I didn't use PARPORT as module.

The file changelog tells me something changed:

drivers/parport/ieee1284_ops.c            |   10 

What is the problem?

Thank you.

-- 
	Noèl Köthe
