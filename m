Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRHTHgE>; Mon, 20 Aug 2001 03:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271112AbRHTHfz>; Mon, 20 Aug 2001 03:35:55 -0400
Received: from mail.uni-kl.de ([131.246.137.52]:24733 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S271108AbRHTHfr>;
	Mon, 20 Aug 2001 03:35:47 -0400
Message-ID: <XFMail.20010820093559.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Mon, 20 Aug 2001 09:35:59 +0200 (CEST)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel 2.4.9, esssolo soundcard, NTFS support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

============================================================================

1.

having problems to build a 2.4.9 kernel with soundcard support (esssolo
for ex.). After having built the kernel with sound modules, depmod
complains about unresolved gameport_register_port and gameport_unregister_port.

What has gameport to do with the soundcard support?

As workaround, I configured the kernel with "Joystick support" = yes and
at least "Classic PC analog joysticks and gamepads" = yes.

This helps, but I think, it should be unnecessary.

I had the same problem in 2.4.7 and 2.4.8, and I'm wondering about
the fact that it takes such a long time to fix it.

===============================================================================

2.

Compiling the kernel with NTFS support fails during compilations of the
NTFS modules:

make[2]: Entering directory `/usr/src/linux-2.4.9/fs/ntfs'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o fs.o fs.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o sysctl.o sysctl.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o support.o support.
c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o util.o util.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o inode.o inode.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o dir.o dir.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o super.o super.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o attr.o attr.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9/include -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack
-boundary=2 -march=i686 -DMODULE -DNTFS_VERSION=\"1.1.16\"   -c -o unistr.o unistr.c
unistr.c: In function `ntfs_collate_names':
unistr.c:99: warning: implicit declaration of function `min'
unistr.c:99: parse error before `unsigned'
unistr.c:99: parse error before `)'
unistr.c:97: warning: `c1' might be used uninitialized in this function
unistr.c: At top level:
unistr.c:118: parse error before `if'
unistr.c:123: warning: type defaults to `int' in declaration of `c1'
unistr.c:123: `name1' undeclared here (not in a function)
unistr.c:123: warning: data definition has no type or storage class
unistr.c:124: parse error before `if'
make[2]: *** [unistr.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.9/fs/ntfs'
make[1]: *** [_modsubdir_ntfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9/fs'
make: *** [_mod_fs] Error 2

====================================================================================

Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

