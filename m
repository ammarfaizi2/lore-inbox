Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbVEFV3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVEFV3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVEFV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:29:40 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:54533 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261271AbVEFV17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:27:59 -0400
Date: Fri, 6 May 2005 23:27:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: pavel@suse.cz
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/power/swsusp.c: make a variable static
Message-ID: <20050506212734.GQ3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global variable static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c.old	2005-05-03 07:48:39.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/power/swsusp.c	2005-05-03 07:48:49.000000000 +0200
@@ -81,7 +81,7 @@
 extern char resume_file[];
 
 /* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
+static unsigned int nr_copy_pages __nosavedata = 0;
 
 /* Suspend pagedir is allocated before final copy, therefore it
    must be freed after resume

