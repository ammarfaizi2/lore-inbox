Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSAAAbK>; Mon, 31 Dec 2001 19:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287701AbSAAAbA>; Mon, 31 Dec 2001 19:31:00 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:56071 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287700AbSAAAa4>; Mon, 31 Dec 2001 19:30:56 -0500
Subject: 2.4.18-pre1 -- fs/partitions/ibm.c doesn't compile.
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Holger Smolinski <Holger.Smolinski@de.ibm.com>,
        Volker Sameske <sameske@de.ibm.com>, Linux390@de.ibm.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2001.12.29.08.57 (Preview Release)
Date: 31 Dec 2001 16:31:38 -0800
Message-Id: <1009845099.1407.623.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gcc -D__KERNEL__ -I/usr/src/usb-2.4/include -Wall -Wstrict-prototypes
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common
-pipe -mpreferred-stack-boundary=2 -march=athlon       -DEXPORT_SYMTAB
-c ibm.c
ibm.c:24:24: asm/ebcdic.h: No such file or directory
ibm.c:26:22: asm/dasd.h: No such file or directory
ibm.c:30:22: asm/vtoc.h: No such file or directory
ibm.c:78: parse error before `*'
ibm.c:78: warning: function declaration isn't a prototype
ibm.c: In function `cchh2blk':
ibm.c:79: `ptr' undeclared (first use in this function)
ibm.c:79: (Each undeclared identifier is reported only once
ibm.c:79: for each function it appears in.)
ibm.c:79: `geo' undeclared (first use in this function)
ibm.c:81: warning: control reaches end of non-void function
ibm.c: At top level:
ibm.c:89: parse error before `*'
ibm.c:89: warning: function declaration isn't a prototype
ibm.c: In function `cchhb2blk':
ibm.c:90: `ptr' undeclared (first use in this function)
ibm.c:90: `geo' undeclared (first use in this function)
ibm.c:93: warning: control reaches end of non-void function
ibm.c: In function `ibm_partition':
ibm.c:108: `format1_label_t' undeclared (first use in this function)
ibm.c:108: parse error before `f1'
ibm.c:109: `volume_label_t' undeclared (first use in this function)
ibm.c:110: `dasd_information_t' undeclared (first use in this function)
ibm.c:110: `info' undeclared (first use in this function)
ibm.c:110: warning: statement with no effect
ibm.c:111: parse error before `dev'
ibm.c:120: `BIODASDINFO' undeclared (first use in this function)
ibm.c:126: parse error before `;'
ibm.c:128: `dev' undeclared (first use in this function)
ibm.c:134: `inode' undeclared (first use in this function)
ibm.c:144: `vlabel' undeclared (first use in this function)
ibm.c:146: warning: implicit declaration of function `EBCASC'
ibm.c:180: `f1' undeclared (first use in this function)
ibm.c:184: `_ascebc' undeclared (first use in this function)
make[3]: *** [ibm.o] Error 1
make[3]: Leaving directory `/usr/src/2.4.18-pre1/fs/partitions'

