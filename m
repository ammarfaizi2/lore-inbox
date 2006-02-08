Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWBHMai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWBHMai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 07:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030373AbWBHMai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 07:30:38 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:55310 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030372AbWBHMah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 07:30:37 -0500
Date: Wed, 8 Feb 2006 13:30:35 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] remove bogus comment from init/main.c
Message-ID: <20060208123035.GA1656@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove bogus comment from init function which could lead to the
assumption that cpu_possible_map is setup in smp_prepare_cpus().

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 init/main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 7c79da5..4c194c4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -668,7 +668,6 @@ static int init(void * unused)
 	 */
 	child_reaper = current;
 
-	/* Sets up cpus_possible() */
 	smp_prepare_cpus(max_cpus);
 
 	do_pre_smp_initcalls();
