Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288677AbSBJFih>; Sun, 10 Feb 2002 00:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289293AbSBJFi0>; Sun, 10 Feb 2002 00:38:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:55044 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288677AbSBJFiR>; Sun, 10 Feb 2002 00:38:17 -0500
Date: Sat, 9 Feb 2002 23:23:43 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C660517.AAA7FA8@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202092322310.11734-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2002, Andrew Morton wrote:
>
> This is the cue for Keith to pop up and say "fixed in kbuild 2.5".

Nope.

> __BASE_FILE__ seems to have been supported for a sufficiently long time.

__BASE_FILE__ is not useful.

Remember: when we have a BUG in a header file, we need to get the HEADER
file, not the base file.

__BASE_FILE__ only works for .c files.

And .c files aren't the problem anyway (ie if we didn't have BUG()
statements in header files, we wouldn't have problems anyway).

		Linus

