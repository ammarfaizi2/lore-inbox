Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVLVEuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVLVEuc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVLVEuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:50:15 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22480 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965056AbVLVEtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:49:40 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 07/36] m68k: Kconfig fix (mac vs. FONTS)
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIOZ-0004qS-GO@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:49:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1133442739 -0500

mac won't build without non-modular FONTS, which requires non-modular
FB and FRAMEBUFFER_CONSOLE

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/m68k/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

052b81bd0ced337e6ca5bb59c584f9561054b223
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 1dd5d18..83d552a 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -131,6 +131,8 @@ config PCI
 config MAC
 	bool "Macintosh support"
 	depends on !MMU_SUN3
+	select FRAMEBUFFER_CONSOLE
+	select FB
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
-- 
0.99.9.GIT

