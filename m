Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286758AbSA1WAq>; Mon, 28 Jan 2002 17:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286871AbSA1WAg>; Mon, 28 Jan 2002 17:00:36 -0500
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:48909 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S286758AbSA1WA3>; Mon, 28 Jan 2002 17:00:29 -0500
Message-ID: <3C55C9F7.6010106@vitalstream.com>
Date: Mon, 28 Jan 2002 14:00:23 -0800
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33L.0201281940580.32617-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> On Mon, 28 Jan 2002, Rick Stevens wrote:
> 
>>Daniel Phillips wrote:
>>[snip]
>>
>   [page table COW description]
> 
> 
>>Perhaps I'm missing this, but I read that as the child gets a reference
>>to the parent's memory.  If the child attempts a write, then new memory
>>is allocated, data copied and the write occurs to this new memory.  As
>>I read this, it's only invoked on a child write.
>>
>>Would this not leave a hole where the parent could write and, since the
>>child shares that memory, the new data would be read by the child?  Sort
>>of a hidden shm segment?  If so, I think we've got problems brewing.
>>Now, if a parent write causes the same behaviour as a child write, then
>>my point is moot.
>>
> 
> Daniel and I discussed this issue when Daniel first came up with
> the idea of doing page table COW.  He seemed a bit confused by
> fork semantics when we first discussed this idea, too ;)
> 
> You're right though, both parent and child need to react in the
> same way, preferably _without_ having to walk all of the parent's
> page tables and mark them read-only ...


Ah, good!  I wasn't losing it then.  That's a relief!

I've gotta read up on the kernel's VM system.  I use to write them
for a certain three-letter-acronymed company--many, many moons ago.
Maybe I'd have some ideas.  Then again, perhaps not.

----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-     Veni, Vidi, VISA:  I came, I saw, I did a little shopping.     -
----------------------------------------------------------------------

