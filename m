Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSA1XNN>; Mon, 28 Jan 2002 18:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287657AbSA1XND>; Mon, 28 Jan 2002 18:13:03 -0500
Received: from vsdc01.corp.publichost.com ([64.7.196.123]:48401 "EHLO
	vsdc01.corp.publichost.com") by vger.kernel.org with ESMTP
	id <S287616AbSA1XMx>; Mon, 28 Jan 2002 18:12:53 -0500
Message-ID: <3C55DAEF.7020500@vitalstream.com>
Date: Mon, 28 Jan 2002 15:12:47 -0800
From: Rick Stevens <rstevens@vitalstream.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <E16VHy5-0000Bz-00@starship.berlin> <3C55C39A.8040203@vitalstream.com> <E16VKR5-0000DG-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> Since the page was copied to the child, the child's page table must be 
> altered, and since it is shared, it must first be instantiated by the child.  
> So after all the dust settles, the parent and child have their own copies of 
> a page table page, which differ only at a single location: the child's page 
> table points at its freshly made CoW copy, and the parent's page table points 
> at the original page.

> 
> The beauty of this is, the page table could just as easily have been shared 
> by a sibling of the child, not the parent at all, in the case that the parent 
> had already instantiated its own copy of the page table page because of an 
> earlier CoW.


Ok.  Still seems like a bit more copying than necessary.  I'd have
to look at it a bit more and do some noodling.

 
> Confused yet?  Welcome to the club ;-)


Does my head exploding qualify for "confused"?  If so, then I'm not
yet "confused".  I'm "concerned", since my ears are bleeding (a
precursor to an explosion) ;-p

----------------------------------------------------------------------
- Rick Stevens, SSE, VitalStream, Inc.      rstevens@vitalstream.com -
- 949-743-2010 (Voice)                    http://www.vitalstream.com -
-                                                                    -
-        "More hay, Trigger?" "No thanks, Roy, I'm stuffed!"         -
----------------------------------------------------------------------

