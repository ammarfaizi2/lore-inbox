Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVCZCSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVCZCSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 21:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVCZCSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 21:18:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:38301 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261909AbVCZCSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 21:18:02 -0500
Date: Fri, 25 Mar 2005 18:17:35 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc1-mm3] Fix typo in scdrv_init()
Message-ID: <20050326021735.GD207782@dragonfly.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in scdrv_init() which was breaking the build for SGI sn2.

Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>

Index: linux/drivers/char/snsc.c
===================================================================
--- linux.orig/drivers/char/snsc.c	2005-03-25 16:53:13.426753917 -0800
+++ linux/drivers/char/snsc.c	2005-03-25 16:53:21.456116301 -0800
@@ -437,7 +437,7 @@
 				continue;
 			}
 
-			class__device_create(snsc_class, dev, NULL,
+			class_device_create(snsc_class, dev, NULL,
 						"%s", devname);
 
 			ia64_sn_irtr_intr_enable(scd->scd_nasid,
