Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271951AbRIIMiF>; Sun, 9 Sep 2001 08:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271953AbRIIMhz>; Sun, 9 Sep 2001 08:37:55 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:62920 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S271951AbRIIMhs>; Sun, 9 Sep 2001 08:37:48 -0400
Subject: [PATCHLET] NTFS compile fix for egcs.
To: torvalds@transmeta.com
Date: Sun, 9 Sep 2001 13:38:07 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15g3qh-0006Lh-00@draco.cus.cam.ac.uk>
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,

Please apply below one-liner required to compile ntfs with egcs-2.91.66.

Thanks,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

----- snip -----
--- linux/fs/ntfs/support.h.old	Sun Sep  9 13:27:27 2001
+++ linux/fs/ntfs/support.h	Sun Sep  9 13:34:27 2001
@@ -22,7 +22,7 @@
 #ifdef DEBUG
 void ntfs_debug(int mask, const char *fmt, ...);
 #else
-#define ntfs_debug(mask, fmt, ...)	do {} while (0)
+#define ntfs_debug(mask, fmt...)	do {} while (0)
 #endif
 
 #include <linux/slab.h>
