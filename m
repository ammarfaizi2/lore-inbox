Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVAIIzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVAIIzx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 03:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVAIIzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 03:55:52 -0500
Received: from mx1.mail.ru ([194.67.23.121]:14408 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S262074AbVAIIzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 03:55:06 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] hfs: s/0/NULL/ in pointer context
Date: Sun, 9 Jan 2005 11:45:54 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501091145.54271.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@mail.ru>

Index: linux-2.6.10-bk11-warnings/fs/hfs/super.c
===================================================================
--- linux-2.6.10-bk11-warnings/fs/hfs/super.c	(revision 12)
+++ linux-2.6.10-bk11-warnings/fs/hfs/super.c	(revision 13)
@@ -159,7 +159,7 @@
 	if (!options)
 		return 1;
 
-	while ((this_char = strsep(&options, ",")) != 0) {
+	while ((this_char = strsep(&options, ",")) != NULL) {
 		if (!*this_char)
 			continue;
 		value = strchr(this_char, '=');
