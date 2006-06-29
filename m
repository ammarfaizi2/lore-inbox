Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWF2Po3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWF2Po3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWF2Po2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:44:28 -0400
Received: from [141.84.69.5] ([141.84.69.5]:35342 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S1750815AbWF2Po2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:44:28 -0400
Date: Thu, 29 Jun 2006 17:43:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@karaya.com, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
       blaisorblade@yahoo.it
Subject: [RFC: 2.6 patch] fix the INIT_ENV_ARG_LIMIT dependencies
Message-ID: <20060629154326.GB19712@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the INIT_ENV_ARG_LIMIT dependencies to what seems to 
have been intended.

Spotted by Jean-Luc Leger.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

---

This patch was already sent on:
- 15 Apr 2006

--- linux-2.6.17-rc1-mm2-full/init/Kconfig.old	2006-04-15 16:26:46.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/init/Kconfig	2006-04-15 16:27:12.000000000 +0200
@@ -46,8 +46,8 @@
 
 config INIT_ENV_ARG_LIMIT
 	int
-	default 32 if !USERMODE
-	default 128 if USERMODE
+	default 32 if !UML
+	default 128 if UML
 	help
 	  Maximum of each of the number of arguments and environment
 	  variables passed to init from the kernel command line.
