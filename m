Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288544AbSBDFgo>; Mon, 4 Feb 2002 00:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288548AbSBDFgd>; Mon, 4 Feb 2002 00:36:33 -0500
Received: from squeaker.ratbox.org ([63.216.218.7]:19205 "EHLO
	squeaker.ratbox.org") by vger.kernel.org with ESMTP
	id <S288544AbSBDFg3>; Mon, 4 Feb 2002 00:36:29 -0500
Date: Mon, 4 Feb 2002 00:43:24 -0500 (EST)
From: Aaron Sethman <androsyn@ratbox.org>
To: Dan Kegel <dank@kegel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Coder-Com] Re: PROBLEM: high system usage / poor SMPnetwork 
 performance
In-Reply-To: <3C5E1DB6.CE97AD36@kegel.com>
Message-ID: <Pine.LNX.4.44.0202040041420.3086-100000@simon.ratbox.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Feb 2002, Dan Kegel wrote:

> Aaron Sethman wrote:
> >
> > On Sun, 3 Feb 2002, Dan Kegel wrote:
> > >
> > > But do you remember that this fd is ready until EWOULDBLOCK?
> > > i.e. if you're notified that an fd is ready, and then you
> > > don't for whatever reason continue to do I/O on it until EWOULDBLOCK,
> > > you'll never ever be notified that it's ready again.
> > > If your code assumes that it will be notified again anyway,
> > > as with poll(), it will be sorely disappointed.
> >
> > Yeah that was the problem and I figured out how to work around it in the
> > code.  If you are interested I can point out the code we have been working
> > with.
>
> Yes, I would like to see it; is it part of the mainline undernet ircd cvs tree?

This is part of the Hybrid ircd tree I've been talking about.
http://squeaker.ratbox.org/ircd-hybrid-7.tar.gz has the latest snapshot of
the tree.  Look at src/s_bsd_sigio.c for the sigio code.

Regards,

Aaron

