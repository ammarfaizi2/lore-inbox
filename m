Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbTCZTDf>; Wed, 26 Mar 2003 14:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261911AbTCZTDf>; Wed, 26 Mar 2003 14:03:35 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:30479
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261910AbTCZTDd>; Wed, 26 Mar 2003 14:03:33 -0500
Subject: [patch] bug 508: ipmi compile fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1441850000.1048704979@flay>
References: <1441850000.1048704979@flay>
Content-Type: text/plain
Organization: 
Message-Id: <1048706090.748.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Mar 2003 14:14:50 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 13:56, Martin J. Bligh wrote:

> Problem Description: drivers/char/ipmi/ipmi_devintf.c:452
> 'snprinf' should be 'snprintf'

Sheesh, diffing the solution is certainly quicker than filling out the
bugzilla entry...

Patch is against 2.5.66.  Linus, please apply.

	Robert Love


 drivers/char/ipmi/ipmi_devintf.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.66/drivers/char/ipmi/ipmi_devintf.c linux/drivers/char/ipmi/ipmi_devintf.c
--- linux-2.5.66/drivers/char/ipmi/ipmi_devintf.c	2003-03-24 17:01:22.000000000 -0500
+++ linux/drivers/char/ipmi/ipmi_devintf.c	2003-03-26 14:12:33.046757752 -0500
@@ -449,7 +449,7 @@
 	if (if_num > MAX_DEVICES)
 		return;
 
-	snprinf(name, sizeof(name), "ipmidev/%d", if_num);
+	snprintf(name, sizeof(name), "ipmidev/%d", if_num);
 
 	handles[if_num] = devfs_register(NULL, name, DEVFS_FL_NONE,
 					 ipmi_major, if_num,



