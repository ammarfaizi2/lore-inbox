Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTFWAVJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 20:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbTFWAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 20:21:09 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:58316 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264505AbTFWAVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 20:21:07 -0400
Date: Mon, 23 Jun 2003 02:35:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: aia21@cantab.net
Cc: linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.5 patch] postfix a NTFS constant with ULL
Message-ID: <20030623003511.GG3710@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below postfixes a NTFS constant that is too big for an int 
with ULL.

cu
Adrian

--- linux-2.5.73-not-full/fs/ntfs/layout.h.old	2003-06-23 02:27:30.000000000 +0200
+++ linux-2.5.73-not-full/fs/ntfs/layout.h	2003-06-23 02:27:51.000000000 +0200
@@ -43,7 +43,7 @@
 #define const_cpu_to_le64(x)	__constant_cpu_to_le64(x)
 
 /* The NTFS oem_id */
-#define magicNTFS	const_cpu_to_le64(0x202020205346544e) /* "NTFS    " */
+#define magicNTFS	const_cpu_to_le64(0x202020205346544eULL) /* "NTFS    " */
 
 /*
  * Location of bootsector on partition:


