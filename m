Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbQLRIG6>; Mon, 18 Dec 2000 03:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129480AbQLRIGt>; Mon, 18 Dec 2000 03:06:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:42504 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129464AbQLRIGf>; Mon, 18 Dec 2000 03:06:35 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14909.48731.574210.724341@wire.cadcamlab.org>
Date: Mon, 18 Dec 2000 01:35:55 -0600 (CST)
To: nbreun@gmx.de, torvalds@transmeta.com
Cc: Mikael Djurfeldt <djurfeldt@nada.kth.se>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test13-pre3: Makefile problem in drivers/video
In-Reply-To: <E147oeY-0006H7-00@mdj.nada.kth.se>
	<20001218001135.Z3199@cadcamlab.org>
	<00121808022301.00937@nmb>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Norbert Breun]
> The problem is, there should be a directory "media" under
> /lib/modules/2.4.0-test12.old/kernel/drivers/ and this is missing in
> test13pre2 and test13pre3. The modules are not built.

Does this help?  I think it's right.

Peter

diff -urk.orig 2.4.0test13pre3/drivers/media/Makefile
--- 2.4.0test13pre3/drivers/media/Makefile.orig	Sat Dec 16 06:18:16 2000
+++ 2.4.0test13pre3/drivers/media/Makefile	Mon Dec 18 01:32:34 2000
@@ -10,6 +10,7 @@
 #
 
 subdir-y     := video radio
+subdir-m     := video radio
 
 O_TARGET     := media.o
 obj-y        := $(join $(subdir-y),$(subdir-y:%=/%.o))
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
