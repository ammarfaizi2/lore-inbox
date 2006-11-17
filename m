Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756047AbWKQX7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbWKQX7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 18:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbWKQX7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 18:59:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37638 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1756047AbWKQX7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 18:59:46 -0500
Date: Sat, 18 Nov 2006 00:59:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, John Stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: [RFC: -mm patch] remove kernel/timer.c:wall_jiffies
Message-ID: <20061117235945.GQ31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"wall_jiffies" was added, but it's completely unused...

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/kernel/timer.c.old	2006-11-17 19:09:54.000000000 +0100
+++ linux-2.6.19-rc5-mm2/kernel/timer.c	2006-11-17 19:10:01.000000000 +0100
@@ -42,9 +42,6 @@
 #include <asm/timex.h>
 #include <asm/io.h>
 
-/* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies = INITIAL_JIFFIES;
-
 u64 jiffies_64 __cacheline_aligned_in_smp = INITIAL_JIFFIES;
 
 EXPORT_SYMBOL(jiffies_64);

