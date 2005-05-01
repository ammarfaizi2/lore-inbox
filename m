Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbVEAVUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVEAVUw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 17:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVEAVTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 17:19:38 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:24339 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262686AbVEAVS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 17:18:29 -0400
Message-Id: <200505012113.j41LD08j016471@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 17/22] UML - S390 preparation, linkage.h inherited from host
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 01 May 2005 17:13:00 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch replaces the contents of include/asm-um/linkage.h
by
    #include "asm/arch/linkage.h" 

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

diff -puN include/asm-um/linkage.h~arch-linkage.h include/asm-um/linkage.h
--- linux-2.6.11/include/asm-um/linkage.h~arch-linkage.h	2005-04-06 12:04:51.000000000 +0200
+++ linux-2.6.11-root/include/asm-um/linkage.h	2005-04-06 12:04:51.000000000 +0200
@@ -1,7 +1,6 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
+#ifndef __ASM_UM_LINKAGE_H
+#define __ASM_UM_LINKAGE_H
 
-#define FASTCALL(x)	x __attribute__((regparm(3)))
-#define fastcall        __attribute__((regparm(3)))
+#include "asm/arch/linkage.h"
 
 #endif
_

