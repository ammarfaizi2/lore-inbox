Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbTHaCTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 22:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTHaCTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 22:19:08 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.5.42]:27792 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S262382AbTHaCTF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 22:19:05 -0400
Date: Sat, 30 Aug 2003 22:18:37 -0400
From: Jeff Sipek <jeffpc@optonline.net>
Subject: Re: bandwidth for bkbits.net (good news)
In-reply-to: <20030831013928.GN24409@dualathlon.random>
To: Andrea Arcangeli <andrea@suse.de>, Pascal Schmidt <der.eremit@email.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Message-id: <200308302218.45779.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.3
References: <20030830230701.GA25845@work.bitmover.com>
 <Pine.LNX.4.44.0308310256420.16308-100000@neptune.local>
 <20030831013928.GN24409@dualathlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Saturday 30 August 2003 21:39, Andrea Arcangeli wrote:
> On Sun, Aug 31, 2003 at 03:05:37AM +0200, Pascal Schmidt wrote:
> > On Sat, 30 Aug 2003, Larry McVoy wrote:
> > >> All you have to do is drop the incoming packets if they exceed
> > >> a certain bandwidth.
> > >
> > > If you think we haven't done that, think again.
> > >
> > > We're at the wrong end of the pipe to do that, I'm pretty sure that
> > > what you are describing simply won't work.
> >
> > In a way, you're on the right end of the pipe because the system
> > that does your traffic shaping is part of the general network, viewed
> > from the machines behind the shaper.
> >
> > Dropping the packets means that the sending side, at least if we're
> > talking TCP, will throttle its sending rate. But, depending on the
> > distance in hops to the sender, it may take up to a few seconds for
> > this to kick in. So I guess that's why it doesn't work for your
> > VoIP case - the senders don't notice fast enough that they should
> > slow down.
>
> that's because you don't limit the bkbits.net to a fixed rate. If you
> want to give priorities, it won't work well because it takes time to be
> effective, but if you rate limit hard both ways it has to work, unless
> you're under syn-flood ;) The downside is that you will waste bandwith
> (i.e. you will hurt the bkbits.net service even when you don't use
> voip), but it will work.

How about giving something to voip as a hard limit and then using some shaper 
to give it more if needed.

Jeff.

- -- 
*NOTE: This message is ROT-13 encrypted twice for extra protection*
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/UVsBwFP0+seVj/4RAkmpAJ9YwjdPLZZsdD7fCRDRHyS+JrJnkgCdG/sc
sr5Mqx5Qii//AQPepCqHDcw=
=RoPR
-----END PGP SIGNATURE-----

