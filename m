Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265589AbUAGRMZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUAGRMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:12:18 -0500
Received: from users.ccur.com ([208.248.32.211]:55018 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S266254AbUAGRLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:11:51 -0500
Date: Wed, 7 Jan 2004 12:11:43 -0500
From: Joe Korty <joe.korty@ccur.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: reduce cpumask digit grouping from 8 to 4
Message-ID: <20040107171142.GA11525@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As long as we are going to have a seperator in cpumask_t displays,
we might as well as group the digits into readable units.

Against 2.6.1-rc2.

--- base/lib/mask.c	2004-01-07 11:40:07.000000000 -0500
+++ new/lib/mask.c	2004-01-07 11:57:38.000000000 -0500
@@ -88,8 +88,8 @@
 int __mask_snprintf_len(char *buf, unsigned int buflen,
 	const unsigned long *maskp, unsigned int maskbytes)
 {
-	u32 *wordp = (u32 *)maskp;
-	int i = maskbytes/sizeof(u32) - 1;
+	u16 *wordp = (u16 *)maskp;
+	int i = maskbytes/sizeof(u16) - 1;
 	int len = 0;
 	char *sep = "";
 

