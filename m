Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUIXDSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUIXDSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUIWUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:35:38 -0400
Received: from baikonur.stro.at ([213.239.196.228]:26061 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266903AbUIWU2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:28:34 -0400
Subject: [patch 3/4]  mark __init/__exit static 	drivers/net/bsd_comp
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:28:31 +0200
Message-ID: <E1CAaCd-0000dX-Oe@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



more static
aplies cleanly on 2.6.7-rc1, compile tested

a++ maks

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/net/bsd_comp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/net/bsd_comp.c~static-bsd_comp drivers/net/bsd_comp.c
--- linux-2.6.9-rc2-bk7/drivers/net/bsd_comp.c~static-bsd_comp	2004-09-21 20:46:59.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/net/bsd_comp.c	2004-09-21 20:47:00.000000000 +0200
@@ -1160,7 +1160,7 @@ static struct compressor ppp_bsd_compres
  * Module support routines
  *************************************************************/
 
-int __init bsdcomp_init(void)
+static int __init bsdcomp_init(void)
 {
 	int answer = ppp_register_compressor(&ppp_bsd_compress);
 	if (answer == 0)
@@ -1168,7 +1168,7 @@ int __init bsdcomp_init(void)
 	return answer;
 }
 
-void __exit bsdcomp_cleanup(void)
+static void __exit bsdcomp_cleanup(void)
 {
 	ppp_unregister_compressor(&ppp_bsd_compress);
 }
_
