Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCUPW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCUPW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVCUPVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:21:09 -0500
Received: from ns3.dataphone.se ([212.37.0.170]:11459 "EHLO
	mail-slave.dataphone.se") by vger.kernel.org with ESMTP
	id S261439AbVCUPTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:19:46 -0500
From: Magnus Damm <damm@opensource.se>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <damm@opensource.se>
Message-Id: <20050321145144.18203.40882.89232@clementine.local>
Subject: [PATCH] asus_acpi: MODULE_PARM_DESC
Date: Mon, 21 Mar 2005 16:19:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove incorrect "asus_"-prefix from parameter name.
Error detected with section2text.rb, see autoparam patch. 

Signed-off-by: Magnus Damm <damm@opensource.se>

--- linux-2.6.12-rc1/drivers/acpi/asus_acpi.c	2005-03-20 18:09:14.000000000 +0100
+++ linux-2.6.12-rc1-autoparam/drivers/acpi/asus_acpi.c	2005-03-21 14:26:23.000000000 +0100
@@ -78,9 +78,9 @@
 
 static uid_t asus_uid;
 static gid_t asus_gid;
-module_param(asus_uid, uint, 0);
+module_param_named(uid, asus_uid, uint, 0);
 MODULE_PARM_DESC(uid, "UID for entries in /proc/acpi/asus.\n");
-module_param(asus_gid, uint, 0);
+module_param_named(gid, asus_gid, uint, 0);
 MODULE_PARM_DESC(gid, "GID for entries in /proc/acpi/asus.\n");
 
 
