Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSLOK27>; Sun, 15 Dec 2002 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbSLOK27>; Sun, 15 Dec 2002 05:28:59 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:36921 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266319AbSLOK26>; Sun, 15 Dec 2002 05:28:58 -0500
Message-ID: <3DFC5AB2.BD4B8219@cinet.co.jp>
Date: Sun, 15 Dec 2002 19:34:26 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.50-ac1-pc98smp i686)
X-Accept-Language: ja
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 addtional for 2.5.50-ac1 (1/21)
References: <3DFC50E9.656B96D0@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------E39B80D2C45F12FC722251A2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E39B80D2C45F12FC722251A2
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

NEC PC-9800 subarchitecture support patch for 2.5.50-ac1(1/21)
This is updates for drivers/block/floppy98.c.
Synchronized with floppy.c in 2.5.50.

diffstat:
 drivers/block/floppy98.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


Regards,
Osamu Tomita
--------------E39B80D2C45F12FC722251A2
Content-Type: text/plain; charset=iso-2022-jp;
 name="floppy98-update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="floppy98-update.patch"

--- linux-2.5.47-ac5/drivers/block/floppy98.c	Mon Nov 11 12:28:05 2002
+++ linux-2.5.48/drivers/block/floppy98.c	Tue Nov 19 10:15:36 2002
@@ -167,6 +167,7 @@
 #include <linux/kernel.h>
 #include <linux/timer.h>
 #include <linux/workqueue.h>
+#include <linux/version.h>
 #define FDPATCHES
 #include <linux/fdreg.h>
 
@@ -3354,7 +3355,7 @@
 static int invalidate_drive(struct block_device *bdev)
 {
 	/* invalidate the buffer track to force a reread */
-	set_bit(DRIVE(to_kdev_t(bdev->bd_dev)), &fake_change);
+	set_bit((int)bdev->bd_disk->private_data, &fake_change);
 	process_fd_request();
 	check_disk_change(bdev);
 	return 0;

--------------E39B80D2C45F12FC722251A2--

