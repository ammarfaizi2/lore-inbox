Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136578AbREAGTd>; Tue, 1 May 2001 02:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136579AbREAGTX>; Tue, 1 May 2001 02:19:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:21519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136578AbREAGTH>; Tue, 1 May 2001 02:19:07 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3AEE553B.B38B00E@transmeta.com>
Date: Mon, 30 Apr 2001 23:18:35 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <Pine.LNX.4.21.0104302312430.861-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 30 Apr 2001, H. Peter Anvin wrote:
> >
> > The attached patch fixes both.  It is against 2.4.4, but from the looks
> > of it it should patch against -ac as well.
> 
> Btw, please use "static inline" instead of "extern inline", as gcc may
> decide not to inline the latter at all, leading to confusing link-time
> errors. (Gcc may also decide not to inline "static inline", but then gcc
> will output the actual body of the function out-of-line if it gets used,
> so you don't get the link-time failure).
> 
> Right now only certain broken versions of gcc will actually show this
> behaviour, I think, but it's at least in theory going to be an issue.
> 

I guess I personally prefer an error over completely broken behaviour,
but feel free to change it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
