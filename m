Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276966AbRJQQk3>; Wed, 17 Oct 2001 12:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276977AbRJQQkT>; Wed, 17 Oct 2001 12:40:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6925 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S277012AbRJQQkL>; Wed, 17 Oct 2001 12:40:11 -0400
Date: Wed, 17 Oct 2001 13:19:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM test on 2.4.13-pre3aa1 (compared to 2.4.12-aa1 and 2.4.13-pre2aa1)
In-Reply-To: <9qkbhd$h8m$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0110171318130.11099-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Oct 2001, Linus Torvalds wrote:

> In article <20011017004839.A15996@earthlink.net>, <rwhron@earthlink.net> wrote:
> >> 
> >> So I'd suggest to try again after "echo 4 > /proc/sys/vm/page-cluster"
> >> to see if it makes any difference.
> >> 
> >> Andrea
> >
> >You Rule!
> >
> >The tweak to page-cluster is basically magic for this test.
> >
> >With page-cluster=4, the mp3blaster sputtered like 2.4.13pre2aa1.
> >Better, but not beautiful.
> >
> >Real beauty happens with page-cluster=2.  There is virtually no sputter.  
> >And the wall clock time is a little better than 2.4.13pre2aa1!
> 
> This is good information.
> 
> The problem is that "page-cluster" is actually used for two different
> things: it's used for mmap page-in clustering, and it's used for swap
> page-in clustering, and they probably have rather different behaviours.

Its also used to limit the number of on flight swapouts. That different
meaning thingie sucks: I would say we need to separate that :)

