Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbTGLLmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 07:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265367AbTGLLmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 07:42:35 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:57528 "HELO
	develer.com") by vger.kernel.org with SMTP id S265074AbTGLLme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 07:42:34 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Oliver Neukum <oliver@neukum.org>
Subject: PATCH: remove redundant offsetof() macro in HFS
Date: Sat, 12 Jul 2003 13:56:54 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307121356.54726.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oliver,

exactly the same definition of offsetof() is already present
in include/linux/stddef.h, therefore this one is redundant.

Applies to 2.5.75.

--- linux-2.5.x/include/linux/hfs_sysdep.h.orig	2003-07-12 13:52:56.000000000 +0200
+++ linux-2.5.x/include/linux/hfs_sysdep.h	2003-07-12 13:53:02.000000000 +0200
@@ -28,9 +28,6 @@
 
 extern struct timezone sys_tz;
 
-#undef offsetof
-#define offsetof(TYPE, MEMB) ((size_t) &((TYPE *)0)->MEMB)
-
 /* Typedefs for integer types by size and signedness */
 typedef __u8            hfs_u8;
 typedef __u16           hfs_u16;

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


