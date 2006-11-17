Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424866AbWKQBTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424866AbWKQBTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 20:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424872AbWKQBTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 20:19:50 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58888 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1424868AbWKQBTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 20:19:45 -0500
Date: Fri, 17 Nov 2006 02:19:44 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] make drivers/base/core.c:setup_parent() static
Message-ID: <20061117011944.GS31879@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114014125.dd315fff.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global setup_parent() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.19-rc5-mm2/drivers/base/core.c.old	2006-11-16 23:14:44.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/base/core.c	2006-11-16 23:14:56.000000000 +0100
@@ -389,7 +389,7 @@
 }
 
 #ifdef CONFIG_SYSFS_DEPRECATED
-int setup_parent(struct device *dev, struct device *parent)
+static int setup_parent(struct device *dev, struct device *parent)
 {
 	/* Set the parent to the class, not the parent device */
 	/* this keeps sysfs from having a symlink to make old udevs happy */
@@ -418,7 +418,7 @@
 	return 0;
 }
 
-int setup_parent(struct device *dev, struct device *parent)
+static int setup_parent(struct device *dev, struct device *parent)
 {
 	int error;
 

