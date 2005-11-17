Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161040AbVKQAKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161040AbVKQAKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030576AbVKQAKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:10:45 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:33194 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030568AbVKQAKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:10:44 -0500
Message-ID: <437BCA5B.4080800@jp.fujitsu.com>
Date: Thu, 17 Nov 2005 09:10:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>	 <437B2C82.6020803@jp.fujitsu.com> <1132147036.7915.19.camel@localhost>	 <437B5801.4010204@jp.fujitsu.com> <1132158704.19290.3.camel@localhost>
In-Reply-To: <1132158704.19290.3.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> Hmmm.  I _think_ you're just trying to do some things at runtime that I
> didn't intend.  In the patch I pointed to in the last mail, look at what
> I did in hot_add_zone_init().  It does some of what
> free_area_init_core() does, but only the most minimal bits.  Basically:
> 
>        zone_wait_table_init(zone, size_pages);
>        init_currently_empty_zone(zone, phys_start_pfn, size_pages);
>        zone_pcp_init(zone);
> 
> Your way may also be valid, but I broke out init_currently_empty_zone()
> for a reason, and I think this was it.  I don't think we want to be
> calling free_area_init_core() itself at runtime.
> 

I understand what is missing..
"add new zone" function is not in -mm kernel.
So, I can't add new pages into Highmem which is empty at boot time.
Could you post your "add new zone" patch to -mm ?

-- Kame

