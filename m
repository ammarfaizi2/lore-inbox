Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbSJJED0>; Thu, 10 Oct 2002 00:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJJEDZ>; Thu, 10 Oct 2002 00:03:25 -0400
Received: from franka.aracnet.com ([216.99.193.44]:30924 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262824AbSJJEDZ>; Thu, 10 Oct 2002 00:03:25 -0400
Date: Wed, 09 Oct 2002 21:06:16 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: colpatch@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org, LSE <lse-tech@lists.sourceforge.net>,
       Andrew Morton <akpm@zip.com.au>, Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [rfc][patch] Memory Binding API v0.3 2.5.41
Message-ID: <1586204621.1034197575@[10.10.2.3]>
In-Reply-To: <3DA4D3E4.6080401@us.ibm.com>
References: <3DA4D3E4.6080401@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#define for_each_valid_zone(zone, zonelist) 		\
> +	for (zone = *zonelist->zones; zone; zone++)	\
> +		if (current->memblk_binding.bitmask & (1 << zone->zone_pgdat->memblk_id))

Does the compiler optimise the last bit away on non-NUMA?
Want to wrap it in #ifdef CONFIG_NUMA_MEMBIND or something?
Not sure what the speed impact of this would be, but I'd
rather it was optional, even on NUMA boxen.

Other than that, looks pretty good.

M.


