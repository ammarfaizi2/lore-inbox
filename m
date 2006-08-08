Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbWHHTyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWHHTyo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbWHHTyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:54:44 -0400
Received: from ipn26-148.piekary.net ([83.238.26.148]:53010 "EHLO
	ipn26-148.piekary.net") by vger.kernel.org with ESMTP
	id S1030264AbWHHTyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:54:44 -0400
Date: Tue, 8 Aug 2006 21:54:41 +0200
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org
Subject: [PATCH] fbdev: include backlight.h only when __KERNEL__ is defined
Message-ID: <20060808195441.GA12060@spock.one.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux/backlight.h pulls in header files (eg. ioport.h) that break compilation
of userspace programs. To solve the problem, only include backlight.h in
fb.h if compiling kernel stuff.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 4ad0673..2f335e9 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1,7 +1,6 @@
 #ifndef _LINUX_FB_H
 #define _LINUX_FB_H
 
-#include <linux/backlight.h>
 #include <asm/types.h>
 
 /* Definitions of frame buffers						*/
@@ -381,6 +380,7 @@ #include <linux/device.h>
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
 #include <linux/list.h>
+#include <linux/backlight.h>
 #include <asm/io.h>
 
 struct vm_area_struct;

