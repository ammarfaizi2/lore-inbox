Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVHWVrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVHWVrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVHWVrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:47:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17590 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932445AbVHWVoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:44 -0400
To: torvalds@osdl.org
Subject: [PATCH] (36/43) typo fix in qdio.c
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gcV-0007Ec-CI@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dumb typo: u32 volatile * mistyped as u32 * volatile

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-emac-iounmap/drivers/s390/cio/qdio.c RC13-rc6-git13-qdio_get_indicator/drivers/s390/cio/qdio.c
--- RC13-rc6-git13-emac-iounmap/drivers/s390/cio/qdio.c	2005-08-10 10:37:50.000000000 -0400
+++ RC13-rc6-git13-qdio_get_indicator/drivers/s390/cio/qdio.c	2005-08-21 13:17:18.000000000 -0400
@@ -230,7 +230,7 @@
 }
 
 /* locked by the locks in qdio_activate and qdio_cleanup */
-static __u32 * volatile 
+static __u32 volatile *
 qdio_get_indicator(void)
 {
 	int i;
