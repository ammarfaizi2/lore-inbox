Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbTL3TVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbTL3TVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:21:49 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:10313 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265900AbTL3TVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:21:46 -0500
Date: Tue, 30 Dec 2003 13:21:45 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Roger Luethi <rl@hellgate.ch>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 performance problems
Message-ID: <20031230132145.B32120@hexapodia.org>
References: <Pine.LNX.4.58.0312291647410.5288@localhost.localdomain> <20031230012551.GA6226@k3.hellgate.ch> <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.58.0312292031450.6227@localhost.localdomain>; from tmolina@cablespeed.com on Mon, Dec 29, 2003 at 08:37:53PM -0500
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 08:37:53PM -0500, Thomas Molina wrote:
> On Tue, 30 Dec 2003, Roger Luethi wrote:
> > I bet this is just yet another instance of a problem we've been
> > discussing on lkml and linux-mm for several months now (although Linus
> > asking for DMA presumably means it's not as well known as I thought
> > it was).
> > 
> > Basically, when you need to resort to paging for getting work done on
> > 2.6 you're screwed. Your bk export takes a lot more memory than you
> > have RAM in your machine, right?
> 
> Right.  I have 120MB RAM and 256MB swap partition.  That corresponds to 
> the 85 to 90 percent top says I am spending in iowait.

Yeah, right now BK needs about 140-160MB of working set to do a
consistency check on the 2.5 tree.  That means you're paging, and it
sounds like paging sucks on 2.6?

(Actually, BK is even happier if the kernel can keep all the sfiles in
cache, so a half-gig is a comfortable amount for working with the
current 2.5 tree, although 256MB should be enough to avoid paging hell.
With a full gig, you can keep two full trees in "checkout:get" mode in
cache, which is nice.)

-andy
