Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbUKJOQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbUKJOQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 09:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbUKJONk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 09:13:40 -0500
Received: from [213.80.72.10] ([213.80.72.10]:34715 "EHLO kubrik.opensource.se")
	by vger.kernel.org with ESMTP id S261959AbUKJOME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 09:12:04 -0500
Subject: [PATCH] mm4: add-do_proc_doulonglongvec_minmax-to-sysctl-functions
From: Magnus Damm <damm@opensource.se>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-zqoaCplIDHXPELYvRdqz"
Message-Id: <1100096060.8660.76.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 15:14:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zqoaCplIDHXPELYvRdqz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

This patch makes the code compile with CONFIG_SYSCTL unset.

/ magnus


--=-zqoaCplIDHXPELYvRdqz
Content-Disposition: attachment; filename=linux-2.6.10-rc1-mm4-no_sysctl.patch
Content-Type: text/x-patch; name=linux-2.6.10-rc1-mm4-no_sysctl.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN linux-2.6.10-rc1-mm4/kernel/sysctl.c linux-2.6.10-rc1-mm4-no_sysctl/kernel/sysctl.c
--- linux-2.6.10-rc1-mm4/kernel/sysctl.c	2004-11-09 19:38:16.000000000 +0100
+++ linux-2.6.10-rc1-mm4-no_sysctl/kernel/sysctl.c	2004-11-10 14:28:34.181959944 +0100
@@ -2313,6 +2313,12 @@
 	return -ENOSYS;
 }
 
+int proc_doulonglongvec_minmax(ctl_table *table, int write, struct file *filp,
+			   void __user *buffer, size_t *lenp, loff_t *ppos)
+{
+	return -ENOSYS;
+}
+
 int proc_doulongvec_ms_jiffies_minmax(ctl_table *table, int write,
 				      struct file *filp,
 				      void __user *buffer,

--=-zqoaCplIDHXPELYvRdqz--

