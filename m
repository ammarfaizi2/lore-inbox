Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbVDAS2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbVDAS2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262845AbVDAS13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:27:29 -0500
Received: from webmail.topspin.com ([12.162.17.3]:34971 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262846AbVDASZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:25:10 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][6/6] IB: Remove incorrect comments
In-Reply-To: <2005411023.Wt2K1CXaZGIHp9sH@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 10:23:51 -0800
Message-Id: <2005411023.sEUedyez566a4lDQ@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 18:23:51.0550 (UTC) FILETIME=[F46481E0:01C536E7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hal Rosenstock <halr@voltaire.com>

Eliminate unneeded and misleading comments

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/core/agent.c	2005-03-31 19:06:48.000000000 -0800
+++ linux-export/drivers/infiniband/core/agent.c	2005-04-01 10:09:02.621290525 -0800
@@ -129,7 +129,6 @@
 		goto out;
 	agent_send_wr->mad = mad_priv;
 
-	/* PCI mapping */
 	gather_list.addr = dma_map_single(mad_agent->device->dma_device,
 					  &mad_priv->mad,
 					  sizeof(mad_priv->mad),
@@ -261,7 +260,6 @@
 	list_del(&agent_send_wr->send_list);
 	spin_unlock_irqrestore(&port_priv->send_list_lock, flags);
 
-	/* Unmap PCI */
 	dma_unmap_single(mad_agent->device->dma_device,
 			 pci_unmap_addr(agent_send_wr, mapping),
 			 sizeof(agent_send_wr->mad->mad),
--- linux-export.orig/drivers/infiniband/core/mad.c	2005-04-01 10:08:56.473624910 -0800
+++ linux-export/drivers/infiniband/core/mad.c	2005-04-01 10:09:02.768258624 -0800
@@ -2283,7 +2283,6 @@
 		/* Remove from posted receive MAD list */
 		list_del(&mad_list->list);
 
-		/* Undo PCI mapping */
 		dma_unmap_single(qp_info->port_priv->device->dma_device,
 				 pci_unmap_addr(&recv->header, mapping),
 				 sizeof(struct ib_mad_private) -

