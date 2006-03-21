Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751714AbWCUNod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWCUNod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751713AbWCUNod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:44:33 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:55307 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751708AbWCUNoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:44:32 -0500
Date: Tue, 21 Mar 2006 14:44:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
Subject: Re: interactive task starvation
Message-ID: <20060321134418.GC26171@w.ods.org>
References: <200603090036.49915.kernel@kolivas.org> <200603220013.15870.kernel@kolivas.org> <1142948000.7807.63.camel@homer> <200603220037.52258.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603220037.52258.kernel@kolivas.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 12:37:51AM +1100, Con Kolivas wrote:
> On Wednesday 22 March 2006 00:33, Mike Galbraith wrote:
> > On Wed, 2006-03-22 at 00:13 +1100, Con Kolivas wrote:
> > > On Wednesday 22 March 2006 00:10, Mike Galbraith wrote:
> > > > How long should Willy be able to scroll without feeling the background,
> > > > and how long should Apache be able to starve his shell.  They are one
> > > > and the same, and I can't say, because I'm not Willy.  I don't know how
> > > > to get there from here without tunables.  Picking defaults is one
> > > > thing, but I don't know how to make it one-size-fits-all.  For the
> > > > general case, the values delivered will work fine.  For the apache
> > > > case, they absolutely 100% guaranteed will not.
> > >
> > > So how do you propose we tune such a beast then? Apache users will use
> > > off, everyone else will have no idea but to use the defaults.
> >
> > Set for desktop, which is intended to mostly emulate what we have right
> > now, which most people are quite happy with.  The throttle will still
> > nail most of the corner cases, and the other adjustments nail the
> > majority of what's left.  That leaves the hefty server type loads as
> > what certainly will require tuning.  They always need tuning.
> 
> That still sounds like just on/off to me. Default for desktop and 0,0 for 
> server. Am I missing something?

Believe it or not, there *are* people running their servers with full
graphical environments. At the place we first encountered the interactivity
problem with my load-balancer, they first installed in on a full FC2 with the
OpenGL screen saver... No need to say they had scaling difficulties and trouble
to log in !

Although that's a stupid thing to do, what I want to show is that even on
servers, you can't easily predict the workload. Maybe a server which often
forks processes for dedicated tasks (eg: monitoring) would prefer running
between "desktop" and "server" mode.

> Cheers,
> Con

Cheers,
Willy

