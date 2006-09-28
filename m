Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964964AbWI1QH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWI1QH7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964932AbWI1QHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:07:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2230 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751631AbWI1QBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:23 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 14 of 28] IB/ipath - Fix mismatch in shifts and masks for
	printing debug info
X-Mercurial-Node: 42f82d2c62bce5aa8ae08acacd509aeb2336a478
Message-Id: <42f82d2c62bce5aa8ae0.1159459210@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:10 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed mismatch in linkstate/trainingstate shifts and masks in the
IPATH_IBSTATE_MASK macro.  It kept some linktrainingstates
from being printed correctly in debug; no functionality issue unless
I misread the code.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 2a328f7db58f -r 42f82d2c62bc drivers/infiniband/hw/ipath/ipath_registers.h
--- a/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Sep 28 08:57:12 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_registers.h	Thu Sep 28 08:57:12 2006 -0700
@@ -223,9 +223,9 @@
 
 /* combination link status states that we use with some frequency */
 #define IPATH_IBSTATE_MASK ((INFINIPATH_IBCS_LINKTRAININGSTATE_MASK \
-		<< INFINIPATH_IBCS_LINKSTATE_SHIFT) | \
+		<< INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT) | \
 		(INFINIPATH_IBCS_LINKSTATE_MASK \
-		<<INFINIPATH_IBCS_LINKTRAININGSTATE_SHIFT))
+		<<INFINIPATH_IBCS_LINKSTATE_SHIFT))
 #define IPATH_IBSTATE_INIT ((INFINIPATH_IBCS_L_STATE_INIT \
 		<< INFINIPATH_IBCS_LINKSTATE_SHIFT) | \
 		(INFINIPATH_IBCS_LT_STATE_LINKUP \
