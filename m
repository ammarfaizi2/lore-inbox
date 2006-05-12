Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbWELXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbWELXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWELXo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:59 -0400
Received: from mx.pathscale.com ([64.160.42.68]:426 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932200AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 52 of 53] ipath - register as IB device owner
X-Mercurial-Node: fd9bdeea5b10eccfc8153303f195c84108c92d34
Message-Id: <fd9bdeea5b10eccfc815.1147477417@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:37 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 5f665c503f0d -r fd9bdeea5b10 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 16:41:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 16:42:39 2006 -0700
@@ -1060,6 +1060,7 @@ static void *ipath_register_ib_device(in
 	idev->dd = dd;
 
 	strlcpy(dev->name, "ipath%d", IB_DEVICE_NAME_MAX);
+	dev->owner = THIS_MODULE;
 	dev->node_guid = ipath_layer_get_guid(dd);
 	dev->uverbs_abi_ver = IPATH_UVERBS_ABI_VERSION;
 	dev->uverbs_cmd_mask =
