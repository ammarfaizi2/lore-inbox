Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268527AbTGNN1M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270129AbTGNNUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:20:43 -0400
Received: from [203.94.130.164] ([203.94.130.164]:44712 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S268527AbTGNNTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:19:54 -0400
Date: Mon, 14 Jul 2003 23:02:39 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [TRIVIAL] cryptoloop in 2.6.0-test1
Message-ID: <Pine.LNX.4.44.0307142258570.7337-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

Compiling cryptoloop as a module showed up the need for this patch

thanks,

	/ Brett

--- drivers/block/Kconfig.old	2003-07-14 18:41:20.000000000 +1000
+++ drivers/block/Kconfig	2003-07-14 18:41:48.000000000 +1000
@@ -264,6 +264,7 @@
 
 config BLK_DEV_CRYPTOLOOP
 	tristate "Cryptoloop Support"
+	select CRYPTO
 	depends on BLK_DEV_LOOP
 	---help---
 	  Say Y here if you want to be able to use the ciphers that are 


