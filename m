Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUJXNeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUJXNeW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbUJXNbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:31:24 -0400
Received: from verein.lst.de ([213.95.11.210]:28838 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261482AbUJXNan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:30:43 -0400
Date: Sun, 24 Oct 2004 15:30:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport getnstimeofday
Message-ID: <20041024133029.GB20048@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this recently added function is only used by the posix timers code,
no need to be exported.


--- 1.25/kernel/time.c	2004-10-20 10:37:07 +02:00
+++ edited/kernel/time.c	2004-10-23 16:19:22 +02:00
@@ -528,8 +528,6 @@
 }
 #endif
 
-EXPORT_SYMBOL(getnstimeofday);
-
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
