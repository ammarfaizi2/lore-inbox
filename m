Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280162AbRKEDdr>; Sun, 4 Nov 2001 22:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280165AbRKEDdj>; Sun, 4 Nov 2001 22:33:39 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:15504 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280162AbRKEDdS>; Sun, 4 Nov 2001 22:33:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] 2.5 PROPOSAL: Replacement for current /proc of shit.
Date: Mon, 5 Nov 2001 04:34:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: tim@tjansen.de, linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104013951Z16981-4784+741@humbolt.nl.linux.org> <20011105111239.3403b162.rusty@rustcorp.com.au>
In-Reply-To: <20011105111239.3403b162.rusty@rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105033316Z16051-18972+45@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 01:12 am, Rusty Russell wrote:
> On Sun, 4 Nov 2001 02:40:51 +0100
> Daniel Phillips <phillips@bonn-fries.net> wrote:
> 
> > On November 2, 2001 03:20 am, Rusty Russell wrote:
> > > I agree with the "one file, one value" idea.
> > 
> > So cat /proc/partitions goes from being a nice, easy to read and use human 
> > interface to something other than that.  Lets not go overboard.
> 
> Firstly, do not perpetuate the myth of /proc being "human readable".  (Hint:
> what language do humans speak?)  It supposed to be "admin readable" and
> "machine readable".

You're letting me out as a human, fair enough ;-)

> Secondly, it is possible to implement a table formatter which kicks in
> when someone does a read() on a directory.  This is not a desirable format:
> look at /proc/mounts when you have a mount point with a space in it for a
> good example.

Yes, sold, if implementing the formatter is part of the plan.

Caveat: by profiling I've found that file ops on proc functions are already
eating a significant amount of cpu, going to one-value-per-file is going to 
make that worse.  But maybe this doesn't bother you.

--
Daniel
