Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbSJXHwA>; Thu, 24 Oct 2002 03:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265340AbSJXHv7>; Thu, 24 Oct 2002 03:51:59 -0400
Received: from packet.digeo.com ([12.110.80.53]:16895 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265339AbSJXHv7>;
	Thu, 24 Oct 2002 03:51:59 -0400
Message-ID: <3DB7A80C.7D13C750@digeo.com>
Date: Thu, 24 Oct 2002 00:58:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [long]2.5.44-mm3 UP went into unexpected trashing
References: <3DB7A581.9214EFCC@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2002 07:58:04.0969 (UTC) FILETIME=[153D6990:01C27B33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> 2.5.44-mm3 just began trashing.  I ran debsums -s in order
> to verify installed packages.  This checksums all
> binaries.  Things got a little sluggish, but it finished.
> 
> Then I started a compile for 2.5.44-mm4, and the machine
> became so hopeless that I stopped the compile.  That
> haven't happened before, I have 256M.
> 
> Looking at a running vmstat I saw lots of swapping,
> almost no free memory (as usual) but _cache_
> was down to 4004 too!

Memory leak.


> dentry_cache      1174824 1174824    140 41958 41958    1 :  248  124 : 1174824 1174923 41958    0    0    0  276 : 1131352  43467      0      0

160 megabytes of dcache.

Hopefully the rcu fix in -mm4 will cure this.
