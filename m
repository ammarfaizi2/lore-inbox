Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272551AbTHKNjP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272584AbTHKNjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:39:15 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:29913
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S272551AbTHKNjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:39:08 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: linux-kernel@vger.kernel.org
Subject: [PATCH][TRIVIAL] BINFMT_ZFLAT is boolean, don't test for =m.
Date: Mon, 11 Aug 2003 04:03:32 -0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308110403.36319.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A boolean can't be set to "m".

Rob

--- old-kconfig/lib/Kconfig	2003-07-27 13:03:20.000000000 -0400
+++ linux-2.6.0-test2/lib/Kconfig	2003-08-11 04:00:24.000000000 -0400
@@ -18,7 +18,7 @@
 config ZLIB_INFLATE
 	tristate
 	default y if CRAMFS=y || PPP_DEFLATE=y || JFFS2_FS=y || ZISOFS_FS=y || BINFMT_ZFLAT=y || CRYPTO_DEFLATE=y
-	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || BINFMT_ZFLAT=m || CRYPTO_DEFLATE=m
+	default m if CRAMFS=m || PPP_DEFLATE=m || JFFS2_FS=m || ZISOFS_FS=m || CRYPTO_DEFLATE=m
 
 config ZLIB_DEFLATE
 	tristate

