Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVHSU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVHSU2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932687AbVHSU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:28:12 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:48145 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932216AbVHSU2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:28:12 -0400
Date: Fri, 19 Aug 2005 22:28:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: spyro@f2s.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] arm26: one -g is enough for everyone  ;-)
Message-ID: <20050819202809.GI3682@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main Makefile is already adding -g to the CFLAGS if 
CONFIG_DEBUG_INFO=y.

Not that two -g would do harm, but one works as well.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 10 Aug 2005

--- linux-2.6.13-rc5-mm1/arch/arm26/Makefile.old	2005-08-10 02:18:56.000000000 +0200
+++ linux-2.6.13-rc5-mm1/arch/arm26/Makefile	2005-08-10 02:19:28.000000000 +0200
@@ -17,10 +17,6 @@
 CFLAGS		+=-fno-omit-frame-pointer -mno-sched-prolog
 endif
 
-ifeq ($(CONFIG_DEBUG_INFO),y)
-CFLAGS		+=-g
-endif
-
 CFLAGS_BOOT	:=-mapcs-26 -mcpu=arm3 -msoft-float -Uarm
 CFLAGS		+=-mapcs-26 -mcpu=arm3 -msoft-float -Uarm
 AFLAGS		+=-mapcs-26 -mcpu=arm3 -msoft-float
