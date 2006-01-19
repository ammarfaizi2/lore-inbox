Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWASBks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWASBks (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWASBks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:40:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4106 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030415AbWASBks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:40:48 -0500
Date: Thu, 19 Jan 2006 02:40:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] don't allow users to set CONFIG_BROKEN=y
Message-ID: <20060119014046.GY19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allow people to create configurations with CONFIG_BROKEN=y.

The sole reason for CONFIG_BROKEN=y would be if you are working on 
fixing a broken driver, but in this case editing the Kconfig file is 
trivial.

Never ever should a user enable CONFIG_BROKEN.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Jan 2006
- 13 Dec 2005

--- linux-2.6.15-rc5-mm2-full/init/Kconfig.old	2005-12-13 18:48:40.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/init/Kconfig	2005-12-13 18:48:52.000000000 +0100
@@ -31,19 +31,8 @@
 	  you say Y here, you will be offered the choice of using features or
 	  drivers that are currently considered to be in the alpha-test phase.
 
-config CLEAN_COMPILE
-	bool "Select only drivers expected to compile cleanly" if EXPERIMENTAL
-	default y
-	help
-	  Select this option if you don't even want to see the option
-	  to configure known-broken drivers.
-
-	  If unsure, say Y
-
 config BROKEN
 	bool
-	depends on !CLEAN_COMPILE
-	default y
 
 config BROKEN_ON_SMP
 	bool

