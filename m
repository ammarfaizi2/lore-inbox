Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964846AbVJDQgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbVJDQgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 12:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbVJDQgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 12:36:07 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:30644 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964826AbVJDQgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 12:36:05 -0400
Date: Tue, 4 Oct 2005 17:36:04 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] missing include in megaraid_sas
Message-ID: <20051004163604.GE7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	megaraid_sas depends on arch-specific indirect includes pulling
fs.h in; on alpha they do not.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc3-git4-base/drivers/scsi/megaraid/megaraid_sas.c current/drivers/scsi/megaraid/megaraid_sas.c
--- RC14-rc3-git4-base/drivers/scsi/megaraid/megaraid_sas.c	2005-10-04 00:41:36.000000000 -0400
+++ current/drivers/scsi/megaraid/megaraid_sas.c	2005-10-04 02:43:31.000000000 -0400
@@ -34,6 +34,7 @@
 #include <linux/delay.h>
 #include <linux/uio.h>
 #include <asm/uaccess.h>
+#include <linux/fs.h>
 #include <linux/compat.h>
 
 #include <scsi/scsi.h>
