Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWA0AmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWA0AmL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 19:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWA0AmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 19:42:11 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:31362 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932290AbWA0AmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 19:42:09 -0500
Message-ID: <43D96C41.6020103@jp.fujitsu.com>
Date: Fri, 27 Jan 2006 09:41:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
CC: Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/9] Reducing fragmentation using zones
 v4
References: <20060126184305.8550.94358.sendpatchset@skynet.csn.ul.ie> <43D96987.8090608@jp.fujitsu.com>
In-Reply-To: <43D96987.8090608@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KAMEZAWA Hiroyuki wrote:
> Could you add this patch to your set ?
> This was needed to boot my x86 machine without HIGHMEM.
> 
Sorry, I sent a wrong patch..
This is correct one.
-- Kame

Index: linux-2.6.16-rc1-mm3/mm/highmem.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/mm/highmem.c
+++ linux-2.6.16-rc1-mm3/mm/highmem.c
@@ -225,9 +225,6 @@ static __init int init_emergency_pool(vo
  	struct sysinfo i;
  	si_meminfo(&i);
  	si_swapinfo(&i);
-
-	if (!i.totalhigh)
-		return 0;

  	page_pool = mempool_create(POOL_SIZE, page_pool_alloc, page_pool_free, NULL);
  	if (!page_pool)



