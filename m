Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVCDS0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVCDS0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262970AbVCDS0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:26:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:20181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262967AbVCDS0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:26:23 -0500
Date: Fri, 4 Mar 2005 10:27:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, greg@kroah.com, jgarzik@pobox.com,
       davem@davemloft.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFD: Kernel release numbering
In-Reply-To: <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0503041020130.25732@ppc970.osdl.org>
References: <42268749.4010504@pobox.com>  <20050302200214.3e4f0015.davem@davemloft.net>
 <42268F93.6060504@pobox.com>  <4226969E.5020101@pobox.com>
 <20050302205826.523b9144.davem@davemloft.net>  <4226C235.1070609@pobox.com>
 <20050303080459.GA29235@kroah.com>  <4226CA7E.4090905@pobox.com> 
 <Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>  <422751C1.7030607@pobox.com>
 <20050303181122.GB12103@kroah.com>  <20050303151752.00527ae7.akpm@osdl.org>
  <1109894511.21781.73.camel@localhost.localdomain>  <20050303182820.46bd07a5.akpm@osdl.org>
  <1109933804.26799.11.camel@localhost.localdomain>  <20050304032820.7e3cb06c.akpm@osdl.org>
 <1109940685.26799.18.camel@localhost.localdomain>
 <Pine.LNX.4.58.0503040959030.25732@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Mar 2005, Linus Torvalds wrote:
> 
> In other words: I'm talking about scalability of development, not about 
> fixing every single serious bug. I think this one will catch the 
> embarrassing brown-paper-bag kinds of things, and maybe 90% of the "duh, 
> we had this race forever, but we never even realized", but it wouldn't 
> solve the ones where we had "damn, we did the locking wrong".

Btw, I also think that this means that the sucker-tree should never aim to 
be a "2.6.x.y" kind of release tree. If we do a "2.6.x.y" release, the 
sucker tree would be _included_ in that release (and it may indeed be all 
of it - most of the time it probably would be), but we should not assume 
that "2.6.x.y" _has_ to be just the sucker tree.

We might want to release a "2.6.x.y" that contains a patch that is too big
or too intrusive (or otherwise controversial) to really be valid in the
sucker-tree.

And I'd want that to be very much explicit in the "charter" for the
sucker-tree. Exactly because the whole point (to me, at least) is to make 
it _easy_ to maintain. There should never be any discussion at all about 
patches: either they are universally loved, or they are not. And if the 
sucker-tree is seen as a 2.6.x.y release tree, then that will _inevitably_ 
mean that people will start discussing whether one patch or the other is 
supposed to go in.

My personal gut feeling is that 90% of the patches I _ever_ see are
"obvious". If we also cut them down to "must fix an oops/hang/roothole", I 
think we'll actually get quite far with a sucker tree. We'll never get all 
the way, but exactly because the tree wouldn't _try_ to get all the way, 
it would be a lot easier to maintain.

And let's face it, just getting 50% of the way and having somethign that 
catches the brown-paper-bag stuff so that nobody else every needs to worry 
about them is really worthwhile.

		Linus
