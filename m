Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422767AbWHYSZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422767AbWHYSZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWHYSZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:40 -0400
Received: from mx.pathscale.com ([64.160.42.68]:43906 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422767AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 23] IB/ipath - add serial number to hardware freeze
	error message
X-Mercurial-Node: 10a37abd2abd9711e9e5c3e263ada3ed60f1a0bd
Message-Id: <10a37abd2abd9711e9e5.1156530280@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:40 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also added the word "Hardware" after "Fatal" to make it more obvious
that it's hardware, not software.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_iba6110.c b/drivers/infiniband/hw/ipath/ipath_iba6110.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6110.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6110.c	Fri Aug 25 11:19:45 2006 -0700
@@ -461,8 +461,9 @@ static void ipath_ht_handle_hwerrors(str
 			 * times.
 			 */
 			if (dd->ipath_flags & IPATH_INITTED) {
-				ipath_dev_err(dd, "Fatal Error (freeze "
-					      "mode), no longer usable\n");
+				ipath_dev_err(dd, "Fatal Hardware Error (freeze "
+					      "mode), no longer usable, SN %.16s\n",
+						  dd->ipath_serial);
 				isfatal = 1;
 			}
 			*dd->ipath_statusp &= ~IPATH_STATUS_IB_READY;
diff --git a/drivers/infiniband/hw/ipath/ipath_iba6120.c b/drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Fri Aug 25 11:19:45 2006 -0700
@@ -363,8 +363,9 @@ static void ipath_pe_handle_hwerrors(str
 			 * and we get here multiple times
 			 */
 			if (dd->ipath_flags & IPATH_INITTED) {
-				ipath_dev_err(dd, "Fatal Error (freeze "
-					      "mode), no longer usable\n");
+				ipath_dev_err(dd, "Fatal Hardware Error (freeze "
+					      "mode), no longer usable, SN %.16s\n",
+						  dd->ipath_serial);
 				isfatal = 1;
 			}
 			/*
