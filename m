Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287550AbSAEGis>; Sat, 5 Jan 2002 01:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSAEGii>; Sat, 5 Jan 2002 01:38:38 -0500
Received: from nycsmtp1fb.rdc-nyc.rr.com ([24.29.99.76]:5390 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S287550AbSAEGia>;
	Sat, 5 Jan 2002 01:38:30 -0500
Date: Sat, 5 Jan 2002 01:26:43 -0500 (EST)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: <fdavis@localhost.localdomain>
To: <linux-kernel@vger.kernel.org>
cc: <fdavis@si.rr.com>
Subject: [PATCH] 2.5.2-pre8: fs/ext3
Message-ID: <Pine.LNX.4.33.0201050122530.10347-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch appears to fix the recent compile error, although it 
might not be correct.
Regards,
Frank

--- fs/ext3/super.c.old	Sat Jan  5 00:26:34 2002
+++ fs/ext3/super.c	Sat Jan  5 01:20:01 2002
@@ -56,10 +56,10 @@
 
 static void make_rdonly(kdev_t dev, int *no_write)
 {
-	if (dev) {
+	if (dev.value) {
 		printk(KERN_WARNING "Turning device %s read-only\n", 
 		       bdevname(dev));
-		*no_write = 0xdead0000 + dev;
+		*no_write = 0xdead0000 + dev.value;
 	}
 }
 


