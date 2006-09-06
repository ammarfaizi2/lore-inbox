Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWIFQLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWIFQLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWIFQLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:11:08 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:4619 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751362AbWIFQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:11:04 -0400
Subject: Re: [patch 5/6] debugfs entries for configuration [bug fix]
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 09:07:21 -0700
Message-Id: <1157558841.9460.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation when (CONFIG_FAILSLAB=n ^ CONFIG_FAIL_MAKE_REQUEST=n).

Signed-off-by: Don Mullis <dwm@meer.net>

---
 lib/should_fail_knobs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.17/lib/should_fail_knobs.c
===================================================================
--- linux-2.6.17.orig/lib/should_fail_knobs.c
+++ linux-2.6.17/lib/should_fail_knobs.c
@@ -124,13 +124,13 @@ static struct should_fail_knobs fail_mak
 static void cleanup_knobs(void)
 {
 #ifdef CONFIG_FAILSLAB
-	cleanup_should_fail_knobs(&fail_make_request_knobs);
+	cleanup_should_fail_knobs(&failslab_knobs);
 #endif
 #ifdef CONFIG_FAIL_PAGE_ALLOC
 	cleanup_should_fail_knobs(&fail_page_alloc_knobs);
 #endif
 #ifdef CONFIG_FAIL_MAKE_REQUEST
-	cleanup_should_fail_knobs(&failslab_knobs);
+	cleanup_should_fail_knobs(&fail_make_request_knobs);
 #endif
 }
 


