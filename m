Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUIGPSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUIGPSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUIGPNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:13:30 -0400
Received: from verein.lst.de ([213.95.11.210]:53658 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268230AbUIGPL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:11:58 -0400
Date: Tue, 7 Sep 2004 17:11:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove wake_up_all_sync
Message-ID: <20040907151154.GB9577@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

no user in sight


--- 1.20/include/linux/wait.h	2004-08-31 10:00:22 +02:00
+++ edited/include/linux/wait.h	2004-09-07 15:56:53 +02:00
@@ -129,7 +129,6 @@
 #define wake_up(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_nr(x, nr)		__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_all(x)			__wake_up(x, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0, NULL)
-#define wake_up_all_sync(x)			__wake_up_sync((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0)
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
 #define wake_up_interruptible_all(x)	__wake_up(x, TASK_INTERRUPTIBLE, 0, NULL)
