Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263451AbTEVXiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 19:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263449AbTEVXiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 19:38:22 -0400
Received: from tomts11.bellnexxia.net ([209.226.175.55]:48613 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263441AbTEVXiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 19:38:15 -0400
Subject: [PATCH] 2.5.69-mm8 apm.c compile fix
From: Shane Shrybman <shrybman@sympatico.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-15fuPYdoA/+e3l96pqkD"
Organization: 
Message-Id: <1053647477.2471.3.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 19:51:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-15fuPYdoA/+e3l96pqkD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Needed this SET_MODULE_OWNER fix to compile -mm8.

Regards,

Shane

--=-15fuPYdoA/+e3l96pqkD
Content-Disposition: attachment; filename=2.5.69-mm8.apm.diff
Content-Type: text/x-diff; name=2.5.69-mm8.apm.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.5.69-mm8/arch/i386/kernel/apm.c.orig	Thu May 22 19:28:12 2003
+++ linux-2.5.69-mm8/arch/i386/kernel/apm.c	Thu May 22 19:45:11 2003
@@ -1998,7 +1998,7 @@
 
 	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
 	if (apm_proc)
-		SET_MODULE_OWNER(apm_proc);
+		apm_proc->owner = THIS_MODULE;
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 

--=-15fuPYdoA/+e3l96pqkD--

