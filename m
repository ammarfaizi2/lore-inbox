Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUIGPFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUIGPFm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268314AbUIGPFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:05:41 -0400
Received: from verein.lst.de ([213.95.11.210]:28058 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268166AbUIGPEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:04:41 -0400
Date: Tue, 7 Sep 2004 17:04:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport exit_mm
Message-ID: <20040907150437.GA9293@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not exactly a thing we want done from modules, and no module uses it
anyway.


--- 1.152/kernel/exit.c	2004-09-02 12:30:52 +02:00
+++ edited/kernel/exit.c	2004-09-07 15:32:47 +02:00
@@ -509,8 +509,6 @@
 	__exit_mm(tsk);
 }
 
-EXPORT_SYMBOL(exit_mm);
-
 static inline void choose_new_parent(task_t *p, task_t *reaper, task_t *child_reaper)
 {
 	/*
