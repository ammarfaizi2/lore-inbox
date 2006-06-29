Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932856AbWF2WC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932856AbWF2WC7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933015AbWF2WC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:02:56 -0400
Received: from mx.pathscale.com ([64.160.42.68]:32655 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932856AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 7 of 39] IB/ipath - update some comments and fix typos
X-Mercurial-Node: 8f08597cacd2a9dcea281d6798934c59b4ce78e3
Message-Id: <8f08597cacd2a9dcea28.1151617258@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:58 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Walsh <robert.walsh@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 600ceb6aeb8c -r 8f08597cacd2 drivers/infiniband/hw/ipath/ipath_kernel.h
--- a/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_kernel.h	Thu Jun 29 14:33:25 2006 -0700
@@ -723,13 +723,8 @@ u64 ipath_read_kreg64_port(const struct 
  * @port: port number
  *
  * Return the contents of a register that is virtualized to be per port.
- * Prints a debug message and returns -1 on errors (not distinguishable from
- * valid contents at runtime; we may add a separate error variable at some
- * point).
- *
- * This is normally not used by the kernel, but may be for debugging, and
- * has a different implementation than user mode, which is why it's not in
- * _common.h.
+ * Returns -1 on errors (not distinguishable from valid contents at
+ * runtime; we may add a separate error variable at some point).
  */
 static inline u32 ipath_read_ureg32(const struct ipath_devdata *dd,
 				    ipath_ureg regno, int port)
diff -r 600ceb6aeb8c -r 8f08597cacd2 drivers/infiniband/hw/ipath/ipath_layer.c
--- a/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_layer.c	Thu Jun 29 14:33:25 2006 -0700
@@ -885,7 +885,7 @@ static void copy_io(u32 __iomem *piobuf,
 /**
  * ipath_verbs_send - send a packet from the verbs layer
  * @dd: the infinipath device
- * @hdrwords: the number of works in the header
+ * @hdrwords: the number of words in the header
  * @hdr: the packet header
  * @len: the length of the packet in bytes
  * @ss: the SGE to send
