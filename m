Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261319AbVFVO11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261319AbVFVO11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 10:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbVFVO11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 10:27:27 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23280 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261319AbVFVO1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 10:27:03 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.30006.760838.986094@tut.ibm.com>
Date: Wed, 22 Jun 2005 09:27:02 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-mm1] relayfs: add private data to channel struct
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a field for clients to use as they wish, as suggested
by Mathieu Desnoyers.

Thanks,

Tom

Signed-off-by: Tom Zanussi <zanussi@us.ibm.com>

diff -urpN -X dontdiff linux-2.6.12-mm1/include/linux/relayfs_fs.h linux-2.6.12-mm1-cur/include/linux/relayfs_fs.h
--- linux-2.6.12-mm1/include/linux/relayfs_fs.h	2005-06-22 11:16:23.000000000 -0500
+++ linux-2.6.12-mm1-cur/include/linux/relayfs_fs.h	2005-06-22 11:39:12.000000000 -0500
@@ -59,6 +59,7 @@ struct rchan
 	int overwrite;			/* overwrite buffer when full? */
 	struct rchan_callbacks *cb;	/* client callbacks */
 	struct kref kref;		/* channel refcount */
+	void *private_data;		/* for user-defined data */
 	struct rchan_buf *buf[NR_CPUS]; /* per-cpu channel buffers */
 };
 


