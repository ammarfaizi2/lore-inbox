Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTE3VFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTE3VFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:05:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2576 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264005AbTE3VFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:05:10 -0400
Date: Fri, 30 May 2003 14:17:45 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Russell King <rmk@arm.linux.org.uk>
cc: Steven Cole <elenstev@mesatop.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
In-Reply-To: <20030530220936.G9419@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 30 May 2003, Russell King wrote:
>
> On Fri, May 30, 2003 at 01:57:13PM -0600, Steven Cole wrote:
> > +int foo(
> > +	long bar,
> > +	long day,
> > +	struct magic *xyzzy
> > +)
> 
> Is this really part of the kernel coding style?

No, but it's better than what it used to be.

Also, while I don't think we should try to maintain 1:1 behaviour with 
the _worst_ offenses of zlib, I do think we should maintain comments etc, 
and a lot of the zlib function declarations used to look like

	int foo(bar, baz)
	long bar;		/* number of frobnicators */
	long baz;		/* self-larting on or off */
	{
		....

and the ANSI-fication changes this to

	int foo(
		long bar,	/* number of frobnicators */
		long baz	/* self-larting on or off */
	)
	{
		...

which while not according to the coding-standard is at least a reasonable 
compromize between having proper C function definitions and keeping the 
code _looking_ more like the original.

		Linus

