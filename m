Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbWGYQ5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWGYQ5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGYQ5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:33 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:30495 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932481AbWGYQ5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:57:00 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 7] [x86-64] Calgary IOMMU: save a bit of space in bus_info
X-Mercurial-Node: 8f45fff682d3bf9aea2328b1ded97745285be538
Message-Id: <8f45fff682d3bf9aea23.1153846597@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:37 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 1 insertion(+), 1 deletion(-)
arch/x86_64/kernel/pci-calgary.c |    2 +-


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153781666 -10800
# Node ID 8f45fff682d3bf9aea2328b1ded97745285be538
# Parent  529b8e81c7603717ddd3782899d3b0159d225b5b
[x86-64] Calgary IOMMU: save a bit of space in bus_info

Make translation_disabled a uchar rather than an int

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 529b8e81c760 -r 8f45fff682d3 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:50:18 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Tue Jul 25 01:54:26 2006 +0300
@@ -117,7 +117,7 @@ static int calgary_detected __read_mostl
 
 struct calgary_bus_info {
 	void *tce_space;
-	int translation_disabled;
+	unsigned char translation_disabled;
 	signed char phbid;
 };
 
