Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbVKHMik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbVKHMik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965021AbVKHMik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:38:40 -0500
Received: from mail.isurf.ca ([66.154.97.68]:8402 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S965008AbVKHMij (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:38:39 -0500
Message-ID: <43709C4B.5010607@staticwave.ca>
Date: Tue, 08 Nov 2005 07:38:35 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davej@codemonkey.org.uk
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org
Subject: [RESEND] [PATCH] arch/i386/kernel/cpu/cpufreq/cpufreq-nforce2.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
