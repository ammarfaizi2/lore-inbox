Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268892AbUH3TnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268892AbUH3TnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268847AbUH3TnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:43:17 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:521 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S268882AbUH3Tlu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:41:50 -0400
Date: Mon, 30 Aug 2004 21:43:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Update help text
Message-ID: <20040830194335.GD18518@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040830193915.GA18518@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040830193915.GA18518@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/30 21:23:24+02:00 sam@mars.ravnborg.org 
#   kbuild: Add stactic analyser tools to make help
#   
#   Added the tools that seems to be maintained.
#   There is a bunch that has not been touched for a while - ignore them for now.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/08/30 21:23:05+02:00 sam@mars.ravnborg.org +9 -3
#   Updated help and use $(srctree) as replacement for $(src)
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-30 21:26:19 +02:00
+++ b/Makefile	2004-08-30 21:26:20 +02:00
@@ -963,7 +963,13 @@
 	@echo  '  rpm		  - Build a kernel as an RPM package'
 	@echo  '  tags/TAGS	  - Generate tags file for editors'
 	@echo  '  cscope	  - Generate cscope index'
+	@echo  ''
+	@echo  'Static analysers'
+	@echo  '  buildcheck      - List dangling references to vmlinux discarded sections'
+	@echo  '                    and init sections from non-init sections'
 	@echo  '  checkstack      - Generate a list of stack hogs'
+	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
+	@echo  ''
 	@echo  'Kernel packaging:'
 	@$(MAKE) -f $(package-dir)/Makefile help
 	@echo  ''
@@ -1123,11 +1129,11 @@
 		| xargs $(PERL) -w scripts/checkversion.pl
 
 buildcheck:
-	$(PERL) $(src)/scripts/reference_discarded.pl
-	$(PERL) $(src)/scripts/reference_init.pl
+	$(PERL) $(srctree)/scripts/reference_discarded.pl
+	$(PERL) $(srctree)/scripts/reference_init.pl
 
 namespacecheck:
-	$(PERL) $(src)/scripts/namespace.pl
+	$(PERL) $(srctree)/scripts/namespace.pl
 
 endif #ifeq ($(config-targets),1)
 endif #ifeq ($(mixed-targets),1)
