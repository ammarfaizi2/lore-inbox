Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUG1BAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUG1BAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 21:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUG1BAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 21:00:31 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:53655 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266703AbUG1BAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 21:00:30 -0400
Message-ID: <4106FAAB.5080106@yahoo.com.au>
Date: Wed, 28 Jul 2004 11:00:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Ed Sweetman <safemode@comcast.net>
CC: Jens Axboe <axboe@suse.de>, Jan-Frode Myklebust <janfrode@parallab.uib.no>,
       linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy.
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no> <410500FD.8070206@comcast.net> <4105D7ED.5040206@yahoo.com.au> <20040727100724.GA11189@suse.de> <41065748.8050107@comcast.net> <41065902.20909@yahoo.com.au> <4106D978.7090008@comcast.net>
In-Reply-To: <4106D978.7090008@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> Nick Piggin wrote:
> 

>> OK so it does sound like a different problem.
>>
>> I didn't follow your other thread closely... does /proc/slabinfo
>> show any evidence of a leak?
> 
> 
> 
> Surprisingly no. You'd think that since the kernel is responsible for 
> saying what memory can't be touched or swapped out it would have some 
> sort of tag on the huge 600MB of ram I currently can't do anything with 
> since i burned that audio cd but slabinfo doesn't seem to show anything 
> about it. Maybe i'm reading it wrong.
> 

It could be memory coming straight out of the page allocator that
isn't being freed.

Jens, any ideas?
