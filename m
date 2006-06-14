Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965023AbWFNQNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWFNQNH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 12:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWFNQNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 12:13:07 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:1505 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S965023AbWFNQNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 12:13:06 -0400
Message-Id: <20060614161210.730877000@mvista.com>
User-Agent: quilt/0.45-1
Date: Wed, 14 Jun 2006 09:12:10 -0700
From: dwalker@mvista.com
To: tglx@linutronix.de
Cc: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix clockevents compile error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

clockevents depends on generic time, since there's some defines
it needs which get removed when generic time is off .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

---
 kernel/time/Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.16/kernel/time/Makefile
===================================================================
--- linux-2.6.16.orig/kernel/time/Makefile
+++ linux-2.6.16/kernel/time/Makefile
@@ -1 +1,5 @@
-obj-y += clocksource.o jiffies.o clockevents.o
+
+obj-y += clocksource.o jiffies.o
+
+obj-$(CONFIG_GENERIC_TIME) += clockevents.o
+
--
