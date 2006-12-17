Return-Path: <linux-kernel-owner+w=401wt.eu-S1752869AbWLQP4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbWLQP4x (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 10:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752871AbWLQP4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 10:56:53 -0500
Received: from smtp-dmz-230-sunday.dmz.nerim.net ([195.5.254.230]:65373 "EHLO
	kellthuzad.dmz.nerim.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752868AbWLQP4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 10:56:52 -0500
Date: Sun, 17 Dec 2006 16:55:49 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: David Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] DRM: Stop defining pci_pretty_name
Message-Id: <20061217165549.77e0325d.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DRM drivers no longer use pci_pretty_name so we can stop defining it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Already sent on:
 2006-06-05
 2006-08-21

 drivers/char/drm/drmP.h |    4 ----
 1 file changed, 4 deletions(-)

--- linux-2.6.20-rc1.orig/drivers/char/drm/drmP.h	2006-12-17 16:46:04.000000000 +0100
+++ linux-2.6.20-rc1/drivers/char/drm/drmP.h	2006-12-17 16:51:28.000000000 +0100
@@ -1143,9 +1143,5 @@
 extern unsigned long drm_core_get_map_ofs(drm_map_t * map);
 extern unsigned long drm_core_get_reg_ofs(struct drm_device *dev);
 
-#ifndef pci_pretty_name
-#define pci_pretty_name(dev) ""
-#endif
-
 #endif				/* __KERNEL__ */
 #endif


-- 
Jean Delvare
