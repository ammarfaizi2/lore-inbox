Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBGS5x>; Wed, 7 Feb 2001 13:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130004AbRBGS5o>; Wed, 7 Feb 2001 13:57:44 -0500
Received: from [194.73.73.176] ([194.73.73.176]:40619 "EHLO protactinium")
	by vger.kernel.org with ESMTP id <S129053AbRBGS5d>;
	Wed, 7 Feb 2001 13:57:33 -0500
Date: Wed, 7 Feb 2001 18:33:01 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon.local>
To: Alan Cox <alan@redhat.com>
Subject: [PATCH] nvram driver 2.88mb floppy fix.
Message-ID: <Pine.LNX.4.31.0102071831450.16839-100000@athlon.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alan,
 Seems that 2.88mb drives can be type 5 or type 6
(I found a Thinkpad with a type 6)

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/char/nvram.c linux-dj/drivers/char/nvram.c
--- linux/drivers/char/nvram.c	Thu Jan  4 20:50:17 2001
+++ linux-dj/drivers/char/nvram.c	Sun Feb  4 20:36:45 2001
@@ -481,7 +481,8 @@
 #ifdef CONFIG_PROC_FS

 static char *floppy_types[] = {
-	"none", "5.25'' 360k", "5.25'' 1.2M", "3.5'' 720k", "3.5'' 1.44M", "3.5'' 2.88M"
+	"none", "5.25'' 360k", "5.25'' 1.2M", "3.5'' 720k", "3.5'' 1.44M",
+	"3.5'' 2.88M", "3.5'' 2.88M"
 };

 static char *gfx_types[] = {


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
