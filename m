Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268497AbRGXWYF>; Tue, 24 Jul 2001 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbRGXWXz>; Tue, 24 Jul 2001 18:23:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:53520 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S266067AbRGXWXr>; Tue, 24 Jul 2001 18:23:47 -0400
Date: Tue, 24 Jul 2001 17:53:36 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.33L.0107241903410.20326-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0107241750090.2263-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing



On Tue, 24 Jul 2001, Rik van Riel wrote:

> On Tue, 24 Jul 2001, Marcelo Tosatti wrote:
> > On Tue, 24 Jul 2001, Daniel Phillips wrote:
> >
> > > Today's patch tackles the use-once problem, that is, the problem of
> >
> > Well, as I see the patch should remove the problem where
> > drop_behind() deactivates pages of a readahead window even if
> > some of those pages are not "used-once" pages, right ?
> >
> > I just want to make sure the performance improvements you're
> > seeing caused by the fix of this _particular_ problem.
> 
> Fully agreed.
> 
> Especially since it was a one-liner change from worse
> performance to better performance (IIRC) it would be
> nice to see exactly WHY the system behaves the way it
> does.  ;)

Yes. 

Daniel's patch adds "drop behind" (that is, adding swapcache
pages to the inactive dirty) behaviour to swapcache pages. 

This is a _new_ thing, and I would like to know how that is changing the
whole VM behaviour..

