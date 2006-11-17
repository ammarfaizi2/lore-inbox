Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932951AbWKQQgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbWKQQgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 11:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933720AbWKQQgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 11:36:32 -0500
Received: from s131.mittwaldmedien.de ([62.216.178.31]:2073 "EHLO
	s131.mittwaldmedien.de") by vger.kernel.org with ESMTP
	id S932951AbWKQQgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 11:36:32 -0500
From: Holger Schurig <hs4233@mail.mn-solutions.de>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.19-rc6] fix warning in speedstep-centrino.c
Date: Fri, 17 Nov 2006 17:36:46 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611171736.46757.hs4233@mail.mn-solutions.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes warning: 'sw_any_bug_dmi_table' defined but not used

Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>

--- linux.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -385,6 +385,7 @@
  * detected, this has a side effect of making CPU run at a different speed
  * than OS intended it to run at. Detect it and handle it cleanly.
  */
+#ifdef CONFIG_SMP
 static int bios_with_sw_any_bug;
 static int sw_any_bug_found(struct dmi_system_id *d)
 {
@@ -405,6 +406,7 @@
 	},
 	{ }
 };
+#endif
 
 
 /*
