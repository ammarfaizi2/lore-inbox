Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWGYQ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWGYQ6B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGYQ5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:34 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:2453 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP id S932482AbWGYQ5A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:57:00 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 6 of 7] [x86-64] Calgary IOMMU:
	calgary_init_one_nontraslated() can return void
X-Mercurial-Node: 529b8e81c7603717ddd3782899d3b0159d225b5b
Message-Id: <529b8e81c7603717ddd3.1153846596@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:36 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 1 insertion(+), 3 deletions(-)
arch/x86_64/kernel/pci-calgary.c |    4 +---


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153738218 -10800
# Node ID 529b8e81c7603717ddd3782899d3b0159d225b5b
# Parent  a42c3826807abbeacc40649127afb5103aabdbd4
[x86-64] Calgary IOMMU: calgary_init_one_nontraslated() can return void

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r a42c3826807a -r 529b8e81c760 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:45:43 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:50:18 2006 +0300
@@ -784,13 +784,11 @@ static inline unsigned int __init locate
 	return address;
 }
 
-static int __init calgary_init_one_nontraslated(struct pci_dev *dev)
+static void __init calgary_init_one_nontraslated(struct pci_dev *dev)
 {
 	pci_dev_get(dev);
 	dev->sysdata = NULL;
 	dev->bus->self = dev;
-
-	return 0;
 }
 
 static int __init calgary_init_one(struct pci_dev *dev)
