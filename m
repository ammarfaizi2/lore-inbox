Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWBWAT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWBWAT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWBWAT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:19:27 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:24777 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751488AbWBWATX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:19:23 -0500
Message-ID: <43FCFFC0.1050405@jp.fujitsu.com>
Date: Thu, 23 Feb 2006 09:20:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [PATCH] refine for_each_pgdat() [1/4] refine for_each_pgdat
References: <20060222200402.e1145286.kamezawa.hiroyu@jp.fujitsu.com> <20060222145256.7b84f444.akpm@osdl.org>
In-Reply-To: <20060222145256.7b84f444.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> It's confusing and asymmetric.  If you have time, it would be nice to later
> remove for_each_pgdat() and for_each_cpu() from the kernel altogether, use
> for_each_online_cpu(), for_each_possible_cpu(), for_each_online_node(),
> for_each_possible_node().
> 
Okay, I'll rewrite my patch and post new one which represents what you mention.

BTW, I noticed  refine-for_each_pgdat-remove-pgdat-sorting.patch
contains bug. (caller of ia64's insert_pgdat() is not removed...)

so please drop them :(, I'll post new ones to next -mm (with enough test...).

Thanks,
-- Kame



