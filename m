Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276750AbRJKTV3>; Thu, 11 Oct 2001 15:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276732AbRJKTUm>; Thu, 11 Oct 2001 15:20:42 -0400
Received: from bzq-240-21.red.bezeqint.net ([212.179.240.21]:260 "EHLO
	darkstar") by vger.kernel.org with ESMTP id <S276751AbRJKTTr>;
	Thu, 11 Oct 2001 15:19:47 -0400
Date: Thu, 11 Oct 2001 21:20:15 +0200
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.12 fails to compile with IEEE 1284 parport enabled
Message-ID: <20011011212015.A7983@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: Koby Kahane <kobyk@bigfoot.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while attempting to compile 2.4.12, during the module compilation phase, the following errors occur:

...
make -C parport modules
make[2]: Entering directory `/usr/src/linux/drivers/parport'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o share.o share.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o ieee1284.o ieee1284.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux/include/linux/modversions.h   -c -o ieee1284_ops.o ieee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this function)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

The following configuration options which appear to be related are enabled:

...
#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y
...

This configuration worked fine with 2.4.11.

  Koby Kahane

