Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSBIUR0>; Sat, 9 Feb 2002 15:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBIURG>; Sat, 9 Feb 2002 15:17:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50185 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286590AbSBIUQ5>; Sat, 9 Feb 2002 15:16:57 -0500
Date: Sat, 9 Feb 2002 12:15:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C658272.8C517D55@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202091214270.32272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 9 Feb 2002, Andrew Morton wrote:
>
> gcc generally get it wrong - unreferenced strings still appear
> in the object code from multiple usage patterns.  I think this
> was fixed about six months ago.

Ok. If it's already fixed in recent gcc's, and since even a unfixed gcc
should at most cause just one extra string per file, this sounds
acceptable.

> But yes, the verbose BUG overhead is now six bytes per BUG, plus
> a few bytes per file for the filename.  And it's my opinion that
> the non-verbose BUG option is undesirable - it's making the
> developers' job harder.  Seems that with this change, the reasons
> for CONFIG_DEBUG_BUGVERBOSE are no longer with us, and it can
> disappear.

Yes. Make it so.

		Linus

