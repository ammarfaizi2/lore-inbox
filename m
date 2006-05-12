Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWEMACx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWEMACx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWEMAC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:02:29 -0400
Received: from mx.pathscale.com ([64.160.42.68]:54953 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932185AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 15 of 53] ipath - make some maximum values more sane
X-Mercurial-Node: 480ceff18a886d7504a5e59488b249add94aaab4
Message-Id: <480ceff18a886d7504a5.1147477380@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:00 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the limits on some maximum values.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 5d9fbba3222e -r 480ceff18a88 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:28 2006 -0700
@@ -64,21 +64,21 @@ module_param_named(max_ahs, ib_ipath_max
 module_param_named(max_ahs, ib_ipath_max_ahs, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_ahs, "Maximum number of address handles to support");
 
-unsigned int ib_ipath_max_cqes = 0xFFFF;
+unsigned int ib_ipath_max_cqes = 0x2FFFF;
 module_param_named(max_cqes, ib_ipath_max_cqes, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_cqes,
 		 "Maximum number of completion queue entries to support");
 
-unsigned int ib_ipath_max_cqs = 0xFFFF;
+unsigned int ib_ipath_max_cqs = 0x1FFFF;
 module_param_named(max_cqs, ib_ipath_max_cqs, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_cqs, "Maximum number of completion queues to support");
 
-unsigned int ib_ipath_max_qp_wrs = 255;
+unsigned int ib_ipath_max_qp_wrs = 0x1FFFF;
 module_param_named(max_qp_wrs, ib_ipath_max_qp_wrs, uint,
 		   S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
 
-unsigned int ib_ipath_max_sges = 255;
+unsigned int ib_ipath_max_sges = 0xFF;
 module_param_named(max_sges, ib_ipath_max_sges, uint, S_IWUSR | S_IRUGO);
 MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
 
