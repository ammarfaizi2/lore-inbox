Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261384AbSIZPTa>; Thu, 26 Sep 2002 11:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261383AbSIZPTa>; Thu, 26 Sep 2002 11:19:30 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:3477 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261381AbSIZPTa>;
	Thu, 26 Sep 2002 11:19:30 -0400
Message-ID: <3D9326AF.4050803@colorfullife.com>
Date: Thu, 26 Sep 2002 17:24:31 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Andrew Morton <akpm@digeo.com>, Ed Tomlinson <tomlins@cam.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
References: <3D931608.3040702@colorfullife.com> <20020926142054.GR3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> This might need testing on large-memory 64-bit boxen for that, since
> ZONE_NORMAL pressure outweighs many other considerations on my boxen.
> 

Most of them will be SMP, correct? For SMP, 95% of the memory operations 
occur in the per-cpu arrays. I'm not sure if a slab is really the right 
backend behind the per-cpu arrays - perhaps a algorithms that's more 
aggressive toward finding freeable pages would be a better choice, even 
if it needs more cpu time for sorting/searching through the partially 
allocated pages.

--
	Manfred

