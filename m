Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUJFFAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUJFFAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 01:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUJFFAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 01:00:18 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:10106 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267250AbUJFFAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 01:00:09 -0400
Message-ID: <41637BD5.7090001@yahoo.com.au>
Date: Wed, 06 Oct 2004 15:00:05 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kenneth.w.chen@intel.com, mingo@redhat.com, linux-kernel@vger.kernel.org,
       Judith Lebzelter <judith@osdl.org>
Subject: Re: Default cache_hot_time value back to 10ms
References: <200410060042.i960gn631637@unix-os.sc.intel.com>	<20041005205511.7746625f.akpm@osdl.org>	<416374D5.50200@yahoo.com.au> <20041005215116.3b0bd028.akpm@osdl.org>
In-Reply-To: <20041005215116.3b0bd028.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> This tunable caused an 11% performance difference in (I assume) TPCx. 
> That's a big deal, and people will want to diddle it.
> 

True. But 2.5 I think really is too low (for anyone, except maybe a
CPU with no/a tiny L2 cache).

> If one number works optimally for all machines and workloads then fine.
> 

Yeah.. 10ms may bring up idle times a bit on other workloads. Judith
had some database tests that were very sensitive to this - if 10ms is
OK there, then I'd say it would be OK for most things.

> But yes, avoiding a tunable would be nice, but we need a tunable to work
> out whether we can avoid making it tunable ;)
> 

Heh. I think it would be good to have a automatic thingy to tune it.
A smarter cache_decay_ticks calculation would suit.

> Not that I'm soliciting patches or anything.  I'll duck this one for now.
> 

OK. Any idea when 2.6.9 will be coming out? :)
