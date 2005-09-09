Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbVIIT0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbVIIT0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVIIT0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:26:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:32701 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030304AbVIIT0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:26:02 -0400
Date: Fri, 9 Sep 2005 20:26:01 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, bcollins@debian.org
Subject: [PATCH] trivial __user cleanup (video1394)
Message-ID: <20050909192601.GW9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/ieee1394/video1394.c current/drivers/ieee1394/video1394.c
--- RC13-git8-base/drivers/ieee1394/video1394.c	2005-08-28 23:09:41.000000000 -0400
+++ current/drivers/ieee1394/video1394.c	2005-09-08 23:53:33.000000000 -0400
@@ -883,7 +883,7 @@
 			      v.channel);
 		}
 
-		if (copy_to_user((void *)arg, &v, sizeof(v))) {
+		if (copy_to_user(argp, &v, sizeof(v))) {
 			/* FIXME : free allocated dma resources */
 			return -EFAULT;
 		}
