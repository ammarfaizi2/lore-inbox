Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274544AbRJOFzv>; Mon, 15 Oct 2001 01:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274667AbRJOFzl>; Mon, 15 Oct 2001 01:55:41 -0400
Received: from h183n3fls22o974.telia.com ([213.64.105.183]:59060 "EHLO
	milou.dyndns.org") by vger.kernel.org with ESMTP id <S274544AbRJOFz0>;
	Mon, 15 Oct 2001 01:55:26 -0400
Message-Id: <200110150555.f9F5tt725407@milou.dyndns.org>
X-Mailer: exmh version 2.5_20010923 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: IEEE1284_PH_DIR_UNKNOWN undeclared in 2.4.12
From: Anders Eriksson <aer-list@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Oct 2001 07:55:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just downloaded 2.4.12, and the compile barfs as follows, any 
suggestions? The thing is nowhere in the source.

/Anders


gcc -D__KERNEL__ -I/home/ander/tmp/linux-milou-12/include -Wall 
-Wstrict-prototy
pes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing 
-fno-common -pi
pe -mpreferred-stack-boundary=2 -march=i686 -DMODULE -DMODVERSIONS 
-include /hom
e/ander/tmp/linux-milou-12/include/linux/modversions.h   -c -o 
ieee1284_ops.o ie
ee1284_ops.c
ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use 
in this func
tion)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use 
in this func
tion)
make[2]: *** [ieee1284_ops.o] Error 1
make[2]: Leaving directory `/home/ander/tmp/linux-milou-12/drivers/par
port'


$ find . -type f | xargs grep IEEE1284_PH_DIR_UNKNOW
N
./drivers/parport/ieee1284_ops.c:               port->ieee1284.phase 
= IEEE1284_PH_DIR_UNK
NOWN;
./drivers/parport/ieee1284_ops.c:               port->ieee1284.phase 
= IEEE1284_PH_DIR_UNK
NOWN;


