Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262691AbVCMD4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbVCMD4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 22:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVCMD4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 22:56:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12294 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262691AbVCMDyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 22:54:14 -0500
Date: Sun, 13 Mar 2005 04:54:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jejb@steeleye.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport mca_find_device_by_slot
Message-ID: <20050313035411.GU3814@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't find any possible modular usage of mca_find_device_by_slot in 
the kernel, and this patch therefore removes the EXPORT_SYMBOL.

This patch should be safe since mca-legacy is nothing drivers should 
move to.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Feb 2005

--- linux-2.6.11-rc3-mm1-full/drivers/mca/mca-legacy.c.old	2005-02-06 14:22:31.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/mca/mca-legacy.c	2005-02-06 14:22:44.000000000 +0100
@@ -180,7 +180,6 @@
 
 	return info.mca_dev;
 }
-EXPORT_SYMBOL(mca_find_device_by_slot);
 
 /**
  *	mca_read_stored_pos - read POS register from boot data

