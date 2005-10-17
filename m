Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVJQWkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVJQWkx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVJQWkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:40:53 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:29379 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932354AbVJQWkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:40:52 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [PATCH 1/4] swsusp: get rid of unnecessary wrapper function
Date: Mon, 17 Oct 2005 23:40:19 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200510172336.53194.rjw@sisk.pl>
In-Reply-To: <200510172336.53194.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172340.20038.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch merges two functions in a trivial way.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc4-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/power/snapshot.c	2005-10-17 23:28:36.000000000 +0200
+++ linux-2.6.14-rc4-mm1/kernel/power/snapshot.c	2005-10-17 23:28:40.000000000 +0200
@@ -384,7 +384,7 @@
 	return 0;
 }
 
-static int suspend_prepare_image(void)
+asmlinkage int swsusp_save(void)
 {
 	int error;
 
@@ -433,9 +433,3 @@
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_copy_pages );
 	return 0;
 }
-
-
-asmlinkage int swsusp_save(void)
-{
-	return suspend_prepare_image();
-}

