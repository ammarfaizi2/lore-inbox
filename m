Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbTBEEcU>; Tue, 4 Feb 2003 23:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267796AbTBEEcU>; Tue, 4 Feb 2003 23:32:20 -0500
Received: from [198.73.180.252] ([198.73.180.252]:64852 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267795AbTBEEcT>;
	Tue, 4 Feb 2003 23:32:19 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [PATCH] let kernel find QT in latest debian sid
Date: Tue, 4 Feb 2003 23:41:47 -0500
User-Agent: KMail/1.5.9
References: <3DF453C8.18B24E66@digeo.com> <200212092059.06287.tomlins@cam.org> <3DF54BD7.726993D@digeo.com>
In-Reply-To: <3DF54BD7.726993D@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200302042341.47931.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Without this QTDIR needs to be set to /usr/share/qt3 with
the latest qt 3.1.1 in debian unstable.  This fixes it.

Ed Tomlinson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.961   -> 1.962  
#	scripts/kconfig/Makefile	1.5     -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/04	ed@oscar.et.ca	1.962
# find debian sid's 'libqt3-headers' without setting QTDIR manually
# --------------------------------------------
#
diff -Nru a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
--- a/scripts/kconfig/Makefile	Tue Feb  4 23:40:13 2003
+++ b/scripts/kconfig/Makefile	Tue Feb  4 23:40:13 2003
@@ -38,7 +38,7 @@
 
 # QT needs some extra effort...
 $(obj)/.tmp_qtcheck:
-	@set -e; for d in $$QTDIR /usr/share/qt /usr/lib/qt*3*; do \
+	@set -e; for d in $$QTDIR /usr/share/qt /usr/lib/qt*3* /usr/share/qt*3*; do \
 	  if [ -f $$d/include/qconfig.h ]; then DIR=$$d; break; fi; \
 	done; \
 	if [ -z "$$DIR" ]; then \




