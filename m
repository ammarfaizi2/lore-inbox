Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSENASR>; Mon, 13 May 2002 20:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293510AbSENASQ>; Mon, 13 May 2002 20:18:16 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:18840 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293203AbSENASQ>; Mon, 13 May 2002 20:18:16 -0400
Subject: Compilation problems in sysinfo.c
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFB2C907A6.9EB8BB42-ON85256BB9.0000494B@raleigh.ibm.com>
From: "Isabelle Poueriet" <ipouerie@us.ibm.com>
Date: Mon, 13 May 2002 17:18:19 -0700
X-MIMETrack: Serialize by Router on D04NM207/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 05/13/2002 08:18:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The Kernel level is: 2.4.9-31 for Red Hat Linux 7.2:

Has anyone had  trouble compiling the modules - especifically in sysinfo.c.
I was trying to build the kernel modules and the compiler found errors when
it got to sysinfo.c.
I re-installed my kernel source code and headers and started from scratch.
I still had the same problem (see output below).

I changed line 11 to "include <compiler.h>", replaced line 86 with
"return_string=system_utsname.version".
Everything worked after that.

I'm wondering if I should report this as a bug or whether I was the only
one w/ the problem.
The source pkg that installed was kernel-source-2.4.9-31.i386.rpm, and
kernel-headers-2.4.9-31.i386.rpm.

Output from 'make modules':
=========================

make[2]: Entering directory `/usr/src/linux-2.4.9-31/abi/sco'
ld -m elf_i386 -r -o abi-sco.o sysent.o misc.o ptrace.o secureware.o
ioctl.o termios.o tapeio.o vtkbd.o
make[2]: Leaving directory `/usr/src/linux-2.4.9-31/abi/sco'
make -C svr4 modules
make[2]: Entering directory `/usr/src/linux-2.4.9-31/abi/svr4'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.9-31/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -Wno-unused -pipe
-mpreferred-stack-boundary=2 -march=i386 -DMODULE -DMODVERSIONS -include
/usr/src/linux-2.4.9-31/include/linux/modversions.h   -c -o sysinfo.o
sysinfo.c
sysinfo.c:11:27: linux/compile.h: No such file or directory
sysinfo.c: In function `svr4_sysinfo':
sysinfo.c:86: `UTS_VERSION' undeclared (first use in this function)
sysinfo.c:86: (Each undeclared identifier is reported only once
sysinfo.c:86: for each function it appears in.)
make[2]: *** [sysinfo.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.9-31/abi/svr4'
make[1]: *** [_modsubdir_svr4] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.9-31/abi'
make: *** [_mod_abi] Error 2

Isabelle Poueriet

 Tivoli Storage Manager
 Software Engineer
 Office 9062/2123
 T/L: 8-321-2889

