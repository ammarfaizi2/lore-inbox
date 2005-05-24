Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVEXWWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVEXWWo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 18:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVEXWVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 18:21:30 -0400
Received: from webmail.topspin.com ([12.162.17.3]:21691 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261321AbVEXWU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 18:20:59 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 2/2] IB: fix endianness of path record MTU field
In-Reply-To: <20055241520.C8dwwpEn6S7vuoR1@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 24 May 2005 15:20:58 -0700
Message-Id: <20055241520.iUNmdsvhnuuiTq8m@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 May 2005 22:20:58.0088 (UTC) FILETIME=[DBF6AE80:01C560AE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make MTU field in SA PathRecord and MCMemberRecord a u8 rather than an
enum to avoid complications with endianness.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 drivers/infiniband/include/ib_sa.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)



--- linux-git.orig/drivers/infiniband/include/ib_sa.h	2005-05-24 15:15:55.076280598 -0700
+++ linux-git/drivers/infiniband/include/ib_sa.h	2005-05-24 15:17:41.485086202 -0700
@@ -147,7 +147,7 @@
 	/* reserved */
 	u8           sl;
 	u8           mtu_selector;
-	enum ib_mtu  mtu;
+	u8           mtu;
 	u8           rate_selector;
 	u8           rate;
 	u8           packet_life_time_selector;
@@ -180,7 +180,7 @@
 	u32          qkey;
 	u16          mlid;
 	u8           mtu_selector;
-	enum         ib_mtu mtu;
+	u8           mtu;
 	u8           traffic_class;
 	u16          pkey;
 	u8 	     rate_selector;

