Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSAaOSh>; Thu, 31 Jan 2002 09:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291085AbSAaOS1>; Thu, 31 Jan 2002 09:18:27 -0500
Received: from mail.chs.ru ([194.154.71.136]:47879 "EHLO mail.unix.ru")
	by vger.kernel.org with ESMTP id <S291084AbSAaOSP>;
	Thu, 31 Jan 2002 09:18:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/partitions/ibm.c compile fixes
Date: Thu, 31 Jan 2002 17:18:13 +0300
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16WHjA-0005Hk-01@mail.unix.ru>
Cc: linux390@de.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

This patch against 2.4.18-pre7 fixes two obvious typos and make
fs/partitions/ibm.c to be compiled.
Also needed for both 2.5.3 and 2.5.2-dj7

--
		Best regards,
		Sergey S. Kostyliov <rathamahata@php4.ru>

diff -urN linux-2.4.18-pre7/fs/partitions/ibm.c linux/fs/partitions/ibm.c
--- linux-2.4.18-pre7/fs/partitions/ibm.c	Mon Oct  1 23:03:26 2001
+++ linux/fs/partitions/ibm.c	Thu Jan 31 07:21:28 2002
@@ -123,7 +123,7 @@
 					    GFP_KERNEL);
 	if ( geo == NULL )
 		return 0;
-	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
+	if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo))
 		return 0;
 	blocksize = hardsect_size[MAJOR(dev)][MINOR(dev)];
 	if ( blocksize <= 0 ) {
@@ -131,7 +131,7 @@
 	}
 	blocksize >>= 9;
 	
-	data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
+	data = read_dev_sector(bdev, info->label_block*blocksize, &sect);
 	if (!data)
 		return 0;
 
