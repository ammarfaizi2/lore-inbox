Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVHKVVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVHKVVc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932490AbVHKVVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:21:32 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:1709 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932489AbVHKVVb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:21:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=fUWTS7xe8i1RZ8GYUDi4NFxopi8IXoReLM0ChykbSkFjLfLuC2ycYr+UgGVLDyqaAofvqDACFMw8HP1zLUUPRLDiRVy0fIDDg/vyLClkzqKze1joFtH5vV57t5Z0hbDIMHtwEs+op+xLQXWXh59mglzDhYjY662J5IpZKqWpees=
Message-ID: <42FBC106.3040501@gmail.com>
Date: Thu, 11 Aug 2005 21:20:06 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Real-Time Preemption V0.7.53-02, fix redundant PREEMPT_RCU
 config option
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a redundant PREEMPT_RCU option from kernel/Kconfig.preempt.



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- realtime-preempt-2.6.13-rc4-RT-V0.7.53-02.orig	2005-08-11 18:56:51.000000000
+0000
+++ realtime-preempt-2.6.13-rc4-RT-V0.7.53-02		2005-08-11 21:13:43.000000000 +0000
@@ -21571,18 +21571,6 @@ Index: linux/kernel/Kconfig.preempt
 +
 +	  Say N if you are unsure.
 +
-+config PREEMPT_RCU
-+	bool "Preemptible RCU"
-+	default n
-+	depends on PREEMPT
-+	help
-+	  This option reduces the latency of the kernel by making certain
-+	  RCU sections preemptible. Normally RCU code is non-preemptible, if
-+	  this option is selected then read-only RCU sections become
-+	  preemptible. This helps latency, but may increase memory utilization.
-+
-+	  Say N if you are unsure.
-+
 +config SPINLOCK_BKL
 +	bool "Old-Style Big Kernel Lock"
 +	depends on (PREEMPT || SMP) && !PREEMPT_RT




Regards,
-- 
					Luca

