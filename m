Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265509AbUEZL5j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265509AbUEZL5j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 07:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUEZL5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 07:57:39 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:15037 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265509AbUEZL5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 07:57:25 -0400
Message-ID: <40B48620.6000309@yahoo.com.au>
Date: Wed, 26 May 2004 21:57:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'John Bradford'" <john@grabjohn.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
>>>That's true, but it's not a magical property of swap space
>>>- extra physical
>>>RAM would do more or less the same thing.
>>>
> 
> 
>>Well it is a magical property of swap space, because extra RAM
>>doesn't allow you to replace unused memory with often used memory.
> 
> 
>>The theory holds true no matter how much RAM you have. Swap can
>>improve performance. It can be trivially demonstrated.
> 
> 
> I bet you have demonstrated this. It strikes me of an observation that could
> be made in a lab environment. But your failing to realize that:
> 
> 1) you will fill physical memory with pages eventually or your not doing
> work.
> 
> 2) pages do not just silently move to the swap device. They move as a result
> of a memory shortfall
> 
> 3) once physical memory is full, file system I/O will only benefit from
> reads that incur a minor fault. All other file system operations are bound
> by the rate you can reclaim pages from physical memory.
> 

No, typically we can reclaim memory very quickly and the operations
are bound by the speed of the block device.

> 4) non-filesystem backed pages are still effected the same way, nothing has
> changed. When you run your next filesystem related operation, those pages
> will be faulted into physical memory, and something will be evicted to it's
> backing store (remember, memory is full).
> 

I haven't failed to realise 1, 2 or 4 and I don't know what you are
arguing about. All I said was basically "no matter how much ram you
have, swap can increase performance by allowing unused anonymous
memory to be paged out, thereby increasing your maximum effective RAM".
