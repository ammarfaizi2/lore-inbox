Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWCJAkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWCJAkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbWCJAgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:36:33 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17806 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1752156AbWCJAfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:35:50 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 19 of 20] ipath - integrate driver into infiniband kbuild
	infrastructure
X-Mercurial-Node: d5a8cb977923d96c11ede00efdd9aded5a7940bf
Message-Id: <d5a8cb977923d96c11ed.1141950949@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1141950930@eng-12.pathscale.com>
Date: Thu,  9 Mar 2006 16:35:49 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 867a396dd518 -r d5a8cb977923 drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig	Thu Mar  9 16:17:00 2006 -0800
+++ b/drivers/infiniband/Kconfig	Thu Mar  9 16:17:14 2006 -0800
@@ -30,6 +30,7 @@ config INFINIBAND_USER_ACCESS
 	  <http://www.openib.org>.
 
 source "drivers/infiniband/hw/mthca/Kconfig"
+source "drivers/infiniband/hw/ipath/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
diff -r 867a396dd518 -r d5a8cb977923 drivers/infiniband/Makefile
--- a/drivers/infiniband/Makefile	Thu Mar  9 16:17:00 2006 -0800
+++ b/drivers/infiniband/Makefile	Thu Mar  9 16:17:14 2006 -0800
@@ -1,4 +1,5 @@ obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
+obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
