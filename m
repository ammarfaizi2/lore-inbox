Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262436AbRGRWY2>; Wed, 18 Jul 2001 18:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRGRWYS>; Wed, 18 Jul 2001 18:24:18 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:44043 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262436AbRGRWYK>; Wed, 18 Jul 2001 18:24:10 -0400
Date: Wed, 18 Jul 2001 15:23:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Inclusion of zoned inactive/free shortage patch 
In-Reply-To: <Pine.LNX.4.21.0107181734560.8651-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107181520150.1237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jul 2001, Marcelo Tosatti wrote:
>
> Ok, I understand and I agree with doing _unconditional_
> "zone_inactive_plenty()" instead of conditional
> "zone_inactive_shortage()".
>
> This way we do not get _strict_ zoned behaviour (with strict I mean only
> doing scanning for zones which have a shortage), making the shortage
> handling smoother and doing "fair" aging in cases where there are not
> specific zones under pressure.

Cool.

Willing to write a patch and give it some preliminary testing? I also
agree with the patch Rik sent in about GFP_HIGHUSER, that's orthogonal
though (even if I suspect it could also have made the problem _appear_
much much more clearly).

I'd like to do a real pre7 one of these days (it's already growing big
enough, thank you), but I'd love to have this issue put at least somewhat
to rest.

		Linus

