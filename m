Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265362AbUEZIpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265362AbUEZIpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265365AbUEZIpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:45:12 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:58775 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265362AbUEZIpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:45:05 -0400
Message-ID: <40B4590A.1090006@yahoo.com.au>
Date: Wed, 26 May 2004 18:44:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
In-Reply-To: <S265353AbUEZI1M/20040526082712Z+1294@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
> No. I am not making any assertions whatsoever. I am just calling out that
> systems that run happily from physical memory and are not in need of swap
> should never sacrifice an ounce of performance for even drastic improvements
> to swap performance. Swap is a band-aid for saving money on memory and a few
> years ago, it allowed you to save a substantial amount of money. 
> 

Hi Buddy,
Even for systems that don't *need* the extra memory space, swap can
actually provide performance improvements by allowing unused memory
to be replaced with often-used memory.

For example, I have 57MB swapped right now. It allows me to instantly
grep the kernel tree. If I turned swap off, each grep would probably
take 30 seconds.

The VM doesn't always get it right, and to make matters worse, desktop
users don't appreciate their long running jobs finishing earlier, but
*hate* having to wait a few seconds for a window to appear if it hasn't
been used for 24 hours.

> Whether the cost savings for utilizing swap vs buying more memory are
> substantial as of late is subject to opinion, but I cannot think of a system
> that I have sized in the last three years where swap was expected to be used
> except in un-anticipated memory shortfalls. In fact, if I didn't plan to
> store crash dumps on the swap device, I think I would have omitted swap all
> together in many configurations.
> 
> I have worked at large fortune 500 companies with deep pockets though, so
> this may not be the case for many. I make this point though because I think
> if it isn't the case yet, it will be in the near future as memory becomes
> even cheaper because the trend certainly exists.
> 
> As for your short, two sentence comment below, let me save you the energy of
> insinuations and translate your message the way I read it: 
> 

[snip]

I think the comment was rather directed at a specific problem you
described:

 > This of course doesn't address the VM paging storms that happen due to large
 > amounts of file system writes. Once the pagecache fills up, dirty pages must
 > be evicted from the pagecache so that new pages can be added to the
 > pagecache.

This sounds like you are having a serious problem, and it would be
great if you could describe it in detail. kernel version, workload,
description of the system, vmstat output, etc.

Let's keep it nice.

Best regards
Nick
