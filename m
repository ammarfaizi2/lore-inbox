Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTIVPrI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbTIVPrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 11:47:08 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:59564 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263190AbTIVPrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 11:47:05 -0400
Date: Mon, 22 Sep 2003 16:45:52 +0100
From: Dave Jones <davej@redhat.com>
To: Marcelo Tossati <marcelo.tosatti@cyclades.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] backport missing Intel cache sizes.
Message-ID: <20030922154552.GD15344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Marcelo Tossati <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some descriptors for Intel cache sizes.

		Dave

--- arch/i386/kernel/setup.c~	2003-09-22 15:48:24.000000000 +0100
+++ arch/i386/kernel/setup.c	2003-09-22 15:49:33.000000000 +0100
@@ -2296,6 +2296,8 @@
 	{ 0x23, LVL_3,      1024 },
 	{ 0x25, LVL_3,      2048 },
 	{ 0x29, LVL_3,      4096 },
+	{ 0x2c, LVL_1_DATA, 32 },
+	{ 0x30, LVL_1_INST, 32 },
 	{ 0x39, LVL_2,      128 },
 	{ 0x3b, LVL_2,      128 },
 	{ 0x3C, LVL_2,      256 },
@@ -2318,6 +2320,8 @@
 	{ 0x83, LVL_2,      512 },
 	{ 0x84, LVL_2,      1024 },
 	{ 0x85, LVL_2,      2048 },
+	{ 0x86, LVL_2,      512 },
+	{ 0x87, LVL_2,      1024 },
 	{ 0x00, 0, 0}
 };
 
-- 
 Dave Jones     http://www.codemonkey.org.uk
