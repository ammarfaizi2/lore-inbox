Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbSJCVb0>; Thu, 3 Oct 2002 17:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJCVb0>; Thu, 3 Oct 2002 17:31:26 -0400
Received: from kraid.nerim.net ([62.4.16.95]:14341 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S261338AbSJCVbZ>;
	Thu, 3 Oct 2002 17:31:25 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4] [TRIVIAL] missing entry in Intel cache table
From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 3 Oct 2002 23:38:40 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.179.148.6]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021003212821.E1A2E40E31@kraid.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.

It seems that the Intel cache table in arch/i386/kernel/setup.c misses one entry. It must have been lost in 2.4.20-pre1 when Andy Grover converted the old switch-case-based method to the much-nicer table-based one.

--- linux-2.4.20-pre8/arch/i386/kernel/setup.c.orig	Thu Oct  3 19:34:34 2002
+++ linux-2.4.20-pre8/arch/i386/kernel/setup.c	Thu Oct  3 19:36:39 2002
@@ -2212,6 +2212,7 @@
 	{ 0x7B, LVL_2,      512 },
 	{ 0x7C, LVL_2,      1024 },
 	{ 0x82, LVL_2,      256 },
+	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
 	{ 0x00, 0, 0}

The same applies to the 2.5 tree, see my next post.

Jean Delvare


___________________________________
Webmail Nerim, http://www.nerim.net/


