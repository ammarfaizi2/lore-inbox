Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWIXVRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWIXVRi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWIXVRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:38 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:9874 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932150AbWIXVNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:12 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 28/28] kbuild: add distclean info to 'make help' and more details for 'clean'
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:24 +0200
Message-Id: <11591327072290-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159132707316-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org> <1159132706126-git-send-email-sam@ravnborg.org> <11591327063625-git-send-email-sam@ravnborg.org> <11591327063733-git-send-email-sam@ravnborg.org> <11591327073816-git-send-email-sam@ravnborg.org> <11591327073393-git-send-email-sam@ravnborg.org> <1159132707316-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Add distclean info, that was previously missing, to 'make help'.
Also add a few more details to the 'make clean' help text.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 241fed3..fce530a 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,9 +1086,10 @@ boards := $(notdir $(boards))
 
 help:
 	@echo  'Cleaning targets:'
-	@echo  '  clean		  - remove most generated files but keep the config'
+	@echo  '  clean		  - remove most generated files but keep the config and'
+	@echo  '                    enough build support to build external modules'
 	@echo  '  mrproper	  - remove all generated files + config + various backup files'
-	@echo  '  distclean	  - mrproper + patch files'
+	@echo  '  distclean	  - mrproper + remove editor backup and patch files'
 	@echo  ''
 	@echo  'Configuration targets:'
 	@$(MAKE) -f $(srctree)/scripts/kconfig/Makefile help
-- 
1.4.1

