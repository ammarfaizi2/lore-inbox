Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268979AbTBWVeo>; Sun, 23 Feb 2003 16:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268980AbTBWVeo>; Sun, 23 Feb 2003 16:34:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4361 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268979AbTBWVen> convert rfc822-to-8bit; Sun, 23 Feb 2003 16:34:43 -0500
Date: Sun, 23 Feb 2003 13:41:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <1046031687.2140.32.camel@bip.localdomain.fake>
Message-ID: <Pine.LNX.4.44.0302231337390.1534-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id h1NLiLF04013
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 23 Feb 2003, Xavier Bestel wrote:
> Le dim 23/02/2003 à 20:17, Linus Torvalds a écrit :
> 
> > And the baroque instruction encoding on the x86 is actually a _good_
> > thing: it's a rather dense encoding, which means that you win on icache. 
> > It's a bit hard to decode, but who cares? Existing chips do well at
> > decoding, and thanks to the icache win they tend to perform better - and
> > they load faster too (which is important - you can make your CPU have
> > big caches, but _nothing_ saves you from the cold-cache costs). 
> 
> Next step: hardware gzip ?

Not gzip, no. It needs to be a random-access compression with reasonably
small blocks, not something designed for streaming. Which makes it harder
to do right and efficiently.

But ARM has Thumb (not the same thing, but same idea), and at least some 
PPC chips have a page-based compressor - IBM calls it "CodePack" in case 
you want to google for it.

				Linus

