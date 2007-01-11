Return-Path: <linux-kernel-owner+w=401wt.eu-S1751421AbXAKTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXAKTNS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 14:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXAKTNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 14:13:18 -0500
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:42363 "EHLO
	mtagate2.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXAKTNP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 14:13:15 -0500
From: Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       openfabrics-ewg@openib.org, openib-general@openib.org
Subject: [PATCH/RFC 2.6.21 5/5] ehca: ehca_main.c: version numbering
Date: Thu, 11 Jan 2007 20:09:30 +0100
User-Agent: KMail/1.8.2
Cc: raisch@de.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701112009.31068.hnguyen@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roland!
This is a patch for ehca_main.c. It mainly updates ehca version appropriately.
Also the abi_version is increased in order to distinguish this from earlier
releases.
Thanks
Nam


Signed-off-by Hoang-Nam Nguyen <hnguyen@de.ibm.com>
---


 ehca_main.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 6574fbb..839beaa 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -52,7 +52,7 @@ #include "hcp_if.h"
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Christoph Raisch <raisch@de.ibm.com>");
 MODULE_DESCRIPTION("IBM eServer HCA InfiniBand Device Driver");
-MODULE_VERSION("SVNEHCA_0019");
+MODULE_VERSION("SVNEHCA_0020");
 
 int ehca_open_aqp1     = 0;
 int ehca_debug_level   = 0;
@@ -288,7 +287,7 @@ int ehca_init_device(struct ehca_shca *s
 	strlcpy(shca->ib_device.name, "ehca%d", IB_DEVICE_NAME_MAX);
 	shca->ib_device.owner               = THIS_MODULE;
 
-	shca->ib_device.uverbs_abi_ver	    = 5;
+	shca->ib_device.uverbs_abi_ver	    = 6;
 	shca->ib_device.uverbs_cmd_mask	    =
 		(1ull << IB_USER_VERBS_CMD_GET_CONTEXT)		|
 		(1ull << IB_USER_VERBS_CMD_QUERY_DEVICE)	|
@@ -790,7 +789,7 @@ int __init ehca_module_init(void)
 	int ret;
 
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
-	                 "(Rel.: SVNEHCA_0019)\n");
+	                 "(Rel.: SVNEHCA_0020)\n");
 	idr_init(&ehca_qp_idr);
 	idr_init(&ehca_cq_idr);
 	spin_lock_init(&ehca_qp_idr_lock);
