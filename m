Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314548AbSGYNbC>; Thu, 25 Jul 2002 09:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314395AbSGYN36>; Thu, 25 Jul 2002 09:29:58 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:2301 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314325AbSGYN3J>; Thu, 25 Jul 2002 09:29:09 -0400
From: Alan Cox <alan@irongate.swansea.linux.org.uk>
Message-Id: <200207251446.g6PEkGEh010427@irongate.swansea.linux.org.uk>
Subject: PATCH: 2.5.28 (resend #1) miropcm20 fails to build
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Thu, 25 Jul 2002 15:46:15 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.28/drivers/media/radio/miropcm20-rds-core.c linux-2.5.28-ac1/drivers/media/radio/miropcm20-rds-core.c
--- linux-2.5.28/drivers/media/radio/miropcm20-rds-core.c	Thu Jul 25 10:48:45 2002
+++ linux-2.5.28-ac1/drivers/media/radio/miropcm20-rds-core.c	Sun Jul 21 15:39:49 2002
@@ -15,8 +15,9 @@
 
 #define _NO_VERSION_
 
-/* #include <linux/kernel.h> */
 #include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <asm/semaphore.h>
