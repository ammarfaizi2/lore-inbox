Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292146AbSBTSRk>; Wed, 20 Feb 2002 13:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292157AbSBTSRZ>; Wed, 20 Feb 2002 13:17:25 -0500
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:61448 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S292146AbSBTSRR>; Wed, 20 Feb 2002 13:17:17 -0500
Subject: 2.5.5 -- filesystems.c:30: In function `sys_nfsservctl':
	dereferencing pointer to incomplete type
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 20 Feb 2002 10:13:21 -0800
Message-Id: <1014228802.6910.29.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been reported by someone else, but the .config 
information was not included in the report.  Hopefully, 
this will help.

Here you go:

CONFIG_QUOTA=y
CONFIG_AUTOFS4_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon   
-DKBUILD_BASENAME=filesystems  -DEXPORT_SYMTAB -c filesystems.c
filesystems.c: In function `sys_nfsservctl':
filesystems.c:30: dereferencing pointer to incomplete type
filesystems.c:30: dereferencing pointer to incomplete type
filesystems.c:30: warning: value computed is not used
filesystems.c:32: dereferencing pointer to incomplete type
filesystems.c:33: dereferencing pointer to incomplete type
filesystems.c:33: dereferencing pointer to incomplete type
filesystems.c:33: warning: value computed is not used
make[2]: *** [filesystems.o] Error 1
make[2]: Leaving directory `/usr/src/linux/fs'


