Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbSLFTsn>; Fri, 6 Dec 2002 14:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSLFTsn>; Fri, 6 Dec 2002 14:48:43 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:4359 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S267594AbSLFTsl>; Fri, 6 Dec 2002 14:48:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Robert Love <rml@tech9.net>
Subject: Re: Detecting threads vs processes with ps or /proc
Date: Fri, 6 Dec 2002 13:56:16 -0600
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200212060924.02162.nleroy@cs.wisc.edu> <1039204112.1943.2142.camel@phantasy>
In-Reply-To: <1039204112.1943.2142.camel@phantasy>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212061356.16022.nleroy@cs.wisc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 December 2002 1:48 pm, Robert Love wrote:
> On Fri, 2002-12-06 at 10:24, Nick LeRoy wrote:
> > >From what else I've read, it seems that the new threading model in
> > > 2.5/2.6 is
> >
> > changing to a more POSIX friendly model, which will effect this answer,
> > but we're not running 2.5 and really can't force such an upgrade -- hell,
> > right now we're having problems getting a switch from 2.2 pushed through.
>
> Yep, you should get what you want with 2.5 + NPTL.  We need to add a few
> bits, though, to make it complete.
>
> > Thanks _very_ much in advance.  I'd be tickled pink if the answer is
> > something like "just look at the foo flag in ps", or "upgrade to version
> > 1.2.3.4 of procps and do xyzzy", but my intuition tells me otherwise.
>
> See http://tech9.net/rml/procps
>
> and "upgrade to version 2.0.8 or later of procps" :)
>
> It is just a heuristic, though.  A hack in fact.  We look at a process's
> children and compare RSS, VM size, and the process image they are
> running.  If they are the same, we label them threads.

I was considerring doing something like this as well.  From your experience, 
does it work reliably?  Do you need to apply a small 'fudge factor' (aka 
VMsize.1 ~= VMsize.2)?

> It is the default behavior.  Flag `-m' turns it off.
>
> See thread_group() and flag_threads().

I assume these are functions in the tools themselves?

> 	Robert Love

Thanks

-Nick

