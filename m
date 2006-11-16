Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161840AbWKPMQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161840AbWKPMQU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 07:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031185AbWKPMQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 07:16:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56589 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031183AbWKPMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 07:16:19 -0500
Date: Thu, 16 Nov 2006 13:16:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>
Subject: [-mm patch] remove arch/i386/kernel/time_hpet.c:hpet_reenable()
Message-ID: <20061116121618.GD31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.19-rc5-mm2:
>...
> +updated-i386-convert-to-clock-event-devices.patch
>...
>  Updated/fixed/reworked/redone hrtimer and dynticks patches.
>...

This patch removes the no longer used hpet_reenable()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/time_hpet.c |    5 -----
 include/asm-i386/hpet.h      |    1 -
 2 files changed, 6 deletions(-)

--- linux-2.6.19-rc5-mm2/include/asm-i386/hpet.h.old	2006-11-15 18:49:35.000000000 +0100
+++ linux-2.6.19-rc5-mm2/include/asm-i386/hpet.h	2006-11-15 18:49:44.000000000 +0100
@@ -96,7 +96,6 @@
 
 extern int hpet_rtc_timer_init(void);
 extern int hpet_enable(void);
-extern int hpet_reenable(void);
 extern int is_hpet_enabled(void);
 extern int is_hpet_capable(void);
 extern int hpet_readl(unsigned long a);
--- linux-2.6.19-rc5-mm2/arch/i386/kernel/time_hpet.c.old	2006-11-15 18:49:53.000000000 +0100
+++ linux-2.6.19-rc5-mm2/arch/i386/kernel/time_hpet.c	2006-11-15 18:50:02.000000000 +0100
@@ -199,11 +199,6 @@
 	return 0;
 }
 
-int hpet_reenable(void)
-{
-	return hpet_timer_stop_set_go(hpet_tick);
-}
-
 int is_hpet_enabled(void)
 {
 	return use_hpet;

