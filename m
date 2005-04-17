Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVDQUWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVDQUWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVDQUUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:20:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:19731 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261485AbVDQUPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:15:41 -0400
Date: Sun, 17 Apr 2005 22:15:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: mpm@selenic.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/char/random.c: #if 0 randomize_range
Message-ID: <20050417201537.GO3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch #if 0's the unused global function randomize_range.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/random.c  |    2 ++
 include/linux/random.h |    1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.12-rc2-mm3-full/include/linux/random.h.old	2005-04-17 18:17:17.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/include/linux/random.h	2005-04-17 18:17:23.000000000 +0200
@@ -65,7 +65,6 @@
 #endif
 
 unsigned int get_random_int(void);
-unsigned long randomize_range(unsigned long start, unsigned long end, unsigned long len);
 
 #endif /* __KERNEL___ */
 
--- linux-2.6.12-rc2-mm3-full/drivers/char/random.c.old	2005-04-17 18:17:30.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/random.c	2005-04-17 18:18:12.000000000 +0200
@@ -1618,6 +1618,7 @@
  * a <range> with size "len" starting at the return value is inside in the
  * area defined by [start, end], but is otherwise randomized.
  */
+#if 0
 unsigned long
 randomize_range(unsigned long start, unsigned long end, unsigned long len)
 {
@@ -1627,3 +1628,4 @@
 		return 0;
 	return PAGE_ALIGN(get_random_int() % range + start);
 }
+#endif  /*  0  */

