Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265658AbSJXVKN>; Thu, 24 Oct 2002 17:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265661AbSJXVKN>; Thu, 24 Oct 2002 17:10:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:53001 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id <S265658AbSJXVKH>;
	Thu, 24 Oct 2002 17:10:07 -0400
Date: Thu, 24 Oct 2002 23:16:08 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Dieter N?tzel <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>, Robert Love <rml@tech9.net>
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024211608.GB486@pcw.home.local>
References: <200210242251.26776.Dieter.Nuetzel@hamburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210242251.26776.Dieter.Nuetzel@hamburg.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 10:51:26PM +0200, Dieter N?tzel wrote:
> copy_page by 'even_faster'       took 5616 cycles (1112.9 MB/s)

something bothers me here : with PC2100 RAM, you copy 1113 MB/s, that
is 1113 MB in + 1113 MB out !

I tried your code and code somewhat same results (dual xp1800+, pc2100, 760MPX).
but I pasted the no_prefetch_copy_page() function into it and now it says that I
copy 1455 MB/s ! I didn't look deep through the code, but I suspect that there's
some static work that is not accounted, or a subtract between two counters, or
something like that.

Cheers,
Willy

