Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268509AbRGXXIu>; Tue, 24 Jul 2001 19:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268508AbRGXXIm>; Tue, 24 Jul 2001 19:08:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:776 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268510AbRGXXI2>; Tue, 24 Jul 2001 19:08:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 01:09:27 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, Ben LaHaise <bcrl@redhat.com>,
        Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva>
MIME-Version: 1.0
Message-Id: <01072501092707.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 22:53, Marcelo Tosatti wrote:
> On Tue, 24 Jul 2001, Rik van Riel wrote:
> > On Tue, 24 Jul 2001, Marcelo Tosatti wrote:
> > > On Tue, 24 Jul 2001, Daniel Phillips wrote:
> > > > Today's patch tackles the use-once problem, that is, the
> > > > problem of
> > >
> > > Well, as I see the patch should remove the problem where
> > > drop_behind() deactivates pages of a readahead window even if
> > > some of those pages are not "used-once" pages, right ?
> > >
> > > I just want to make sure the performance improvements you're
> > > seeing caused by the fix of this _particular_ problem.
> >
> > Fully agreed.
> >
> > Especially since it was a one-liner change from worse
> > performance to better performance (IIRC) it would be
> > nice to see exactly WHY the system behaves the way it
> > does.  ;)
>
> Yes.
>
> Daniel's patch adds "drop behind" (that is, adding swapcache
> pages to the inactive dirty) behaviour to swapcache pages.
>
> This is a _new_ thing, and I would like to know how that is changing
> the whole VM behaviour..

Yes, absolutely.  I knew I was doing that but I also thought it wouldn't
hurt.  Rather it's part of a transition towards a full unification of 
the file and swap paths.

Basically, I just left that part of it hanging.  If you check my 
detailed timings you'll see all my test runs have swaps=0, basically
because I didn't really want to hear about it just then ;-)

I was pretty sure it could be fixed if it broke.

--
Daniel
