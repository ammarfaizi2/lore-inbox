Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136497AbREAGPW>; Tue, 1 May 2001 02:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136577AbREAGPM>; Tue, 1 May 2001 02:15:12 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18447 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136497AbREAGPI>; Tue, 1 May 2001 02:15:08 -0400
Date: Mon, 30 Apr 2001 23:14:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
In-Reply-To: <3AEE4A06.3666F4BE@transmeta.com>
Message-ID: <Pine.LNX.4.21.0104302312430.861-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 30 Apr 2001, H. Peter Anvin wrote:
> 
> The attached patch fixes both.  It is against 2.4.4, but from the looks
> of it it should patch against -ac as well.

Btw, please use "static inline" instead of "extern inline", as gcc may
decide not to inline the latter at all, leading to confusing link-time
errors. (Gcc may also decide not to inline "static inline", but then gcc
will output the actual body of the function out-of-line if it gets used,
so you don't get the link-time failure).

Right now only certain broken versions of gcc will actually show this
behaviour, I think, but it's at least in theory going to be an issue.

		Linus

