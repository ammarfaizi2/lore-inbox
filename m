Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276344AbRJKN2n>; Thu, 11 Oct 2001 09:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276350AbRJKN2e>; Thu, 11 Oct 2001 09:28:34 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:31481 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S276344AbRJKN22>; Thu, 11 Oct 2001 09:28:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Steve Snyder <swsnyder@home.com>
Reply-To: swsnyder@home.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.4.12: IEEE-1284 won't compile
Date: Thu, 11 Oct 2001 08:28:53 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01101108285301.04104@mercury.snydernet.lan>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patched from 2.4.11 on a RedHat v7.1 system, no errors seen in patching:
 
gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o procfs.o 
procfs.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this 
function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this 
function)
gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE   -c -o usb-uhci.o 
usb-uhci.c
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: *** Waiting for unfinished jobs....
ld -m elf_i386 -r -o usbcore.o usb.o usb-debug.o hub.o
make[2]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/parport'
make[1]: *** [_modsubdir_parport] Error 2
make[1]: *** Waiting for unfinished jobs....
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/usb'
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2m
