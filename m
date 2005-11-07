Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965326AbVKGUEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965326AbVKGUEo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965324AbVKGUEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:04:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27410 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965319AbVKGUDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:03:46 -0500
Date: Mon, 7 Nov 2005 21:03:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/cpufreq/cpufreq.c: fix a compile warning with SMP=n
Message-ID: <20051107200345.GJ3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile warning with CONFIG_SMP=n:

<--  snip  -->

...
  CC      drivers/cpufreq/cpufreq.o
drivers/cpufreq/cpufreq.c: In function 'cpufreq_remove_dev':
drivers/cpufreq/cpufreq.c:696: warning: unused variable 'cpu_sys_dev'
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-mm1-full/drivers/cpufreq/cpufreq.c.old	2005-11-07 19:27:33.000000000 +0100
+++ linux-2.6.14-mm1-full/drivers/cpufreq/cpufreq.c	2005-11-07 19:27:50.000000000 +0100
@@ -693,8 +693,8 @@
 	unsigned int cpu = sys_dev->id;
 	unsigned long flags;
 	struct cpufreq_policy *data;
-	struct sys_device *cpu_sys_dev;
 #ifdef CONFIG_SMP
+	struct sys_device *cpu_sys_dev;
 	unsigned int j;
 #endif
 

