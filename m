Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbUB2Gee (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 01:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUB2Gee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 01:34:34 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:40393 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261986AbUB2Gec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 01:34:32 -0500
Message-ID: <404187EA.6090307@matchmail.com>
Date: Sat, 28 Feb 2004 22:34:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
 end)
References: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
In-Reply-To: <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> On Fri, 27 Feb 2004, Andrea Arcangeli wrote:
>>>Then again, your stuff will also find pages the moment they're
>>>cleaned, just at the cost of a (little?) bit more CPU time.
>>
>>exactly, that's an important effect of my patch and that's the only
>>thing that o1 vm is taking care of, I don't think it's enough since the
>>gigs of cache would still be like a memleak without my code.
> 
> 
> ... however, if you have a hundred gigabyte of memory, or
> even more, then you cannot afford to search the inactive
> list for clean pages on swapout. It will end up using too
> much CPU time.
> 
> The FreeBSD people found this out the hard way, even on
> smaller systems...

So that's what the inact_clean list is for in 2.4-rmap.

But your inactive lists are always much smaller than the active list on 
the smallish (< 1.5G) machines...
