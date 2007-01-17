Return-Path: <linux-kernel-owner+w=401wt.eu-S1751006AbXAQWyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbXAQWyQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 17:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXAQWyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 17:54:16 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:57234 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbXAQWyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 17:54:15 -0500
X-Originating-Ip: 74.109.98.130
Date: Wed, 17 Jan 2007 17:48:33 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH]  Add new categories of DEPRECATED and OBSOLETE.
Message-ID: <Pine.LNX.4.64.0701171745480.4740@CPE00045a9c397f-CM001225dbafb6>
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


  Next to EXPERIMENTAL, add two new kernel config categories of
DEPRECATED and OBSOLETE.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  speak now or forever ... too late.


diff --git a/init/Kconfig b/init/Kconfig
index a3f83e2..433dd30 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -29,9 +29,10 @@ config EXPERIMENTAL
 	  <file:Documentation/BUG-HUNTING>, and
 	  <file:Documentation/oops-tracing.txt> in the kernel source).

-	  This option will also make obsoleted drivers available. These are
-	  drivers that have been replaced by something else, and/or are
-	  scheduled to be removed in a future kernel release.
+	  At the moment, this option also makes obsolete drivers available,
+	  but such drivers really should be removed from the EXPERIMENTAL
+	  category and added to either DEPRECATED or OBSOLETE, depending
+	  on their status.

 	  Unless you intend to help test and develop a feature or driver that
 	  falls into this category, or you have a situation that requires
@@ -40,6 +41,26 @@ config EXPERIMENTAL
 	  you say Y here, you will be offered the choice of using features or
 	  drivers that are currently considered to be in the alpha-test phase.

+config DEPRECATED
+	bool "Prompt for deprecated code/drivers"
+	default y
+	---help---
+	  Code that is tagged as "deprecated" is officially still available
+	  for use but will typically have already been scheduled for removal
+	  at some point, so it's in your best interests to start looking for
+	  an alternative.
+
+config OBSOLETE
+	bool "Prompt for obsolete code/drivers"
+	default n
+	---help---
+	  Code that is tagged as "obsolete" is officially no longer supported
+	  and shouldn't play a part in any normal build, but those features
+	  might still be available if you absolutely need access to them.
+
+	  You are *strongly* discouraged from continuing to depend on
+	  obsolete code on an ongoing, long-term basis.
+
 config BROKEN
 	bool

