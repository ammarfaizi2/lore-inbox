Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUJGOFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUJGOFy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266175AbUJGOFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:05:54 -0400
Received: from webapps.arcom.com ([194.200.159.168]:50186 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S269664AbUJGOET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:04:19 -0400
Subject: [PATCH] trivial fix for warning in kernel/power/console.c
From: Ian Campbell <icampbell@arcom.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1097157857.5231.10.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 07 Oct 2004 15:04:17 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2004 14:09:01.0078 (UTC) FILETIME=[31DBA360:01C4AC77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

orig_fgconsole and orig_kmsg are only used in kernel/power/console.c if 
SUSPEND_CONSOLE is defined.

Signed-off-by: Ian Campbell <icampbell@arcom.com>

Index: 2.6-bk/kernel/power/console.c
===================================================================
--- 2.6-bk.orig/kernel/power/console.c	2004-10-07 14:47:25.764724497 +0100
+++ 2.6-bk/kernel/power/console.c	2004-10-07 14:47:54.241016791 +0100
@@ -11,7 +11,9 @@
 
 static int new_loglevel = 10;
 static int orig_loglevel;
+#ifdef SUSPEND_CONSOLE
 static int orig_fgconsole, orig_kmsg;
+#endif
 
 int pm_prepare_console(void)
 {


-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

