Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUI3U4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUI3U4B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 16:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269510AbUI3Uyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 16:54:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:61830 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S269484AbUI3Utb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 16:49:31 -0400
Date: Thu, 30 Sep 2004 22:49:18 +0200
From: maximilian attems <janitor@sternwelten.at>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] msleep_interruptible() fix whitespace
Message-ID: <20040930204918.GD1848@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks Xu for noticing, some whitespace found it's way there.
clean that up.


--- linux-2.6.9-rc3-b/kernel/timer.c	2004-09-30 22:25:27.000000000 +0200
+++ linux-2.6.9-rc3/kernel/timer.c	2004-09-30 22:37:09.000000000 +0200
@@ -1624,13 +1624,13 @@ EXPORT_SYMBOL(msleep);
  */
 unsigned long msleep_interruptible(unsigned int msecs)
 {
-       unsigned long timeout = msecs_to_jiffies(msecs);
+	unsigned long timeout = msecs_to_jiffies(msecs);
 
-       while (timeout && !signal_pending(current)) {
-               set_current_state(TASK_INTERRUPTIBLE);
-               timeout = schedule_timeout(timeout);
-       }
-       return jiffies_to_msecs(timeout);
+	while (timeout && !signal_pending(current)) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		timeout = schedule_timeout(timeout);
+	}
+	return jiffies_to_msecs(timeout);
 }
 
 EXPORT_SYMBOL(msleep_interruptible);

--
maks
kernel janitor  	http://janitor.kernelnewbies.org/

