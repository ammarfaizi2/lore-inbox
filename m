Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287579AbSAEHfG>; Sat, 5 Jan 2002 02:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287585AbSAEHe4>; Sat, 5 Jan 2002 02:34:56 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:9232 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S287579AbSAEHek>; Sat, 5 Jan 2002 02:34:40 -0500
Subject: 2.5.2-pre8 -- compile error in ieee1394/highlevel.c, pcilynx.c
From: Miles Lane <miles@megapathdsl.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Evolution/1.1.0.99 (Preview Release)
Date: 04 Jan 2002 23:34:56 -0800
Message-Id: <1010216097.12947.189.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Most of these are gcc 3.0.x-specific warnings:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o pcilynx.o pcilynx.c
pcilynx.c: In function `get_phy_reg':
pcilynx.c:164: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
pcilynx.c:176: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
pcilynx.c: In function `set_phy_reg':
pcilynx.c:199: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
pcilynx.c:205: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
pcilynx.c: In function `sel_phy_reg_page':
pcilynx.c:225: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
pcilynx.c: In function `mem_open':
pcilynx.c:797: invalid operands to binary &
pcilynx.c: In function `mem_read':
pcilynx.c:1013: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
pcilynx.c: At top level:
pcilynx.c:775: warning: `aux_ops' defined but not used
make[3]: *** [pcilynx.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/ieee1394'

Other __FUNCTION__ usage warnings:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o ieee1394_transactions.o ieee1394_transactions.c
ieee1394_transactions.c: In function `hpsb_packet_success':
ieee1394_transactions.c:249: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
ieee1394_transactions.c:293: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=athlon     -c -o highlevel.o highlevel.c
In file included from highlevel.c:14:
ieee1394_types.h: In function `memcpy_le32':
ieee1394_types.h:107: warning: implicit declaration of function `memcpy'
highlevel.c: In function `hpsb_register_addrspace':
highlevel.c:90: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
highlevel.c: In function `hpsb_listen_channel':
highlevel.c:134: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future
highlevel.c: In function `hpsb_unlisten_channel':
highlevel.c:147: warning: concatenation of string literals with __FUNCTION__ is deprecated.  This feature will be removed in future



