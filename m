Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264507AbSIREBo>; Wed, 18 Sep 2002 00:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264534AbSIREBo>; Wed, 18 Sep 2002 00:01:44 -0400
Received: from postoffice2.mail.cornell.edu ([132.236.56.10]:10951 "EHLO
	postoffice2.mail.cornell.edu") by vger.kernel.org with ESMTP
	id <S264507AbSIREBn>; Wed, 18 Sep 2002 00:01:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: xconfig doesn't work, 2.4.20-pre7
Date: Sun, 15 Sep 2002 08:16:16 -0400
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209150816.16473.ivg2@cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After make clean and make mrproper:

================================
[root@cobra linux-2.4]# make xconfig
rm -f include/asm
( cd include ; ln -sf asm-i386 asm)
make -C scripts kconfig.tk
make[1]: Entering directory `/usr/src/linux-2.4.20-pre7/scripts'
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkparse.o 
tkparse.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkcond.o tkcond.c
gcc -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -c -o tkgen.o tkgen.c
gcc -o tkparse tkparse.o tkcond.o tkgen.o
cat header.tk >> ./kconfig.tk
./tkparse < ../arch/i386/config.in >> kconfig.tk
drivers/video/Config.in: 216: can't handle dep_bool/dep_mbool/dep_tristate 
condition
make[1]: *** [kconfig.tk] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre7/scripts'
make: *** [xconfig] Error 2
[root@cobra linux-2.4]# 

