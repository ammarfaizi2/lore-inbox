Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbTCOSlD>; Sat, 15 Mar 2003 13:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTCOSlD>; Sat, 15 Mar 2003 13:41:03 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:53653 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S261517AbTCOSlC>; Sat, 15 Mar 2003 13:41:02 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303151417.h2FEHNV9002747@eeyore.valparaiso.cl>
References: <200303151417.h2FEHNV9002747@eeyore.valparaiso.cl>
Organization: 
Message-Id: <1047754297.21464.26.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 15 Mar 2003 18:51:38 +0000
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 14:17, Horst von Brand wrote:
> The dependency among changes is a partial order, the sequence in which they
> were applied is one valid topological sort of that, and the only valid one
> known to the SCM. Asking the user to provide the complete dependencies is
> error prone at very best.
> 
> > Assuming no ordering is wrong. But likewise, assuming the order in which
> > changes _happened_ to occur is also wrong,
> 
> But much less so.
> 
> >                                            and _enforcing_ that is more
> > wrong. 
> 
> What else can you do?

You could at least allow changesets to be committed out-of-order if they
don't touch the same files _at_ _all_. Unless you're going to do a
complete compile-and-regression test after every commit, you have no
business being anal about change ordering either.

I don't claim this is _easy_, merely that it's a requirement for me to
be happy with the thing.

I also _really_ miss the ability to 'pull' while there are uncommitted
changes in the checked-out tree. Especially since actually having
_committed_ certain one-line compile fixes makes all my _real_ changes
depend on them, etc...
 
-- 
dwmw2


