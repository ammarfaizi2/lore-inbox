Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWHaM2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWHaM2A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWHaM2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:28:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49540 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751371AbWHaM17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:27:59 -0400
Date: Thu, 31 Aug 2006 14:27:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>,
       john.ronciak@intel.com, jesse.brandeburg@intel.com,
       jeffrey.t.kirsher@intel.com, auke-jan.h.kok@intel.com
Subject: e1000: small cleanups
Message-ID: <20060831122746.GZ3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill unneccessary macros and fix whitespace... e1000_osdep should just
die, but it is a bit soon for that :-(.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/net/e1000/e1000_osdep.h b/drivers/net/e1000/e1000_osdep.h
index 2d3e8b0..503870c 100644
--- a/drivers/net/e1000/e1000_osdep.h
+++ b/drivers/net/e1000/e1000_osdep.h
@@ -43,7 +43,7 @@
 #include <linux/sched.h>
 
 #ifndef msec_delay
-#define msec_delay(x)	do { if(in_interrupt()) { \
+#define msec_delay(x)	do { if (in_interrupt()) { \
 				/* Don't mdelay in interrupt context! */ \
 	                	BUG(); \
 			} else { \
@@ -68,8 +68,6 @@ typedef enum {
     TRUE = 1
 } boolean_t;
 
-#define MSGOUT(S, A, B)	printk(KERN_DEBUG S "\n", A, B)
-
 #ifdef DBG
 #define DEBUGOUT(S)		printk(KERN_DEBUG S "\n")
 #define DEBUGOUT1(S, A...)	printk(KERN_DEBUG S "\n", A)
@@ -79,9 +77,7 @@ typedef enum {
 #endif
 
 #define DEBUGFUNC(F) DEBUGOUT(F)
-#define DEBUGOUT2 DEBUGOUT1
-#define DEBUGOUT3 DEBUGOUT2
-#define DEBUGOUT7 DEBUGOUT3
+#define DEBUGOUT7 DEBUGOUT1
 
 
 #define E1000_WRITE_REG(a, reg, value) ( \

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
