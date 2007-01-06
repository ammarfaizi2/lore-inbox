Return-Path: <linux-kernel-owner+w=401wt.eu-S1751093AbXAFCZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXAFCZ6 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbXAFCZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:25:58 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:47750 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbXAFCZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:25:57 -0500
Message-Id: <20070106022857.222067000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:27:54 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Rene Herman <rene.herman@gmail.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>
Subject: [patch 01/50] dm-crypt: Select CRYPTO_CBC
Content-Disposition: inline; filename=dm-crypt-select-crypto_cbc.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Herbert Xu <herbert@gondor.apana.org.au>

As CBC is the default chaining method for cryptoloop, we should select
it from cryptoloop to ease the transition.  Spotted by Rene Herman.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/md/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.19.1.orig/drivers/md/Kconfig
+++ linux-2.6.19.1/drivers/md/Kconfig
@@ -215,6 +215,7 @@ config DM_CRYPT
 	tristate "Crypt target support"
 	depends on BLK_DEV_DM && EXPERIMENTAL
 	select CRYPTO
+	select CRYPTO_CBC
 	---help---
 	  This device-mapper target allows you to create a device that
 	  transparently encrypts the data on it. You'll need to activate

--
