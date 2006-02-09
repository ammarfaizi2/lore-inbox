Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWBIOVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWBIOVL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 09:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWBIOVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 09:21:10 -0500
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:52323 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932268AbWBIOVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 09:21:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Fd1cHtARlLalYjM89lADWEeKgqfNpl5Kys2wdj7rdyGTq1Oo0fgqYiacqm3ujZq9aDw5sO08sEWwoQ7w/UgZMPJ9y+KT3fs1y4T1ID31X1A2q6ghaBApulcf5+ZHpP7b5nfw0rB/lT0IUzeFco+DRPZnkHo/RAk57lDGnxQ1s1w=  ;
Message-ID: <43EB4FD5.20107@yahoo.com.au>
Date: Fri, 10 Feb 2006 01:21:09 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       ck list <ck@vds.kolivas.org>, linux-mm@kvack.org,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] mm: Implement Swap Prefetching v22
References: <200602092339.49719.kernel@kolivas.org> <43EB43B9.5040001@yahoo.com.au> <200602100047.09722.kernel@kolivas.org>
In-Reply-To: <200602100047.09722.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

> I really don't want to go throwing out pagecache without some smart semantics 
> and then swap in random stuff that could be crap I agree. The answer to this 
> is for the vm itself to have an ageing algorithm like the clockpro stuff 
> which does this in a smart way. It could certainly age away the updatedb 
> wrinkles and leave some free ram - which would help/be helped by prefetching.
> 

AFAIK clockpro will not leave free ram, will it?

Getting a little hand-wavy; I don't think the updatedb problem needs to
be fixed by a really fancy page reclaim algorithm (IMO, and that's not to
say that a fancy reclaim algorithm wouldn't be nice for other reasons).
Just small improvements here and there, and there will always be a tradeoff
between throughput and interactive pagein latency so in the end it might
need a tunable (hey there is one - maybe it needs to be improved)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
