Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWEWSdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWEWSdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 14:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWEWSdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 14:33:36 -0400
Received: from mx.pathscale.com ([64.160.42.68]:2231 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751208AbWEWSdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 14:33:35 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 3 of 10] ipath - fix reporting of driver version to userspace
X-Mercurial-Node: 386fe7306b31e98661611906e35cfcc8bbfd0815
Message-Id: <386fe7306b31e9866161.1148409151@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1148409148@eng-12.pathscale.com>
Date: Tue, 23 May 2006 11:32:31 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the interface version that gets exported to userspace.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r bb640dcf4d9d -r 386fe7306b31 drivers/infiniband/hw/ipath/ipath_file_ops.c
--- a/drivers/infiniband/hw/ipath/ipath_file_ops.c	Tue May 23 11:29:15 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_file_ops.c	Tue May 23 11:29:15 2006 -0700
@@ -139,7 +139,7 @@ static int ipath_get_base_info(struct ip
 	kinfo->spi_piosize = dd->ipath_ibmaxlen;
 	kinfo->spi_mtu = dd->ipath_ibmaxlen;	/* maxlen, not ibmtu */
 	kinfo->spi_port = pd->port_port;
-	kinfo->spi_sw_version = IPATH_USER_SWVERSION;
+	kinfo->spi_sw_version = IPATH_KERN_SWVERSION;
 	kinfo->spi_hw_version = dd->ipath_revision;
 
 	if (copy_to_user(ubase, kinfo, sizeof(*kinfo)))
