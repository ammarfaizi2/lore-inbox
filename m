Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTJXWR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTJXWR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:17:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:21229 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262686AbTJXWMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:12:38 -0400
Date: Fri, 24 Oct 2003 15:12:36 -0700
From: Chris Wright <chrisw@osdl.org>
To: marcelo.tosatti@cyclades.com
Cc: sarnold@immunix.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sysctl core_setuid_ok fix
Message-ID: <20031024151236.B19328@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend, to fix bad Cc: adress]

The sysctl kern_table entry part of the core_setuid_ok patch has wrong
ctl_name.  Patch below is against current 2.4.23-pre8-bk.  Seth Arnold
pointed this problem out to me.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net


===== kernel/sysctl.c 1.28 vs edited =====
--- 1.28/kernel/sysctl.c	Wed Oct  8 07:35:22 2003
+++ edited/kernel/sysctl.c	Fri Oct 24 14:37:35 2003
@@ -180,7 +180,7 @@
 	 0644, NULL, &proc_dointvec},
 	{KERN_CORE_USES_PID, "core_uses_pid", &core_uses_pid, sizeof(int),
 	 0644, NULL, &proc_dointvec},
-	{KERN_CORE_USES_PID, "core_setuid_ok", &core_setuid_ok, sizeof(int),
+	{KERN_CORE_SETUID, "core_setuid_ok", &core_setuid_ok, sizeof(int),
 	0644, NULL, &proc_dointvec},
 	{KERN_CORE_PATTERN, "core_pattern", core_pattern, 64,
 	 0644, NULL, &proc_dostring, &sysctl_string},

