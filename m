Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946410AbWKACQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946410AbWKACQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 21:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946427AbWKACQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 21:16:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:40624 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946410AbWKACQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 21:16:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=kYsQGLk0GK9PKiuBn29GV2wZxCiNT7rA4mbzKi6CdiIPg4X52rUbXnolIBSlp+m8aosdJNK2q1gyAnOAorz6glEtHx3fNIHqGEG993ZS3SUKXFpXYwORp6WyYZBsGhwiXy1F3AH8aokvnLmA4Ow8AXC60qyEntutJKfr74bAVw4=
Date: Wed, 1 Nov 2006 05:14:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/isdn/*: trivial vsnprintf() conversion
Message-ID: <20061101021440.GD5014@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/isdn/hardware/eicon/divasmain.c |    2 +-
 drivers/isdn/hisax/hisax_isac.c         |    2 +-
 drivers/isdn/hisax/st5481_d.c           |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -185,7 +185,7 @@ void diva_log_info(unsigned char *format
 	unsigned char line[160];
 
 	va_start(args, format);
-	vsprintf(line, format, args);
+	vsnprintf(line, sizeof(line), format, args);
 	va_end(args);
 
 	printk(KERN_INFO "%s: %s\n", DRIVERLNAME, line);
--- a/drivers/isdn/hisax/hisax_isac.c
+++ b/drivers/isdn/hisax/hisax_isac.c
@@ -433,7 +433,7 @@ static void l1m_debug(struct FsmInst *fi
 	char buf[256];
 	
 	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
+	vsnprintf(buf, sizeof(buf), fmt, args);
 	DBG(DBG_L1M, "%s", buf);
 	va_end(args);
 }
--- a/drivers/isdn/hisax/st5481_d.c
+++ b/drivers/isdn/hisax/st5481_d.c
@@ -173,7 +173,7 @@ static void l1m_debug(struct FsmInst *fi
 	char buf[256];
 	
 	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
+	vsnprintf(buf, sizeof(buf), fmt, args);
 	DBG(8, "%s", buf);
 	va_end(args);
 }
@@ -275,7 +275,7 @@ static void dout_debug(struct FsmInst *f
 	char buf[256];
 	
 	va_start(args, fmt);
-	vsprintf(buf, fmt, args);
+	vsnprintf(buf, sizeof(buf), fmt, args);
 	DBG(0x2, "%s", buf);
 	va_end(args);
 }

