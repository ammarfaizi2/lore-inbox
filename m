Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbVH3Wm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVH3Wm1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 18:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbVH3Wm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 18:42:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9973 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932277AbVH3WmZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 18:42:25 -0400
Subject: [PATCH] PREEMPT_RT vermagic
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
In-Reply-To: <20050829084829.GA23176@elte.hu>
References: <20050829084829.GA23176@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 30 Aug 2005 15:42:17 -0700
Message-Id: <1125441737.18150.43.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,
	This patch adds a vermagic hook so PREEMPT_RT modules can be
distinguished from PREEMPT_DESKTOP modules.
	
Signed-off-by: Daniel Walker <dwalker@mvista.com>
Index: linux-2.6.10/include/linux/vermagic.h
===================================================================
--- linux-2.6.10.orig/include/linux/vermagic.h	2004-12-24 21:35:50.000000000 +0000
+++ linux-2.6.10/include/linux/vermagic.h	2005-08-23 17:35:08.000000000 +0000
@@ -8,7 +8,11 @@
 #define MODULE_VERMAGIC_SMP ""
 #endif
 #ifdef CONFIG_PREEMPT
-#define MODULE_VERMAGIC_PREEMPT "preempt "
+# ifdef CONFIG_PREEMPT_RT
+# define MODULE_VERMAGIC_PREEMPT "preempt_rt "
+# else
+# define MODULE_VERMAGIC_PREEMPT "preempt "
+# endif
 #else
 #define MODULE_VERMAGIC_PREEMPT ""
 #endif


