Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbUDEK0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUDEK0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:26:25 -0400
Received: from mailbox.leidenuniv.nl ([132.229.102.4]:59595 "EHLO
	mailbox.leidenuniv.nl") by vger.kernel.org with ESMTP
	id S261455AbUDEK0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:26:19 -0400
From: Willem de Bruijn <wdebruij@dds.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][MINOR] define default SEEK_SET, SEEK_CUR and SEEK_END
Date: Mon, 5 Apr 2004 10:27:12 +0000
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404051027.13149.wdebruij@dds.nl>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a very minor patch to include the various llseek SEEK macro's into 
linux/fs.h

perhaps there's a reason this hasn't been included yet, but a simple grep 
showed me that I'm not the only one defining these in my drivers (which IMHO 
is bad). I simply copied these lines from libc's fnctl.h, including the 
original commentary. 

By the way, can someone tell me if I should cc: these minor patches to a 
specific maintainer? 

-- 
Willem de Bruijn
+31 6 2695 2446
+31 71 517 7174
wdebruij_at_dds.nl
http://www.wdebruij.dds.nl/

current project : 
Fairly Fast Packet Filter (FFPF)
http:/ffpf.sourceforge.net/

--- start of patch ---

diff -Nur linux-2.6.5-orig/include/linux/fs.h linux-2.6.5/include/linux/fs.h
--- linux-2.6.5-orig/include/linux/fs.h	2004-04-05 10:05:20.000000000 +0000
+++ linux-2.6.5/include/linux/fs.h	2004-04-05 10:08:54.934203912 +0000
@@ -87,6 +87,10 @@
 #define SEL_OUT		2
 #define SEL_EX		4
 
+#define SEEK_SET	0	/* Seek from beginning of file.  */
+#define SEEK_CUR	1	/* Seek from current position.  */
+#define SEEK_END	2	/* Seek from end of file.  */
+
 /* public flags for file_system_type */
 #define FS_REQUIRES_DEV 1 
 #define FS_BINARY_MOUNTDATA 2

-- 
Dit bericht is gescand op virussen en andere gevaarlijke inhoud door ULCN MailScanner en het bericht lijkt schoon te zijn.
This message has been scanned for viruses and dangerous content by ULCN MailScanner, and is believed to be clean.

