Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbULFAr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbULFAr2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbULFAmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:42:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23051 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261443AbULFAlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:41:36 -0500
Date: Mon, 6 Dec 2004 01:41:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, pazke@donpac.ru,
       linux-visws-devel@lists.sf.net
Subject: [2.6 patch] i386 mpparse.c: make MP_processor_info static
Message-ID: <20041206004133.GJ2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes a needlessly global function static.


diffstat output:
 arch/i386/kernel/mpparse.c     |    2 +-
 arch/i386/mach-visws/mpparse.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/arch/i386/mach-visws/mpparse.c.old	2004-12-06 01:19:45.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/mach-visws/mpparse.c	2004-12-06 01:19:54.000000000 +0100
@@ -36,7 +36,7 @@
  * No problem for Linux.
  */
 
-void __init MP_processor_info (struct mpc_config_processor *m)
+static void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, logical_apicid;
 	physid_mask_t apic_cpus;
--- linux-2.6.10-rc2-mm4-full/arch/i386/kernel/mpparse.c.old	2004-12-06 01:20:02.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/arch/i386/kernel/mpparse.c	2004-12-06 01:20:07.000000000 +0100
@@ -119,7 +119,7 @@
 }
 #endif
 
-void __init MP_processor_info (struct mpc_config_processor *m)
+static void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, apicid;
 	physid_mask_t tmp;

