Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269550AbRHGARR>; Mon, 6 Aug 2001 20:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269514AbRHGARG>; Mon, 6 Aug 2001 20:17:06 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:41223 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269418AbRHGAQ4>; Mon, 6 Aug 2001 20:16:56 -0400
Date: Mon, 6 Aug 2001 19:47:41 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: BERECZ Szabolcs <szabi@inf.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <01080701213301.02122@starship>
Message-ID: <Pine.LNX.4.21.0108061943090.11191-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Daniel Phillips wrote:

> On Tuesday 07 August 2001 00:48, BERECZ Szabolcs wrote:
> > On Fri, 3 Aug 2001, Marcelo Tosatti wrote:
> > > Does the problem happen only with the used-once patch ?
> > >
> > > If it also happens without the used-once patch, can you reproduce
> > > the problem with 2.4.6 ?
> >
> > The problem happened about 4 times, with the used-once patch,
> > but I don't know exactly what triggered it.
> >
> > now I use 2.4.7-ac5, and I have not seen the problem, yet.
> >
> > I will try with the used-once patch, if it appears again.
> 
> Please note the additional patch, to be applied after the used-once 
> patch for 2.4.7 and 2.4.7-ac*, or directly to 2.4.8-pre*.  This was 
> posted on lkml and linux-mm on Aug 5 under the subject:
> 
>     [PATCH] Unlazy activate
> 
> which adds the additional behaviour of moving used-twice pages to the 
> active list.


Daniel,

I would like to identify the reason why kswapd is looping like mad instead
trying _any_ fix.

I can't see why unlazy activation would make kswapd not loop like mad
anymore.

