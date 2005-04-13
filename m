Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263014AbVDMBhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbVDMBhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 21:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVDMBeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 21:34:37 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:42337 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262135AbVDMBcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 21:32:08 -0400
Message-ID: <425C7691.80605@yahoo.com.au>
Date: Wed, 13 Apr 2005 11:32:01 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: axboe@suse.de, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: [patch 6/9] blk: unplug later
References: <425BC262.1070500@yahoo.com.au>	<425BC421.9010302@yahoo.com.au> <20050412125859.209beead.akpm@osdl.org>
In-Reply-To: <20050412125859.209beead.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>get_request_wait needn't unplug the device immediately.
> 
> 
> Probably.  But what if the get_request(q, rw, GFP_NOIO); did
> some sleeping?
> 

It can't sleep unless it returns the request, because it
is using mempool allocs. So any time it returns NULL, it
hasn't slept.

But Jens would have a better idea of the correct behaviour.
Jens, what do you think?

-- 
SUSE Labs, Novell Inc.

