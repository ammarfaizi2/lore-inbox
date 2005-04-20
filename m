Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261536AbVDTMGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVDTMGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 08:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDTMGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 08:06:45 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:21730 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261536AbVDTMGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 08:06:24 -0400
Message-ID: <426646EE.1010505@jp.fujitsu.com>
Date: Wed, 20 Apr 2005 21:11:26 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Subject: [RFC][PATCH] nameing reserved pages [2/3]
Content-Type: multipart/mixed;
 boundary="------------000602030004050000080000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602030004050000080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

naming reserved-at-boot page.
-- Kame

--------------000602030004050000080000
Content-Type: text/plain;
 name="mark_reserved_boot.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mark_reserved_boot.patch"


Nameing Reserved at boot pages as Reserved_At_Boot.

Signed-off-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


---

 linux-2.6.12-rc2-kamezawa/mm/page_alloc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN mm/page_alloc.c~mark_reserved_boot mm/page_alloc.c
--- linux-2.6.12-rc2/mm/page_alloc.c~mark_reserved_boot	2005-04-20 10:39:22.000000000 +0900
+++ linux-2.6.12-rc2-kamezawa/mm/page_alloc.c	2005-04-20 10:39:22.000000000 +0900
@@ -1589,7 +1589,7 @@ void __init memmap_init_zone(unsigned lo
 		set_page_zone(page, NODEZONE(nid, zone));
 		set_page_count(page, 0);
 		reset_page_mapcount(page);
-		SetPageReserved(page);
+		set_page_reserved(page, Reserved_At_Boot);
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */

_

--------------000602030004050000080000--

