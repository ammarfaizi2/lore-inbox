Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTKFCUl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 21:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbTKFCUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 21:20:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:44012 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263281AbTKFCUj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 21:20:39 -0500
Date: Wed, 5 Nov 2003 18:20:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
cc: Tomas Szepe <szepe@pinerecords.com>, Larry McVoy <lm@work.bitmover.com>,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: BK2CVS problem
In-Reply-To: <20031105185713.U10197@schatzie.adilger.int>
Message-ID: <Pine.LNX.4.44.0311051810510.1842-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Nov 2003, Andreas Dilger wrote:
> 
> Granted that this was not a break in BK itself the event is still alarming.
> It makes me wonder if there is some way we can start using GPG signatures
> with BK itself so that you can get proof-positive that a CSET annotated
> as from davem really is from the David Miller we know and trust.

A few things do make the current system _fairly_ secure. One of them is
that if somebody were to actually access the BK trees directly, that would
be noticed immediately: when I push to the places I export from, the push
itself would fail due to having an unexpected changeset in the target that
I don't have on my local tree. So I'd notice that kind of stuff
immediately.

And that's likely to be true of all other BK users too: the public trees 
are just replicas of the trees people actually _work_ on, so if the public 
tree has something unexpected, trying to update them just won't work. You 
just can't push to a tree that isn't a subset of what you already have.

So any BK corruption would have to come from the private trees, not the
public ones. Which tend to be better secured, exactly because they are
private (ie they don't have things like cvspserver etc public servers). I
suspect most of us have firewalls that just don't accept any incoming
connections - I know I do.

I think it's telling that it was the CVS tree and not the BK tree that 
somebody tried to corrupt.

			Linus

