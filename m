Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVCCTis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVCCTis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVCCTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:38:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5251 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261645AbVCCS4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 13:56:17 -0500
Date: Thu, 3 Mar 2005 10:56:15 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Kernel-Janitors <kernel-janitors@lists.osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/timer: fix msleep_interruptible() comment
Message-ID: <20050303185615.GN11600@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please consider applying.

Description: The comment for msleep_interruptible() is wrong, as it will
ignore wait-queue events, but will wake up early for signals.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>


--- 2.6.11-kj-v/kernel/timer.c	2005-03-01 23:38:25.000000000 -0800
+++ 2.6.11-kj/kernel/timer.c	2005-03-02 15:22:06.000000000 -0800
@@ -1589,7 +1589,7 @@ void msleep(unsigned int msecs)
 EXPORT_SYMBOL(msleep);
 
 /**
- * msleep_interruptible - sleep waiting for waitqueue interruptions
+ * msleep_interruptible - sleep waiting for signals
  * @msecs: Time in milliseconds to sleep for
  */
 unsigned long msleep_interruptible(unsigned int msecs)
