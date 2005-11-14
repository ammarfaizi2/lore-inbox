Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVKNTiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVKNTiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKNTiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:38:12 -0500
Received: from 81-178-76-253.dsl.pipex.com ([81.178.76.253]:63907 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751251AbVKNTiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:38:10 -0500
Date: Mon, 14 Nov 2005 19:37:37 +0000
To: akpm@osdl.org
Cc: apw@shadowen.org, kravetz@us.ibm.com, haveblue@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] __add_section remove unused pgdat definition
Message-ID: <20051114193737.GA15487@shadowen.org>
References: <exportbomb.1131997056@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
InReply-To: <exportbomb.1131997056@pinky>
User-Agent: Mutt/1.5.9i
From: Andy Whitcroft <apw@shadowen.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__add_section defines an unused pointer to the zones pgdat.  Remove
this definition.  This fixes a compile warning.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
 memory_hotplug.c |    1 -
 1 file changed, 1 deletion(-)
diff -upN reference/mm/memory_hotplug.c current/mm/memory_hotplug.c
--- reference/mm/memory_hotplug.c
+++ current/mm/memory_hotplug.c
@@ -42,7 +42,6 @@ extern int sparse_add_one_section(struct
 				  int nr_pages);
 static int __add_section(struct zone *zone, unsigned long phys_start_pfn)
 {
-	struct pglist_data *pgdat = zone->zone_pgdat;
 	int nr_pages = PAGES_PER_SECTION;
 	int ret;
 
