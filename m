Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264280AbRFQFkx>; Sun, 17 Jun 2001 01:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264441AbRFQFkn>; Sun, 17 Jun 2001 01:40:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30865 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264280AbRFQFki>;
	Sun, 17 Jun 2001 01:40:38 -0400
Date: Sun, 17 Jun 2001 01:40:33 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HotPlug CPU patch against 2.4.5 
In-Reply-To: <m15BVAM-001UIzC@mozart>
Message-ID: <Pine.GSO.4.21.0106170137000.13857-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Jun 2001, Rusty Russell wrote:

> In message <200106161359.f5GDxQ214335@ns.caldera.de> you write:
> > In article <m15BG8K-001UIwC@mozart> you wrote:
> > > 	# Up...
> > >	echo 1 > /proc/sys/cpu/1
> > 
> > Wouldn't /proc/sys/cpu/<num>/enable be better?  This way other per-cpu
> > sysctls could be added more easily...
> 
> Yep.  But rewrite the sysctl crap first to make dynamically adding and
> deleting entries sane.

I had, actually. 2.5 stuff, but as soon as fs/super.c merge gets into the
sane area I'll see what can be safely merged into 2.4. Sorry - it touches
quite a few places and running two splitups in parallel... <shudder> As
soon as this fscking roll of barbwire^W^W^Wset of locking changes gets
untangled...

