Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVDJXW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVDJXW1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVDJXV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:21:58 -0400
Received: from hermes.domdv.de ([193.102.202.1]:520 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261641AbVDJXTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:19:23 -0400
Message-ID: <4259B47A.6020208@domdv.de>
Date: Mon, 11 Apr 2005 01:19:22 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: [PATCH encrypted swsusp 2/3] configuration
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050402010501070007020907"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050402010501070007020907
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

The following patch includes the necessary kernel configuration option.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de



--------------050402010501070007020907
Content-Type: text/plain;
 name="swsusp-encrypt-config.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-encrypt-config.diff"

--- linux-2.6.11.2/kernel/power/Kconfig.ast	2005-04-10 20:44:48.000000000 +0200
+++ linux-2.6.11.2/kernel/power/Kconfig	2005-04-10 21:01:36.000000000 +0200
@@ -72,3 +72,14 @@
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config SWSUSP_ENCRYPT
+	bool "Encrypt suspend image"
+	depends on SOFTWARE_SUSPEND && CRYPTO=y && (CRYPTO_AES=y || CRYPTO_AES_586=y)
+	default ""
+	---help---
+	  To prevent data gathering from swap after resume you can encrypt
+	  the suspend image with a temporary key that is deleted on
+	  resume.
+
+	  Note that the temporary key is stored unencrypted on disk while the
+	  system is suspended.



--------------050402010501070007020907--
