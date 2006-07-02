Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWGBX3z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWGBX3z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWGBX3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:29:55 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59863 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750725AbWGBX3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:29:54 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:29:40 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 18/19] ieee1394: fix kerneldoc of hpsb_alloc_host
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.40a2db179a3d955f@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.338) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was stuff between the comment and the function.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
When applied to -mm, this will have a conflict with a lock validator
annotations patch which currently lives in -mm.  This is easy to
resolve but I will post this patch as an -mm version too.

Index: linux/drivers/ieee1394/hosts.c
===================================================================
--- linux.orig/drivers/ieee1394/hosts.c	2006-07-02 14:16:53.000000000 +0200
+++ linux/drivers/ieee1394/hosts.c	2006-07-02 14:17:54.000000000 +0200
@@ -90,6 +90,8 @@ static int alloc_hostnum_cb(struct hpsb_
 	return 0;
 }
 
+static DEFINE_MUTEX(host_num_alloc);
+
 /**
  * hpsb_alloc_host - allocate a new host controller.
  * @drv: the driver that will manage the host controller
@@ -105,8 +107,6 @@ static int alloc_hostnum_cb(struct hpsb_
  * Return Value: a pointer to the &hpsb_host if successful, %NULL if
  * no memory was available.
  */
-static DEFINE_MUTEX(host_num_alloc);
-
 struct hpsb_host *hpsb_alloc_host(struct hpsb_host_driver *drv, size_t extra,
 				  struct device *dev)
 {


