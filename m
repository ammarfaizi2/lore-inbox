Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVEHUYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVEHUYP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262822AbVEHUXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:23:37 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:62614 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262771AbVEHTJ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:09:56 -0400
Message-Id: <20050508184348.191994000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:52 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-fe-dvb-pll-include.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 23/37] dvb-pll.h: prevent multiple inclusion
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

added missing #ifndef and #define to inhibit multiple inclusions (Patrick Boettcher)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/frontends/dvb-pll.h |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/frontends/dvb-pll.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/frontends/dvb-pll.h	2005-05-08 15:55:37.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/frontends/dvb-pll.h	2005-05-08 16:31:55.000000000 +0200
@@ -2,6 +2,9 @@
  * $Id: dvb-pll.h,v 1.2 2005/02/10 11:43:41 kraxel Exp $
  */
 
+#ifndef __DVB_PLL_H__
+#define __DVB_PLL_H__
+
 struct dvb_pll_desc {
 	char *name;
 	u32  min;
@@ -26,9 +29,4 @@ extern struct dvb_pll_desc dvb_pll_unkno
 int dvb_pll_configure(struct dvb_pll_desc *desc, u8 *buf,
 		      u32 freq, int bandwidth);
 
-/*
- * Local variables:
- * c-basic-offset: 8
- * compile-command: "make DVB=1"
- * End:
- */
+#endif

--

