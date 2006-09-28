Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbWI1QEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbWI1QEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWI1QCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:32 -0400
Received: from mx.pathscale.com ([64.160.42.68]:5302 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751930AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 26 of 28] IB/ipath - support new PCIE device, QLE7142
X-Mercurial-Node: 8b45b43df5adb4ea7dec01bd2965df7c49be3516
Message-Id: <8b45b43df5adb4ea7dec.1159459222@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:22 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 4269068599c2 -r 8b45b43df5ad drivers/infiniband/hw/ipath/ipath_iba6120.c
--- a/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_iba6120.c	Thu Sep 28 08:57:13 2006 -0700
@@ -538,6 +538,9 @@ static int ipath_pe_boardname(struct ipa
 	case 5:
 		n = "InfiniPath_QMH7140";
 		break;
+	case 6:
+		n = "InfiniPath_QLE7142";
+		break;
 	default:
 		ipath_dev_err(dd,
 			      "Don't yet know about board with ID %u\n",
