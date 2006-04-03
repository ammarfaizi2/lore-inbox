Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWDCETR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWDCETR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 00:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964776AbWDCETR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 00:19:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52116 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964783AbWDCETQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 00:19:16 -0400
Date: Sun, 2 Apr 2006 23:19:16 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: missing \n in sc1200wdt driver.
Message-ID: <20060403041916.GB9115@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix printk output.

sc1200wdt: build 20020303<3>sc1200wdt: io parameter must be specified

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/drivers/char/watchdog/sc1200wdt.c~	2006-02-01 22:24:11.000000000 -0500
+++ linux-2.6.15.noarch/drivers/char/watchdog/sc1200wdt.c	2006-02-01 22:24:43.000000000 -0500
@@ -377,7 +377,7 @@ static int __init sc1200wdt_init(void)
 {
 	int ret;
 
-	printk(banner);
+	printk("%s\n", banner);
 
 	spin_lock_init(&sc1200wdt_lock);
 	sema_init(&open_sem, 1);


