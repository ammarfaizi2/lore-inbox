Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTFMD6v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 23:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265121AbTFMD6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 23:58:51 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:42425 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265111AbTFMD6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 23:58:50 -0400
Date: Fri, 13 Jun 2003 00:04:02 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: [PATCH] make pid_max readable
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <1055477042.4048.132.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed so that apps can set appropriate column
widths for PID display.

diff -Naurd old-2.5.70/kernel/sysctl.c new-2.5.70/kernel/sysctl.c
--- old-2.5.70/kernel/sysctl.c	2003-06-12 23:43:00.000000000 -0400
+++ new-2.5.70/kernel/sysctl.c	2003-06-12 23:44:18.000000000 -0400
@@ -539,7 +539,7 @@
 		.procname	= "pid_max",
 		.data		= &pid_max,
 		.maxlen		= sizeof (int),
-		.mode		= 0600,
+		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
 	{



