Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVF1V2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVF1V2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVF1V2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 17:28:46 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:46351 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261395AbVF1V2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 17:28:17 -0400
Date: Tue, 28 Jun 2005 23:28:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: cpufreq@lists.linux.org.uk, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6] cpufreq: two minor cleanups
Message-Id: <20050628232830.6630c526.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here are two possible cleanups in cpufreq.c:
* ret has no need to be unsigned in cpufreq_driver_target()
* ret has no need to be initialized in __cpufreq_governor()

Thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/cpufreq/cpufreq.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.12.orig/drivers/cpufreq/cpufreq.c	2005-06-21 21:25:31.000000000 +0200
+++ linux-2.6.12/drivers/cpufreq/cpufreq.c	2005-06-21 21:29:01.000000000 +0200
@@ -1130,7 +1130,7 @@
 			  unsigned int target_freq,
 			  unsigned int relation)
 {
-	unsigned int ret;
+	int ret;
 
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
@@ -1151,7 +1151,7 @@
 
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
 {
-	int ret = -EINVAL;
+	int ret;
 
 	if (!try_module_get(policy->governor->owner))
 		return -EINVAL;


-- 
Jean Delvare
