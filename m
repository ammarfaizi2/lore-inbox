Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275270AbRJPJ6Z>; Tue, 16 Oct 2001 05:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275693AbRJPJ6Q>; Tue, 16 Oct 2001 05:58:16 -0400
Received: from post.it.helsinki.fi ([128.214.205.24]:36871 "EHLO
	post.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S275270AbRJPJ57>; Tue, 16 Oct 2001 05:57:59 -0400
To: linux-kernel@vger.kernel.org
Subject: SCSI compile error
Message-ID: <1003226310.3bcc04c6b2a12@www3.helsinki.fi>
Date: Tue, 16 Oct 2001 12:58:30 +0300 (EEST)
From: Henrikki Almusa <henrikki.almusa@helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
X-Originating-IP: 128.214.191.211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was compiling kernel 2.4.12 and encountered a following problem. I couldn't 
found anything from list archives about this. I tried to fix this by using the 
same source file from 2.4.10, but that gives same error except the line number 
is one smaller in all lines.

Output from compiling:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.12/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include 
/usr/src/linux-2.4.12/include/linux/modversions.h   -c -o cpqfcTSinit.o 
cpqfcTSinit.c
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:663: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in this
function)
cpqfcTSinit.c:663: (Each undeclared identifier is reported only once
cpqfcTSinit.c:663: for each function it appears in.)
cpqfcTSinit.c:681: `SCSI_IOCTL_FC_TDR' undeclared (first use in this function)
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.12/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.12/drivers'
make: *** [_mod_drivers] Error 2
[root@my_comp linux-2.4.12]#

Ps. i'm not on the kernel-list so put my email in cc atleast.

Henrikki Almusa
