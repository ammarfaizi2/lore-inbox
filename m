Return-Path: <linux-kernel-owner+w=401wt.eu-S1947517AbWLHX6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947517AbWLHX6o (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947529AbWLHX6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:58:43 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37382 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947519AbWLHX61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:58:27 -0500
Message-Id: <20061208235942.464993000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:57:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [patch 08/32] cryptoloop: Select CRYPTO_CBC
Content-Disposition: inline; filename=cryptoloop-select-crypto_cbc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

As CBC is the default chaining method for cryptoloop, we should select
it from cryptoloop to ease the transition.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/block/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19.orig/drivers/block/Kconfig
+++ linux-2.6.19/drivers/block/Kconfig
@@ -305,6 +305,7 @@ config BLK_DEV_LOOP
 config BLK_DEV_CRYPTOLOOP
 	tristate "Cryptoloop Support"
 	select CRYPTO
+	select CRYPTO_CBC
 	depends on BLK_DEV_LOOP
 	---help---
 	  Say Y here if you want to be able to use the ciphers that are 

--
