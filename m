Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269608AbUJLKxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269608AbUJLKxi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269619AbUJLKvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:51:48 -0400
Received: from mail.renesas.com ([202.234.163.13]:52944 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269608AbUJLKth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:49:37 -0400
Date: Tue, 12 Oct 2004 19:49:28 +0900 (JST)
Message-Id: <20041012.194928.749247009.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc4-mm1] [m32r] Fix a compile error of M32R SIO driver
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a patch to fix a compile error of m32r-sio.c.
Please apply.

	* include/asm-m32r/termbits.h:
	- Add CTVB definition.
	  This modification is derived from new-serial-flow-control.patch;

	  "[Patch] new serial flow control" (Oct. 4, 2004)
	  http://www.uwsg.iu.edu/hypermail/linux/kernel/0410.0/0853.html

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 include/asm-m32r/termbits.h |    1 +
 1 files changed, 1 insertion(+)


diff -ruNp a/include/asm-m32r/termbits.h b/include/asm-m32r/termbits.h
--- a/include/asm-m32r/termbits.h	2004-10-12 09:35:17.000000000 +0900
+++ b/include/asm-m32r/termbits.h	2004-10-12 10:47:33.000000000 +0900
@@ -136,6 +136,7 @@ struct termios {
 #define  B3500000 0010016
 #define  B4000000 0010017
 #define CIBAUD	  002003600000	/* input baud rate (not used) */
+#define CTVB	  004000000000		/* VisioBraille Terminal flow control */
 #define CMSPAR	  010000000000		/* mark or space (stick) parity */
 #define CRTSCTS	  020000000000		/* flow control */
 

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
