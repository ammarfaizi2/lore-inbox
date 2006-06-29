Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932922AbWF2Vqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbWF2Vqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932833AbWF2VoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:16 -0400
Received: from mx.pathscale.com ([64.160.42.68]:32911 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932862AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 8 of 39] IB/ipath - remove some duplicate code
X-Mercurial-Node: 08114201137114764a8337458d120795d995947c
Message-Id: <08114201137114764a83.1151617259@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:59 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Walsh <robert.walsh@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 8f08597cacd2 -r 081142011371 drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Thu Jun 29 14:33:25 2006 -0700
@@ -511,9 +511,6 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 	if (attr_mask & IB_QP_QKEY)
 		qp->qkey = attr->qkey;
 
-	if (attr_mask & IB_QP_PKEY_INDEX)
-		qp->s_pkey_index = attr->pkey_index;
-
 	qp->state = new_state;
 	spin_unlock(&qp->s_lock);
 	spin_unlock_irqrestore(&qp->r_rq.lock, flags);
