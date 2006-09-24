Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWIXVNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWIXVNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWIXVN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:27 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:7570 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932141AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 14/28] kbuild: preperly align SYSMAP output
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:10 +0200
Message-Id: <11591327053365-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327051652-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Align filenames for SYSMAP with other filenames

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index ccbc8c0..fc67adc 100644
--- a/Makefile
+++ b/Makefile
@@ -639,12 +639,12 @@ define rule_vmlinux__
 	$(call cmd,vmlinux__)
 	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 
-	$(Q)$(if $($(quiet)cmd_sysmap),                 \
-	  echo '  $($(quiet)cmd_sysmap) System.map' &&) \
-	$(cmd_sysmap) $@ System.map;                    \
-	if [ $$? -ne 0 ]; then                          \
-		rm -f $@;                               \
-		/bin/false;                             \
+	$(Q)$(if $($(quiet)cmd_sysmap),                                      \
+	  echo '  $($(quiet)cmd_sysmap)  System.map' &&)                     \
+	$(cmd_sysmap) $@ System.map;                                         \
+	if [ $$? -ne 0 ]; then                                               \
+		rm -f $@;                                                    \
+		/bin/false;                                                  \
 	fi;
 	$(verify_kallsyms)
 endef
@@ -677,12 +677,12 @@ endif
 kallsyms.o := .tmp_kallsyms$(last_kallsyms).o
 
 define verify_kallsyms
-	$(Q)$(if $($(quiet)cmd_sysmap),                       \
-	  echo '  $($(quiet)cmd_sysmap) .tmp_System.map' &&)  \
+	$(Q)$(if $($(quiet)cmd_sysmap),                                      \
+	  echo '  $($(quiet)cmd_sysmap)  .tmp_System.map' &&)                \
 	  $(cmd_sysmap) .tmp_vmlinux$(last_kallsyms) .tmp_System.map
-	$(Q)cmp -s System.map .tmp_System.map ||              \
-		(echo Inconsistent kallsyms data;             \
-		 echo Try setting CONFIG_KALLSYMS_EXTRA_PASS; \
+	$(Q)cmp -s System.map .tmp_System.map ||                             \
+		(echo Inconsistent kallsyms data;                            \
+		 echo Try setting CONFIG_KALLSYMS_EXTRA_PASS;                \
 		 rm .tmp_kallsyms* ; /bin/false )
 endef
 
-- 
1.4.1

