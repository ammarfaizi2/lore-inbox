Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbTEaC6j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 22:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264110AbTEaC6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 22:58:39 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:18187 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264111AbTEaC6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 22:58:38 -0400
Date: Sat, 31 May 2003 00:12:31 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Steven Cole <elenstev@mesatop.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 Documentation/CodingStyle ANSI C function declarations.
Message-ID: <20030531031231.GE5783@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Steven Cole <elenstev@mesatop.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305301414210.2671-100000@home.transmeta.com> <1054342517.2901.78.camel@spc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054342517.2901.78.camel@spc>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 30, 2003 at 06:55:18PM -0600, Steven Cole escreveu:
> On Fri, 2003-05-30 at 15:17, Linus Torvalds wrote:
> > On Fri, 30 May 2003, Russell King wrote:
> > >
> > > On Fri, May 30, 2003 at 01:57:13PM -0600, Steven Cole wrote:
> > > > +int foo(
> > > > +	long bar,
> > > > +	long day,
> > > > +	struct magic *xyzzy
> > > > +)
> > > 
> > > Is this really part of the kernel coding style?
> > 
> > No, but it's better than what it used to be.
> > 
> > Also, while I don't think we should try to maintain 1:1 behaviour with 
> > the _worst_ offenses of zlib, I do think we should maintain comments etc, 
> > and a lot of the zlib function declarations used to look like
> > 
> > 	int foo(bar, baz)
> > 	long bar;		/* number of frobnicators */
> > 	long baz;		/* self-larting on or off */
> > 	{
> > 		....
> > 
> > and the ANSI-fication changes this to
> > 
> > 	int foo(
> > 		long bar,	/* number of frobnicators */
> > 		long baz	/* self-larting on or off */
> > 	)
> > 	{
> > 		...
> > 
> > which while not according to the coding-standard is at least a reasonable 
> > compromize between having proper C function definitions and keeping the 
> > code _looking_ more like the original.
> > 
> > 		Linus
> > 
> > 
> OK, here is a modified version of the patch to CodingStyle which
> explicitly notes the reason for this secondary style.

In the cases where there are documentation for the paramenters isn't it better
to just bite the bullet and use the kerneldoc style?

Documentation/kernel-doc-nano-HOWTO.txt

- Arnaldo
