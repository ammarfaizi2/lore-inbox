Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270495AbRIJLP4>; Mon, 10 Sep 2001 07:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270523AbRIJLPq>; Mon, 10 Sep 2001 07:15:46 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:60934 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S270495AbRIJLPe>; Mon, 10 Sep 2001 07:15:34 -0400
Date: Mon, 10 Sep 2001 12:14:37 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
X-X-Sender: <steve@sorbus.navaho>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [COMPILE FAILS] linux-2.4.10-pre7
Message-ID: <Pine.LNX.4.33.0109101152120.22591-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just tried compiling 2.4.10-pre7, and the build fails with the following
errors... having grepped the source-tree, it seems that
SCSI_IOCTL_FC_TARGET_ADDRESS and SCSI_IOCTL_FC_TDR aren't defined
anywhere:

gcc -D__KERNEL__ -I/usr/src/redhat/BUILD/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i586 -DMODULE   -c -o cpqfcTSinit.o cpqfcTSinit.c
ld -m elf_i386 -r -o sr_mod.o sr.o sr_ioctl.o sr_vendor.o
cpqfcTSinit.c: In function `cpqfcTS_ioctl':
cpqfcTSinit.c:662: `SCSI_IOCTL_FC_TARGET_ADDRESS' undeclared (first use in
this function)
cpqfcTSinit.c:662: (Each undeclared identifier is reported only once
cpqfcTSinit.c:662: for each function it appears in.)
cpqfcTSinit.c:680: `SCSI_IOCTL_FC_TDR' undeclared (first use in this
function)
make[2]: *** [cpqfcTSinit.o] Error 1
make[2]: Leaving directory `/usr/src/redhat/BUILD/linux/drivers/scsi'
make[1]: *** [_modsubdir_scsi] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/linux/drivers'
make: *** [_mod_drivers] Error 2


-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


