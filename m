Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUEUXrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUEUXrV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbUEUXqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:46:48 -0400
Received: from zeus.kernel.org ([204.152.189.113]:47802 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264546AbUEUX2V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:28:21 -0400
Date: Thu, 20 May 2004 11:57:46 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix return value for sysfs_rename_dir stub
Message-Id: <20040520115746.4645797c@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs_rename_dir changed to return a value.  The stub was not updated.
This causes compile failure for !CONFIG_SYSFS in lib/kobject.c

--- linux-2.6/include/linux/sysfs.h	2004-05-18 11:37:34.000000000 -0700
+++ bridge-2.6/include/linux/sysfs.h	2004-05-20 11:46:02.814243528 -0700
@@ -80,9 +80,9 @@
 	;
 }
 
-static inline void sysfs_rename_dir(struct kobject * k, const char *new_name)
+static inline int sysfs_rename_dir(struct kobject * k, const char *new_name)
 {
-	;
+	return 0;
 }
 
 static inline int sysfs_create_file(struct kobject * k, const struct attribute * a)
