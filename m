Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268004AbRGVQuS>; Sun, 22 Jul 2001 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268001AbRGVQuJ>; Sun, 22 Jul 2001 12:50:09 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:6468 "HELO
	email03.aon.at") by vger.kernel.org with SMTP id <S268000AbRGVQt6>;
	Sun, 22 Jul 2001 12:49:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter Klotz <peter.klotz@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Problem compiling kernel 2.4.7 with gcc 2.96
Date: Sun, 22 Jul 2001 18:51:24 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01072218512400.13385@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi folks

When creating the modules (make modules) for my 2.4.7 kernel the compilation 
aborts with the following error message. I used the standard Red Hat 7.1 
kernel configuration file with only minor modifications.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.7/include/linux/modversions.h   -c -o xd.o xd.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.7/include/linux/modversions.h   -c -o cpqarray.o 
cpqarray.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /usr/src/linux-2.4.7/include/linux/modversions.h   -c -o cciss.o 
cciss.cgcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4.7/include/linux/modversions.h   -DEXPORT_SYMTAB -c DAC960.c
DAC960.c: In function `DAC960_ProcessRequest':
DAC960.c:2771: structure has no member named `sem'
make[2]: *** [DAC960.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.7/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.7/drivers'
make: *** [_mod_drivers] Error 2
[root@localhost linux]#

I have run the ver_linux script as recommended. Here is the output.

[root@localhost linux]# sh scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.6 #1 Thu Jul 5 08:40:51 CEST 2001 i686 unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.91.0.2
util-linux             2.10s
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0f
PPP                    2.4.0
isdn4k-utils           3.1pre1
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ppp_async ppp_generic binfmt_misc autofs scanner 3c59x 
ipchains parport_pc ppa parport ide-scsi scsi_mod ide-cd cdrom ntfs 
nls_iso8859-1 nls_cp437 vfat fat reiserfs usb-uhci usbcore
[root@localhost linux]#

Maybe someone has an idea.

Bye, Peter.
