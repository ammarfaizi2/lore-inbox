Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264932AbTFQVPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 17:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbTFQVPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 17:15:37 -0400
Received: from aneto.able.es ([212.97.163.22]:43970 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S264932AbTFQVP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 17:15:26 -0400
Date: Tue, 17 Jun 2003 23:29:17 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] db4 for aicasm
Message-ID: <20030617212917.GA13990@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This enables the build of aicasm with db4-devel.

--- linux-2.4.21/drivers/scsi/aic7xxx/aicasm/Makefile.orig	2003-06-17 23:26:37.000000000 +0200
+++ linux-2.4.21/drivers/scsi/aic7xxx/aicasm/Makefile	2003-06-17 23:26:55.000000000 +0200
@@ -33,7 +33,9 @@
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG)
 
 aicdb.h:
-	@if [ -e "/usr/include/db3/db_185.h" ]; then		\
+	@if [ -e "/usr/include/db4/db_185.h" ]; then		\
+		echo "#include <db4/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db2/db_185.h" ]; then		\
 		echo "#include <db2/db_185.h>" > aicdb.h;	\
--- linux-2.4.21/drivers/scsi/aic79xx/aicasm/Makefile.orig	2003-06-17 23:25:57.000000000 +0200
+++ linux-2.4.21/drivers/scsi/aic79xx/aicasm/Makefile	2003-06-17 23:26:22.000000000 +0200
@@ -33,7 +33,9 @@
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG)
 
 aicdb.h:
-	@if [ -e "/usr/include/db3/db_185.h" ]; then		\
+	@if [ -e "/usr/include/db4/db_185.h" ]; then		\
+		echo "#include <db4/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db2/db_185.h" ]; then		\
 		echo "#include <db2/db_185.h>" > aicdb.h;	\


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-jam1 (gcc 3.3 (Mandrake Linux 9.2 3.3-1mdk))
