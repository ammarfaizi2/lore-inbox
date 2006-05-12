Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWELX5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWELX5z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWELX5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:42 -0400
Received: from mx.pathscale.com ([64.160.42.68]:57513 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932217AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 25 of 53] ipath - remove some duplicated lines of code
X-Mercurial-Node: 2b7918a7133eafcc21bb932abe7dbfc650c1cbce
Message-Id: <2b7918a7133eafcc21bb.1147477390@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:10 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic fixes.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r e468ad0bd83e -r 2b7918a7133e drivers/infiniband/hw/ipath/ipath_ht400.c
--- a/drivers/infiniband/hw/ipath/ipath_ht400.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_ht400.c	Fri May 12 15:55:28 2006 -0700
@@ -1555,7 +1555,6 @@ void ipath_init_ht400_funcs(struct ipath
 	dd->ipath_f_reset = ipath_setup_ht_reset;
 	dd->ipath_f_get_boardname = ipath_ht_boardname;
 	dd->ipath_f_init_hwerrors = ipath_ht_init_hwerrors;
-	dd->ipath_f_init_hwerrors = ipath_ht_init_hwerrors;
 	dd->ipath_f_early_init = ipath_ht_early_init;
 	dd->ipath_f_handle_hwerrors = ipath_ht_handle_hwerrors;
 	dd->ipath_f_quiet_serdes = ipath_ht_quiet_serdes;
diff -r e468ad0bd83e -r 2b7918a7133e drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri May 12 15:55:28 2006 -0700
@@ -513,9 +513,6 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 	if (attr_mask & IB_QP_QKEY)
 		qp->qkey = attr->qkey;
 
-	if (attr_mask & IB_QP_PKEY_INDEX)
-		qp->s_pkey_index = attr->pkey_index;
-
 	qp->state = new_state;
 	spin_unlock_irqrestore(&qp->s_lock, flags);
 
