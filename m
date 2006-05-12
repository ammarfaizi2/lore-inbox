Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWELX6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWELX6A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWELX5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:40 -0400
Received: from mx.pathscale.com ([64.160.42.68]:57769 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932218AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 26 of 53] ipath - treat PE800 rev1 and rev2 as similar
X-Mercurial-Node: 8e2d63833cf2a2d133373424f868f747d3f6d56a
Message-Id: <8e2d63833cf2a2d13337.1147477391@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:11 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 2b7918a7133e -r 8e2d63833cf2 drivers/infiniband/hw/ipath/ipath_pe800.c
--- a/drivers/infiniband/hw/ipath/ipath_pe800.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_pe800.c	Fri May 12 15:55:28 2006 -0700
@@ -532,7 +532,7 @@ static int ipath_pe_boardname(struct ipa
 	if (n)
 		snprintf(name, namelen, "%s", n);
 
-	if (dd->ipath_majrev != 4 || dd->ipath_minrev != 1) {
+	if (dd->ipath_majrev != 4 || !dd->ipath_minrev || dd->ipath_minrev>2) {
 		ipath_dev_err(dd, "Unsupported PE-800 revision %u.%u!\n",
 			      dd->ipath_majrev, dd->ipath_minrev);
 		ret = 1;
