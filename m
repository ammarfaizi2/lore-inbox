Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbSBIUEX>; Sat, 9 Feb 2002 15:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSBIUEN>; Sat, 9 Feb 2002 15:04:13 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30985 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286161AbSBIUEA>; Sat, 9 Feb 2002 15:04:00 -0500
Date: Sat, 9 Feb 2002 13:49:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrew Morton <akpm@zip.com.au>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C657FDF.5070605@zytor.com>
Message-ID: <Pine.LNX.4.33.0202091348230.1497-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2002, H. Peter Anvin wrote:
> >
> > This is all assuming that gcc doesn't create the string for inline
> > functions that aren't used, which it probably cannot, so maybe this
> > doesn't work out.
>
> Since gcc wouldn't even *see* a macro it didn't use, I find it hard to
> imagine it would create anything.

Oh, but I was talking about the case of the macro being used in an "static
inline" in a header file, and that inline is not actually _used_
anywhere..

> However, you really want to do "asm volatile" rather than "asm"...

Without any inputs and outputs, asms default to volatile, but yes, I
agree. Better make it explicit.

		Linus

