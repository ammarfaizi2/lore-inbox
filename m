Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbUJXN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbUJXN3q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261478AbUJXNWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:22:19 -0400
Received: from verein.lst.de ([213.95.11.210]:17318 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261487AbUJXNWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:22:04 -0400
Date: Sun, 24 Oct 2004 15:21:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] unexport sys_lseek
Message-ID: <20041024132152.GA19927@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fortunately dvb stopped using it in their firmware loader


--- 1.45/fs/read_write.c	2004-10-19 07:26:38 +02:00
+++ edited/fs/read_write.c	2004-10-23 12:52:13 +02:00
@@ -146,7 +146,6 @@
 bad:
 	return retval;
 }
-EXPORT_SYMBOL_GPL(sys_lseek);
 
 #ifdef __ARCH_WANT_SYS_LLSEEK
 asmlinkage long sys_llseek(unsigned int fd, unsigned long offset_high,
