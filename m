Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280583AbRK1UOt>; Wed, 28 Nov 2001 15:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280593AbRK1UOa>; Wed, 28 Nov 2001 15:14:30 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:56836 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S280583AbRK1UOS>; Wed, 28 Nov 2001 15:14:18 -0500
Date: Wed, 28 Nov 2001 16:57:03 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Ahmed Masud <masud@googgun.com>,
        "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <Pine.LNX.4.21.0111281604390.15571-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0111281656520.15571-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001, Marcelo Tosatti wrote:

> 
> 
> On Tue, 27 Nov 2001, Andrew Morton wrote:
> 
> > Mike Fedyk wrote:
> > > 
> > > >   I'll send you a patch which makes the VM less inclined to page things
> > > >   out in the presence of heavy writes, and which decreases read
> > > >   latencies.
> > > >
> > > Is this patch posted anywhere?
> > 
> > I sent it yesterday, in this thread.  Here it is again.
> > 
> > Description:
> > 
> > - Account for locked as well as dirty buffers when deciding
> >   to throttle writers.
> 
> Just one thing: If we have lots of locked buffers due to reads we are
> going to may unecessarily block writes, and thats not any good.
> 
> But well, I prefer to fix interactivity than to care about that one kind
> of workload, so I'm ok with it.
> 
> > - Tweak VM to make it work the inactive list harder, before starting
> >   to evict pages or swap.
> 
> I would like to see he interactivity problems get fixed on block layer
> side first: Its not a VM issue initially. Actually, the thing is that if
> you tweak VM this way you're going to break some workloads.
> 
> > - Change the elevator so that once a request's latency has
> >   expired, we can still perform merges in front of that
> >   request.  But we no longer will insert new requests in
> >   front of that request.  
> 
> Sounds fine... I've received quite many success reports already, right ? 

Err...

s/I/you/ 

