Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWHMVCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWHMVCE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWHMVCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 17:02:01 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10766 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751487AbWHMVBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 17:01:51 -0400
Date: Sun, 13 Aug 2006 23:01:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, herbert@gondor.apana.org.au,
       davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [-mm patch] Kconfig: move CRYPTO to the "Cryptographic options" menu
Message-ID: <20060813210149.GR3543@stusta.de>
References: <20060813012454.f1d52189.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813012454.f1d52189.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 13, 2006 at 01:24:54AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc3-mm2:
>...
>  git-cpufreq.patch
>...
>  git trees
>...

This patch moves the CRYPTO option to the "Cryptographic options" menu
(it was the only option directly in the toplevel menu).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 crypto/Kconfig |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.18-rc4-mm1/crypto/Kconfig.old	2006-08-13 21:13:38.000000000 +0200
+++ linux-2.6.18-rc4-mm1/crypto/Kconfig	2006-08-13 21:14:24.000000000 +0200
@@ -2,6 +2,8 @@
 # Cryptographic API Configuration
 #
 
+menu "Cryptographic options"
+
 config CRYPTO
 	bool "Cryptographic API"
 	help
@@ -9,8 +11,6 @@
 
 if CRYPTO
 
-menu "Cryptographic options"
-
 config CRYPTO_LOWAPI
 	tristate
 
@@ -402,6 +402,6 @@
 
 source "drivers/crypto/Kconfig"
 
-endmenu
+endif	# if CRYPTO
 
-endif	# if CRYPTO
+endmenu

