Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261697AbVCGU50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbVCGU50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVCGU4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:56:41 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:12978 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261816AbVCGUNg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:36 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [1/many] acrypto: Kconfig
In-Reply-To: <1110227853910@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:33 +0300
Message-Id: <11102278531852@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru /tmp/empty/Kconfig ./acrypto/Kconfig
--- /tmp/empty/Kconfig	1970-01-01 03:00:00.000000000 +0300
+++ ./acrypto/Kconfig	2005-03-07 21:21:33.000000000 +0300
@@ -0,0 +1,30 @@
+menu "Asynchronous crypto layer"
+
+config ACRYPTO
+	tristate "Asynchronous crypto layer"
+	select CONNECTOR
+	--- help ---
+	It supports:
+	 - multiple asynchronous crypto device queues
+	 - crypto session routing
+	 - crypto session binding
+	 - modular load balancing
+	 - crypto session batching genetically implemented by design
+	 - crypto session priority
+	 - different kinds of crypto operation(RNG, asymmetrical crypto, HMAC and any other
+
+config SIMPLE_LB
+	tristate "Simple load balancer"
+	depends on ACRYPTO
+	--- help ---
+	Simple load balancer returns device with the lowest load
+	(device has the least number of session in it's queue) if it exists.
+
+config ASYNC_PROVIDER
+	tristate "Asynchronous crypto provider (AES CBC)"
+	depends on ACRYPTO && (CRYPTO_AES || CRYPTO_AES_586)
+	--- help ---
+	Asynchronous crypto provider based on synchronous crypto layer.
+	It supports AES CBC crypto mode (may be changed by source edition).
+
+endmenu

