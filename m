Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVBFNtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVBFNtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 08:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVBFNtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 08:49:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:5646 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261244AbVBFNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 08:49:02 -0500
Date: Sun, 6 Feb 2005 14:48:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] unexport mca_find_device_by_slot
Message-ID: <20050206134859.GP3129@stusta.de>
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

--- linux-2.6.11-rc3-mm1-full/drivers/mca/mca-legacy.c.old	2005-02-06 14:22:31.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/mca/mca-legacy.c	2005-02-06 14:22:44.000000000 +0100
@@ -180,7 +180,6 @@
 
 	return info.mca_dev;
 }
-EXPORT_SYMBOL(mca_find_device_by_slot);
 
 /**
  *	mca_read_stored_pos - read POS register from boot data

