Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTLMASN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTLMASN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:18:13 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:8097 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262153AbTLMASK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:18:10 -0500
Date: Sat, 13 Dec 2003 01:18:08 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Allow 2.6.0-test11-bk8 AIC build with db1/db4
Message-ID: <20031213001808.GA10640@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

This is still needed in bk8. Could it be got right for final, please ?

--- linux-2.6.0-test11/drivers/scsi/aic7xxx/aicasm/Makefile.orig	2003-12-02 23:52:29.000000000 +0100
+++ linux-2.6.0-test11/drivers/scsi/aic7xxx/aicasm/Makefile	2003-12-03 00:01:04.000000000 +0100
@@ -34,10 +34,14 @@
 	$(AICASM_CC) $(AICASM_CFLAGS) $(SRCS) -o $(PROG) $(LIBS)
 
 aicdb.h:
-	@if [ -e "/usr/include/db3/db_185.h" ]; then		\
+	@if [ -e "/usr/include/db4/db_185.h" ]; then		\
+		echo "#include <db4/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db3/db_185.h" ]; then		\
 		echo "#include <db3/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db2/db_185.h" ]; then		\
 		echo "#include <db2/db_185.h>" > aicdb.h;	\
+	 elif [ -e "/usr/include/db1/db_185.h" ]; then		\
+		echo "#include <db1/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db/db_185.h" ]; then		\
 		echo "#include <db/db_185.h>" > aicdb.h;	\
 	 elif [ -e "/usr/include/db_185.h" ]; then		\


TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.0-test11-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
