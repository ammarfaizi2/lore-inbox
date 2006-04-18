Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbWDRWPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbWDRWPh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 18:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWDRWPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 18:15:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:14090 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750768AbWDRWPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 18:15:36 -0400
Date: Wed, 19 Apr 2006 00:15:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: rolandd@cisco.com, mshefty@ichips.intel.com, halr@voltaire.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/infiniband/hw/mthca/mthca_mad.c: make a function static
Message-ID: <20060418221535.GX11582@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global mthca_update_rate() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm3-full/drivers/infiniband/hw/mthca/mthca_mad.c.old	2006-04-18 21:38:06.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/infiniband/hw/mthca/mthca_mad.c	2006-04-18 21:38:14.000000000 +0200
@@ -49,7 +49,7 @@
 	MTHCA_VENDOR_CLASS2 = 0xa
 };
 
-int mthca_update_rate(struct mthca_dev *dev, u8 port_num)
+static int mthca_update_rate(struct mthca_dev *dev, u8 port_num)
 {
 	struct ib_port_attr *tprops = NULL;
 	int                  ret;

