Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932312AbVJaLOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVJaLOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVJaLOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:14:21 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:23814 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932312AbVJaLOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:14:01 -0500
Date: Mon, 31 Oct 2005 12:13:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: sfrench@samba.org
Cc: samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] let CIFS_EXPERIMENTAL depend on EXPERIMENTAL
Message-ID: <20051031111359.GI8009@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems logical.

Note that CONFIG_EXPERIMENTAL itself doesn't enable any code.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Jul 2005

--- linux-2.6.13-rc3-mm1-modular/fs/Kconfig.old	2005-07-21 13:52:49.000000000 +0200
+++ linux-2.6.13-rc3-mm1-modular/fs/Kconfig	2005-07-21 13:53:11.000000000 +0200
@@ -1804,7 +1804,7 @@
 
 config CIFS_EXPERIMENTAL
 	  bool "CIFS Experimental Features (EXPERIMENTAL)"
-	  depends on CIFS
+	  depends on CIFS && EXPERIMENTAL
 	  help
 	    Enables cifs features under testing. These features
 	    are highly experimental.  If unsure, say N.

