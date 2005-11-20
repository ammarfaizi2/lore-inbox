Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVKTXds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVKTXds (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 18:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbVKTXds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 18:33:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49168 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750907AbVKTXds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 18:33:48 -0500
Date: Mon, 21 Nov 2005 00:33:47 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/sched.h: no need to guard the normalize_rt_tasks() prototype
Message-ID: <20051120233347.GP16060@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to guard the normalize_rt_tasks() prototype with an
#ifdef CONFIG_MAGIC_SYSRQ.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc1-mm2-full/include/linux/sched.h.old	2005-11-20 20:44:28.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/linux/sched.h	2005-11-20 20:44:35.000000000 +0100
@@ -1423,12 +1423,8 @@
 extern long sched_setaffinity(pid_t pid, cpumask_t new_mask);
 extern long sched_getaffinity(pid_t pid, cpumask_t *mask);
 
-#ifdef CONFIG_MAGIC_SYSRQ
-
 extern void normalize_rt_tasks(void);
 
-#endif
-
 #ifdef CONFIG_PM
 /*
  * Check if a process has been frozen

