Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261805AbRE0Lw1>; Sun, 27 May 2001 07:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbRE0LwH>; Sun, 27 May 2001 07:52:07 -0400
Received: from WARSL401PIP3.highway.telekom.at ([195.3.96.75]:7194 "HELO
	email02.aon.at") by vger.kernel.org with SMTP id <S261805AbRE0Lv4>;
	Sun, 27 May 2001 07:51:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Peter Klotz <peter.klotz@aon.at>
To: linux-kernel@vger.kernel.org
Subject: Problem compiling kernel 2.4.5 with gcc 2.96
Date: Sun, 27 May 2001 13:53:03 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01052713530300.01775@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

When creating the modules (make modules) for my 2.4.5 kernel the compilation 
aborts with the following error messages. The problem seems to be related 
with Video for Linux and the Iomega Buz Driver.

gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4.5/include/linux/modversions.h   -c -o c-qcam.o c-qcam.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4.5/include/linux/modversions.h   -c -o bw-qcam.o bw-qcam.c
gcc -D__KERNEL__ -I/usr/src/linux-2.4.5/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4.5/include/linux/modversions.h   -c -o buz.o buz.c
buz.c: In function `v4l_fbuffer_alloc':
buz.c:188: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:188: (Each undeclared identifier is reported only once
buz.c:188: for each function it appears in.)
buz.c: In function `jpg_fbuffer_alloc':
buz.c:262: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:256: warning: `alloc_contig' might be used uninitialized in this 
function
buz.c: In function `jpg_fbuffer_free':
buz.c:322: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c:316: warning: `alloc_contig' might be used uninitialized in this 
function
buz.c: In function `zoran_ioctl':
buz.c:2837: `KMALLOC_MAXSIZE' undeclared (first use in this function)
buz.c: In function `zr36057_init':
buz.c:3215: too few arguments to function `video_register_device_Recfe1c4b'
make[3]: *** [buz.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.5/drivers/media/video'
make[2]: *** [_modsubdir_video] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.5/drivers/media'
make[1]: *** [_modsubdir_media] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.5/drivers'
make: *** [_mod_drivers] Error 2

I have run the ver_linux script as recommended. Here is the output.

[root@localhost scripts]# ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.4 #1 Fri May 11 10:19:47 CEST 2001 i686 
unknown

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
Modules Loaded         ppp_async ppp_generic binfmt_misc scanner autofs 3c59x 
ipchains parport_pc ppa parport ide-scsi scsi_mod ide-cd cdrom ntfs 
nls_iso8859-1
nls_cp437 vfat fat usb-uhci usbcore
[root@localhost scripts]#  

Maybe someone has an idea (other than deactivating Video for Linux).

Bye, Peter.
