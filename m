Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbWCXS7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbWCXS7R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWCXS7R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:59:17 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:22681 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964773AbWCXS7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:59:15 -0500
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: powerpc: fix hvc-rtas comments
Date: Fri, 24 Mar 2006 19:58:51 +0100
User-Agent: KMail/1.9.1
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323213217.GB5538@pb15.lixom.net> <200603232336.19683.arnd@arndb.de>
In-Reply-To: <200603232336.19683.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241958.52188.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As notice by Olof Johansson, the comment about module_exit
in hvc_rtas is rather confusing, so remove it.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Index: linus-2.6/drivers/char/hvc_rtas.c
===================================================================
--- linus-2.6.orig/drivers/char/hvc_rtas.c
+++ linus-2.6/drivers/char/hvc_rtas.c
@@ -119,7 +119,7 @@ static void __exit hvc_rtas_exit(void)
 	if (hvc_rtas_dev)
 		hvc_remove(hvc_rtas_dev);
 }
-module_exit(hvc_rtas_exit); /* before drivers/char/hvc_console.c */
+module_exit(hvc_rtas_exit);
 
 /* This will happen prior to module init.  There is no tty at this time? */
 static int hvc_rtas_console_init(void)
