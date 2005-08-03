Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVHCGiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVHCGiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 02:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262105AbVHCGiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 02:38:01 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:14493 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262084AbVHCGh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 02:37:59 -0400
Date: Wed, 3 Aug 2005 08:37:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Hans Reiser <reiser@namesys.com>, Arjan van de Ven <arjan@infradead.org>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
In-Reply-To: <4CBCB111-36B9-4F8C-9A3F-A9126ADE1CA2@mac.com>
Message-ID: <Pine.LNX.4.61.0508030826000.2263@yvahk01.tjqt.qr>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0508021655580.4138@yvahk01.tjqt.qr>
 <1122994972.3247.31.camel@laptopd505.fenrus.org> <42F01712.2030105@namesys.com>
 <4CBCB111-36B9-4F8C-9A3F-A9126ADE1CA2@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > because reiser got merged before jbd. Next question.
>>
>> That is the wrong reason.  We use our own journaling layer for the
>> reason that Vivaldi used his own melody.
>> 
>> [...] He might want to look at how reiser4 does wandering
>> logs instead of using jbd..... but I would never claim that for sure
>> some other author should be expected to use it.....  and something like
>> changing one's journaling system is not something to do just before a
>> merge.....
>
> Do you see my point here?  If every person who added new kernel code
> just wrote their own thing without checking to see if it had already
> been done before, then there would be a lot of poorly maintained code
> in the kernel.  If a journalling layer already exists, _new_ journaled
> filesystems should either (A) use the layer as is, or (B) fix the layer
> so it has sufficient functionality for them to use, and submit patches.

Maybe jbd 'sucks' for something 'cool' like reiser*, and modifying jbd to be 
'eleet enough' for reiser* would overwhelm ext.

Lastly, there is the 'political' thing, when a <your-favorite-jbd-fs>-only 
specific change to jbd is rejected by all other jbd-using fs. (Basically the 
situation thing that leads to software forks, in any area.)



Jan Engelhardt
-- 
