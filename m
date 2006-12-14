Return-Path: <linux-kernel-owner+w=401wt.eu-S1750956AbWLNTnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWLNTnl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 14:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWLNTnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 14:43:41 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:58047 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbWLNTnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 14:43:40 -0500
X-Originating-Ip: 74.109.98.100
Date: Thu, 14 Dec 2006 14:39:07 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] init: Remove commented, obsolete code invoking smp_commence().
Message-ID: <Pine.LNX.4.64.0612141433050.7079@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the "#if 0"ed call to smp_commence, which is clearly
obsolete.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  There appears to be no value to leaving that call in the code, given
that the source file "arch/ia64/kernel/smpboot.c" explains:

  "Switch over to hotplug-CPU boot-sequence.
smp_boot_cpus()/smp_commence() is replaced by
smp_prepare_cpus()/__cpu_up()/smp_cpus_done()."

diff --git a/init/main.c b/init/main.c
index e3f0bb2..a148039 100644
--- a/init/main.c
+++ b/init/main.c
@@ -397,11 +397,6 @@ static void __init smp_init(void)
 	/* Any cleanup work */
 	printk(KERN_INFO "Brought up %ld CPUs\n", (long)num_online_cpus());
 	smp_cpus_done(max_cpus);
-#if 0
-	/* Get other processors into their bootup holding patterns. */
-
-	smp_commence();
-#endif
 }

 #endif
