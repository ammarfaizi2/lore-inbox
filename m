Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVEUVEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVEUVEG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 17:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVEUVEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 17:04:05 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:897 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261603AbVEUVEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 17:04:01 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200505212103.j4LL3u3G017183@wildsau.enemy.org>
Subject: [PATH] binutils-2.16.90.0.3 kernel-2.4.30 apm.c
To: linux-kernel@vger.kernel.org
Date: Sat, 21 May 2005 23:03:56 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sorry, I didn't notice this file also affected (see previous email)
probably there are other places around too.... I probably should
recompile with all kernel-options enabled.

anyway ...


--- linux-2.4.30/arch/i386/kernel/apm.c Mon Aug 25 13:44:39 2003
+++ linux-2.4.30.rescue/arch/i386/kernel/apm.c  Sat May 21 22:54:50 2005
@@ -15,6 +15,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  * General Public License for more details.
  *
+ * Sat May 21 22:54:03 MEST 2005 herp - Herbert Rosmanith
+ *    make it compile with as-2.16 again
  * October 1995, Rik Faith (faith@cs.unc.edu):
  *    Minor enhancements and updates (to the patch set) for 1.3.x
  *    Documentation
@@ -327,7 +329,7 @@
  * Save a segment register away
  */
 #define savesegment(seg, where) \
-               __asm__ __volatile__("movl %%" #seg ",%0" : "=m" (where))
+               __asm__ __volatile__("movw %%" #seg ",%0" : "=m" (where))
 
 /*
  * Maximum number of events stored

