Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030372AbWCUNqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030372AbWCUNqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030374AbWCUNqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:46:19 -0500
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:38063 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030372AbWCUNqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:46:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: interactive task starvation
Date: Wed, 22 Mar 2006 00:45:54 +1100
User-Agent: KMail/1.9.1
Cc: Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
References: <200603090036.49915.kernel@kolivas.org> <200603220037.52258.kernel@kolivas.org> <20060321134418.GC26171@w.ods.org>
In-Reply-To: <20060321134418.GC26171@w.ods.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603220045.54736.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 March 2006 00:44, Willy Tarreau wrote:
> On Wed, Mar 22, 2006 at 12:37:51AM +1100, Con Kolivas wrote:
> > On Wednesday 22 March 2006 00:33, Mike Galbraith wrote:
> > > On Wed, 2006-03-22 at 00:13 +1100, Con Kolivas wrote:
> > > > On Wednesday 22 March 2006 00:10, Mike Galbraith wrote:
> > > > > How long should Willy be able to scroll without feeling the
> > > > > background, and how long should Apache be able to starve his shell.
> > > > >  They are one and the same, and I can't say, because I'm not Willy.
> > > > >  I don't know how to get there from here without tunables.  Picking
> > > > > defaults is one thing, but I don't know how to make it
> > > > > one-size-fits-all.  For the general case, the values delivered will
> > > > > work fine.  For the apache case, they absolutely 100% guaranteed
> > > > > will not.
> > > >
> > > > So how do you propose we tune such a beast then? Apache users will
> > > > use off, everyone else will have no idea but to use the defaults.
> > >
> > > Set for desktop, which is intended to mostly emulate what we have right
> > > now, which most people are quite happy with.  The throttle will still
> > > nail most of the corner cases, and the other adjustments nail the
> > > majority of what's left.  That leaves the hefty server type loads as
> > > what certainly will require tuning.  They always need tuning.
> >
> > That still sounds like just on/off to me. Default for desktop and 0,0 for
> > server. Am I missing something?
>
> Believe it or not, there *are* people running their servers with full
> graphical environments. At the place we first encountered the interactivity
> problem with my load-balancer, they first installed in on a full FC2 with
> the OpenGL screen saver... No need to say they had scaling difficulties and
> trouble to log in !
>
> Although that's a stupid thing to do, what I want to show is that even on
> servers, you can't easily predict the workload. Maybe a server which often
> forks processes for dedicated tasks (eg: monitoring) would prefer running
> between "desktop" and "server" mode.

I give up. Add as many tunables as you like in as many places as possible that 
even less people will understand. You've already told me you'll be running 
0,0.

Cheers,
Con
