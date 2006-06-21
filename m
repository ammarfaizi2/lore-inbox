Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWFUV6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWFUV6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWFUV6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:58:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:7133 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1030196AbWFUV6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:58:43 -0400
Date: Wed, 21 Jun 2006 23:57:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Leech <christopher.leech@intel.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/dma/iovlock.c: make num_pages_spanned() static
Message-ID: <20060621215723.GK9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global num_pages_spanned() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

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

