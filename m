Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261299AbSIZOPn>; Thu, 26 Sep 2002 10:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261300AbSIZOPn>; Thu, 26 Sep 2002 10:15:43 -0400
Received: from holomorphy.com ([66.224.33.161]:56741 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261299AbSIZOPn>;
	Thu, 26 Sep 2002 10:15:43 -0400
Date: Thu, 26 Sep 2002 07:20:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@digeo.com>, Ed Tomlinson <tomlins@cam.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
Message-ID: <20020926142054.GR3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Andrew Morton <akpm@digeo.com>, Ed Tomlinson <tomlins@cam.org>,
	linux-kernel@vger.kernel.org
References: <3D931608.3040702@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D931608.3040702@colorfullife.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Ed Tomlinson wrote:
>> Slab caches no longer hold onto completely empty pages.  Instead, pages
>> are freed as soon as they have zero objects.  This is possibly a
>> performance hit for slabs which have constructors, but it's doubtful. 

On Thu, Sep 26, 2002 at 04:13:28PM +0200, Manfred Spraul wrote:
> It could be a performance hit for slab with just one object - e.g the 
> page sized names cache, used in every syscall that has a path name as a 
> parameter.
> Ed, have you benchmarked that there is no noticable slowdown?
> e.g. test the time needed for stat("."). on UP, otherwise the SMP arrays 
> would perform the caching.

This might need testing on large-memory 64-bit boxen for that, since
ZONE_NORMAL pressure outweighs many other considerations on my boxen.


Cheers,
Bill
