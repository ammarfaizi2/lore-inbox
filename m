Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271686AbRICNDh>; Mon, 3 Sep 2001 09:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271690AbRICND1>; Mon, 3 Sep 2001 09:03:27 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:50953 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S271686AbRICNDQ>;
	Mon, 3 Sep 2001 09:03:16 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15251.29253.68409.428884@tango.paulus.ozlabs.org>
Date: Mon, 3 Sep 2001 22:06:29 +1000 (EST)
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix include/linux/mc146818rtc.h
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/mc146818rtc.h declares a spinlock but doesn't include
<linux/spinlock.h>.  This patch fixes that.

Paul.

diff -urN linux/include/linux/mc146818rtc.h linuxppc_2_4/include/linux/mc146818rtc.h
--- linux/include/linux/mc146818rtc.h	Mon Apr  2 02:21:50 2001
+++ linuxppc_2_4/include/linux/mc146818rtc.h	Thu Aug 16 07:49:52 2001
@@ -13,6 +13,7 @@
 
 #include <asm/io.h>
 #include <linux/rtc.h>			/* get the user-level API */
+#include <linux/spinlock.h>		/* spinlock_t */
 #include <asm/mc146818rtc.h>		/* register access macros */
 
 extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
