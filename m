Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317445AbSFMEV6>; Thu, 13 Jun 2002 00:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSFMEV5>; Thu, 13 Jun 2002 00:21:57 -0400
Received: from newman.edw2.uc.edu ([129.137.2.198]:57362 "EHLO smtp.uc.edu")
	by vger.kernel.org with ESMTP id <S317445AbSFMEV5>;
	Thu, 13 Jun 2002 00:21:57 -0400
From: kuebelr@email.uc.edu
Date: Thu, 13 Jun 2002 00:21:51 -0400
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] 3c509.c - 1/2
Message-Id: <20020613042151.GA12340@cartman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch clears up another defined but not used compiler warning.
nopnp is not used when niether CONFIG_ISAPNP or CONFIG_ISAPNP_MODULE are
defined.

Patch is agains 2.4.19-pre10.

Rob.

--- linux-clean/drivers/net/3c509.c     Fri Jun  7 23:41:59 2002
+++ linux-dirty/drivers/net/3c509.c     Thu Jun 13 00:16:46 2002
@@ -234,8 +234,8 @@
 
 
 static u16 el3_isapnp_phys_addr[8][3];
-#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 static int nopnp;
+#endif /* CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE */
 
 int __init el3_probe(struct net_device *dev, int card_idx)
 {
