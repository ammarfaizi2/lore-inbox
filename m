Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270403AbTGSRhp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270407AbTGSRhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:37:45 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:16028 "HELO
	develer.com") by vger.kernel.org with SMTP id S270403AbTGSRho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:37:44 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
To: torvalds@osdl.org
Subject: [TRIVIAL] fix include/linux/sysctl.h for userland
Date: Sat, 19 Jul 2003 19:52:35 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200307191952.35499.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Include linux/compiler.h in include/linux/sysctl.h. Needed to get __user
defined when C library uses this header (ie: no __KERNEL__).

Please apply.

--- linux-2.6.0-test1.orig/include/linux/sysctl.h	2003-07-14 05:34:40.000000000 +0200
+++ linux-2.6.0-test1/include/linux/sysctl.h	2003-07-19 19:20:29.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/list.h>
+#include <linux/compiler.h>
 
 struct file;
 

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


