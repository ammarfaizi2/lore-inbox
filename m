Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268017AbRIHIuq>; Sat, 8 Sep 2001 04:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267043AbRIHIuf>; Sat, 8 Sep 2001 04:50:35 -0400
Received: from HINux.hin.no ([158.39.26.220]:49585 "EHLO hinux.hin.no")
	by vger.kernel.org with ESMTP id <S266827AbRIHIuS> convert rfc822-to-8bit;
	Sat, 8 Sep 2001 04:50:18 -0400
Subject: [PATCH] 2.4.10-pre5 rd.c
From: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<zole@jblinux.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12 (Preview Release)
Date: 08 Sep 2001 10:55:30 -0100
Message-Id: <999950131.8667.1.camel@zole.jblinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this fix might already have been submitted, but as I'm not currently
subscribed to the list, I post it here just in case. :-)

Best regards,
Ole André
---

--- linux/drivers/block/rd.c-orig	Sat Sep  8 10:50:35 2001
+++ linux/drivers/block/rd.c	Sat Sep  8 10:50:41 2001
@@ -259,7 +259,7 @@
 			/* special: we want to release the ramdisk memory,
 			   it's not like with the other blockdevices where
 			   this ioctl only flushes away the buffer cache. */
-			if ((atomic_read(rd_bdev[minor]->bd_openers) > 2))
+			if ((atomic_read(&rd_bdev[minor]->bd_openers) > 2))
 				return -EBUSY;
 			destroy_buffers(inode->i_rdev);
 			rd_blocksizes[minor] = 0;

