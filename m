Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267258AbUGNAUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267258AbUGNAUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267263AbUGNAUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:20:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:60404 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267258AbUGNAUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:20:37 -0400
Date: Wed, 14 Jul 2004 02:20:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] small drivers/ide/legacy/Makefile cleanup
Message-ID: <20040714002034.GB7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- kill obsolete CONFIG_BLK_DEV_HD98 entry
- include hd.o only if CONFIG_BLK_DEV_HD_ONLY=y


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full-gcc3.4/drivers/ide/legacy/Makefile.old	2004-07-14 02:08:50.000000000 +0200
+++ linux-2.6.7-mm7-full-gcc3.4/drivers/ide/legacy/Makefile	2004-07-14 02:09:16.000000000 +0200
@@ -9,7 +9,6 @@
 obj-$(CONFIG_BLK_DEV_IDECS)		+= ide-cs.o
 
 # Last of all
-obj-$(CONFIG_BLK_DEV_HD)		+= hd.o
-obj-$(CONFIG_BLK_DEV_HD98)		+= hd98.o
+obj-$(CONFIG_BLK_DEV_HD_ONLY)		+= hd.o
 
 EXTRA_CFLAGS	:= -Idrivers/ide

