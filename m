Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVL2Ajl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVL2Ajl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 19:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVL2Ajj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 19:39:39 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53992 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964944AbVL2AjK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 19:39:10 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 20 of 20] ipath - integrate driver into infiniband kbuild
	infrastructure
X-Mercurial-Node: 914136b2b8eed9417ce64b15deab02974cb1029c
Message-Id: <914136b2b8eed9417ce6.1135816299@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1135816279@eng-12.pathscale.com>
Date: Wed, 28 Dec 2005 16:31:39 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 07bf9f34e221 -r 914136b2b8ee drivers/infiniband/Kconfig
--- a/drivers/infiniband/Kconfig	Wed Dec 28 14:19:43 2005 -0800
+++ b/drivers/infiniband/Kconfig	Wed Dec 28 14:19:43 2005 -0800
@@ -30,6 +30,7 @@
 	  <http://www.openib.org>.
 
 source "drivers/infiniband/hw/mthca/Kconfig"
+source "drivers/infiniband/hw/ipath/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
diff -r 07bf9f34e221 -r 914136b2b8ee drivers/infiniband/Makefile
--- a/drivers/infiniband/Makefile	Wed Dec 28 14:19:43 2005 -0800
+++ b/drivers/infiniband/Makefile	Wed Dec 28 14:19:43 2005 -0800
@@ -1,4 +1,5 @@
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
+obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
