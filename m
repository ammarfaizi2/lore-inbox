Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWELX6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWELX6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWELX5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:36 -0400
Received: from mx.pathscale.com ([64.160.42.68]:58537 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932271AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 29 of 53] ipath - remove redundant register read
X-Mercurial-Node: 23519e578bf04f4582ab94a3359dc3a25a790616
Message-Id: <23519e578bf04f4582ab.1147477394@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:14 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 47f1df66d097 -r 23519e578bf0 drivers/infiniband/hw/ipath/ipath_intr.c
--- a/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_intr.c	Fri May 12 15:55:28 2006 -0700
@@ -780,7 +780,6 @@ irqreturn_t ipath_intr(int irq, void *da
 			ipath_stats.sps_fastrcvint++;
 			goto done;
 		}
-		istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
 	}
 
 	istat = ipath_read_kreg32(dd, dd->ipath_kregs->kr_intstatus);
