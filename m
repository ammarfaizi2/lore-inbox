Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318470AbSIBUun>; Mon, 2 Sep 2002 16:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318473AbSIBUum>; Mon, 2 Sep 2002 16:50:42 -0400
Received: from nycsmtp3fa.rdc-nyc.rr.com ([24.29.99.79]:12559 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S318470AbSIBUum>;
	Mon, 2 Sep 2002 16:50:42 -0400
Date: Mon, 2 Sep 2002 16:47:07 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.33 : drivers/media/video/cpia.h DBG marco
Message-ID: <Pine.LNX.4.44.0209021643310.908-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  The following patch performs the same as Alessandro's fix to the LOG 
macro, but to DBG. Please review.

Regards,
Frank

--- drivers/media/video/cpia.h.old	Sat Nov 10 23:35:55 2001
+++ drivers/media/video/cpia.h	Mon Sep  2 16:42:07 2002
@@ -383,7 +383,7 @@
 
 #ifdef _CPIA_DEBUG_
 #define ADBG(lineno,fmt,args...) printk(fmt, jiffies, lineno, ##args)
-#define DBG(fmt,args...) ADBG((__LINE__),KERN_DEBUG __FILE__"(%ld):"__FUNCTION__"(%d):"fmt,##args)
+#define DBG(fmt,args...) ADBG((__LINE__),KERN_DEBUG __FILE__"(%ld):%s(%d):"fmt,__FUNCTION__, ##args)
 #else
 #define DBG(fmn,args...) do {} while(0)
 #endif

