Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318818AbSIIUHP>; Mon, 9 Sep 2002 16:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318830AbSIIUHP>; Mon, 9 Sep 2002 16:07:15 -0400
Received: from borg.org ([208.218.135.231]:22652 "HELO borg.org")
	by vger.kernel.org with SMTP id <S318818AbSIIUHL>;
	Mon, 9 Sep 2002 16:07:11 -0400
Date: Mon, 9 Sep 2002 16:11:55 -0400
From: Kent Borg <kentborg@borg.org>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020909161155.A17836@borg.org>
References: <1029760150.19376.14.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0209072328240.21724-100000@redshift.mimosa.com> <alg3ct$pru$1@abraham.cs.berkeley.edu> <20020909165303.GA31597@waste.org> <20020909145451.G14891@borg.org> <20020909195733.GC31597@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020909195733.GC31597@waste.org>; from oxymoron@waste.org on Mon, Sep 09, 2002 at 02:57:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 02:57:34PM -0500, Oliver Xymoron wrote:
> > Why not use the power-on state of DRAM as a source of initial pool
> > entropy?  
> 
> There's actually not a lot there, and what is there is not random, but
> rather a rapidly fading "ghost" of what was there last. 

Which means it is not completely predictable, which means there is
going to be some entropy in there...

> And for most folks, this gets wiped by POST or the kernel long
> before the RNG gets its hands on it.

Well now, *that's* a pain.

But for us embedded folks who control our boot ROM there is the
potential to grab some entropy from that melting ghost.
  
> Nonetheless, there's no reason not to take whatever state we get
> when we allocate our pool. Amusingly, the current code needlessly
> zeroes out its pool before using it - twice! I've already fixed this
> in my patches.

Perfect!  So if some embedded-types do manage to dig up some entropy
from the end/beginning of the world, we will have a place to put it
where it will be put to use.  Cool.


Thanks,

-kb, the Kent who suggests a comment left in that code might prevent
someone from "fixing" it at a later date.
