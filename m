Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133027AbRECT0o>; Thu, 3 May 2001 15:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133007AbRECT02>; Thu, 3 May 2001 15:26:28 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:8964 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132984AbRECTZK>;
	Thu, 3 May 2001 15:25:10 -0400
Date: Tue, 1 May 2001 20:21:40 +0000
From: Pavel Machek <pavel@suse.cz>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andries Brouwer <Andries.Brouwer@cwi.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: iso9660 endianness cleanup patch
Message-ID: <20010501202139.B32@(none)>
In-Reply-To: <Pine.LNX.4.21.0104302312430.861-100000@penguin.transmeta.com> <3AEE553B.B38B00E@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AEE553B.B38B00E@transmeta.com>; from hpa@transmeta.com on Mon, Apr 30, 2001 at 11:18:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The attached patch fixes both.  It is against 2.4.4, but from the looks
> > > of it it should patch against -ac as well.
> > 
> > Btw, please use "static inline" instead of "extern inline", as gcc may
> > decide not to inline the latter at all, leading to confusing link-time
> > errors. (Gcc may also decide not to inline "static inline", but then gcc
> > will output the actual body of the function out-of-line if it gets used,
> > so you don't get the link-time failure).
> > 
> > Right now only certain broken versions of gcc will actually show this
> > behaviour, I think, but it's at least in theory going to be an issue.
> > 
> 
> I guess I personally prefer an error over completely broken behaviour,
> but feel free to change it.

It  should ot break anything. gcc decides its bad to inline it, so it
does not inline it. Small code growth at worst. Compiler has right to
make your code bigger or slower, if it decides to do so.
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

