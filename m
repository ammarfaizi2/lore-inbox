Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030267AbWDOOai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbWDOOai (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 10:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbWDOOai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 10:30:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44046 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030267AbWDOOah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 10:30:37 -0400
Date: Sat, 15 Apr 2006 16:30:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jdike@karaya.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: [RFC: 2.6 patch] fix the INIT_ENV_ARG_LIMIT dependencies
Message-ID: <20060415143036.GI15022@stusta.de>
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
