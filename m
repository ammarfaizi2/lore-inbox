Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUDEVKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263213AbUDEVIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:08:05 -0400
Received: from gprs214-195.eurotel.cz ([160.218.214.195]:35200 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263202AbUDEVH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:07:26 -0400
Date: Mon, 5 Apr 2004 23:07:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Telling user machine is going to crash at KERN_WARNING level is good joke
Message-ID: <20040405210717.GA3558@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...but its victims might not like it. Please apply,
							Pavel

--- tmp/linux/mm/page_alloc.c	2004-04-05 10:45:31.000000000 +0200
+++ linux/mm/page_alloc.c	2004-04-05 16:50:49.000000000 +0200
@@ -1478,7 +1478,7 @@
 		zone->zone_start_pfn = zone_start_pfn;
 
 		if ((zone_start_pfn) & (zone_required_alignment-1))
-			printk("BUG: wrong zone alignment, it will crash\n");
+			printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");
 
 		memmap_init(lmem_map, size, nid, j, zone_start_pfn);
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
