Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265704AbTIFBqq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 21:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265707AbTIFBqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 21:46:46 -0400
Received: from DSL022.LABridge.com ([206.117.136.22]:11792 "EHLO Perches.com")
	by vger.kernel.org with ESMTP id S265704AbTIFBqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 21:46:44 -0400
Subject: [PATCH] 2.6.0-test4 SEQ_START_TOKEN Add #define to seq_file.h (1/6)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Content-Type: text/plain
Message-Id: <1062812809.16845.163.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 05 Sep 2003 18:46:49 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Code that includes seq_file.h use a magic pointer "(void*)1"
to start a header seq_printf.

These patches convert the magic pointer use to a #define

diff -urN linux-2.6.0-test4/include/linux/seq_file.h SEQ_START_TOKEN/include/linux/seq_file.h
-- linux-2.6.0-test4/include/linux/seq_file.h	2003-08-22 17:02:49.000000000 -0700
+++ SEQ_START_TOKEN/include/linux/seq_file.h	2003-09-04 17:28:19.000000000 -0700
@@ -65,5 +65,8 @@
 int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
 int single_release(struct inode *, struct file *);
 int seq_release_private(struct inode *, struct file *);
+
+#define SEQ_START_TOKEN ((void *)1)
+
 #endif
 #endif


