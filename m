Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262718AbSI1FTw>; Sat, 28 Sep 2002 01:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbSI1FTw>; Sat, 28 Sep 2002 01:19:52 -0400
Received: from netcore.fi ([193.94.160.1]:22276 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S262718AbSI1FTu>;
	Sat, 28 Sep 2002 01:19:50 -0400
Date: Sat, 28 Sep 2002 08:24:58 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: kuznet@ms2.inr.ac.ru
cc: davem@redhat.com, <yoshfuji@linux-ipv6.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
In-Reply-To: <200209280500.JAA02974@sex.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0209280813030.8846-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002 kuznet@ms2.inr.ac.ru wrote:
> > route, as there would have to be at least two candidates there.
> ...
> > Am I missing something obvious here?
> 
> Yes. You select some one of the candidates eventually, do not you? :-)

But can there be more candidates for one route, in which case one would 
run something similar to this algorithm then?

Or would you have an already-sorted list of possible candidate addresses 
for each route in the order of preference?  And recalculate always when 
address changes?

Or..?

> And when you have some special preference for a subnet you create
> a route for it.

This is IMO a wrong approach from user's perspective.  Perhaps not if the 
algorithm was run and e.g. additional, temporary "address selection" 
routes were created by kernel.
 
> > (stuff that's network prefix -independent
> 
> I am sorry, I feel I do not understand what you mean.

Hmm.. this depends on the interpretation of the concept above.  If the
list is refreshed always when addresses change or change state, this could
perhaps work..

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

