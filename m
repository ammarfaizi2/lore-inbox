Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267587AbSKQUZW>; Sun, 17 Nov 2002 15:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267589AbSKQUZW>; Sun, 17 Nov 2002 15:25:22 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22354 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267587AbSKQUZV>; Sun, 17 Nov 2002 15:25:21 -0500
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Larry McVoy <lm@bitmover.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lan based kgdb
References: <1037490849.24843.11.camel@irongate.swansea.linux.org.uk>
	<Pine.LNX.4.44.0211161915360.1337-100000@home.transmeta.com>
	<20021116193008.C25741@work.bitmover.com>
	<m11y5k3ruw.fsf@frodo.biederman.org>
	<20021117201026.GB1851@bjl1.asuk.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Nov 2002 13:31:57 -0700
In-Reply-To: <20021117201026.GB1851@bjl1.asuk.net>
Message-ID: <m1wunc2b0i.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <lk@tantalophile.demon.co.uk> writes:

> Eric W. Biederman wrote:
> > As long as the network console/debug interface includes basic a basic
> > check to verify that the packets it accepts are from the local network.
> > And it's outgoing packets have a ttl of one.  I don't have a problem.
> 
> Is there a working network console?  It would be _great_ to have a
> network console to my _remote_ server, far far away on the internet.

There are bits and pieces, and a lan based kgdb is basically the same
problem security wise.  When you allow any kind of control the security
cannot be in the console protocol.  Therefore it can only be used on
a trusted lan and be only talk to local addresses.  At the same time
if you have two remote machines on that trusted lan you can use one
to control the other.  Knowing that a root exploit on one likely
becomes a root exploit on both.

And weather or not we have one at the moment, it is an active area of
research.  We just need to get a useable security model.  And I think
enforcing that the console be on a secure lan where every connected
machine is trusted is a good first draft, at the latter.

So I do not think this is the kind of thing that will help if you
only have one _remote_ server, far far away on the internet, but when
you start getting a collection of them it may help.

Eric
