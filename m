Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933016AbWFWK7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933016AbWFWK7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWFWK4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:56:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7692 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933015AbWFWKzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:55:49 -0400
Date: Fri, 23 Jun 2006 12:55:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make kernel/sysctl.c:_proc_do_string() static
Message-ID: <20060623105549.GQ9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global _proc_do_string() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/kernel/sysctl.c.old	2006-06-22 20:50:08.000000000 +0200
+++ linux-2.6.17-mm1-full/kernel/sysctl.c	2006-06-22 20:50:39.000000000 +0200
@@ -1706,8 +1706,9 @@
 	return do_rw_proc(1, file, (char __user *) buf, count, ppos);
 }
 
-int _proc_do_string(void* data, int maxlen, int write, struct file *filp,
-		    void __user *buffer, size_t *lenp, loff_t *ppos)
+static int _proc_do_string(void* data, int maxlen, int write,
+			   struct file *filp, void __user *buffer,
+			   size_t *lenp, loff_t *ppos)
 {
 	size_t len;
 	char __user *p;

