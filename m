Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281867AbRKSCxn>; Sun, 18 Nov 2001 21:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280047AbRKSCxe>; Sun, 18 Nov 2001 21:53:34 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:52240 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S281867AbRKSCxV>;
	Sun, 18 Nov 2001 21:53:21 -0500
Subject: Re: replacing the page replacement algo.
From: Shaya Potter <spotter@cs.columbia.edu>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111190037550.4079-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0111190037550.4079-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1 (Preview Release)
Date: 18 Nov 2001 21:51:44 -0500
Message-Id: <1006138361.605.12.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-18 at 21:38, Rik van Riel wrote:
> On 18 Nov 2001, Shaya Potter wrote:
> > On Sun, 2001-11-18 at 20:44, Rik van Riel wrote:
> > > On 18 Nov 2001, Shaya Potter wrote:
> > >
> > > > If I wanted to experiment with different algorithms that chose which
> > > > page to replace (say on a page fault) what functions would I have to
> > > > replace?
> > >
> > > try_to_free_pages() and all the functions it calls.
> >
> > I was looking at vmscan.c and it appears that swap_out() is what I
> > want.
> 
> You're missing the fact here that swap_out() only unmaps
> pages from processes' page tables, actual reclaiming of
> the pages is done elsewhere.

ok, but if what I'm interested in playing with right now is playing
around with which pages get swapped out, and not with the actual
reclamation procedure, is it ok to just play with swap_out and having it
do the thing it does, and let the rest of the kernel behave as is, or
will this cause problems?

thanks again,

shaya potter

