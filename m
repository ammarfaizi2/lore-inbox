Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267446AbSLRXXA>; Wed, 18 Dec 2002 18:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbSLRXXA>; Wed, 18 Dec 2002 18:23:00 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48401 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267446AbSLRXWx>;
	Wed, 18 Dec 2002 18:22:53 -0500
Date: Wed, 18 Dec 2002 15:28:10 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.52
Message-ID: <20021218232810.GD1782@kroah.com>
References: <20021218231917.GA1782@kroah.com> <20021218232125.GB1782@kroah.com> <20021218232714.GC1782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021218232714.GC1782@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.900, 2002/12/18 15:09:33-08:00, greg@kroah.com

LSM: Fix up the description of the root_plug code to try to make it clearer.


diff -Nru a/security/Kconfig b/security/Kconfig
--- a/security/Kconfig	Wed Dec 18 15:13:33 2002
+++ b/security/Kconfig	Wed Dec 18 15:13:33 2002
@@ -27,8 +27,11 @@
 	depends on SECURITY!=n
 	help
 	  This is a sample LSM module that should only be used as such.
-	  It enables control over processes being created by root users
-	  if a specific USB device is not present in the system.
+	  It prevents any programs running with egid == 0 if a specific
+	  USB device is not present in the system.
+
+	  See <http://www.linuxjournal.com/article.php?sid=6279> for
+	  more information about this module.
 	  
 	  If you are unsure how to answer this question, answer N.
 
diff -Nru a/security/root_plug.c b/security/root_plug.c
--- a/security/root_plug.c	Wed Dec 18 15:13:33 2002
+++ b/security/root_plug.c	Wed Dec 18 15:13:33 2002
@@ -13,6 +13,9 @@
  * If you want to turn this into something with a semblance of security,
  * you need to hook the task_* functions also.
  *
+ * See http://www.linuxjournal.com/article.php?sid=6279 for more information
+ * about this code.
+ *
  *	This program is free software; you can redistribute it and/or
  *	modify it under the terms of the GNU General Public License as
  *	published by the Free Software Foundation, version 2 of the
