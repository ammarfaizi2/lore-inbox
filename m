Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbVFXEIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVFXEIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbVFXEHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:07:02 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263097AbVFXEEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:24 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 08/14] IB/mthca: Fix memset size
In-Reply-To: <2005623214.1YZfsHaBvXkxQMAb@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.G1df9mxuEjBWFXr4@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0948 (UTC) FILETIME=[CC9E2140:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memset to use sizeof *props instead of just sizeof props.

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_provider.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-23 13:03:02.629547920 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-23 13:03:06.413728929 -0700
@@ -53,7 +53,7 @@ static int mthca_query_device(struct ib_
 	if (!in_mad || !out_mad)
 		goto out;
 
-	memset(props, 0, sizeof props);
+	memset(props, 0, sizeof *props);
 
 	props->fw_ver              = mdev->fw_ver;
 

