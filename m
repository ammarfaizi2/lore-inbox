Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263169AbVCXSp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263169AbVCXSp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVCXSps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:45:48 -0500
Received: from aun.it.uu.se ([130.238.12.36]:6868 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263154AbVCXSmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:42:14 -0500
Date: Thu, 24 Mar 2005 19:42:03 +0100 (MET)
Message-Id: <200503241842.j2OIg3fa011988@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm2] x86_64: fix vsyscall.c syntax error
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling 2.6.12-rc1-mm2 on x86_64 with gcc-4.0 fails with:

arch/x86_64/kernel/vsyscall.c:193: error: syntax error before 'vsyscall_sysctl_change'

Fix: repair the syntax error

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.12-rc1-mm2/arch/x86_64/kernel/vsyscall.c.~1~	2005-03-24 16:33:50.000000000 +0100
+++ linux-2.6.12-rc1-mm2/arch/x86_64/kernel/vsyscall.c	2005-03-24 19:31:40.000000000 +0100
@@ -190,7 +190,7 @@ static ctl_table kernel_table2[] = {
 	{ .ctl_name = 99, .procname = "vsyscall64",
 	  .data = &sysctl_vsyscall, .maxlen = sizeof(int), .mode = 0644,
 	  .strategy = vsyscall_sysctl_nostrat,
-	  .proc_handler vsyscall_sysctl_change },
+	  .proc_handler = vsyscall_sysctl_change },
 	{ 0, }
 };
 
