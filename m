Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTFBM0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTFBM0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:26:25 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:19448 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262263AbTFBM0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:26:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Larry McVoy <lm@bitmover.com>, Willy Tarreau <willy@w.ods.org>
Subject: Re: Question about style when converting from K&R to ANSI C.
Date: Mon, 2 Jun 2003 07:39:12 -0500
X-Mailer: KMail [version 1.2]
Cc: Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org
References: <1054446976.19557.23.camel@spc> <20030601134942.GA10750@alpha.home.local> <20030601140602.GA3641@work.bitmover.com>
In-Reply-To: <20030601140602.GA3641@work.bitmover.com>
MIME-Version: 1.0
Message-Id: <03060207391200.24067@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 01 June 2003 09:06, Larry McVoy wrote:
> > > Sometimes it is nice to be able to see function names with a
> > >
> > > 	grep '^[a-zA-Z].*(' *.c
> >
> > This will return 'int foo(void)', what's the problem ?
>
> You get a lot of other false hits, like globals.  I don't feel strongly
> about this, I'm more wondering why this style was choosen.  The way
> I showed is pretty common,  it's sort of the "Unix" way (it's how the
> original Unix guys did it, how BSD did it, and how the GNU guys do it), so
> it's a somewhat surprising difference.  I've never understood the logic.
> The more I think about it the less I understand it, doing it that way
> means you are more likely to have to wrap a function definition which
> is ugly:
>
> static inline int cdrom_write_check_ireason(ide_drive_t *drive, int len,
> int ireason) {
> }

Actually, that would most likely be:
static inline int cdrom_write_check_ireason(
			ide_drive_t *drive,
			int len,
			int ireason
)
{
...
}

At least If I were doing it. Over my 20 years, I've found that many of MY
type errors are due to returning or expecting the wrong structure/variable
because I forgot the type of the function.

I rarely have to look at the parameters (though when I do, I locate them
via the function name, then scan the parameters...) sometimes just to count
the number of parameters, or the order, which is easier when the parameters
are one to a line. Either as in K&R, or the new style.

