Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVKRPDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVKRPDo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVKRPDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:03:44 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32410 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750815AbVKRPDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:03:43 -0500
Date: Fri, 18 Nov 2005 15:03:40 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: scanf sector format change
Message-ID: <20051118150340.GR11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use %llu not %Lu in sscanf/printf format strings.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.13.1/drivers/md/dm.h
===================================================================
--- linux-2.6.13.1.orig/drivers/md/dm.h	2005-09-16 23:00:13.000000000 +0100
+++ linux-2.6.13.1/drivers/md/dm.h	2005-09-16 23:01:00.000000000 +0100
@@ -28,7 +28,7 @@
  * in types.h.
  */
 #ifdef CONFIG_LBD
-#define SECTOR_FORMAT "%Lu"
+#define SECTOR_FORMAT "%llu"
 #else
 #define SECTOR_FORMAT "%lu"
 #endif
