Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269897AbSISERU>; Thu, 19 Sep 2002 00:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269908AbSISERU>; Thu, 19 Sep 2002 00:17:20 -0400
Received: from dyn12.31.bnt.com ([208.251.212.31]:24960 "EHLO yavin")
	by vger.kernel.org with ESMTP id <S269897AbSISERT>;
	Thu, 19 Sep 2002 00:17:19 -0400
Subject: Compile problem w/ 2.4.20-pre7-ac2
From: Wes Kurdziolek <wkurdzio@cs.vt.edu>
To: linux-kernel@vger.kernel.org
Cc: alan@lxorguk.ukuu.org.uk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 19 Sep 2002 00:22:21 -0400
Message-Id: <1032409341.6480.2.camel@yavin>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found a compile problem w/ 2.4.20-pre7-ac2 when attempting to compile
the PIIX driver:

make[4]: Entering directory
`/usr/src/linux-2.4.20-pre7-ac2/drivers/ide/pci'
gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-pre7-ac2/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-I../ -nostdinc -iwithprefix include -DKBUILD_BASENAME=piix  -c -o
piix.o piix.c
piix.c: In function `init_chipset_piix':
piix.c:533: init_chipset_piix causes a section type conflict
piix.c: In function `piix_init_one':
piix.c:677: piix_init_one causes a section type conflict
piix.c: At top level:
piix.c:696: warning: `piix_remove_one' defined but not used
make[4]: *** [piix.o] Error 1
make[4]: Leaving directory
`/usr/src/linux-2.4.20-pre7-ac2/drivers/ide/pci'
make[3]: *** [first_rule] Error 2
make[3]: Leaving directory
`/usr/src/linux-2.4.20-pre7-ac2/drivers/ide/pci'
make[2]: *** [_subdir_pci] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20-pre7-ac2/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20-pre7-ac2/drivers'
make: *** [_dir_drivers] Error 2
yavin:/usr/src/linux-2.4.20-pre7-ac2# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011002 (Debian prerelease)
yavin:/usr/src/linux-2.4.20-pre7-ac2# ld -v
GNU ld version 2.13.90.0.4 20020814 Debian GNU/Linux
yavin:/usr/src/linux-2.4.20-pre7-ac2#
