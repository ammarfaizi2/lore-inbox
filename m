Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261318AbSIZOI3>; Thu, 26 Sep 2002 10:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbSIZOI3>; Thu, 26 Sep 2002 10:08:29 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:55188 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261318AbSIZOI2>;
	Thu, 26 Sep 2002 10:08:28 -0400
Message-ID: <3D931608.3040702@colorfullife.com>
Date: Thu, 26 Sep 2002 16:13:28 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/4] slab reclaim balancing
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Slab caches no longer hold onto completely empty pages.  Instead, pages
> are freed as soon as they have zero objects.  This is possibly a
> performance hit for slabs which have constructors, but it's doubtful. 

It could be a performance hit for slab with just one object - e.g the 
page sized names cache, used in every syscall that has a path name as a 
parameter.

Ed, have you benchmarked that there is no noticable slowdown?
e.g. test the time needed for stat("."). on UP, otherwise the SMP arrays 
would perform the caching.

--
	Manfred

