Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132046AbQKWNyt>; Thu, 23 Nov 2000 08:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132601AbQKWNyj>; Thu, 23 Nov 2000 08:54:39 -0500
Received: from draconic.fyremoon.net ([194.159.247.49]:59922 "EHLO
        draconic.fyremoon.net") by vger.kernel.org with ESMTP
        id <S132046AbQKWNy0>; Thu, 23 Nov 2000 08:54:26 -0500
Message-ID: <58599.195.11.55.51.974985864.squirrel@www.fyremoon.net>
Date: Thu, 23 Nov 2000 13:24:24 -0000 (GMT)
Subject: ixj compile problems in 2.4.0-test11
From: "John Crowhurst" <FyreMoon@fyremoon.net>
To: linux-kernel@vger.kernel.org
Reply-To: FyreMoon@fyremoon.net
X-Mailer: SquirrelMail (version 1.0pre1 (cvs))
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just recompiled my kernel from 2.4.0-test10, upgrading to test-11, this
is the output from a make bzlilo:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2
-fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o ixj.o
ixj.c
ixj.c: In function      xj_ioctl':
ixj.c:4703: D_PHONE_RING_START' undeclared (first use in this function)
ixj.c:4703: (Each undeclared identifier is reported only once          
ixj.c:4703: for each function it appears in.)
ixj.c:4948: `PHONE_QUERY_CODEC' undeclared (first use in this function)
ixj.c:4950: storage size of `pd' isn't known                           
ixj.c:4950: warning: unused variable `pd'
make[3]: *** [ixj.o] Error 1
make[3]: Leaving directory /usr/src/linux/drivers/telephony'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory /usr/src/linux/drivers/telephony'
make[1]: *** [_subdir_telephony] Error 2
make[1]: Leaving directory /usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

Here is the .config diff from test-10 to test-11:
--- /usr/src/linux-test-10/.config      Thu Nov 23 12:08:38 2000
+++ /usr/src/linux-test-11/.config      Thu Nov 23 12:36:13 2000
@@ -28,6 +28,7 @@
 # CONFIG_M586MMX is not set
 # CONFIG_M686 is not set   
 CONFIG_M686FXSR=y
+# CONFIG_MPENTIUM4 is not set
 # CONFIG_MK6 is not set
 # CONFIG_MK7 is not set
 # CONFIG_MCRUSOE is not set
@@ -71,6 +72,7 @@
 CONFIG_PCI_BIOS=y
 CONFIG_PCI_DIRECT=y
 CONFIG_PCI_NAMES=y 
+# CONFIG_EISA is not set
 # CONFIG_MCA is not set 
 CONFIG_HOTPLUG=y

I hope this is what you need, as the kernel compiles on test-10

-- 
FyreMoon
Under the moon, the dragon flies.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
