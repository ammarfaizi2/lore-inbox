Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVHHWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVHHWfX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVHHWbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:31:09 -0400
Received: from coderock.org ([193.77.147.115]:34691 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932305AbVHHWat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:49 -0400
Message-Id: <20050808223030.935446000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:44 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 08/16] tulip/de4x5: list_for_each
Content-Disposition: inline; filename=list-for-each-drivers_net_tulip_de4x5.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



s/for/list_for_each/

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 de4x5.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt/drivers/net/tulip/de4x5.c
===================================================================
--- quilt.orig/drivers/net/tulip/de4x5.c
+++ quilt/drivers/net/tulip/de4x5.c
@@ -2144,9 +2144,9 @@ srom_search(struct net_device *dev, stru
     u_long iobase = 0;                     /* Clear upper 32 bits in Alphas */
     int i, j, cfrv;
     struct de4x5_private *lp = netdev_priv(dev);
-    struct list_head *walk = &pdev->bus_list;
+    struct list_head *walk;
 
-    for (walk = walk->next; walk != &pdev->bus_list; walk = walk->next) {
+    list_for_each(walk, &pdev->bus_list) {
 	struct pci_dev *this_dev = pci_dev_b(walk);
 
 	/* Skip the pci_bus list entry */

--
