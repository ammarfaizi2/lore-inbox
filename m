Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbUKOUDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUKOUDU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUKOUCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:02:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:54722 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261673AbUKOTzb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 14:55:31 -0500
Message-ID: <419906BB.9080405@osdl.org>
Date: Mon, 15 Nov 2004 11:42:51 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, ak@suse.de, discuss@x86-64.org
Subject: [PATCH] x8664 hpet: fix function warning
Content-Type: multipart/mixed;
 boundary="------------020705000704080309000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020705000704080309000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


put function prototype outside of #ifdef block, to fix:
arch/x86_64/kernel/time.c:941: warning: implicit declaration of
function `oem_force_hpet_timer'

diffstat:=
   include/asm-x86_64/hpet.h |    2 +-
   1 files changed, 1 insertion(+), 1 deletion(-)

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
-- 


--------------020705000704080309000604
Content-Type: text/x-patch;
 name="hpet_force.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hpet_force.patch"

diff -Naurp ./include/asm-x86_64/hpet.h~hpet_force ./include/asm-x86_64/hpet.h
--- ./include/asm-x86_64/hpet.h~hpet_force	2004-11-15 10:02:01.442748048 -0800
+++ ./include/asm-x86_64/hpet.h	2004-11-15 10:51:53.284918904 -0800
@@ -46,6 +46,7 @@
 
 extern int is_hpet_enabled(void);
 extern int hpet_rtc_timer_init(void);
+extern int oem_force_hpet_timer(void);
 
 #ifdef CONFIG_HPET_EMULATE_RTC
 extern int hpet_mask_rtc_irq_bit(unsigned long bit_mask);
@@ -54,7 +55,6 @@ extern int hpet_set_alarm_time(unsigned 
 extern int hpet_set_periodic_freq(unsigned long freq);
 extern int hpet_rtc_dropped_irq(void);
 extern int hpet_rtc_timer_init(void);
-extern int oem_force_hpet_timer(void);
 #endif /* CONFIG_HPET_EMULATE_RTC */
 
 #endif


--------------020705000704080309000604--
