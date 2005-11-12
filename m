Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVKLDxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVKLDxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 22:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKLDxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 22:53:51 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:14020 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751208AbVKLDxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 22:53:50 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Silence cpufreq warning for UP
Date: Sat, 12 Nov 2005 14:53:29 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <47pan1982sc5ait2m75ejrui6ur151saqr@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

From: Grant Coady <gcoady@gmail.com>

Fix this warning for UP system:
drivers/cpufreq/cpufreq.c: In function `cpufreq_remove_dev':
drivers/cpufreq/cpufreq.c:696: warning: unused variable `cpu_sys_dev'

Signed-off-by: Grant Coady <gcoady@gmail.com>

---
 cpufreq.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15-rc1a/drivers/cpufreq/cpufreq.c~	2005-11-12 15:16:34.000000000 +1100
+++ linux-2.6.15-rc1a/drivers/cpufreq/cpufreq.c	2005-11-12 16:02:06.000000000 +1100
@@ -693,8 +693,8 @@
 	unsigned int cpu = sys_dev->id;
 	unsigned long flags;
 	struct cpufreq_policy *data;
-	struct sys_device *cpu_sys_dev;
 #ifdef CONFIG_SMP
+	struct sys_device *cpu_sys_dev;
 	unsigned int j;
 #endif
 
-- 
Thanks,
Grant.
