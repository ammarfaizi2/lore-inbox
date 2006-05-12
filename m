Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWELXpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWELXpI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWELXoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:54 -0400
Received: from mx.pathscale.com ([64.160.42.68]:682 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932297AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 53 of 53] ipath - add memory barrier when waiting for writes
X-Mercurial-Node: f8ebb8c1e43635081b735c19335fd2fa19f9a6e3
Message-Id: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:38 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r fd9bdeea5b10 -r f8ebb8c1e436 drivers/infiniband/hw/ipath/ipath_eeprom.c
--- a/drivers/infiniband/hw/ipath/ipath_eeprom.c	Fri May 12 16:42:39 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_eeprom.c	Fri May 12 16:42:39 2006 -0700
@@ -185,6 +185,7 @@ bail:
  */
 static void i2c_wait_for_writes(struct ipath_devdata *dd)
 {
+	mb();
 	(void)ipath_read_kreg32(dd, dd->ipath_kregs->kr_scratch);
 }
 
