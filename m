Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVCCSIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVCCSIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 13:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVCCSHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 13:07:33 -0500
Received: from mx02.qsc.de ([213.148.130.14]:17355 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S262504AbVCCSFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:05:18 -0500
Message-ID: <422751D9.2060603@exactcode.de>
Date: Thu, 03 Mar 2005 19:05:13 +0100
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCode
User-Agent: Mozilla Thunderbird 1.0 (X11/20050205)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


--- linux-2.6.11/drivers/md/raid6altivec.uc.vanilla	2005-03-02 
16:44:56.407107752 +0100
+++ linux-2.6.11/drivers/md/raid6altivec.uc	2005-03-02 
16:45:22.424152560 +0100
@@ -108,7 +108,7 @@
  int raid6_have_altivec(void)
  {
  	/* This assumes either all CPUs have Altivec or none does */
-	return cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC;
+	return cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC;
  }
  #endif


Yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de/ | http://www.t2-project.org/
             +49 (0)30  255 897 45

