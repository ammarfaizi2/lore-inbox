Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316958AbSEWRFQ>; Thu, 23 May 2002 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316960AbSEWRFP>; Thu, 23 May 2002 13:05:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45842 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316958AbSEWRFN>; Thu, 23 May 2002 13:05:13 -0400
Date: Thu, 23 May 2002 10:03:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jan Kara <jack@suse.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nathan Scott <nathans@sgi.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Quota patches
In-Reply-To: <20020523091626.GA8683@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0205231002460.1006-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 May 2002, Jan Kara wrote:
> > Doesn't let me select both ?
>   Yes. Only one of compatible interfaces is allowed. The reason is
> mainly due to QUOTAON. Both V1 and V2 interfaces used Q_QUOTAON
> to turn quotas on (looking back I admit it was stupid but it happened).
> So now we would have to recognize which quota file was actually given
> to us and turn on proper quota format - and I dislike such magic in
> kernel.. especially when it's not needed. When user has really old
> quota tools (<=2.00) he will turn on V1 interface. If he has newer tools
> (<3.05) he has to decide depending on format he wants to use...

This makes me pretty certain we just do not want to have the backwards-
compatibility layer in 2.5.x

Are there _any_ reasons to use the old stuff, if the fix is just to
upgrade to a newer quota tool?

		Linus

