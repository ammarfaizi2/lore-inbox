Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbTC2Afk>; Fri, 28 Mar 2003 19:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263368AbTC2Afj>; Fri, 28 Mar 2003 19:35:39 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:7343 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263365AbTC2Afh>; Fri, 28 Mar 2003 19:35:37 -0500
Message-Id: <200303290046.h2T0kp35027188@deviant.impure.org.uk>
Date: Sat, 29 Mar 2003 00:46:36 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: fix up newer x86 cpuinfo flags.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Intel document 24161823.pdf[*] page 18, 'tm2' is misdefined.
Its bit 7 not, bit 8. Also add the missing 'EST' (Enhanced Speedstep Technology)
bit, and use the correct Intel terminology for the context ID bit.

[*] http://www.intel.com/design/xeon/applnots/241618.htm

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/proc.c linux-2.5/arch/i386/kernel/cpu/proc.c
--- bk-linus/arch/i386/kernel/cpu/proc.c	2003-03-15 19:33:58.000000000 +0000
+++ linux-2.5/arch/i386/kernel/cpu/proc.c	2003-03-28 12:10:26.000000000 +0000
@@ -44,8 +44,8 @@ static int show_cpuinfo(struct seq_file 
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* Intel-defined (#2) */
-		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, NULL,
-		"tm2", NULL, "cnxt_id", NULL, NULL, NULL, NULL, NULL,
+		"pni", NULL, NULL, "monitor", "ds_cpl", NULL, NULL, "tm2",
+		"est", NULL, "cid", NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
