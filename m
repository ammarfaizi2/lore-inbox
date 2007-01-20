Return-Path: <linux-kernel-owner+w=401wt.eu-S965344AbXATSry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965344AbXATSry (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 13:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965349AbXATSrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 13:47:53 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53362 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965344AbXATSrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 13:47:53 -0500
X-Originating-Ip: 74.109.98.130
Date: Sat, 20 Jan 2007 13:28:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Remove final reference to superfluous smp_commence().
Message-ID: <Pine.LNX.4.64.0701201326330.24479@CPE00045a9c397f-CM001225dbafb6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Remove the last (and commented out) invocation of the obsolete
smp_commence() call.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

diff --git a/init/main.c b/init/main.c
index 8b4a7d7..4e88bdd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -395,11 +395,6 @@ static void __init smp_init(void)
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

