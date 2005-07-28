Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVG1UgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVG1UgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVG1Ud6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:33:58 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:23839 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S261664AbVG1UcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:32:05 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 1/2] [IB/cm]: Correct CM port redirect reject codes
In-Reply-To: <20057281331.dR47KhjBsU48JfGE@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 28 Jul 2005 13:31:45 -0700
Message-Id: <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 28 Jul 2005 20:31:56.0855 (UTC) FILETIME=[65EF7C70:01C593B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reject code 24 is port and CM redirection, not just port redirection.
Port redirection alone is code 25.

Therefore we should rename code 24 to IB_CM_REJ_PORT_CM_REDIRECT and
use IB_CM_REJ_PORT_REDIRECT for code 25.

Signed-off-by: Roland Dreier <rolandd@cisco.com>
---

 drivers/infiniband/include/ib_cm.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

4e38d36d88ead4e56f3155573976da84d5df18b3
diff --git a/drivers/infiniband/include/ib_cm.h b/drivers/infiniband/include/ib_cm.h
--- a/drivers/infiniband/include/ib_cm.h
+++ b/drivers/infiniband/include/ib_cm.h
@@ -169,7 +169,8 @@ enum ib_cm_rej_reason {
 	IB_CM_REJ_INVALID_ALT_TRAFFIC_CLASS	= __constant_htons(21),
 	IB_CM_REJ_INVALID_ALT_HOP_LIMIT		= __constant_htons(22),
 	IB_CM_REJ_INVALID_ALT_PACKET_RATE	= __constant_htons(23),
-	IB_CM_REJ_PORT_REDIRECT			= __constant_htons(24),
+	IB_CM_REJ_PORT_CM_REDIRECT		= __constant_htons(24),
+	IB_CM_REJ_PORT_REDIRECT			= __constant_htons(25),
 	IB_CM_REJ_INVALID_MTU			= __constant_htons(26),
 	IB_CM_REJ_INSUFFICIENT_RESP_RESOURCES	= __constant_htons(27),
 	IB_CM_REJ_CONSUMER_DEFINED		= __constant_htons(28),
