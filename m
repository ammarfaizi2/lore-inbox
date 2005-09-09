Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVIIQHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVIIQHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbVIIQHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:07:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51147 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030209AbVIIQHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:07:23 -0400
Date: Fri, 9 Sep 2005 17:07:23 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bogus #if (acpi/blacklist)
Message-ID: <20050909160723.GI9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git8-base/drivers/acpi/blacklist.c current/drivers/acpi/blacklist.c
--- RC13-git8-base/drivers/acpi/blacklist.c	2005-09-08 23:42:49.000000000 -0400
+++ current/drivers/acpi/blacklist.c	2005-09-09 11:28:44.000000000 -0400
@@ -73,7 +73,7 @@
 	{""}
 };
 
-#if	CONFIG_ACPI_BLACKLIST_YEAR
+#ifdef	CONFIG_ACPI_BLACKLIST_YEAR
 
 static int __init blacklist_by_year(void)
 {
