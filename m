Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTBTMo3>; Thu, 20 Feb 2003 07:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBTMnt>; Thu, 20 Feb 2003 07:43:49 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:35512 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265369AbTBTMng>; Thu, 20 Feb 2003 07:43:36 -0500
Date: Thu, 20 Feb 2003 14:49:48 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix bug 376 - tiny extra echo in Makefile
Message-ID: <20030220124948.GC17614@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=376

It's not really a bug, which means this isn't really a fix, but it
does make things more consistent. Please consider for inclusion or let
me know you aren't interested so I can close the bug. Thanks. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1004  -> 1.1005 
#	            Makefile	1.362   -> 1.363  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/20	mulix@alhambra.mulix.org	1.1005
# don't print the echo command when printing 'Generating build number'
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Thu Feb 20 13:40:59 2003
+++ b/Makefile	Thu Feb 20 13:40:59 2003
@@ -325,7 +325,7 @@
 define rule_vmlinux__
 	set -e
 	$(if $(filter .tmp_kallsyms%,$^),,
-	  echo '  Generating build number'
+	  @echo '  Generating build number'
 	  . $(src)/scripts/mkversion > .tmp_version
 	  mv -f .tmp_version .version
 	  $(Q)$(MAKE) $(build)=init



-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

