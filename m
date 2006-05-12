Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWEMADJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWEMADJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 20:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbWEMACz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 20:02:55 -0400
Received: from mx.pathscale.com ([64.160.42.68]:55209 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932204AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 53] ipath - fix reporting of driver version to userspace
X-Mercurial-Node: 176d1f0c26a3d2464eea0d6dac9fbe4b2c459e82
Message-Id: <176d1f0c26a3d2464eea.1147477381@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:01 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the interface version that gets exported to userspace.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 480ceff18a88 -r 176d1f0c26a3 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Fri May 12 15:55:28 2006 -0700
@@ -139,7 +139,7 @@ static int ipath_get_base_info(struct ip
 	kinfo->spi_piosize = dd->ipath_ibmaxlen;
 	kinfo->spi_mtu = dd->ipath_ibmaxlen;	/* maxlen, not ibmtu */
 	kinfo->spi_port = pd->port_port;
-	kinfo->spi_sw_version = IPATH_USER_SWVERSION;
+	kinfo->spi_sw_version = IPATH_KERN_SWVERSION;
 	kinfo->spi_hw_version = dd->ipath_revision;
 
 	if (copy_to_user(ubase, kinfo, sizeof(*kinfo)))
