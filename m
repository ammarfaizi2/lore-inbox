Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287593AbSAEH4S>; Sat, 5 Jan 2002 02:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287596AbSAEH4K>; Sat, 5 Jan 2002 02:56:10 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:59913 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287593AbSAEH4A>; Sat, 5 Jan 2002 02:56:00 -0500
Subject: 2.5.2-pre8 -- Compile errors in ieee1394/raw1394.c and video1394.c
	(invalid operands to binary &)
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 04 Jan 2002 23:56:03 -0800
Message-Id: <1010217375.19924.8.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am including relevant bits of the .config.
I am running gcc 3.0.3.

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o raw1394.o raw1394.c
raw1394.c: In function `raw1394_open':
raw1394.c:918: invalid operands to binary &
make[3]: *** [raw1394.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/ieee1394'

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o video1394.o video1394.c
video1394.c: In function `video1394_ioctl':
video1394.c:853: invalid operands to binary &
video1394.c:863: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
video1394.c:863: invalid operands to binary &
video1394.c: In function `video1394_mmap':
video1394.c:1331: invalid operands to binary &
video1394.c:1340: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
video1394.c:1340: invalid operands to binary &
video1394.c: In function `video1394_open':
video1394.c:1360: invalid operands to binary &
video1394.c: In function `video1394_release':
video1394.c:1400: invalid operands to binary &
video1394.c:1409: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
video1394.c:1409: invalid operands to binary &
video1394.c: In function `irq_handler':
video1394.c:1477: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
make[3]: *** [video1394.o] Error 1

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=y
# CONFIG_IEEE1394_PCILYNX is not set
CONFIG_IEEE1394_OHCI1394=y
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_SBP2=y
CONFIG_IEEE1394_RAWIO=y
CONFIG_IEEE1394_VERBOSEDEBUG=y

If you need more .config, please let me know.

Also. here's what ver_linux spits out:

Gnu C                  3.0.3
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.23
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.22
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Linux C++ Library      3.0.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0


