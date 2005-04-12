Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVDLKwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVDLKwR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVDLKvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:51:21 -0400
Received: from fire.osdl.org ([65.172.181.4]:36554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262269AbVDLKdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:19 -0400
Message-Id: <200504121033.j3CAXCgm005809@shell0.pdx.osdl.net>
Subject: [patch 162/198] IB: Remove incorrect comments
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, halr@voltaire.com,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Hal Rosenstock <halr@voltaire.com>

Eliminate unneeded and misleading comments

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/core/agent.c |    2 --
 25-akpm/drivers/infiniband/core/mad.c   |    1 -
 2 files changed, 3 deletions(-)

diff -puN drivers/infiniband/core/agent.c~ib-remove-incorrect-comments drivers/infiniband/core/agent.c
--- 25/drivers/infiniband/core/agent.c~ib-remove-incorrect-comments	2005-04-12 03:21:42.166726584 -0700
+++ 25-akpm/drivers/infiniband/core/agent.c	2005-04-12 03:21:42.171725824 -0700
@@ -129,7 +129,6 @@ static int agent_mad_send(struct ib_mad_
 		goto out;
 	agent_send_wr->mad = mad_priv;
 
-	/* PCI mapping */
 	gather_list.addr = dma_map_single(mad_agent->device->dma_device,
 					  &mad_priv->mad,
 					  sizeof(mad_priv->mad),
@@ -261,7 +260,6 @@ static void agent_send_handler(struct ib
 	list_del(&agent_send_wr->send_list);
 	spin_unlock_irqrestore(&port_priv->send_list_lock, flags);
 
-	/* Unmap PCI */
 	dma_unmap_single(mad_agent->device->dma_device,
 			 pci_unmap_addr(agent_send_wr, mapping),
 			 sizeof(agent_send_wr->mad->mad),
diff -puN drivers/infiniband/core/mad.c~ib-remove-incorrect-comments drivers/infiniband/core/mad.c
--- 25/drivers/infiniband/core/mad.c~ib-remove-incorrect-comments	2005-04-12 03:21:42.168726280 -0700
+++ 25-akpm/drivers/infiniband/core/mad.c	2005-04-12 03:21:42.173725520 -0700
@@ -2283,7 +2283,6 @@ static void cleanup_recv_queue(struct ib
 		/* Remove from posted receive MAD list */
 		list_del(&mad_list->list);
 
-		/* Undo PCI mapping */
 		dma_unmap_single(qp_info->port_priv->device->dma_device,
 				 pci_unmap_addr(&recv->header, mapping),
 				 sizeof(struct ib_mad_private) -
_
