Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129839AbRCATrD>; Thu, 1 Mar 2001 14:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129840AbRCATqy>; Thu, 1 Mar 2001 14:46:54 -0500
Received: from colorfullife.com ([216.156.138.34]:53764 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129839AbRCATqq>;
	Thu, 1 Mar 2001 14:46:46 -0500
Message-ID: <3A9EA740.4F8647D3@colorfullife.com>
Date: Thu, 01 Mar 2001 20:47:12 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Q: explicit alignment control for the slab allocator
In-Reply-To: <3A9E8628.7CCD1162@colorfullife.com> <15006.41335.378413.427127@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> Manfred, why are you changing the cache alignment to
> SMP_CACHE_BYTES?  If you read the original SLAB papers
> and other documents, the code intends to color the L1
> cache not the L2 or subsidiary caches.
>
I'll undo that change.

I only found this comment in the source file:

> /* For performance, all the general caches are L1 aligned.
>  * This should be particularly beneficial on SMP boxes, as it
>  * eliminates "false sharing".
>  * Note for systems short on memory removing the alignment will
>  * allow tighter packing of the smaller caches. */

To avoid false sharing we would need SMP_CACHE_BYTES aligning, not L1
aligning.

--
	Manfred
