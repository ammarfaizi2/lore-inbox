Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWF1Q7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWF1Q7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWF1Qyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:54:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37892 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751432AbWF1Qys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:54:48 -0400
Date: Wed, 28 Jun 2006 18:54:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Leech <christopher.leech@intel.com>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/dma/iovlock.c: make num_pages_spanned() static
Message-ID: <20060628165447.GR13915@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global num_pages_spanned() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Jun 2006

--- linux-2.6.17-mm1-full/drivers/dma/iovlock.c.old	2006-06-21 22:49:48.000000000 +0200
+++ linux-2.6.17-mm1-full/drivers/dma/iovlock.c	2006-06-21 22:50:01.000000000 +0200
@@ -31,7 +31,7 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
-int num_pages_spanned(struct iovec *iov)
+static int num_pages_spanned(struct iovec *iov)
 {
 	return
 	((PAGE_ALIGN((unsigned long)iov->iov_base + iov->iov_len) -

