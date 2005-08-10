Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbVHJAYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbVHJAYI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVHJAYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:24:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42252 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750999AbVHJAYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:24:07 -0400
Date: Wed, 10 Aug 2005 02:24:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: spyro@f2s.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arm26: one -g is enough for everyone  ;-)
Message-ID: <20050810002401.GO4006@stusta.de>
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
