Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbULYRfd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbULYRfd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:35:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbULYRfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:35:32 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:43648 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261540AbULYRfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:35:25 -0500
Date: Sat, 25 Dec 2004 18:32:35 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Right severity level for fatal message
Message-ID: <20041225173235.GA9122@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Telling user machine will crash with default loglevel is nice joke, it
at least needs worse severity. Please apply,
                                                                Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/mm/page_alloc.c	2004-11-19 12:54:54.000000000 +0100
+++ linux-cvs/mm/page_alloc.c	2004-12-10 22:35:59.000000000 +0100
@@ -1581,7 +1585,7 @@
 		zone->zone_start_pfn = zone_start_pfn;
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk("BUG: wrong zone alignment, it will crash\n");
+			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
 
 		memmap_init(size, nid, j, zone_start_pfn);
 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
