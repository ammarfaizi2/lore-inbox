Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262967AbTCWIaf>; Sun, 23 Mar 2003 03:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262968AbTCWIaf>; Sun, 23 Mar 2003 03:30:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19719 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262967AbTCWIae>; Sun, 23 Mar 2003 03:30:34 -0500
Date: Sun, 23 Mar 2003 00:27:11 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] parallel port
In-Reply-To: <20030323082239.GE6940@fs.tum.de>
Message-ID: <Pine.LNX.4.44.0303230024280.5588-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Mar 2003, Adrian Bunk wrote:
> > 
> > for me. I think I complained about that once before already. Tssk, tssk.
> 
> It's perhaps a silly question:
> Why did you use a "do ... while  (0)" in your fix?

I always do that (well, almost always), just because it protects macros 
from being mis-used.

For example, if you have

	#define macro(x) ((x) = 3)

that _looks_ safe, but it allows people to write

	x++ = macro(x);

or similar nonsense. So if you want a macro that always behaves like a 
statement (and can't be used as an expression), the "do { } while (0)" 
will do that.

[ The real answer is that it's so built in to my spine, that I just can't 
  stop myself. Even if it doesn't really matter. ]

			Linus

