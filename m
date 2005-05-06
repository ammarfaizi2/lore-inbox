Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVEFViS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVEFViS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 17:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVEFViS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 17:38:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64005 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261274AbVEFViL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 17:38:11 -0400
Date: Fri, 6 May 2005 23:37:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rusty@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/module.c: make a function static
Message-ID: <20050506213752.GT3590@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes a needlessly global function static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc3-mm2-full/kernel/module.c.old	2005-05-03 07:45:42.000000000 +0200
+++ linux-2.6.12-rc3-mm2-full/kernel/module.c	2005-05-03 07:47:08.000000000 +0200
@@ -692,7 +692,7 @@
 	return 0;
 }
 
-int set_obsolete(const char *val, struct kernel_param *kp)
+static int set_obsolete(const char *val, struct kernel_param *kp)
 {
 	unsigned int min, max;
 	unsigned int size, maxsize;

