Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269967AbUJNEod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269967AbUJNEod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269970AbUJNEoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:44:32 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:24812 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S269967AbUJNEoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:44:04 -0400
Date: Thu, 14 Oct 2004 13:49:40 +0900
From: Hiroyuki KAMEZAWA <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: bug in 2.6.9-rc4-mm1 ia64/mm/init.c
In-reply-to: <416CEF0E.1060406@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, akepner@sgi.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jbarnes@sgi.com
Message-id: <416E0564.9030002@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.3)
 Gecko/20040910
References: <Pine.LNX.4.33.0410121705510.31839-100000@localhost.localdomain>
 <16748.57721.66330.638048@napali.hpl.hp.com> <416CEADA.2060207@jp.fujitsu.com>
 <16748.60002.875945.950324@napali.hpl.hp.com> <416CEF0E.1060406@jp.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

this patch removes problematic GRANULEROUNDDOWN/GRANULEROUNDUP lines
from 2.6.9-rc4-mm1, arch/ia64m/mm/init.c.

I think aligning memmap patch should be removed now,
and be discussed when it really looks necessary.

Thanks.

Kame <kamezawa.hiroyu@jp.fujitsu.com>

---

  linux-2.6.9-rc4-mm1-kamezawa/arch/ia64/mm/init.c |    2 --
  1 files changed, 2 deletions(-)

diff -puN arch/ia64/mm/init.c~ia64_bugfix arch/ia64/mm/init.c
--- linux-2.6.9-rc4-mm1/arch/ia64/mm/init.c~ia64_bugfix	2004-10-14 07:26:04.283256397 +0900
+++ linux-2.6.9-rc4-mm1-kamezawa/arch/ia64/mm/init.c	2004-10-14 07:26:23.644584285 +0900
@@ -410,8 +410,6 @@ virtual_memmap_init (u64 start, u64 end,
  	struct page *map_start, *map_end;

  	args = (struct memmap_init_callback_data *) arg;
-	start = GRANULEROUNDDOWN(start);
-	end = GRANULEROUNDUP(end);
  	map_start = vmem_map + (__pa(start) >> PAGE_SHIFT);
  	map_end   = vmem_map + (__pa(end) >> PAGE_SHIFT);


_

