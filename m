Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVDORFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVDORFL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVDORFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:05:11 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:54207 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S261154AbVDORFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:05:02 -0400
Date: Fri, 15 Apr 2005 13:04:50 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
Subject: Re: Fortuna
Message-ID: <20050415170450.GB23277@certainkey.com>
References: <20050415162225.GA23277@certainkey.com> <20050415165036.16224.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050415165036.16224.qmail@science.horizon.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 04:50:36PM -0000, linux@horizon.com wrote:
> (And as for the endianness of the SHA-1, are you trying to imply
> something?  Because it makes zero difference, and reduces the code
> size and execution time.  Which is obviously a Good Thing.)

It just bugged me when I was reading random.c for the first time.  First
impressions and all.

> As for hacking Fortuna in, could you give a clear statement of what
> you're trying to achieve?
> 
> Do you like:
> - The neat name,
> - The strong ciphers used in the pools, or
> - The multi-pool reseeding strategy, or
> - Something else?
> 
> If you're doing it just for hack value, or to learn how to write a
> device driver or whatever, then fine.  But if you're proposing it as
> a mainline patch, then could we discuss the technical goals?
> 
> I don't think anyone wants to draw and quarter *you*, but your
> code is going to get some extremely critical examination.

The multi-pool reseeding strategy is what I find particular interesting.
It's design that can fit neatly into my little head and I hope into the heads
of others in the future.  You can call it Bob or whatever you want, names
doesn't matter to me.  As for the ciphers/digest algos used, they are
not if great concern to me, replace them with what you want.  It's the design
of the RNG itself that has my attention for the time being.

Ted and yourself are in the nest position to say "we understand random.c
currently, and should be need arise, we can feel strong enough that we can
find someone to take it over and go up the learning curve" and with a
statement "we like the current RNG design now for mixing entropy and don't
see the need to confuse people with alternatives to /dev/{u}random" and
that'll be that.

I'll take my patch and not bother you anymore.  I'm sure I've taken a lot of
your time as it is.

Not to sound like a "I'm taking my ball and going home" - just explaining
that I like the Fortuna design, I think it's elegant, I want it for my
systems.  GPL requires I submit changes back, so I did with the unpleasant
side-dish of my opinion on random.c.

JLC
