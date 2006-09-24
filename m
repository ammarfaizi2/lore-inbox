Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752047AbWIXBPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbWIXBPi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 21:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbWIXBPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 21:15:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752047AbWIXBPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 21:15:37 -0400
Date: Sat, 23 Sep 2006 21:15:32 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: ak@suse.de
Subject: New Intel feature flags.
Message-ID: <20060924011532.GA5804@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, ak@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add supplemental SSE3 instructions flag, and Direct Cache Access flag.
As described in "Intel Processor idenfication and the CPUID instruction
AP485 Sept 2006"

Signed-off-by: Dave Jones <davej@redhat.com>

--- local-git/arch/i386/kernel/cpu/proc.c~	2006-09-23 20:46:35.000000000 -0400
+++ local-git/arch/i386/kernel/cpu/proc.c	2006-09-23 20:48:02.000000000 -0400
@@ -46,8 +46,8 @@ static int show_cpuinfo(struct seq_file 
 
 		/* Intel-defined (#2) */
 		"pni", NULL, NULL, "monitor", "ds_cpl", "vmx", "smx", "est",
-		"tm2", NULL, "cid", NULL, NULL, "cx16", "xtpr", NULL,
-		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
+		"tm2", "ssse3", "cid", NULL, NULL, "cx16", "xtpr", NULL,
+		NULL, NULL, "dca", NULL, NULL, NULL, NULL, NULL,
 		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
 
 		/* VIA/Cyrix/Centaur-defined */

-- 
http://www.codemonkey.org.uk
