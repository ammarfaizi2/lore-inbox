Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRGRWaa>; Wed, 18 Jul 2001 18:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGRWaT>; Wed, 18 Jul 2001 18:30:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:12302 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262389AbRGRWaG>; Wed, 18 Jul 2001 18:30:06 -0400
Date: Wed, 18 Jul 2001 17:58:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.33.0107181520150.1237-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0107181754400.8651-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Jul 2001, Linus Torvalds wrote:

> 
> On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
> >
> > Ok, I understand and I agree with doing _unconditional_
> > "zone_inactive_plenty()" instead of conditional
> > "zone_inactive_shortage()".
> >
> > This way we do not get _strict_ zoned behaviour (with strict I mean only
> > doing scanning for zones which have a shortage), making the shortage
> > handling smoother and doing "fair" aging in cases where there are not
> > specific zones under pressure.
> 
> Cool.
> 
> Willing to write a patch and give it some preliminary testing? 

Sure. However its not _that_ easy. We do have a global inactive target. 

There is no perzone inactive shortage, which is needed to calculate
"zone_inactive_plenty()". 

> I also agree with the patch Rik sent in about GFP_HIGHUSER, that's
> orthogonal though (even if I suspect it could also have made the
> problem _appear_ much much more clearly).

Right.

