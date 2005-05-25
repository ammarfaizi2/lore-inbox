Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbVEYQZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbVEYQZV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 12:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVEYQZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 12:25:21 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:3213 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261462AbVEYQZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 12:25:15 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.12-rc5: compilation fix for IPMI
Date: Wed, 25 May 2005 18:25:09 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505251825.10274.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.12-rc5/drivers/char/ipmi/ipmi_devintf.c	2005-05-25 18:18:22.000000000 +0200
+++ patched/drivers/char/ipmi/ipmi_devintf.c	2005-05-25 18:03:27.000000000 +0200
@@ -520,7 +520,7 @@ MODULE_PARM_DESC(ipmi_major, "Sets the m
 		 " interface.  Other values will set the major device number"
 		 " to that value.");
 
-static struct class *ipmi_class;
+static struct class_simple *ipmi_class;
 
 static void ipmi_new_smi(int if_num)
 {
@@ -534,7 +534,7 @@ static void ipmi_new_smi(int if_num)
 
 static void ipmi_smi_gone(int if_num)
 {
-	class_simple_device_remove(ipmi_class, MKDEV(ipmi_major, if_num));
+	class_simple_device_remove(MKDEV(ipmi_major, if_num));
 	devfs_remove("ipmidev/%d", if_num);
 }
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
