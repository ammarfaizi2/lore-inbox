Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261637AbULFUxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbULFUxO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 15:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbULFUxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 15:53:13 -0500
Received: from math.ut.ee ([193.40.5.125]:35465 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261637AbULFUxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 15:53:02 -0500
Date: Mon, 6 Dec 2004 22:52:58 +0200 (EET)
From: Riina Kikas <riinak@ut.ee>
To: linux-kernel@vger.kernel.org
cc: mroos@ut.ee
Subject: [PATCH 2.6] clean-up: fixes "shadows global" warning
Message-ID: <Pine.SOC.4.61.0412062251140.21075@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes warning "declaration of `errno' shadows a global declaration"
occuring on line 102

Signed-off-by: Riina Kikas <Riina.Kikas@mail.ee>

--- a/include/linux/nfsd/export.h	2004-08-14 10:55:33.000000000 +0000
+++ b/include/linux/nfsd/export.h	2004-10-31 19:01:15.000000000 +0000
@@ -99,7 +99,7 @@
  int			exp_rootfh(struct auth_domain *,
  					char *path, struct knfsd_fh *, int maxsize);
  int			exp_pseudoroot(struct auth_domain *, struct svc_fh *fhp, struct cache_req *creq);
-int			nfserrno(int errno);
+int			nfserrno(int errno_l);

  extern void expkey_put(struct cache_head *item, struct cache_detail *cd);
  extern void svc_export_put(struct cache_head *item, struct cache_detail *cd);
