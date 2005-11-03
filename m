Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVKCBzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVKCBzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 20:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVKCBzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 20:55:04 -0500
Received: from mail.isurf.ca ([66.154.97.68]:5049 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S1030264AbVKCBzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 20:55:03 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: davej@codemonkey.org.uk
Subject: [PATCH] arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
Date: Wed, 2 Nov 2005 20:55:46 -0500
User-Agent: KMail/1.8.3
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022055.47183.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to LinuxICC (http://linuxicc.sf.net), a comparison of a u32 less than 0 was found, this patch changes the variable to a signed int so that comparison is meaningful.

This patch applies to linus' git tree as of 02.11.2005

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>

--
diff --git a/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c b/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
index 04a4053..039297b 100644
--- a/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
+++ b/arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
@@ -177,9 +177,9 @@ static unsigned int nforce2_fsb_read(int
  */
 static int nforce2_set_fsb(unsigned int fsb)
 {
-	u32 pll, temp = 0;
+	u32 temp = 0;
 	unsigned int tfsb;
-	int diff;
+	int diff, pll = 0;
 
 	if ((fsb > max_fsb) || (fsb < NFORCE2_MIN_FSB)) {
 		printk(KERN_ERR "cpufreq: FSB %d is out of range!\n", fsb);


-- 
Gabriel A. Devenyi
ace@staticwave.ca
