Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271752AbRICQsW>; Mon, 3 Sep 2001 12:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271751AbRICQsN>; Mon, 3 Sep 2001 12:48:13 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:33546 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271752AbRICQrz>; Mon, 3 Sep 2001 12:47:55 -0400
Date: Mon, 3 Sep 2001 12:22:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
In-Reply-To: <20010902174454Z16091-32383+3013@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.21.0109031221290.929-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Sep 2001, Daniel Phillips wrote:

> On September 2, 2001 11:46 pm, Samium Gromoff wrote:
> > Daniel Phillips wrote:
> > > > One thing that goes away with rmaps is the need to scan process page tables.
> > > It's possible that this takes enough load off L1 cache to produce the effects
> >
> >     I feel like that. 
> >     actually there was a fear that the overhead of reverse map maintenance
> >  will overthrow the gain on low loads, but in my case this isnt an issue.
> 
> Rik's patch can be optimized a lot by using a direct pointer to the pte in the
> nonshared case, and perhaps a null rmap pointer in the kernel-only case (e.g.,
> page cache).  If the non-optimized version is already performing better than the
> traditional approach it's a very good sign.  This needs careful confirmation.
> 
> Measurements where you force your system into continuous swapping would be very
> interesting.

Indeed.

Samium, I would appreciated if you could run heavy anon mem tests with
Rik's code. (eg programs from the memtest suite, make -jALOT, etc)

