Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262416AbSJDTAi>; Fri, 4 Oct 2002 15:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSJDTAi>; Fri, 4 Oct 2002 15:00:38 -0400
Received: from packet.digeo.com ([12.110.80.53]:47068 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262416AbSJDTAh>;
	Fri, 4 Oct 2002 15:00:37 -0400
Message-ID: <3D9DE69C.C6E88C9F@digeo.com>
Date: Fri, 04 Oct 2002 12:06:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [PATCH] patch-slab-split-03-tail
References: <3D9DCA1D.7070400@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Oct 2002 19:06:04.0980 (UTC) FILETIME=[1686BF40:01C26BD9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> part 3:
> [depends on -02-SMP]
> 
> If an object is freed from a slab, then move the slab to the tail of the
> partial list - this should increase the probability that the other
> objects from the same page are freed, too, and that a page can be
> returned to gfp later.
> 
> The cpu arrays are now always in front of the list, i.e. cache hit rates
> should not matter.
> 

Run that by me again?  So we're saying "if we just freed an
object from this page then make this page be the *last* page
which is eligible for new allocations"?  Under the assumption
that other objects in that same page are about to be freed
up as well?

Makes sense.  It would be nice to get this confirmed in 
targetted testing ;)
