Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbSI2IgW>; Sun, 29 Sep 2002 04:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262421AbSI2IgV>; Sun, 29 Sep 2002 04:36:21 -0400
Received: from netcore.fi ([193.94.160.1]:18698 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S262420AbSI2IgT>;
	Sun, 29 Sep 2002 04:36:19 -0400
Date: Sun, 29 Sep 2002 11:41:23 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: kuznet@ms2.inr.ac.ru
cc: davem@redhat.com, <yoshfuji@linux-ipv6.org>,
       <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       <usagi@linux-ipv6.org>
Subject: Re: [PATCH] IPv6: Improvement of Source Address Selection
In-Reply-To: <200209280537.JAA03046@sex.inr.ac.ru>
Message-ID: <Pine.LNX.4.44.0209291135210.27427-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002 kuznet@ms2.inr.ac.ru wrote:
> > Or would you have an already-sorted list of possible candidate addresses 
> > for each route in the order of preference?
> 
> I am not mad yet. :-)
> 
> What preference? You must select _one_ address, you do not need lost
> candidates.

In the case the first entry goes away, having a list could help being able 
to the next one to use very easily.  But this probably just an 
implementation detail.

> > And recalculate always when address changes?
> 
> What address? Interface address? Routing tables used to be synchronized
> to this.

Any address.

One notable case is that the outgoing interface has only link/site-local 
addresses and the destination is global.  There are other cases too.

> > This is IMO a wrong approach from user's perspective.  Perhaps not if the 
> > algorithm was run and e.g. additional, temporary "address selection" 
> > routes were created by kernel.
> >  
> > > > (stuff that's network prefix -independent
> > > 
> > > I am sorry, I feel I do not understand what you mean.
> > 
> > Hmm.. this depends on the interpretation of the concept above.  If the
> > list is refreshed always when addresses change or change state, this could
> > perhaps work..
> 
> I am afraid I do not understand what "address", "state", "temporary" routes
> etc you mean. It remained in your brains. :-)
> 
> Pekka, are you not going to sleep? (I am.) I bet when you reread this tomorrow,
> you will not blame that my brains eventually falled to "parse error" loop. :-)

I had already woken up :-).

At least BSD and I think Linux create ad-hoc, "cloned" routes e.g. in Path
MTU discovery process to hold some different values.  I don't remember the 
details.  I was wondering if this would be done the same or not.

change state = move to deprecated, move to non-deprecated.

Hope this clarifies.

-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords

