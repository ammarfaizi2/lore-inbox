Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261492AbUJXNfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbUJXNfr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbUJXN3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:29:53 -0400
Received: from verein.lst.de ([213.95.11.210]:26022 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261485AbUJXN3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:29:33 -0400
Date: Sun, 24 Oct 2004 15:29:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport kick_process
Message-ID: <20041024132921.GA20048@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this isn't exactly the kind of interface modules should use..


--- 1.367/kernel/sched.c	2004-10-19 07:26:52 +02:00
+++ edited/kernel/sched.c	2004-10-23 14:20:54 +02:00
@@ -895,8 +895,6 @@
 	preempt_enable();
 }
 
-EXPORT_SYMBOL_GPL(kick_process);
-
 /*
  * Return a low guess at the load of a migration-source cpu.
  *
