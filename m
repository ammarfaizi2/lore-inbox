Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUFNAvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUFNAvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbUFNAuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:50:37 -0400
Received: from holomorphy.com ([207.189.100.168]:33181 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261582AbUFNAs5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:48:57 -0400
Date: Sun, 13 Jun 2004 17:48:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [12/12] fix thread_info.h ignoring __HAVE_THREAD_FUNCTIONS
Message-ID: <20040614004855.GA1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com> <20040614004147.GW1444@holomorphy.com> <20040614004354.GX1444@holomorphy.com> <20040614004516.GY1444@holomorphy.com> <20040614004701.GZ1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004701.GZ1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Check __HAVE_THREAD_FUNCTIONS in include/linux/thread_info.h (m68k)
This fixes the build on m68k; its thread_info functions need to be used.

Index: linux-2.5/include/linux/thread_info.h
===================================================================
--- linux-2.5.orig/include/linux/thread_info.h	2004-06-13 11:57:45.000000000 -0700
+++ linux-2.5/include/linux/thread_info.h	2004-06-13 12:08:57.000000000 -0700
@@ -21,6 +21,7 @@
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
+#ifndef __HAVE_THREAD_FUNCTIONS
 
 /*
  * flag set/clear/test wrappers
@@ -87,6 +88,7 @@
 	clear_thread_flag(TIF_NEED_RESCHED);
 }
 
-#endif
+#endif	/* __HAVE_THREAD_FUNCTIONS */
+#endif	/* __KERNEL__ */
 
 #endif /* _LINUX_THREAD_INFO_H */
