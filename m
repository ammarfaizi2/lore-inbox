Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVCDAyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVCDAyl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVCDAtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:49:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22028 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262809AbVCDArN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:47:13 -0500
Date: Fri, 4 Mar 2005 01:47:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport complete_all
Message-ID: <20050304004701.GU4608@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage in the kernel.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc5-mm1-full/kernel/sched.c.old	2005-03-04 01:04:28.000000000 +0100
+++ linux-2.6.11-rc5-mm1-full/kernel/sched.c	2005-03-04 01:04:34.000000000 +0100
@@ -3053,7 +3053,6 @@
 			 0, 0, NULL);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }
-EXPORT_SYMBOL(complete_all);
 
 void fastcall __sched wait_for_completion(struct completion *x)
 {
