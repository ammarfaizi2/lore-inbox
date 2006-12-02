Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162792AbWLBEqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162792AbWLBEqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 23:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162793AbWLBEqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 23:46:51 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:56710 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1162792AbWLBEqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 23:46:50 -0500
Date: Fri, 1 Dec 2006 23:39:34 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] crypto: cryptoloop requires CBC
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-stable <stable@kernel.org>
Message-ID: <200612012342_MC3-1-D39B-996E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel builds but cryptoloop won't work without CBC crypto
algorithm in kernel 2.6.19.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.19-32.orig/drivers/block/Kconfig
+++ 2.6.19-32/drivers/block/Kconfig
@@ -305,6 +305,7 @@ config BLK_DEV_LOOP
 config BLK_DEV_CRYPTOLOOP
 	tristate "Cryptoloop Support"
 	select CRYPTO
+	select CRYPTO_CBC
 	depends on BLK_DEV_LOOP
 	---help---
 	  Say Y here if you want to be able to use the ciphers that are 
-- 
Chuck
"Even supernovas have their duller moments."
