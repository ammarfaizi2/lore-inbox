Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267224AbTAFXoH>; Mon, 6 Jan 2003 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbTAFXoH>; Mon, 6 Jan 2003 18:44:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:36595 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267224AbTAFXoG>;
	Mon, 6 Jan 2003 18:44:06 -0500
Message-ID: <3E1A16C5.87EDE35A@digeo.com>
Date: Mon, 06 Jan 2003 15:52:37 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Wood <cwood@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1A12B5.4020505@xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 23:52:37.0459 (UTC) FILETIME=[B0DF5A30:01C2B5DE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wood wrote:
> 
> Due to kswapd problems in Redhat's 2.4.9 kernel, I have had to upgrade
> to the 2.4.20 kernel with the IBM Summit Patches for our IBM x440.
> ...
> 16480 total                                      0.0138
>    6383 .text.lock.swap                          110.0517
>    4689 .text.lock.vmscan                         28.2470
>    4486 shrink_cache                               4.6729
>     168 rw_swap_page_base                          0.6176
>     124 prune_icache                               0.5167

With six gigs of memory, it looks like the VM has gone nuts
trying to locate some reclaimable lowmem.

Suggest you send the contents of /proc/meminfo and /proc/slabinfo,
captured during a period of misbehaviour.

Then please apply 
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.20aa1.bz2
and send a report on the outcome.
