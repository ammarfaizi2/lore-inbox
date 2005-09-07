Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750925AbVIGW0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbVIGW0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 18:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVIGW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 18:26:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52876 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750848AbVIGW0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 18:26:36 -0400
Date: Wed, 7 Sep 2005 23:26:35 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] bogus #if (ncr53c406)
Message-ID: <20050907222635.GG13549@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-hamachi/drivers/scsi/NCR53c406a.c RC13-git7-ncr53c406/drivers/scsi/NCR53c406a.c
--- RC13-git7-hamachi/drivers/scsi/NCR53c406a.c	2005-08-28 23:09:45.000000000 -0400
+++ RC13-git7-ncr53c406/drivers/scsi/NCR53c406a.c	2005-09-07 13:55:46.000000000 -0400
@@ -62,7 +62,7 @@
 
 #define SYNC_MODE 0		/* Synchronous transfer mode */
 
-#if DEBUG
+#ifdef DEBUG
 #undef NCR53C406A_DEBUG
 #define NCR53C406A_DEBUG 1
 #endif
