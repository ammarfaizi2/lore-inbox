Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVBMIY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVBMIY3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 03:24:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVBMIY3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 03:24:29 -0500
Received: from web14525.mail.yahoo.com ([216.136.224.54]:41110 "HELO
	web14525.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261254AbVBMIYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 03:24:17 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=o6K/mmrDjbLmjgp2e2g7yh7YCJylTCiKVldUOTgWl98ecfQIDncC6ptemoJx/P1tL9gNPZYH7wxG6YUlJYy/MaQnqA2FDx9QpM9Z0KFKQf90zNuqRoPmVJpuDWHPN+tpZ0eiK/JDfUSYLZEuOBT8mn1+jWzXa2CzeDMvd8WiGbY=  ;
Message-ID: <20050213082413.65917.qmail@web14525.mail.yahoo.com>
Date: Sun, 13 Feb 2005 00:24:13 -0800 (PST)
From: Daniel Dickman <didickman@yahoo.com>
To: linux-m32r@ml.linux-m32r.org, lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the m32r architecture, is there a reason not to use the generic bug.h
definition?

Signed-off-by: Daniel Dickman <didickman@yahoo.com>

--- linux-2.6.11-rc4/include/asm-m32r/bug.h     2004-12-24 16:34:01.000000000
-0500
+++ linux/include/asm-m32r/bug.h        2005-02-13 03:39:39.775236000 -0500
@@ -1,22 +1,4 @@
 #ifndef _M32R_BUG_H
 #define _M32R_BUG_H
-
-#define BUG()  do { \
-       printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
-} while (0)
-
-#define PAGE_BUG(page) do { BUG(); } while (0)
-
-#define BUG_ON(condition) \
-       do { if (unlikely((condition)!=0)) BUG(); } while(0)
-
-#define WARN_ON(condition) do { \
-       if (unlikely((condition)!=0)) { \
-               printk("Badness in %s at %s:%d\n", __FUNCTION__, \
-               __FILE__, __LINE__); \
-               dump_stack(); \
-       } \
-} while (0)
-
-#endif /* _M32R_BUG_H */
-
+#include <asm-generic/bug.h>
+#endif

