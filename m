Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319064AbSHMWS6>; Tue, 13 Aug 2002 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319073AbSHMWS6>; Tue, 13 Aug 2002 18:18:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17379 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S319064AbSHMWS6>; Tue, 13 Aug 2002 18:18:58 -0400
Date: Wed, 14 Aug 2002 00:22:43 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
In-Reply-To: <ajc095$hk1$1@cesium.transmeta.com>
Message-ID: <Pine.NEB.4.44.0208140020260.1351-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Aug 2002, H. Peter Anvin wrote:

>...
> > > Because the compiler sees:
> > >
> > > 	for (i = 0; i < N; i++)
> > > 		;
> > >
> > > and it says "ah ha.  A busy wait delay loop" and leaves it alone.
> > >
> > > It's actually a special-case inside the compiler to not optimise
> > > away such constructs.
> >
> > Why is this a special case? As long as a compiler can't prove that the
> > computed value of i isn't used later it mustn't optimize it away.
>
> Bullsh*t.  It can legitimately transform it into:
>
> 	   i = N;
>...

Ah, my misunderstanding:
"optimize away" didn't mean "completely remove it" but "transform it to
something semantically equivalent".

> 	-hpa

Thanks
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

