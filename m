Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbTB0R2p>; Thu, 27 Feb 2003 12:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbTB0R2p>; Thu, 27 Feb 2003 12:28:45 -0500
Received: from tao.natur.cuni.cz ([195.113.56.1]:61702 "EHLO tao.natur.cuni.cz")
	by vger.kernel.org with ESMTP id <S266161AbTB0R2o>;
	Thu, 27 Feb 2003 12:28:44 -0500
X-Obalka-From: mmokrejs@natur.cuni.cz
X-Obalka-To: <linux-kernel@vger.kernel.org>
Date: Thu, 27 Feb 2003 18:39:02 +0100 (CET)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Cannot compile 2.4.21-pre5/drivers/raw1394.c
Message-ID: <Pine.OSF.4.51.0302271835260.283763@tao.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I can't compile latest linus kernel on ASUS L3000C P4m laptop with
gcc-3.2.1:

$ make dep
$ make bzImage
$ make modules
[...]
make -C ieee1394 modules
make[2]: Entering directory `/usr/src/linux-2.4.21-pre5/drivers/ieee1394'
ld -m elf_i386 -e stext -r -o ieee1394.o ieee1394_core.o ieee1394_transactions.o hosts.o highlevel.o csr.o nodemgr.o dma.o
gcc -D__KERNEL__ -I/usr/src/linux-2.4.21-pre5/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS -include /usr/src/linux-2.4.21-pre5/include/linux/modversions.h  -nostdinc -iwithprefix include -DKBUILD_BASENAME=raw1394  -c -o raw1394.o raw1394.c
In file included from raw1394.c:50:
raw1394.h:167: field `tq' has incomplete type
raw1394.c: In function `__alloc_pending_request':
raw1394.c:110: warning: implicit declaration of function `HPSB_INIT_WORK'
raw1394.c:118: confused by earlier errors, bailing out
make[2]: *** [raw1394.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.21-pre5/drivers/ieee1394'

Please Cc: me in replies. Thanks.
-- 
Martin Mokrejs <mmokrejs@natur.cuni.cz>, <m.mokrejs@gsf.de>
PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany
tel.: +49-89-3187 3683 , fax: +49-89-3187 3585
