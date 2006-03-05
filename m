Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWCECsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWCECsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 21:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWCECsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 21:48:36 -0500
Received: from havoc.gtf.org ([69.61.125.42]:31893 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750789AbWCECsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 21:48:35 -0500
Date: Sat, 4 Mar 2006 21:48:32 -0500
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git patch] misc hw_random fix
Message-ID: <20060305024832.GA11302@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes an array mis-index on non-x86...



Please pull from 'upstream-fixes' branch of
master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to receive the following updates:

 drivers/char/hw_random.c |    2 ++
 1 files changed, 2 insertions(+)

Mark Brown:
      Add missing ifdef for VIA RNG code

diff --git a/drivers/char/hw_random.c b/drivers/char/hw_random.c
index b3bc2e3..29dc87e 100644
--- a/drivers/char/hw_random.c
+++ b/drivers/char/hw_random.c
@@ -131,7 +131,9 @@ enum {
 	rng_hw_none,
 	rng_hw_intel,
 	rng_hw_amd,
+#ifdef __i386__
 	rng_hw_via,
+#endif
 	rng_hw_geode,
 };
 
