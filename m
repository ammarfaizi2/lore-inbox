Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030490AbWBHDY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030490AbWBHDY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWBHDTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:19:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:62848 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030480AbWBHDS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:18:57 -0500
To: torvalds@osdl.org
Subject: [PATCH 13/29] timer.c NULL noise removal
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1F6fr7-0006Cm-2N@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 08 Feb 2006 03:18:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 1138791401 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

53f087febfd12e74ba9f1082e71e9a45adc039ad
diff --git a/kernel/timer.c b/kernel/timer.c
index 4f1cb0a..b9dad39 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -495,7 +495,7 @@ unsigned long next_timer_interrupt(void)
 	base = &__get_cpu_var(tvec_bases);
 	spin_lock(&base->t_base.lock);
 	expires = base->timer_jiffies + (LONG_MAX >> 1);
-	list = 0;
+	list = NULL;
 
 	/* Look for timer events in tv1. */
 	j = base->timer_jiffies & TVR_MASK;
-- 
0.99.9.GIT

