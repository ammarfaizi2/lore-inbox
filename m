Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261332AbSJCVd4>; Thu, 3 Oct 2002 17:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261350AbSJCVd4>; Thu, 3 Oct 2002 17:33:56 -0400
Received: from kraid.nerim.net ([62.4.16.95]:20485 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S261332AbSJCVdz>;
	Thu, 3 Oct 2002 17:33:55 -0400
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5] [TRIVIAL] missing entry in Intel cache table
From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 3 Oct 2002 23:41:10 CEST
Reply-To: Jean Delvare <khali@linux-fr.org>
X-Priority: 3 (Normal)
X-Originating-Ip: [172.179.148.6]
X-Mailer: Webmail Nerim (NOCC v0.9.5)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <20021003213052.097A740E2A@kraid.nerim.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone.

It seems that the Intel cache table in arch/i386/kernel/cpu/intel.c misses one entry. It must have been lost in 2.5.26 when Andy Grover converted the old switch-case-based method to the much-nicer table-based one.

--- linux-2.5.40/arch/i386/kernel/cpu/intel.c.orig	Sun Sep 22 06:25:04 2002
+++ linux-2.5.40/arch/i386/kernel/cpu/intel.c	Thu Oct  3 22:26:20 2002
@@ -127,6 +127,7 @@
 	{ 0x7B, LVL_2,      512 },
 	{ 0x7C, LVL_2,      1024 },
 	{ 0x82, LVL_2,      256 },
+	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
 	{ 0x00, 0, 0}

Jean Delvare


___________________________________
Webmail Nerim, http://www.nerim.net/


