Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbVCSNTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbVCSNTL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 08:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVCSNRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 08:17:43 -0500
Received: from coderock.org ([193.77.147.115]:61575 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262466AbVCSNRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 08:17:30 -0500
Subject: [patch 03/10] kernel/timer: fix msleep_interruptible() comment
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sat, 19 Mar 2005 14:17:22 +0100
Message-Id: <20050319131723.310D41ECA8@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The comment for msleep_interruptible() is wrong, as it will
ignore wait-queue events, but will wake up early for signals.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/kernel/timer.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN kernel/timer.c~msleep_interruptible_comment-kernel_timer kernel/timer.c
--- kj/kernel/timer.c~msleep_interruptible_comment-kernel_timer	2005-03-18 20:05:13.000000000 +0100
+++ kj-domen/kernel/timer.c	2005-03-18 20:05:13.000000000 +0100
@@ -1594,7 +1594,7 @@ void msleep(unsigned int msecs)
 EXPORT_SYMBOL(msleep);
 
 /**
- * msleep_interruptible - sleep waiting for waitqueue interruptions
+ * msleep_interruptible - sleep waiting for signals
  * @msecs: Time in milliseconds to sleep for
  */
 unsigned long msleep_interruptible(unsigned int msecs)
_
