Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbTEHVph (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbTEHVpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:45:36 -0400
Received: from port-212-202-186-70.reverse.qdsl-home.de ([212.202.186.70]:37504
	"EHLO gw.localnet") by vger.kernel.org with ESMTP id S262157AbTEHVpf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:45:35 -0400
Message-ID: <3EBAD2F1.9090802@trash.net>
Date: Thu, 08 May 2003 23:58:09 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix kfree(skb) in iphase driver
Content-Type: multipart/mixed;
 boundary="------------000907080609000002000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000907080609000002000604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes a kfree(skb) in the iphase driver.

Best regards,
Patrick


--------------000907080609000002000604
Content-Type: text/plain;
 name="iphase-kfree-skb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iphase-kfree-skb.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1198  -> 1.1199 
#	drivers/atm/iphase.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/08	kaber@trash.net	1.1199
# fix kfree(skb)
# --------------------------------------------
#
diff -Nru a/drivers/atm/iphase.c b/drivers/atm/iphase.c
--- a/drivers/atm/iphase.c	Thu May  8 23:56:27 2003
+++ b/drivers/atm/iphase.c	Thu May  8 23:56:27 2003
@@ -2965,7 +2965,7 @@
 	                 dev_kfree_skb_any(skb);
 	           return 0;
 	   }
-	   kfree(skb);
+	   dev_kfree_skb_any(skb);
 	   skb = newskb;
         }       
 	/* Get a descriptor number from our free descriptor queue  

--------------000907080609000002000604--

