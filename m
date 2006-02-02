Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161123AbWBBJza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161123AbWBBJza (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWBBJz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:55:29 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:46466 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161123AbWBBJz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:55:28 -0500
Date: Thu, 2 Feb 2006 10:55:02 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] s390: fix to_channelpath macro
Message-ID: <20060202095502.GC22815@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Fix broken to_channelpath macro (fortunately worked in all current cases...).

Signed-off-by: Cornelia Huck <cohuck@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/cio/chsc.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/cio/chsc.h linux-2.6-patched/drivers/s390/cio/chsc.h
--- linux-2.6/drivers/s390/cio/chsc.h	2006-02-02 09:52:57.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/chsc.h	2006-02-02 09:53:29.000000000 +0100
@@ -68,6 +68,6 @@ extern void *chsc_get_chp_desc(struct su
 
 extern int chsc_enable_facility(int);
 
-#define to_channelpath(dev) container_of(dev, struct channel_path, dev)
+#define to_channelpath(device) container_of(device, struct channel_path, dev)
 
 #endif
