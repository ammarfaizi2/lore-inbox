Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261595AbSJJOWh>; Thu, 10 Oct 2002 10:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261597AbSJJOWh>; Thu, 10 Oct 2002 10:22:37 -0400
Received: from bitmover.com ([192.132.92.2]:18646 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261595AbSJJOWg>;
	Thu, 10 Oct 2002 10:22:36 -0400
Date: Thu, 10 Oct 2002 07:28:18 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Walter Landry <wlandry@ucsd.edu>, linux-kernel@vger.kernel.org
Subject: Re: A simple request (was Re: boring BK stats)
Message-ID: <20021010072818.F27122@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <jgarzik@pobox.com>, Walter Landry <wlandry@ucsd.edu>,
	linux-kernel@vger.kernel.org
References: <20021009.163920.85414652.wlandry@ucsd.edu> <3DA58B60.1010101@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA58B60.1010101@pobox.com>; from jgarzik@pobox.com on Thu, Oct 10, 2002 at 10:14:56AM -0400
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The laptop has 200MB RAM, and mozilla and a ton of xterms loaded.  IDE 
> drives w/ Intel PIIX4 controller.  The Dual Athlon has 512MB RAM, and I 
> forget what kind of IDE controller -- I think AMD.  IDE drives as well.
> 
> BitKeeper must scan the entire tree when doing a checkin or checkout, so 
> that is impossible to optimize at the SCM level without compromising 
> features...  if your source tree takes up ~190MB on disk, you have 200MB 
> of RAM total, and you need to sequentially scan the entire thing, there 
> is nothing that can be done at either the OS or app level... You're just 
> screwed.  Things are extremely fast on the Dual Athlon because the 
> entire tree is in RAM.

In low memory situations you really want to run the tree compressed.  
ON a fast machine do a "bk -r admin -Z" and then clone that onto your
laptop.  I think that will drop the tree to about 145MB which will
help, maybe.  I suspect that you use enough of the rest of your 200MB
that it still won't fit.

For the checkouts, always do a "bk -r get -S" the -S doesn't check out the
file again if it is already there.  We could make that the default but
it is an interface change.  A fairly minor one though.

We've got some other fixes in the pipeline for the checkin and integrity
check pass.

There is only so much we can do when you are trying to cram 10 pounds of
crap in a 5 pound bag :(
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
