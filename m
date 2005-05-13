Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVEMArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVEMArS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 20:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVEMArR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 20:47:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35595 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262200AbVEMArH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:07 -0400
Date: Fri, 13 May 2005 02:47:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: pavel@suse.cz, linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/swsusp.c: make a variable static
Message-ID: <20050513004704.GO3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

This patch was already ACK'ed by Pavel Machek.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 May 2005

--- linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c.old	2005-05-03 07:48:39.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c	2005-05-03 07:48:49.000000000 +0200
@@ -81,7 +81,7 @@
 extern char resume_file[];
 
 /* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
+static unsigned int nr_copy_pages __nosavedata = 0;
 
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume

